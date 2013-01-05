//
//  PrincipalViewController.h
//  Assets
//
//  Created by Rafael Brigagão Paulino on 21/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PrincipalViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *imagem;
@property (nonatomic, weak) IBOutlet UIStepper *seletor;

-(IBAction)trocarFoto:(id)sender;

@end
