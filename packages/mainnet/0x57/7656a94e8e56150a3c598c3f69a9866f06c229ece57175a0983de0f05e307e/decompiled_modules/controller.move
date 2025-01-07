module 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::controller {
    public entry fun modify_controller(arg0: &mut 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_emergency(arg0), 202);
        assert!(0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_emergency(arg0), 203);
        assert!(0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

