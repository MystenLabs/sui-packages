module 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::is_emergency(arg0), 302);
        assert!(0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::get_mut_pool<T0, T1>(arg0, 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::event::withdrew_event(0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::global_id<T0, T1>(v0), 0x7cc0e37931f6c7ab358d6cbb467789b8316a6ca5f1a1aef06fda79d63438c95e::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

