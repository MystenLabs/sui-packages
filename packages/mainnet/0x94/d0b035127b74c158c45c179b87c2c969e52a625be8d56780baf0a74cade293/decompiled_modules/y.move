module 0x94d0b035127b74c158c45c179b87c2c969e52a625be8d56780baf0a74cade293::y {
    public entry fun y_call_x(arg0: u64) {
        0x6cc6777b722cc48e89256ef7ffc3433867b40391e5d379ff16f345a4a226b9ce::x::call_x(arg0);
    }

    // decompiled from Move bytecode v6
}

