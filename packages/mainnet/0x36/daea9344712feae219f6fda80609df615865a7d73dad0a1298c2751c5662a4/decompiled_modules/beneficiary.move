module 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::is_emergency(arg0), 302);
        assert!(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::get_mut_pool<T0, T1>(arg0, 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::event::withdrew_event(0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::global_id<T0, T1>(v0), 0x36daea9344712feae219f6fda80609df615865a7d73dad0a1298c2751c5662a4::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

