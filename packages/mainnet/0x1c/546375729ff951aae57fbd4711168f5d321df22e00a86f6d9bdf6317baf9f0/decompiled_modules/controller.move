module 0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::controller {
    public entry fun modify_controller(arg0: &mut 0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::is_emergency(arg0), 202);
        assert!(0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::is_emergency(arg0), 203);
        assert!(0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

