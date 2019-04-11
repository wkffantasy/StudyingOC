//
//  GCDController.m
//  Studying
//
//  Created by wangkongfei on 2019/4/4.
//  Copyright © 2019 wangkongfei. All rights reserved.
//

#import "GCDController.h"

@interface GCDController ()

@end

@implementation GCDController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    dispatch_queue_t queue = dispatch_queue_create("zzzz", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
        [self test0];
//    });
}
- (void)test0 {
    
}

/**
 同步执行+并发队列
 当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务
 */
- (void)test1 {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"begin");
    
    dispatch_queue_t queue = dispatch_queue_create("1111", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
       //task1
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        //task2
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        //task3
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"end");
    
}


/**
 异步执行 + 并发队列
 可以开启多个线程，任务交替（同时）执行
 */
- (void)test2 {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"begin");
    
    dispatch_queue_t queue = dispatch_queue_create("222", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        //task1
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        //task2
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        //task3
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
    
     NSLog(@"end");
    
}


/**
 同步执行 + 串行队列
 不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 所有任务都是在当前线程（主线程）中执行的，并没有开启新的线程（同步执行不具备开启新线程的能力
 所有任务都在打印的syncConcurrent---begin和syncConcurrent---end之间执行（同步任务需要等待队列的任务执行结束）。
 任务是按顺序执行的（串行队列每次只有一个任务被执行，任务一个接一个按顺序执行）
 */
- (void)test3 {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("333", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        //task1
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        //task2
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        //task3
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"end");
    
    
}


/**
 异步执行+串行队列
 会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务
 开启了一条新线程（异步执行具备开启新线程的能力，串行队列只开启一个线程
 所有任务是在打印的syncConcurrent---begin和syncConcurrent---end之后才开始执行的（异步执行不会做任何等待，可以继续执行任务）
 任务是按顺序执行的（串行队列每次只有一个任务被执行，任务一个接一个按顺序执行）
 */
- (void)test4 {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("44", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        //task1
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        //task2
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        //task3
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"end");
    
    
    
}


/**
 同步执行 + 主队列
 
 同步执行 + 主队列在不同线程中调用结果也是不一样，在主线程中调用会出现死锁，而在其他线程中则不会
 
 这是因为我们在主线程中执行syncMain方法，相当于把syncMain任务放到了主线程的队列中。而同步执行会等待当前队列中的任务执行完毕，才会接着执行。那么当我们把任务1追加到主队列中，任务1就在等待主线程处理完syncMain任务。而syncMain任务需要等待任务1执行完毕，才能接着执行

 
 */
- (void)test5 {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"同步执行 + 主队列");
    });
    
    NSLog(@"end");
    
}

/**
 异步执行 + 主队列
 
 */
- (void)test6 {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"异步执行 + 主队列");
    });
    
    NSLog(@"end");
    
}


/**
 GCD的栅栏方法 dispatch_barrier_async
 */
- (void)test7 {
    
    dispatch_queue_t queue = dispatch_queue_create("77", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        //task1
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        //task2
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        //task3
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        //task4
        for (int i = 0; i<2; ++i) {
            // 模拟耗时操作
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4---%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"end");
    
}


/**
 延时执行方法 dispatch_after
 dispatch_after函数并不是在指定时间之后才开始执行处理，而是在指定时间之后将任务追加到主队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效的
 */
- (void)test8 {
    
}

/*
 Grand Central Dispatch(GCD) 是 Apple 开发的一个多核编程的较新的解决方法。它主要用于优化应用程序以支持多核处理器以及其他对称多处理系统。它是一个在线程池模式的基础上执行的并发任务。在 Mac OS X 10.6 雪豹中首次推出，也可在 iOS 4 及以上版本使用。

 
 为什么要用 GCD 呢？
 因为 GCD 有很多好处啊，具体如下：
 
 GCD 可用于多核的并行运算
 GCD 会自动利用更多的 CPU 内核（比如双核、四核）
 GCD 会自动管理线程的生命周期（创建线程、调度任务、销毁线程）
 程序员只需要告诉 GCD 想要执行什么任务，不需要编写任何线程管理代码
 
 
 学习 GCD 之前，先来了解 GCD 中两个核心概念：任务和队列。
 
 
 任务：就是执行操作的意思，换句话说就是你在线程中执行的那段代码。在 GCD 中是放在 block 中的。执行任务有两种方式：同步执行（sync）和异步执行（async）。两者的主要区别是：是否等待队列的任务执行结束，以及是否具备开启新线程的能力。
 
 
 同步执行（sync）：
 
 同步添加任务到指定的队列中，在添加的任务执行结束之前，会一直等待，直到队列里面的任务完成之后再继续执行。
 只能在当前线程中执行任务，不具备开启新线程的能力。
 
 
 
 异步执行（async）：
 
 异步添加任务到指定的队列中，它不会做任何等待，可以继续执行任务。
 可以在新的线程中执行任务，具备开启新线程的能力。

 注意：异步执行（async）虽然具有开启新线程的能力，但是并不一定开启新线程。这跟任务所指定的队列类型有关
 
 队列（Dispatch Queue）：这里的队列指执行任务的等待队列，即用来存放任务的队列。队列是一种特殊的线性表，采用 FIFO（先进先出）的原则，即新任务总是被插入到队列的末尾，而读取任务的时候总是从队列的头部开始读取。每读取一个任务，则从队列中释放一个任务
 
 在 GCD 中有两种队列：串行队列和并发队列。两者都符合 FIFO（先进先出）的原则。两者的主要区别是：执行顺序不同，以及开启线程数不同
 
 串行队列（Serial Dispatch Queue）
 每次只有一个任务被执行。让任务一个接着一个地执行。（只开启一个线程，一个任务执行完毕后，再执行下一个任务）
 并发队列（Concurrent Dispatch Queue）
 可以让多个任务并发（同时）执行。（可以开启多个线程，并且同时执行任务）
 注意：并发队列的并发功能只有在异步（dispatch_async）函数下才有效
 
 对于串行队列，GCD 提供了的一种特殊的串行队列：主队列（Main Dispatch Queue）
 所有放在主队列中的任务，都会放到主线程中执行
 可使用dispatch_get_main_queue()
 
 对于并发队列，GCD 默认提供了全局并发队列（Global Dispatch Queue）
 可以使用dispatch_get_global_queue来获取。需要传入两个参数。第一个参数表示队列优先级，一般用DISPATCH_QUEUE_PRIORITY_DEFAULT。第二个参数暂时没用，用0即可
 
 GCD 提供了同步执行任务的创建方法dispatch_sync和异步执行任务创建方法dispatch_async
 
 */
@end
