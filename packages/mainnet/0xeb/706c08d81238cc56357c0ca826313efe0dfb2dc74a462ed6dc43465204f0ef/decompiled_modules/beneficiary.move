module 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_emergency(arg0), 302);
        assert!(0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::get_mut_pool<T0, T1>(arg0, 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::event::withdrew_event(0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::global_id<T0, T1>(v0), 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

