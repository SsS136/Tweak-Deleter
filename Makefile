ARCHS = armv7 armv7s arm64 arm64e

PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk
APPLICATION_NAME = TweakDeleter
TweakDeleter_FILES = DylibDisableViewController.xm main.m DeleterAppDelegate.m DeleterRootViewController.xm NSString+split.m MenuViewController.m OthersViewController.xm TerminalViewController.xm
TweakDeleter_FRAMEWORKS = UIKit CoreGraphics
TweakDeleter_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"TweakDeleter\"" || true

after-stage::
	$(ECHO_NOTHING)chmod 06755 $(THEOS_STAGING_DIR)/Applications/TweakDeleter.app/TweakDeleter $(ECHO_END)