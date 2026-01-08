module 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::rebalancer {
    public entry fun create<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_access::assert_owner(arg0);
        0x2::transfer::public_transfer<0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::create_vault<T0, T1>(arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun deposit_magma<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_access::assert_owner(arg2);
        0x2::balance::join<T0>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_mut<T0, T1>(arg0), 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_reward<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_access::assert_owner(arg2);
        0x2::balance::join<T1>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_r_mut<T0, T1>(arg0), 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun deposit_usdc<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_access::assert_owner(arg2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_mut<T0, T1>(arg0), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
    }

    fun ll_balance_usdc_m_equal_value<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_value<T0, T1>(arg0);
        let v1 = 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_value<T0, T1>(arg0);
        if (v0 == 0 && v1 == 0) {
            return
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2);
        assert!(v2 > 0, 7);
        let v3 = v0 + 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_price::usdc_value_of_m_amount(v1, v2);
        if (v3 <= 1) {
            return
        };
        let v4 = v3 / 2;
        if (v0 > v4 + 1) {
            let v5 = v0 - v4;
            let v6 = v5;
            if (v5 > 1) {
                v6 = v5 - 1;
            };
            if (v6 > 0) {
                ll_swap_usdc_to_m_amount<T0, T1>(arg0, arg1, arg2, arg3, v6);
            };
            return
        };
        if (v4 > v0 + 1) {
            let v7 = 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_price::m_amount_for_usdc_value(v4 - v0 + 1, v2);
            let v8 = v7;
            if (v7 > 1) {
                v8 = v7 + 1;
            };
            let v9 = 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_value<T0, T1>(arg0);
            if (v8 > v9) {
                v8 = v9;
            };
            if (v8 > 0) {
                ll_swap_m_to_usdc_amount<T0, T1>(arg0, arg1, arg2, arg3, v8);
            };
        };
    }

    fun ll_close_stored_position<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::id_mut<T0, T1>(arg0), 0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, &mut v0, v1, arg4)
        } else {
            (0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::balance::zero<T0>())
        };
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, &v0, true);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v5, v6);
        0x2::balance::join<T0>(&mut v4, v7);
        if (arg5) {
            0x2::balance::join<T1>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_r_mut<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0, T1>(arg1, arg2, &v0, arg3, true, arg4));
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v5);
        0x2::balance::join<T0>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_mut<T0, T1>(arg0), v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, v0);
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::set_has_position<T0, T1>(arg0, false);
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::set_pos_tick_lower<T0, T1>(arg0, 0);
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::set_pos_tick_upper<T0, T1>(arg0, 0);
    }

    fun ll_open_position_store_inside_vault<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::has_position<T0, T1>(arg0), 4);
        let v0 = 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_value<T0, T1>(arg0);
        let v1 = 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_value<T0, T1>(arg0);
        assert!(v0 > 0 || v1 > 0, 5);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, arg3, arg4, arg7);
        let v3 = if (arg6) {
            v0
        } else {
            v1
        };
        assert!(v3 > 0, 5);
        let v4 = if (v3 > 1) {
            v3 - 1
        } else {
            v3
        };
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, &mut v2, v4, arg6, arg5);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(&v5);
        assert!(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_value<T0, T1>(arg0) >= v6, 5);
        assert!(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_value<T0, T1>(arg0) >= v7, 5);
        let v8 = if (v6 == 0) {
            0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v6)
        };
        let v9 = if (v7 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_mut<T0, T1>(arg0), v7)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, v8, v9, v5);
        0x2::dynamic_object_field::add<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::id_mut<T0, T1>(arg0), 0, v2);
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::set_has_position<T0, T1>(arg0, true);
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::set_pos_tick_lower<T0, T1>(arg0, arg3);
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::set_pos_tick_upper<T0, T1>(arg0, arg4);
    }

    fun ll_swap_all_m_to_usdc<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_value<T0, T1>(arg0);
        if (v0 == 0) {
            return
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(&v4);
        assert!(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_value<T0, T1>(arg0) >= v5, 5);
        let v6 = if (v5 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_mut<T0, T1>(arg0), v5)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v6, v4);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v1);
        0x2::balance::join<T0>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_mut<T0, T1>(arg0), v2);
    }

    fun ll_swap_m_to_usdc_amount<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock, arg4: u64) {
        if (arg4 == 0) {
            return
        };
        assert!(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_value<T0, T1>(arg0) >= arg4, 5);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, false, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(&v3);
        assert!(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_value<T0, T1>(arg0) >= v4, 5);
        let v5 = if (v4 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_mut<T0, T1>(arg0), v4)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v5, v3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v0);
        0x2::balance::join<T0>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_mut<T0, T1>(arg0), v1);
    }

    fun ll_swap_usdc_to_m_amount<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock, arg4: u64) {
        if (arg4 == 0) {
            return
        };
        assert!(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_value<T0, T1>(arg0) >= arg4, 5);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, true, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(&v3);
        assert!(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_value<T0, T1>(arg0) >= v4, 5);
        let v5 = if (v4 == 0) {
            0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v4)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, v5, 0x2::balance::zero<T0>(), v3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v0);
        0x2::balance::join<T0>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_mut<T0, T1>(arg0), v1);
    }

    public entry fun rebalance<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: bool, arg6: bool, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_access::assert_owner(arg8);
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_access::assert_pool<T0>(arg2);
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::set_last_sqrt_price_x64<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2));
        let v0 = if (0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::has_position<T0, T1>(arg0)) {
            if (!arg5) {
                !arg6
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2);
            if (0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_price::is_current_pos_one_of_three(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::pos_tick_lower<T0, T1>(arg0), 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::pos_tick_upper<T0, T1>(arg0), 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_math::i32_to_u32_nonneg(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2)), v1, 1 * v1)) {
                return
            };
        };
        if (0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::has_position<T0, T1>(arg0)) {
            ll_close_stored_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7, arg8);
        };
        if (arg6) {
            ll_swap_all_m_to_usdc<T0, T1>(arg0, arg1, arg2, arg4, arg8);
            return
        };
        if (arg5) {
            return
        };
        ll_balance_usdc_m_equal_value<T0, T1>(arg0, arg1, arg2, arg4);
        let (v2, v3, v4) = 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_price::pick_best_range_and_limit_side(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_value<T0, T1>(arg0), 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_value<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2), 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_math::i32_to_u32_nonneg(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2)), 1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2));
        ll_open_position_store_inside_vault<T0, T1>(arg0, arg1, arg2, v2, v3, arg4, v4, arg8);
    }

    public entry fun withdraw_magma<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_access::assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_m_mut<T0, T1>(arg0), arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_reward<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_access::assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_r_mut<T0, T1>(arg0), arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_usdc<T0, T1>(arg0: &mut 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::VaultUsdc<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::utils_access::assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::vault_usdc::bal_usdc_mut<T0, T1>(arg0), arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

