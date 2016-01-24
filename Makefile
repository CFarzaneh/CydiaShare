include theos/makefiles/common.mk

TWEAK_NAME = CydiaShare
CydiaShare_FILES = Tweak.xm
CydiaShare_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
