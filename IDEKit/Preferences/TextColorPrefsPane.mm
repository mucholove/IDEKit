//
//  TextColorPrefsPane.mm
//
//  Created by Glenn Andreas on Wed May 21 2003.
//  Copyright (c) 2003, 2004 by Glenn Andreas
//
//  This library is free software; you can redistribute it and/or
//  modify it under the terms of the GNU Library General Public
//  License as published by the Free Software Foundation; either
//  version 2 of the License, or (at your option) any later version.
//
//  This library is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//  Library General Public License for more details.
//
//  You should have received a copy of the GNU Library General Public
//  License along with this library; if not, write to the Free
//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//

#import "TextColorPrefsPane.h"
#import "IDEKit_TextColors.h"

@implementation TextColorsPrefsPane
- (NSArray *) editedProperties
{
    return @[IDEKit_TextColorsPrefKey,IDEKit_TextColorDefaultBrowserKey,IDEKit_TextColorDefaultStateKey];
}

- (void) didSelect
{
    // load up the colors
    for (NSUInteger i=IDEKit_kLangColor_Background;i<IDEKit_kLangColor_End;i++) {
		id well = [[self mainView] viewWithTag: i+100];
		if (well) {
			[well setColor: IDEKit_TextColorForColor(i)];
		}
    }
    [myDefaultState selectCellWithTag: [[myDefaults objectForKey: IDEKit_TextColorDefaultStateKey] intValue]];
    [[[self mainView] window] makeFirstResponder: [[self mainView] window]];
}
-(IBAction) changeDefaultState: (id) sender
{
    [myDefaults setObject: @([[sender selectedCell] tag]) forKey: IDEKit_TextColorDefaultStateKey];
}
-(IBAction) changeColor: (id) sender
{
    id colorName = IDEKit_NameForColor([sender tag]-100);
    if (colorName) {
		NSDictionary *oldValue = [myDefaults objectForKey: IDEKit_TextColorsPrefKey];
		NSMutableDictionary *newValue;
		if (!oldValue) newValue = [NSMutableDictionary dictionary];
		else
			newValue = [NSMutableDictionary dictionaryWithDictionary: oldValue];
		newValue[colorName] = [[sender color] htmlString];
		[myDefaults setObject: newValue forKey: IDEKit_TextColorsPrefKey];
    } else {
		NSLog(@"Couldn't find name for color %ld",[sender tag]-100);
    }
}


@end
