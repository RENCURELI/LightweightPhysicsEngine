workspace("LightweightPhysicsEngine")
    architecture("x64")

    configurations
    {
        "Debug",
        "Release"
    }

    function includeGlad()
        includedirs "Libraries/Glad/Include/"
    end

    function includeGLFW()
        includedirs "Libraries/GLFW/Include"
    end

    function linkGLFW()
        libdirs "Libraries/GLFW/Lib"

        filter "kind:not StaticLib"
            links "glfw3"
        filter{}
    end
    
    function SetupOpenGL()
    includeGlad()
    includeGLFW()
    linkGLFW()
    end

project("LightweightPhyicsEngine")
    location "LightweightPhyicsEngine"
    kind "ConsoleApp"
    language "C++"

    targetdir("bin/%{cfg.buildcfg}")
    objdir("bin-int/%{cfg.buildcfg}") -- for obj files

    files {"%{prj.name}/include/**.hpp", "%{prj.name}/src/**.cpp"}

    vpaths{ ["include"] = {"**.hpp", "**.h"}, ["src"] = "**.cpp"}

    SetupOpenGL()

    filter "system:windows"
        cppdialect "C++23"
        systemversion "latest"
        links "OpenGL32"

    filter "configurations:Debug"
        defines "CONFIG_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "CONFIG_RELEASE"
        optimize "On"

    filter {}

