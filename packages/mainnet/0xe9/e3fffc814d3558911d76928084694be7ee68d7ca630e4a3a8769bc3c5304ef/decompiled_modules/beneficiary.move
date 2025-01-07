module 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::is_emergency(arg0), 302);
        assert!(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::get_mut_pool<T0, T1>(arg0, 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::event::withdrew_event(0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::global_id<T0, T1>(v0), 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

