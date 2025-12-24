module 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::is_emergency(arg0), 302);
        assert!(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::get_mut_pool<T0, T1>(arg0, 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::event::withdrew_event(0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::global_id<T0, T1>(v0), 0xf64c53c15b63226cff5e81f5dfcaa7d7f2743e93dfeded0a83b5f5db4f19ccff::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

