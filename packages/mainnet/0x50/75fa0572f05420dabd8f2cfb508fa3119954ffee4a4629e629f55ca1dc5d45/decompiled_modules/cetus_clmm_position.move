module 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_position {
    public(friend) fun assert_loss(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg1: u64, arg2: u64) {
        assert_loss_bps(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::configured_execution_loss_bps(arg0), arg1, arg2);
    }

    public(friend) fun assert_loss_bps(arg0: u64, arg1: u64, arg2: u64) {
        if (arg1 <= arg2) {
            return
        };
        assert!(((arg1 - arg2) as u128) <= 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div((arg1 as u128), (arg0 as u128), (10000 as u128)), 219);
    }

    public(friend) fun assert_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 217);
        (arg0 as u64)
    }

    fun assert_u64_u256(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 217);
        (arg0 as u64)
    }

    public(friend) fun calculate_lp_to_withdraw(arg0: u64, arg1: u128, arg2: u128) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        if (arg2 >= arg1) {
            return arg0
        };
        let v1 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div_ceil((arg0 as u128), arg2, arg1);
        if (v1 > (arg0 as u128)) {
            arg0
        } else {
            (v1 as u64)
        }
    }

    public(friend) fun conservative_value(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64, arg2: u64, arg3: bool, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams) : u128 {
        conservative_value_from_physical(physical_value(arg0, arg1, arg2, arg3), arg4)
    }

    public(friend) fun conservative_value_from_physical(arg0: u128, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams) : u128 {
        haircut(arg0, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::configured_nav_haircut_bps(arg1))
    }

    public(friend) fun consumed_input(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 205);
        arg0 - arg1
    }

    public(friend) fun dynamic_supply_swap_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: bool) : u64 {
        assert!(arg1 > 0 || arg2 > 0, 227);
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_sqrt_price(arg3);
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg3 as u256);
        let v1 = (arg1 as u256) * v0 * v0 / 18446744073709551616;
        let v2 = (arg2 as u256) * 18446744073709551616;
        let v3 = v1 + v2;
        assert!(v3 > 0, 227);
        let v4 = if (arg4) {
            v1
        } else {
            v2
        };
        assert_u64_u256((arg0 as u256) * v4 / v3)
    }

    public(friend) fun enter_base<T0, T1, T2>(arg0: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg1: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: 0x2::coin::Coin<T0>, arg8: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg9: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, u64, u64, u128, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_vault::composition<T1, T0, T2>(arg1, arg6, arg8, arg9);
        let v3 = dynamic_supply_swap_amount(0x2::coin::value<T0>(&arg7), v0, v1, v2, true);
        let v4 = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_pool::swap_all_base_to_lst<T1, T0>(arg5, arg6, 0x2::coin::split<T0>(&mut arg7, v3, arg11), arg8, arg9, arg10, arg11);
        let (v5, v6, _) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_vault::composition<T1, T0, T2>(arg1, arg6, arg8, arg9);
        let v8 = safe_fixed_pair_amount(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T1>(&v4), v5, v6, true);
        let (v9, v10) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_vault::deposit_base<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v4, v8, v5, v6, arg8, arg9, arg10, arg11);
        (v9, v10, v0, v1, v2, v3, v5, v6, v8)
    }

    public(friend) fun enter_lst<T0, T1, T2>(arg0: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg1: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x2::coin::Coin<T0>, arg8: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg9: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, u64, u64, u128, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_vault::composition<T0, T1, T2>(arg1, arg6, arg8, arg9);
        let v3 = dynamic_supply_swap_amount(0x2::coin::value<T0>(&arg7), v0, v1, v2, false);
        let v4 = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_pool::swap_all_lst_to_base<T1, T0>(arg5, arg6, 0x2::coin::split<T0>(&mut arg7, v3, arg11), arg8, arg9, arg10, arg11);
        let (v5, v6, _) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_vault::composition<T0, T1, T2>(arg1, arg6, arg8, arg9);
        let v8 = safe_fixed_pair_amount(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T1>(&v4), v5, v6, false);
        let (v9, v10) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_vault::deposit_lst<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v4, v8, v5, v6, arg8, arg9, arg10, arg11);
        (v9, v10, v0, v1, v2, v3, v5, v6, v8)
    }

    public(friend) fun exit_accounting(arg0: u64, arg1: u64) : u64 {
        max_u64(arg0, arg1)
    }

    public(friend) fun exit_base<T0, T1, T2>(arg0: 0x2::balance::Balance<T2>, arg1: u64, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg10: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg11: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::coin::Coin<T0>, u64) {
        let (v0, v1, v2) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_vault::remove<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
        let v3 = v2;
        let v4 = v1;
        0x2::coin::join<T0>(&mut v4, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_pool::swap_all_lst_to_base<T0, T1>(arg8, arg9, v3, arg10, arg11, arg12, arg13));
        (v0, v4, assert_u64(conservative_value(arg10, 0x2::coin::value<T1>(&v3), 0x2::coin::value<T0>(&v4), true, arg11)))
    }

    public(friend) fun exit_lst<T0, T1, T2>(arg0: 0x2::balance::Balance<T2>, arg1: u64, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg10: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg11: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::coin::Coin<T0>, u64) {
        let (v0, v1, v2) = 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_vault::remove<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
        let v3 = v2;
        let v4 = v1;
        0x2::coin::join<T0>(&mut v3, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_pool::swap_all_base_to_lst<T0, T1>(arg8, arg9, v4, arg10, arg11, arg12, arg13));
        (v0, v3, assert_u64(conservative_value(arg10, 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v4), false, arg11)))
    }

    public(friend) fun exit_plan(arg0: u64, arg1: u128, arg2: u128) : (u64, u64) {
        let v0 = calculate_lp_to_withdraw(arg0, arg1, arg2);
        (v0, proportional_accounted_value(arg1, arg0, v0))
    }

    public(friend) fun gap(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    fun haircut(arg0: u128, arg1: u64) : u128 {
        if (arg0 == 0) {
            0
        } else {
            0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(arg0, ((10000 - arg1) as u128), (10000 as u128))
        }
    }

    public(friend) fun loss_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 >= arg0) {
            return 0
        };
        assert_u64(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(((arg0 - arg1) as u128), (10000 as u128), (arg0 as u128)))
    }

    public(friend) fun max_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public(friend) fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public(friend) fun physical_value(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64, arg2: u64, arg3: bool) : u128 {
        if (arg3) {
            0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::composition_value_wal(arg0, arg1, arg2)
        } else {
            0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::composition_value_hawal(arg0, arg1, arg2)
        }
    }

    public(friend) fun proportional_accounted_value(arg0: u128, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        assert!(arg1 > 0, 223);
        if (arg0 == 0) {
            return 0
        };
        assert_u64(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div(arg0, (arg2 as u128), (arg1 as u128)))
    }

    public(friend) fun safe_fixed_pair_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        assert!(arg2 > 0 || arg3 > 0, 227);
        if (arg1 == 0) {
            return 0
        };
        let (v0, v1) = if (arg4) {
            (arg2, arg3)
        } else {
            (arg3, arg2)
        };
        if (v0 == 0) {
            return 0
        };
        let v2 = if (v1 == 0) {
            arg1
        } else {
            min_u64(arg1, assert_u64_u256((arg0 as u256) * (v0 as u256) / (v1 as u256)))
        };
        assert_u64_u256((v2 as u256) * ((10000 - 10) as u256) / (10000 as u256))
    }

    public(friend) fun user_min_output(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg1: u64) : u64 {
        user_min_output_with_buffer(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::configured_user_output_buffer_bps(arg0))
    }

    fun user_min_output_with_buffer(arg0: u64, arg1: u64) : u64 {
        assert_u64((arg0 as u128) - 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_math::mul_div((arg0 as u128), (arg1 as u128), (10000 as u128)))
    }

    // decompiled from Move bytecode v7
}

