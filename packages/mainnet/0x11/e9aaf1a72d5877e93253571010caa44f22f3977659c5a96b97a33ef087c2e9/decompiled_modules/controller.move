module 0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::controller {
    public entry fun modify_controller(arg0: &mut 0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::is_emergency(arg0), 202);
        assert!(0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::is_emergency(arg0), 203);
        assert!(0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x11e9aaf1a72d5877e93253571010caa44f22f3977659c5a96b97a33ef087c2e9::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

