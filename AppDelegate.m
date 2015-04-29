
#import "AppDelegate.h"
#import "PayPalMobile.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AWccMFNhdPrsCLZN9z1FXluXGZuM0nWncFJ413Y0vGOnZzZ-yOr01QEZ9Rf328o2Pw-Mku4XREZIVE_V",
                                                         PayPalEnvironmentSandbox : @"AWccMFNhdPrsCLZN9z1FXluXGZuM0nWncFJ413Y0vGOnZzZ-yOr01QEZ9Rf328o2Pw-Mku4XREZIVE_V"}];
  return YES;
}

@end
