module 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::rebalancer_rev {
    fun ll_balance_usdc_m_equal_value_rev<T0, T1>(arg0: &mut 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock) {
        let v0 = 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_value<T0, T1>(arg0);
        let v1 = 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0);
        if (v0 == 0 && v1 == 0) {
            return
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        assert!(v2 > 0, 7);
        let v3 = v0 + 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_price_rev::usdc_value_of_m_amount(v1, v2);
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
                ll_swap_usdc_to_m_amount_rev<T0, T1>(arg0, arg1, arg2, arg3, v6);
            };
            return
        };
        if (v4 > v0 + 1) {
            let v7 = 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_price_rev::m_amount_for_usdc_value(v4 - v0 + 1, v2);
            let v8 = v7;
            if (v7 > 1) {
                v8 = v7 + 1;
            };
            let v9 = 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0);
            if (v8 > v9) {
                v8 = v9;
            };
            if (v8 > 0) {
                ll_swap_m_to_usdc_amount_rev<T0, T1>(arg0, arg1, arg2, arg3, v8);
            };
        };
    }

    fun ll_close_stored_position_rev<T0, T1>(arg0: &mut 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::id_mut<T0, T1>(arg0), 0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, &mut v0, v1, arg4)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>())
        };
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, &v0, true);
        0x2::balance::join<T0>(&mut v5, v6);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v4, v7);
        if (arg5) {
            0x2::balance::join<T1>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_r_mut<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T1>(arg1, arg2, &v0, arg3, true, arg4));
        };
        if (arg6) {
            0x2::balance::join<T0>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, &v0, arg3, true, arg4));
        };
        0x2::balance::join<T0>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_mut<T0, T1>(arg0), v5);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v0);
        0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_has_position<T0, T1>(arg0, false);
        0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_pos_tick_lower<T0, T1>(arg0, 0);
        0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_pos_tick_upper<T0, T1>(arg0, 0);
    }

    fun ll_open_position_store_inside_vault_rev<T0, T1>(arg0: &mut 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::has_position<T0, T1>(arg0), 4);
        let v0 = 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_value<T0, T1>(arg0);
        let v1 = 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0);
        assert!(v0 > 0 || v1 > 0, 5);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, arg3, arg4, arg7);
        let v3 = if (arg6) {
            v1
        } else {
            v0
        };
        assert!(v3 > 0, 5);
        let v4 = if (v3 > 1) {
            v3 - 1
        } else {
            v3
        };
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, &mut v2, v4, arg6, arg5);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v5);
        assert!(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0) >= v6, 5);
        assert!(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_value<T0, T1>(arg0) >= v7, 5);
        let v8 = if (v6 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_mut<T0, T1>(arg0), v6)
        };
        let v9 = if (v7 == 0) {
            0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v7)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v8, v9, v5);
        0x2::dynamic_object_field::add<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::id_mut<T0, T1>(arg0), 0, v2);
        0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_has_position<T0, T1>(arg0, true);
        0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_pos_tick_lower<T0, T1>(arg0, arg3);
        0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_pos_tick_upper<T0, T1>(arg0, arg4);
    }

    fun ll_swap_all_m_to_usdc_rev<T0, T1>(arg0: &mut 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0);
        if (v0 == 0) {
            return
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4);
        assert!(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0) >= v5, 5);
        let v6 = if (v5 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_mut<T0, T1>(arg0), v5)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v6, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v4);
        0x2::balance::join<T0>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_mut<T0, T1>(arg0), v1);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v2);
    }

    fun ll_swap_m_to_usdc_amount_rev<T0, T1>(arg0: &mut 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: u64) {
        if (arg4 == 0) {
            return
        };
        assert!(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0) >= arg4, 5);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, true, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3);
        assert!(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0) >= v4, 5);
        let v5 = if (v4 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_mut<T0, T1>(arg0), v4)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v5, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v3);
        0x2::balance::join<T0>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_mut<T0, T1>(arg0), v0);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v1);
    }

    fun ll_swap_usdc_to_m_amount_rev<T0, T1>(arg0: &mut 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: u64) {
        if (arg4 == 0) {
            return
        };
        assert!(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_value<T0, T1>(arg0) >= arg4, 5);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, false, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3);
        assert!(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_value<T0, T1>(arg0) >= v4, 5);
        let v5 = if (v4 == 0) {
            0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v4)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, 0x2::balance::zero<T0>(), v5, v3);
        0x2::balance::join<T0>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_mut<T0, T1>(arg0), v0);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_mut<T0, T1>(arg0), v1);
    }

    public entry fun rebalance_rev<T0, T1>(arg0: &mut 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::VaultUsdc<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: bool, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &0x2::clock::Clock, arg7: bool, arg8: bool, arg9: u32, arg10: u32, arg11: bool, arg12: bool, arg13: bool, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_access::assert_owner(arg15);
        assert!(arg9 > 0, 8);
        0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_last_sqrt_price_x64<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        let v0 = if (0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::has_position<T0, T1>(arg0)) {
            if (!arg7) {
                !arg8
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            if (0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_price_rev::is_in_range_plus_hyst(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::pos_tick_lower<T0, T1>(arg0), 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::pos_tick_upper<T0, T1>(arg0), tick_i32_to_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2)), arg10 * 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2))) {
                return
            };
        };
        if (0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::has_position<T0, T1>(arg0)) {
            ll_close_stored_position_rev<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg11, arg12, arg15);
            0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_last_usdc_bal<T0, T1>(arg0, 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_value<T0, T1>(arg0));
            0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_last_m_bal<T0, T1>(arg0, 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0));
            0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_last_r_bal<T0, T1>(arg0, 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_r_value<T0, T1>(arg0));
        };
        if (arg8) {
            if (arg4) {
                ll_swap_all_m_to_usdc_rev<T0, T1>(arg0, arg1, arg3, arg6, arg15);
            } else {
                ll_swap_all_m_to_usdc_rev<T0, T1>(arg0, arg1, arg2, arg6, arg15);
            };
            return
        };
        if (arg7) {
            return
        };
        let v1 = arg13;
        if (arg13 && arg14 > 0) {
            let v2 = 0x2::clock::timestamp_ms(arg6);
            let v3 = 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::last_swap_ts_ms<T0, T1>(arg0);
            if (v3 != 0 && v2 > v3) {
                if (v2 - v3 < arg14) {
                    v1 = false;
                };
            };
        };
        if (v1) {
            if (arg4) {
                ll_balance_usdc_m_equal_value_rev<T0, T1>(arg0, arg1, arg3, arg6);
            } else {
                ll_balance_usdc_m_equal_value_rev<T0, T1>(arg0, arg1, arg2, arg6);
            };
            0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::set_last_swap_ts_ms<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg6));
        };
        let (v4, v5, v6) = 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::utils_price_rev::pick_best_range_and_limit_side(0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_usdc_value<T0, T1>(arg0), 0xbbc842c13e6347512800daef454dd14f5deb6fe89a77552fb1c1337de6d12fb2::vault_usdc::bal_m_value<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2), tick_i32_to_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2)), arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        ll_open_position_store_inside_vault_rev<T0, T1>(arg0, arg1, arg2, v4, v5, arg6, v6, arg15);
    }

    fun tick_i32_to_u32(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0)
    }

    // decompiled from Move bytecode v6
}

