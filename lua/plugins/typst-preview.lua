local open_command = nil

-- Detect if we are running inside your Windows/WSL container vs your Mac
if os.getenv("WSL_DISTRO_NAME") ~= nil then
  -- Handles the URL routing flawlessly on the PC side without path warnings
  open_command = "powershell.exe Start-Process %s"
end

return {
  'chomosuke/typst-preview.nvim',
  lazy = false,
  ft = 'typst',
  version = '0.3.*',
  build = function() require('typst-preview').update() end,
  opts = {
    open_cmd = open_command,
    
    -- The Secret Sauce: Forces a smart dark-mode filter in the browser viewport
    -- but leaves your actual code and PDF exports perfectly black-and-white.
    invert_colors = "always", 
  },
}
