module 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::init_vault {
    public fun seed<T0, T1, T2>(arg0: &mut 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        assert!(0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::seed_balance<T0, T1, T2>(arg0) == 0, 1);
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        let (_, _) = 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::utils::create_position<T0, T1, T2>(arg0, arg1, arg2, &mut v0, &mut v1, arg6, arg7);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg7), 0x2::tx_context::sender(arg7));
        };
        if (0x2::balance::value<T1>(&v1) == 0) {
            0x2::balance::destroy_zero<T1>(v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg7), 0x2::tx_context::sender(arg7));
        };
        0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::seed<T0, T1, T2>(arg0, 0x2::coin::into_balance<T2>(0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault::mint_vault_coin_unsafe<T0, T1, T2>(arg0, arg3, arg7)));
    }

    // decompiled from Move bytecode v6
}

