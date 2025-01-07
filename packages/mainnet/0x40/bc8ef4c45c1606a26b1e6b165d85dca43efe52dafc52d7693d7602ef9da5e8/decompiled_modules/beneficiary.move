module 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::is_emergency(arg0), 302);
        assert!(0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::get_mut_pool<T0, T1>(arg0, 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::event::withdrew_event(0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::global_id<T0, T1>(v0), 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

