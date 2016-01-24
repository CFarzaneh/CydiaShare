#import "Cydia/CYPackageController.h"
#import "Cydia/MIMEAddress.h"
#import "Cydia/Package.h"
#import "Cydia/Source.h"

%hook CYPackageController

- (void)applyRightButton {
	%orig;

	if (self.rightButton && !self.isLoading) {
		Package *package = MSHookIvar<Package *>(self, "package_");

		if (package.source) {
			self.navigationItem.rightBarButtonItems = @[
				self.rightButton,
				[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(_cydiasharecfarzaneh_share:)] autorelease]
			];
		}
	}
}

%new 

- (void)_cydiasharecfarzaneh_share:(UIBarButtonItem *)sender {

	Package *package = MSHookIvar<Package *>(self, "package_");

	NSString *message = [NSString stringWithFormat:@"Check out %@ by %@ on Cydia:", package.name, package.author.name];
	NSURL *url;

	NSString *fullpackageurl = [NSString stringWithFormat:@"%@/%@", @"Cydia://package", package.id];

    url = [NSURL URLWithString:fullpackageurl];

	UIActivityViewController *viewController = [[[UIActivityViewController alloc] initWithActivityItems:@[ message, url ] applicationActivities:nil] autorelease];
	viewController.popoverPresentationController.barButtonItem = sender;
	[self.navigationController presentViewController:viewController animated:YES completion:nil];
}

%end