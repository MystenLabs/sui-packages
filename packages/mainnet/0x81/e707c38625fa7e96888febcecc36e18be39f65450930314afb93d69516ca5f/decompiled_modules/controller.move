module 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::controller {
    public entry fun modify_controller(arg0: &mut 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::is_emergency(arg0), 202);
        assert!(0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::is_emergency(arg0), 203);
        assert!(0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

