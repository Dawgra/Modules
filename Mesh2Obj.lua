---------------------------------------------------------------------------------------------------------------------------------------
-- @CloneTrooper1019, 2017
-- 2026 Edit: @Dogutsune

-- Mesh2obj.lua
-- This script converts Roblox's mesh format into a .obj file
-- Written for Dawgra (now Dogutsune), with the intent of recovering the meshes stored in this model:
-- https://www.roblox.com/library/12468931/Reason-2-Die-Meshpack-2
---------------------------------------------------------------------------------------------------------------------------------------

-- ~ CONTEXT OF CREATION ~ 

-- In 2009, Roblox used to have a "feature" (hack) where you could store a content file directly inside of their .rbxm format if you
-- encoded the content into a base64 string, and put it inside of <binary></binary> tags. This was probably intended to be for
-- debugging purposes, but some clever users at the discovered this feature and utilized it to inject meshes into Roblox long before
-- uploading meshes was even a feature. The problem here was that you could inject basically any arbitrary data into Roblox, which in turn
-- allowed users to bypass moderation. Thus Roblox removed the feature and user meshes were no more (until mid 2016).

-- To recover those meshes with this script:
-- 01: Save the model that contains the mesh binary data as a .rbxmx file
-- 02: In a text editor, strip out all the XML text until you're just left with the base64 encoded string
-- 03: Paste the base64 content onto a website that decodes base64 data into it's raw binary data
-- 04: Copy the data and create a new module in the workspace named "Mesh2obj"
-- 05: Change the modules content to something like this
--[[
	return [[
	version 1.00
	298
	[-1.52827, 5.78714, -0.128485] (...)
	]]
--]]
-- 06: Run the game and copy the contents of "ReturnedOutput" attribute for this script.
-- 07: Paste that into a new file and save it as a .obj file
-- 08: Import the mesh into Blender or whatever mesh editing tool you use.
-- 09: Save the mesh as a .FBX file
-- 10: Add a MeshPart to the Workspace, and upload the .FBX mesh

-- Congratulations, you have recovered the mesh!

---------------------------------------------------------------------------------------------------------------------------------------

local meshData = require(workspace.Mesh2obj) -- Change the directory of the module.
local readLine = meshData:gmatch("[^\r\n]+")

-- Read mesh file
local version = readLine()
assert(version:sub(1,9) == "version 1","Unsupported version " .. version)

local meshScale = 0.5
if version == "version 1.01" then
	meshScale = 1
end

local numFaces = tonumber(readLine())
assert(numFaces,"number of faces not specified!")

local data = readLine()
local readChar = data:gmatch(".")
local meshFaces = {}

local function seek(token)
	local read = ""
	while true do
		local char = readChar()
		if char == token then
			break
		elseif char == nil then
			error("Reached end of data stream prematurely while seeking token: " .. token)
		end
		read = read .. char
	end
	return tonumber(read)
end

local function readVector3(scale)
	local scale = scale or 1
	local x,y,z
	seek("[")
	x = seek(",")
	y = seek(",")
	z = seek("]")
	return Vector3.new(x,y,z) * scale
end

for faceId = 1,numFaces do
	local face = {}
	face.Vertices = {}
	face.Normals = {}
	face.UVs = {}
	for i = 1,3 do
		face.Vertices[i] = readVector3(meshScale)
		face.Normals[i] = readVector3()
		face.UVs[i] = readVector3()
	end
	meshFaces[faceId] = face
end

-- Dump as .obj

local v3Format = "%s %s %s %s"
local faceFormat = "\nf %s/%s/%s %s/%s/%s %s/%s/%s"

local function writeVector3(v3,tag)
	return v3Format:format(tag,v3.X,v3.Y,v3.Z)
end

local function writeFace(faceIndex)
	local r = (faceIndex-1)*3
	local a,b,c = r+1,r+2,r+3
	return faceFormat:format(a,a,a,b,b,b,c,c,c)
end

---------------------------------------------------------------------------------------------------------------------------------------

local returnedPrint = "g Mesh\n"

for faceIndex,face in ipairs(meshFaces) do
	for i = 1,3 do
		returnedPrint = returnedPrint.."\n"
		local v = face.Vertices[i]
		returnedPrint = returnedPrint..writeVector3(v,"v").."\n"
		local n = face.Normals[i]
		returnedPrint = returnedPrint..writeVector3(n,"vn").."\n"
		local t = face.UVs[i]
		returnedPrint = returnedPrint..writeVector3(t,"vt").."\n"
	end
	returnedPrint = returnedPrint..writeFace(faceIndex).."\n"
end

script:SetAttribute("ReturnedOutput", returnedPrint)
print("Done! Check the script's ReturnedOutput attribute and copy it into a text file.")
