module 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::controller {
    public entry fun modify_controller(arg0: &mut 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::is_emergency(arg0), 202);
        assert!(0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::is_emergency(arg0), 203);
        assert!(0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

