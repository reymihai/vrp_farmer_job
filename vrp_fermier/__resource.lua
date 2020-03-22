description 'nui_example'
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
ui_page 'ui/index.html'

client_scripts {
    "lib/Proxy.lua",
    "lib/Tunnel.lua",
    'client.lua',
} 

server_scripts{
    "@vrp/lib/utils.lua",
	"server.lua",
}
files {
    'ui/index.html',
    'ui/index.css',
    'ui/index.js'
}