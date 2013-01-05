//
//  PrincipalViewController.m
//  Assets
//
//  Created by Rafael Brigagão Paulino on 21/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "PrincipalViewController.h"

@interface PrincipalViewController ()
{
    //local onde vamos procurar pelos recursos no device
    ALAssetsLibrary *bibliotecaFotos;
    
    //local onde vou salvar as referencias para as imagens encontradas
    NSMutableArray *listaImagens;
}

@end

@implementation PrincipalViewController

-(IBAction)trocarFoto:(id)sender
{
    if (listaImagens.count > 0)
    {
        //recuperando umareferencia ao recuso foto de acordo com a selecaodo stepper
        ALAsset *recurso = [listaImagens objectAtIndex:_seletor.value];
        
        //transformar o recurso em uma imagem que possa ser careegada pelo UIImageView
        ALAssetRepresentation *representacao = [recurso defaultRepresentation];
        
        //criando uma referencia a uma imagem apartir darepresentacao do asset
        CGImageRef imageRef = [representacao fullScreenImage];
        
        //criando uma uiimage que pode ser lida pelo uiimageview
        UIImage *foto = [UIImage imageWithCGImage:imageRef];
        
        _imagem.image = foto;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    //localize os recursos (Assets)
    listaImagens = [[NSMutableArray alloc] init];
    bibliotecaFotos = [[ALAssetsLibrary alloc] init];
    
    //criar o bloco que sera utilzado pela bibliotecaFotos para localizar os recursos
    void(^pegarGrupos)(ALAssetsGroup*, BOOL*) = ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group != nil)
        {
            [group  enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                //para cada recurso encontrado neste grupo, vou verificar se é do tipo photo
                if (result != nil && ([result valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto))
                {
                    //se o if é verdadeiro, encontrei uma foto, vou salvar no array listaImagens
                    [listaImagens addObject:result];
                }
                _seletor.maximumValue = listaImagens.count - 1;
                
                //exibir a primeira imagem ao executar o projeto
                [self trocarFoto:_seletor];
            }];
        }
    };
    //metodo para iniciar a busca por fotos na bibliotecado usuario
    [bibliotecaFotos enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:pegarGrupos failureBlock:nil];
    
    
   }

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
