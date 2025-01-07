module 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::init_vault {
    public fun seed<T0, T1, T2>(arg0: &mut 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        assert!(arg3 > 0, 0);
        assert!(0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::seed_balance<T0, T1, T2>(arg0) == 0, 1);
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        let (v2, v3) = 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::utils::create_position<T0, T1, T2>(arg0, arg1, arg2, &mut v0, &mut v1, arg6, arg7);
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::update_ticks_info<T0, T1, T2>(arg0, v2, v3);
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::update_ticks_info<T0, T1, T2>(arg0, v2, v3);
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
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::seed<T0, T1, T2>(arg0, 0x2::coin::into_balance<T2>(0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::mint_vault_coin_unsafe<T0, T1, T2>(arg0, arg3, arg7)));
    }

    // decompiled from Move bytecode v6
}

