module 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::controller {
    public entry fun modify_controller(arg0: &mut 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::is_emergency(arg0), 202);
        assert!(0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::is_emergency(arg0), 203);
        assert!(0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

