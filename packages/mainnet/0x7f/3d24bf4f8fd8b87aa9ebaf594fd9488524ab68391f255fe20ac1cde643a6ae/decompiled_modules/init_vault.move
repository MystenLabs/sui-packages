module 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::init_vault {
    public fun seed<T0, T1, T2>(arg0: &mut 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::Vault<T0, T1, T2>, arg1: &mut 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::VaultCap, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::version::assert_current_version(arg8);
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg2);
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::check_vault_cap_uninitialised(arg1);
        assert!(arg4 > 0, 0);
        assert!(arg4 <= 100000000, 1);
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let v1 = 0x2::coin::into_balance<T1>(arg6);
        let (v2, v3, v4, v5) = 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::utils::create_position<T0, T1, T2>(arg0, arg2, arg3, &mut v0, &mut v1, arg7, arg9);
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::update_ticks_info<T0, T1, T2>(arg0, v2, v3);
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::update_trigger_ticks_info<T0, T1, T2>(arg0, v4, v5);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg9), 0x2::tx_context::sender(arg9));
        };
        if (0x2::balance::value<T1>(&v1) == 0) {
            0x2::balance::destroy_zero<T1>(v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg9), 0x2::tx_context::sender(arg9));
        };
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::seed<T0, T1, T2>(arg0, 0x2::coin::into_balance<T2>(0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::mint_vault_coin_unsafe<T0, T1, T2>(arg0, arg4, arg9)));
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::set_intialised(arg1);
    }

    // decompiled from Move bytecode v6
}

