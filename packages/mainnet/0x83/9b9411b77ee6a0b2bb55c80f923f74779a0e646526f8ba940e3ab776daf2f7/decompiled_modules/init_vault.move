module 0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::init_vault {
    public fun seed<T0, T1, T2>(arg0: &mut 0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::Vault<T0, T1, T2>, arg1: &mut 0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::VaultCap, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::version::Version, arg8: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::version::assert_current_version(arg7);
        0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg2);
        0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::check_vault_cap_uninitialised(arg1);
        assert!(arg3 > 0, 0);
        assert!(arg3 <= 100000000, 1);
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        let (v2, v3, v4, v5) = 0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::utils::create_position<T0, T1, T2>(arg0, arg2, &mut v0, &mut v1, arg6, arg8, arg9);
        0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::update_ticks_info<T0, T1, T2>(arg0, v2, v3);
        0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::update_trigger_ticks_info<T0, T1, T2>(arg0, v4, v5);
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
        0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::seed<T0, T1, T2>(arg0, 0x2::coin::into_balance<T2>(0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::mint_vault_coin_unsafe<T0, T1, T2>(arg0, arg3, arg9)));
        0x7a628ca1e3f3ca219b90c446ccbc48c7fa9ef92ce419bf830bebc3f216f2a951::vault::set_intialised(arg1);
    }

    // decompiled from Move bytecode v6
}

