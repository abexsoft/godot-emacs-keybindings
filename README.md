# Godot Emacs Keybindings
This plugin provides emacs-like key bindings for Godot Editor.

## Features
- emacs-like keybindings for TextEdit.
- hooking and replacing key events.
- allowing Godot Editor shortcuts to issue via 'C-c' mode.

## Key Maps
Command means:
- C-: Control
- M-: ESC or Alt

### Motion
|Command |Desc |
|--------|-----|
| `C-f`  | Move forward one character (forward-char). |
| `C-b`  | Move backward one character (backward-char). |
| `C-n`  | Move down one line (next-line). |
| `C-p`  | Move up one line (previous-line). |
| `C-a`  | Move to the beginning of the line (move-beginning-of-line). |
| `C-e`  | Move to the end of the line (move-end-of-line). |
| `M-<`  | Move to the top of the buffer (beginning-of-buffer).  |
| `M->`  | Move to the end of the buffer (end-of-buffer). |
| `C-v`  | Scroll forward.  (scroll-up-command). |
| `M-v`  | Scroll backward. (scroll-down-command). |
| `M-g`  | Call godot's goto line window. |

### Killing and Deleting
|Command | Desc |
|--------|------|
| `C-d`  | Delete the next character (delete-char). |
| `C-h`  | Delete the previous character (delete-backward-char). |
| `C-k`  | Kill rest of line (kill-line). |
| `C-w`  | Kill the region (kill-region). |
| `M-w`  | Copy the region into the kill ring (kill-ring-save). |
| `C-y`  | Yank the last kill into the buffer, at point (yank). |

### Marking
|Command | Desc |
|--------|------|
| `C-space` | Set the mark at point, and activate it (set-mark-command). |
| `C-x h` | Select whole buffer (mark-whole-buffer). |

### Searching and Replacement
|Command | Desc |
|--------|-------|
| `C-s`  | Call godot's search window.|
| `C-r`  | Call godot's search window.|
| `M-%`  | Call godot's replace window.|

### Error Recovery
|Command  | Desc |
|---------|------|
| `C-g`   | Cancel running or partially typed command. |
| `C-x u` | Undo one entry in the current buffer's undo records (undo). |
| `C-_`   | Undo one entry in the current buffer's undo records (undo). |
| `C-/`   | Undo one entry in the current buffer's undo records (undo). |
| `C-l`   | Scroll the selected window so the current line is the center-most text line (recenter-top-bottom).|

### Files
|Command | Desc |
|--------|------|
| `C-x C-s` | Save the current buffer to its file (save-buffer). |
| `C-x s`   | Save any or all buffers to their files (save-some-buffers).|

### Buffers
|Command | Desc |
|--------|------|
| `C-x b` | Switch into Selecting Buffer Mode. |

### In Selecting Buffer Mode only
|Command | Desc |
|--------|------|
| `C-n` | Switch into next buffer. |
| `C-p` | Switch into previous buffer. |
| `C-j` | Select the buffer and leave from Selecting Buffer Mode. |
| `C-m` | Select the buffer and leave from Selecting Buffer Mode. |
| `enter` | Select the buffer and leave from Selecting Buffer Mode. |
| `C-g` | Select the buffer and leave from Selecting Buffer Mode. |

### Other Commands
|Command | Desc |
|--------|------|
| `C-i` | Tab. |
| `C-j` | Enter. |
| `C-m` | Enter. |
| `C-;` | Comment out the line. |
| `C-c` | Switch into 'C-c' mode (passing through next input). |



## About conflicts with default key bindings
Use 'C-c' mode.  
The next command of 'C-c' passes through this emacs keybinds plugin for once.  
For example, if you need to issue "Save Scene  Ctrl-S", input 'C-c C-s'. 

## License

Godot Emacs Keybindings is licensed under MIT License.  
Copyright (C) 2020 abexsoft@gmail.com  


