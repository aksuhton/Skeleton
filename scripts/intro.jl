using DrWatson
@quickactivate "Skeleton"

# Here you may include files from the source directory
include(srcdir("dummy_src_file.jl"))

println(
"""
Currently active project is: $(projectname())

Path of active project: $(projectdir())

Have fun with your new project!

You can help us improve DrWatson by opening
issues on GitHub, submitting feature requests,
or even opening your own Pull Requests!

1) Enable Pages on main/ in repo settings
2) Actions/General/Workflow Permissions -> Read/Write
"""
)
