module 0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::controller {
    public entry fun modify_controller(arg0: &mut 0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::is_emergency(arg0), 202);
        assert!(0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::is_emergency(arg0), 203);
        assert!(0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x63a2750601f368a60efc1ae9b7b30ae6a755bd6e2f8d9fe0f5e6178dddf17ca5::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

