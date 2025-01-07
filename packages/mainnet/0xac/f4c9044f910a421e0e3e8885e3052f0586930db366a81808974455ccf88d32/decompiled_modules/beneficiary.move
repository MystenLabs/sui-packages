module 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::Global, arg1: &mut 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::Pools, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::is_emergency(arg0), 302);
        assert!(0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::beneficiary(arg0) == 0x2::tx_context::sender(arg2), 301);
        let v0 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::get_mut_pool<T0, T1>(arg1, 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::withdraw<T0, T1>(v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg2));
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::event::withdrew_event(0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::global_id<T0, T1>(v0), 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

