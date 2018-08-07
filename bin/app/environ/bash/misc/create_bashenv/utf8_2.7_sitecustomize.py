import sys
reload(sys)
u="UTF-8"
sys.setdefaultencoding(u)
sys.getfilesystemencoding = lambda: 'UTF-8'

