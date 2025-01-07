module 0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::implements::is_emergency(arg0), 302);
        assert!(0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::implements::get_mut_pool<T0, T1>(arg0, 0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::event::withdrew_event(0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::implements::global_id<T0, T1>(v0), 0xdb60d1349c1b93ae7b1be8e57d7673163fb11916194323945827161c24bc9611::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

