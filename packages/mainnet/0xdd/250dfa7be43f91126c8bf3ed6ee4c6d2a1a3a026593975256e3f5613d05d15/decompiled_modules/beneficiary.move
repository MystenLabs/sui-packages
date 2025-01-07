module 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::Global, arg1: &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::Pools, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::is_emergency(arg0), 302);
        assert!(0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::beneficiary(arg0) == 0x2::tx_context::sender(arg2), 301);
        let v0 = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::get_mut_pool<T0, T1>(arg1, 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::withdraw<T0, T1>(v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg2));
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::event::withdrew_event(0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::global_id<T0, T1>(v0), 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

