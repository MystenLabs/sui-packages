module 0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::controller {
    public entry fun modify_controller(arg0: &mut 0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::is_emergency(arg0), 202);
        assert!(0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::is_emergency(arg0), 203);
        assert!(0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

