module 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_vault {
    public(friend) fun composition<T0, T1, T2>(arg0: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg3: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams) : (u64, u64, u128) {
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_pool_spot<T0, T1>(arg2, arg1, arg3);
        let v0 = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::total_token_amount<T2>(arg0);
        assert!(v0 > 0, 227);
        let (v1, v2) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::get_position_amounts<T0, T1, T2>(arg0, arg1, v0);
        assert!(v1 > 0 || v2 > 0, 227);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_sqrt_price(v3);
        (v1, v2, v3)
    }

    public(friend) fun deposit_base<T0, T1, T2>(arg0: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg1: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: u64, arg12: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg13: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>) {
        let v0 = arg10 > 0;
        if (v0) {
            assert!(arg9 > 0, 229);
        } else {
            assert!(arg11 > 0, 227);
        };
        let v1 = if (v0) {
            arg9
        } else {
            0x2::coin::value<T1>(&arg8)
        };
        let (v2, v3, v4) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::deposit_v2<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg7, v1, 0x2::coin::value<T0>(&arg7), v0, arg14, arg15);
        let v5 = v4;
        0x2::coin::join<T0>(&mut v5, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_pool::swap_all_lst_to_base<T0, T1>(arg5, arg6, v3, arg12, arg13, arg14, arg15));
        (0x2::coin::into_balance<T2>(v2), 0x2::coin::into_balance<T0>(v5))
    }

    public(friend) fun deposit_lst<T0, T1, T2>(arg0: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg1: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: u64, arg12: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg13: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>) {
        let v0 = arg11 > 0;
        if (v0) {
            assert!(arg9 > 0, 229);
        } else {
            assert!(arg10 > 0, 227);
        };
        let v1 = if (v0) {
            arg9
        } else {
            0x2::coin::value<T1>(&arg8)
        };
        let (v2, v3, v4) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::deposit_v2<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin::value<T0>(&arg7), v1, !v0, arg14, arg15);
        let v5 = v3;
        0x2::coin::join<T0>(&mut v5, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_pool::swap_all_base_to_lst<T0, T1>(arg5, arg6, v4, arg12, arg13, arg14, arg15));
        (0x2::coin::into_balance<T2>(v2), 0x2::coin::into_balance<T0>(v5))
    }

    public(friend) fun remove<T0, T1, T2>(arg0: 0x2::balance::Balance<T2>, arg1: u64, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::balance::value<T2>(&arg0);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T2>(arg0);
            return (0x2::balance::zero<T2>(), 0x2::coin::zero<T0>(arg11), 0x2::coin::zero<T1>(arg11))
        };
        let v1 = 0x2::coin::from_balance<T2>(arg0, arg11);
        let (v2, v3) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::remove<T1, T0, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, &mut v1, v0, arg1, arg2, arg10, arg11);
        (0x2::coin::into_balance<T2>(v1), v3, v2)
    }

    // decompiled from Move bytecode v7
}

