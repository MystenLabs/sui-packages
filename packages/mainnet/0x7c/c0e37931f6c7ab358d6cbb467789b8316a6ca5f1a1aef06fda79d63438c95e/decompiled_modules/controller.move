module 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::controller {
    public entry fun modify_controller(arg0: &mut 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::is_emergency(arg0), 202);
        assert!(0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::is_emergency(arg0), 203);
        assert!(0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

