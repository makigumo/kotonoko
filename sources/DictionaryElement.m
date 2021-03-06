//	DictionaryElement.m
//	kotonoko
//
//	Copyright 2001 - 2014 Atsushi Tagami. All rights reserved.
//



#import "DictionaryElement.h"
#import "EBStyleSheet.h"

@implementation DictionaryElement
//-- initWithHeading:page:offset
// 初期化
- (id) initWithHeading : (NSAttributedString*) heading
				anchor : (EBLocation) location
				  data : (NSData*) inRawData
{
    self = [super init];
    _heading = [heading copyWithZone:nil];
	if(location.page < 0){
		_url = nil;
	}else{
		_url = [[NSURL alloc] initWithString:[[self class] locationToURLString:location]];
	}
	_rawData = (inRawData) ? [inRawData copyWithZone:nil] : NULL;
    
    return self;
}


//-- initWithHeading:page:offset
// 初期化
- (id) initWithHeading : (NSAttributedString*) heading
				   url : (NSString*) url
{
    self = [super init];
    if(self){
        _heading = [heading copyWithZone:nil];
        _url	 = [[NSURL alloc] initWithString:url];
        _rawData = nil;
    }    
    return self;
}



//-- elementWithHeading:page:offset
// element の生成
+ (id) elementWithHeading : (NSAttributedString*) inHeading
				   anchor : (EBLocation) inLocation
{
    return [[DictionaryElement alloc]
                    initWithHeading:inHeading anchor:inLocation data:NULL];
}


//-- elementWithHeading:page:offset:data
// element の生成
+ (id) elementWithHeading : (NSAttributedString*) inHeading
				   anchor : (EBLocation) inLocation
					 data : (NSData*) inRawData
{
    return [[DictionaryElement alloc]
                    initWithHeading:inHeading anchor:inLocation data:inRawData];
}


//-- elementWithHeading:url:
// elementの生成
+ (id) elementWithHeading : (NSAttributedString*) inHeading
					  url : (NSString*) url
{
    return [[DictionaryElement alloc] initWithHeading:inHeading url:url];
}


//-- locationToURLString
// locationをURL文字列に変換する
+(NSString*) locationToURLString:(EBLocation) location
{
	return [NSString stringWithFormat:@"eb:/%ld/%ld/%ld", (long)location.ebook, (long)location.page, (long)location.offset];
}


//-- dealloc
// 開放処理


//-- stringHeading
// 文字列を返す
- (NSString*) string
{
    return [_heading string];
}


//-- attributedString
// 文字列を返す
- (NSAttributedString*) attributedString
{
    return _heading;
}


//-- anchor
// anchorを返す
- (NSURL*) anchor
{
    return _url;
}


//-- anchor
// anchorを返す
-(NSString*) URLString
{
    return _url ? [_url absoluteString] : nil;
}



//-- dataForEntry
// rawdataを返す
- (NSData*) dataForEntry
{
    return _rawData;
}


//-- canSelect
// 選択可能かどうか
-(BOOL) canSelect
{
	return (_url != nil);
}

@end
