import os
import sys
import shutil
import time

# Current platform
from sys import platform as _platform

# Supported platforms
supported_platforms = ["linux", "darwin", "win32"]

# Current path
script_path = os.path.abspath(os.path.dirname(__file__))

# Default configuration
if _platform == "win32":
    home_path = os.getenv("USERPROFILE")
    vimrc_file_path = os.path.join(home_path, "_vimrc")
    gvimrc_file_path = os.path.join(home_path, "_gvimrc")
    vim_dir_path = os.path.join(home_path, "vimfiles")
else:
    home_path = os.getenv("HOME")
    vimrc_file_path = os.path.join(home_path, ".vimrc")
    gvimrc_file_path = os.path.join(home_path, ".gvimrc")
    vim_dir_path = os.path.join(home_path, ".vim")

# Symlink function (platform dependent)
if _platform == "win32":
    import ntfsutils.junction as junction
    def symlink(source, link_name):
        junction.create(source, link_name)
else:
    symlink = os.symlink

# Back up an existing configuration
def backup_config():
    time_stamp = "_" + time.strftime('%Y%m%d%H%M%S', time.localtime())
    if os.path.isdir(vim_dir_path):
        print("Back up: " + vim_dir_path)
        try:
            shutil.copytree(vim_dir_path, vim_dir_path + time_stamp)
        except RuntimeError:
            print("Error while backing up " + vim_dir_path)
    for backup_f in [vimrc_file_path, gvimrc_file_path]:
        if os.path.isfile(vimrc_file_path):
            print("Back up: " + backup_f)
            try:
                shutil.copyfile(backup_f, backup_f + time_stamp)
            except RuntimeError:
                print("Error while backing up " + backup_f)

# Get the correct template starting from a base name
# For example, if the files are vimrc, gvimrc, gvimrc_linux:
#     - calling this function with "vimrc" will always return "vimrc"
#     - calling this function with "gvimrc" in Linux will return "gvimrc"
#     - calling this function with "gvimrc" in Windows will return "gvimrc_win32"
def get_template(base):
    if os.path.isfile(os.path.join(script_path, base + _platform)):
        return os.path.join(script_path, base + _platform)
    else:
        return os.path.join(script_path, base)

# Clean the current configuration if needed
def clean_config():
    print "Removing previous configuration"
    try:
        try:
            shutil.rmtree(vim_dir_path)
        except OSError: # maybe it's a link
            os.unlink(vim_dir_path)
        os.remove(vimrc_file_path)
        os.remove(gvimrc_file_path)
    except: # TODO: check errors properly here
        pass

def main():
    if _platform not in supported_platforms:
        raise RuntimeError("This platform is currently unsupported")
    # If vundle already exists, don't proceed unless "-f" is given
    force = len(sys.argv) == 2 and sys.argv[1] == "-f"
    if os.path.isdir(os.path.join(vim_dir_path, "bundle", "Vundle.vim")):
        if not force:
            print "Vundle already found, exiting (use '-f' to force installation)"
            sys.exit(1)
        exists = True

    # Backup existing configuration
    backup_config()

    # Delete the previous configuration
    clean_config()

    # Clone Vundle
    print "Cloning Vundle..."
    try:
        os.makedirs(vim_dir_path)
    except:
        pass
    os.chdir(vim_dir_path)
    os.system("git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim")

    # Link the required files
    os.chdir("..")
    symlink(get_template("vimrc"), vimrc_file_path)
    #symlink(os.path.join(get_template("gvimrc"), gvimrc_file_path)

    # And install everyting in VIM
    print "Installing plugins ... (ignore vim errors)"
    os.system("vim +PluginInstall +Qall")

    print "Done installing."

if __name__ == "__main__":
    main()
