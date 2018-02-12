//
//  main.m
//  FileManagement
//
//  Created by Eduardo Vital Alencar Cunha on 23/03/17.
//  Copyright © 2017 Vital. All rights reserved.
//

#import <Foundation/Foundation.h>

void writeString();
void readString();
void requestFromServer();
void readFile();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        writeString();
        readString();
        requestFromServer();
        readFile();
    }
    return 0;
}

void writeString() {
    NSMutableString *str = [[NSMutableString alloc]init];

    for (int i = 0; i < 10; i++) {
        [str appendString: @"Não seja otário!\n"];
    }

    NSError *error;

    [str writeToFile:@"/tmp/cool.txt"
          atomically:YES
            encoding:NSUTF8StringEncoding
               error:&error];

    if (error) {
        NSLog(@"%@", error);
    } else {
        NSLog(@"Escreveu o arquivo");
    }
}

void readString() {
    NSError *error;

    NSString *str = [[NSString alloc]initWithContentsOfFile:@"/tmp/cool.txt"
                                                   encoding:NSASCIIStringEncoding
                                                      error:&error];
    if (str) {
        NSLog(@"Pegou os dados: %@", str);
    } else {
        NSLog(@"Falhou: %@", [error localizedDescription]);
    }
}

void requestFromServer() {
    NSURL *url = [NSURL URLWithString:@"https://www.google.com/images/logos/ps_logo2.png"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSError *error;

    NSData *data = [NSURLConnection
                    sendSynchronousRequest:request
                    returningResponse:NULL
                    error:&error];

    if (!data) {
        NSLog(@"Falhou: %@", [error localizedDescription]);
        return;
    }

    NSLog(@"O arquivo possui %lu bytes", [data length]);

    BOOL write = [data writeToFile:@"/tmp/logo-google.png"
                           options:NSDataWritingAtomic
                             error:&error];

    if (write) {
        NSLog(@"Feito com sucesso!");
    } else {
        NSLog(@"Falhou a leitura %@", [error localizedDescription]);
    }
}

void readFile() {
    NSData *data = [NSData dataWithContentsOfFile:@"/tmp/logo-google.png"];

    NSLog(@"O arquivo lido no disco tem %lu bytes", [data length]);
}
