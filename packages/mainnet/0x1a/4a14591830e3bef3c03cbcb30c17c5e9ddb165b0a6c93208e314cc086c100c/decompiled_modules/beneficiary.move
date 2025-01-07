module 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::Global, arg1: &mut 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::Pools, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::is_emergency(arg0), 302);
        assert!(0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::beneficiary(arg0) == 0x2::tx_context::sender(arg2), 301);
        let v0 = 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::get_mut_pool<T0, T1>(arg1, 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::withdraw<T0, T1>(v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg2));
        0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::event::withdrew_event(0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::global_id<T0, T1>(v0), 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::swap::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

