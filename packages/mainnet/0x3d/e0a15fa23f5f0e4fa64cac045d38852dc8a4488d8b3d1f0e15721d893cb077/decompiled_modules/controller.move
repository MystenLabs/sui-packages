module 0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::controller {
    public entry fun modify_controller(arg0: &mut 0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::is_emergency(arg0), 202);
        assert!(0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::is_emergency(arg0), 203);
        assert!(0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x3de0a15fa23f5f0e4fa64cac045d38852dc8a4488d8b3d1f0e15721d893cb077::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

