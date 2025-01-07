module 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::is_emergency(arg0), 302);
        assert!(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::get_mut_pool<T0, T1>(arg0, 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::event::withdrew_event(0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::global_id<T0, T1>(v0), 0xd8be9b19612c580e12fb327f39ebb8f3f6a7bc8bd6f19dc549e75a0a8bafc96d::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

