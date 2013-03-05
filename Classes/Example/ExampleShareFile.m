//
//  ExampleShareFile.m
//  ShareKit
//
//  Created by Nathan Weiner on 6/29/10.

//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//

#import "ExampleShareFile.h"
#import "SHK.h"
#import "SHKActionSheet.h"

@interface ExampleShareFile () <UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;

@end

@implementation ExampleShareFile

- (void)dealloc
{
    _webView.delegate = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		self.toolbarItems = [NSArray arrayWithObjects:
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)],
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
							 nil
							 ];
	}
	
	return self;
}

- (void)loadView 
{ 
	self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
	self.webView.delegate = self;
	self.webView.scalesPageToFit = YES;
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"example.pdf"]]]];
	
	self.view = self.webView;
}

- (void)share
{
    /*
     //examle of how to share pdf file.
     NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"example.pdf"];
     NSData *file = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMapped error:&error];
     SHKItem *item = [SHKItem file:file filename:@"Awesome.pdf" mimeType:@"application/pdf" title:@"My Awesome PDF"];
     */
    
    /*
     //examle of how to share image file.
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sanFran" ofType:@"jpg"];
     NSData *file = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMapped error:&error];
     SHKItem *item = [SHKItem file:file filename:@"sanFran.jpg" mimeType:@"image/jpeg" title:@"San Francisco"];
     */
    
    //example of how to share video file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo_video_share" ofType:@"mov"];
    NSError *error = nil;
    NSData *file = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMapped error:&error];
    SHKItem *item = [SHKItem file:file filename:@"demo_video_share.mov" mimeType:@"video/quicktime" title:@"Impressionism - blue ball"];
    
    /*
     //example of how to share audio file
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo_audio_share" ofType:@"mp3"];
     NSData *file = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMapped error:&error];
     SHKItem *item = [SHKItem file:file filename:@"demo_audio_share.mp3" mimeType:@"audio/mpeg" title:@"Demo audio beat"];
     */
    
    
    item.tags = [NSArray arrayWithObjects:@"file share", @"sharekit", nil];
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    [SHK setRootViewController:self];
	[actionSheet showFromToolbar:self.navigationController.toolbar];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

@end
