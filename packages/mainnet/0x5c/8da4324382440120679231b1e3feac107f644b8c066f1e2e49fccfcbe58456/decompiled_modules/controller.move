module 0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::controller {
    public entry fun modify_controller(arg0: &mut 0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::is_emergency(arg0), 202);
        assert!(0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::is_emergency(arg0), 203);
        assert!(0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x5c8da4324382440120679231b1e3feac107f644b8c066f1e2e49fccfcbe58456::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

