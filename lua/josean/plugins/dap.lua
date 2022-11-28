local status, dap = pcall(require, "dap")
local status_util, util = pcall(require, "jdtls.util")
if not status and status_util then
	return
end

dap.adapters.java = function(callback)
	util.execute_command({ command = "vscode.java.startDebugSession" }, function(err0, port)
		assert(not err0, vim.inspect(err0))
		-- print("puerto:", port)
		callback({
			type = "server",
			host = "127.0.0.1",
			port = port,
		})
	end)
end

local projectName = os.getenv("PROJECT_NAME")
dap.configurations.java = {
	{
		type = "java",
		request = "attach",
		projectName = projectName or nil,
		name = "Java attach",
		hostName = "127.0.0.1",
		port = 5005,
	},
}
