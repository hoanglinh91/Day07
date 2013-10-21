//
//  ViewController.m
//  colection
//
//  Created by MAC on 10/18/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end



@implementation ViewController

-(NSString *)chk:(NSString *)str{
    
    char temp[100];
    int j = 0;
    
    for (int i=0; i< [str length]; i++) {
        if (([str characterAtIndex:i] >= 'A' && [str characterAtIndex:i] <= 'Z') || ([str characterAtIndex:i] >= 'a' && [str characterAtIndex:i] <= 'z')) {
            temp[j++] = [str characterAtIndex:i];
        }
    }
    temp[j] = 0;
    NSString *string = [[NSString alloc] initWithFormat:@"%s",temp];
    return string;
}
-(BOOL)heyYouAreSoLucky:(int)number{
    
    // nếu là số nguyên tố trả về NO ngược lại you're so lucky
    if(number == 2 || number == 3)
        return NO;
    if (number % 2 || number % 3 || number < 2)
        return YES;
    
    int add = 2;
    int tmp = (int)sqrt(number);
    for (int i=5; i<=tmp; i+=add,add=6-add) {
        if (!(number % i))
            return YES;
    }
    return NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"putin" ofType:@"txt"];
//    NSString *data = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    
//    // cắt ký tự - > chỉ lấy alphabetic
//    NSArray *array = [data componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    
//    NSMutableArray *myarr = [[NSMutableArray alloc] initWithArray:array];
//    
//    NSCountedSet *mySet = [[NSCountedSet alloc] init];
//    
//    // adding + count set
//    for (int i=0; i < [myarr count]; i++) {
//        myarr[i] = [self chk:myarr[i]];
//        if (myarr[i] != nil) {
//            [mySet addObject:myarr[i]];
//        }
//    }
//    
//    NSMutableSet *otherSet = [[NSMutableSet alloc] init];
//    
//    // chọn ra nhiều nhất 20 chữ vô nghĩa để loại bỏ
//    
//    int i = 0;
//    for (NSCountedSet *set in mySet) {
//        if ([self heyYouAreSoLucky:(arc4random() % 200)]) {
//            [otherSet addObject:set];
//            i++;
//            if (i == 15) {
//                break;
//            }
//        }
//    }
//    
//    //NSLog(@"%d",[mySet count]);
//    
//    //NSLog(@"%@",otherSet);
//    
//    // Xóa phần tử
//    for (NSSet *set in otherSet) {
//        [mySet removeObject:set];
//    }
//   // NSLog(@"%d",[mySet count]);
//    
//    // sắp xếp theo tần suất
//    myarr = [[NSMutableArray alloc] init];
//    
//    for (NSSet *set in mySet) {
//        [myarr addObject:set];
//    }
//    // sorting
//    NSArray *kq = [myarr sortedArrayUsingComparator:^(id obj1,id obj2){
//       	return [mySet countForObject:obj1] > [mySet countForObject:obj2] ? NSOrderedAscending : NSOrderedDescending;
//        return NSOrderedSame;
//    }];
//    
//    
//    for (id obj in kq) {
//        NSLog(@"%@ %d",obj,[mySet countForObject:obj]);
//    }
    [self regularExpression];
}

-(void)regularExpression{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"putin" ofType:@"txt"];
    NSString *data = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSString *pattern = @"[a-zA-Z]{1,}";
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *kq = [re matchesInString:data options:0 range:NSMakeRange(0, [data length])];
    NSMutableArray *myArray = [[NSMutableArray alloc] init];
    
    for (NSTextCheckingResult *chk in kq) {
        //NSRange segment = [chk rangeAtIndex:0];
        NSString *matchString = [data substringWithRange:[chk range]];
        //NSLog(@"%@",matchString);
        [myArray addObject:matchString];
    }
    
    //NSLog(@"%@",myArray);
    
    NSCountedSet *mySet = [[NSCountedSet alloc] initWithArray:myArray];
    //NSLog(@"%@",mySet);
    
    myArray = [[NSMutableArray alloc] init];
    
    for (id obj in mySet) {
        [myArray addObject:obj];
    }
    
    NSArray *result = [myArray sortedArrayWithOptions:0 usingComparator:^(id obj1,id obj2){
        return [mySet countForObject:obj1] > [mySet countForObject:obj2] ? NSOrderedAscending : NSOrderedDescending;
        return NSOrderedSame;
    }];
    
    for (id obj in result) {
        NSLog(@"%@ - %d",obj,[mySet countForObject:obj]);
    }
    /// 2
    NSArray *ignore = [self getIgnore];
    NSMutableArray *result2 = [[NSMutableArray alloc] init];
    
    
    for (id obj1 in result) {
        BOOL adding = YES;
        for (id obj2 in ignore) {
            if (![obj1 compare:obj2 options:1]) {
                //NSLog(@"%@ %@",obj1,obj2);
                adding = NO;
                break;
            }
        }
        if (adding) {
            [result2 addObject:obj1];
        }
    }
    
    for (id obj in result2) {
        NSLog(@"%@ - %d",obj,[mySet countForObject:obj]);
    }
}

-(NSArray *)getIgnore{
    NSArray *myArray = [[NSArray alloc] init];
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ignore" ofType:@"txt"];
    NSString *data = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *pattern = @"[a-zA-Z]{1,}";
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    myArray = [re matchesInString:data options:0 range:NSMakeRange(0, [data length])];
    
    for (NSTextCheckingResult *chk in myArray) {
        NSString *myString = [data substringWithRange:[chk range]];
        [tmp addObject:myString];
    }
    
    return tmp;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
