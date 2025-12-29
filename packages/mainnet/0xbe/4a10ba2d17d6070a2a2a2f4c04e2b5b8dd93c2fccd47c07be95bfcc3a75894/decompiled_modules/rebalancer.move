module 0xbe4a10ba2d17d6070a2a2a2f4c04e2b5b8dd93c2fccd47c07be95bfcc3a75894::rebalancer {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        bal_usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        bal_m: 0x2::balance::Balance<T0>,
        has_position: bool,
        pos_tick_lower: u32,
        pos_tick_upper: u32,
        last_sqrt_price_x64: u128,
    }

    fun assert_owner(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x381fa7b8c35ef12b989638c01e3d46ab9839736fdc13bff0bff5b4505a907c80, 1);
    }

    fun assert_pool<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>>(arg0);
        assert!(0x2::object::id_to_address(&v0) == @0x9aedfbd1a64798b83a0d70d4432327c6372207aa2ff60ed828b799a634054411, 6);
    }

    public entry fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0);
        let v0 = Vault<T0>{
            id                  : 0x2::object::new(arg0),
            bal_usdc            : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            bal_m               : 0x2::balance::zero<T0>(),
            has_position        : false,
            pos_tick_lower      : 0,
            pos_tick_upper      : 0,
            last_sqrt_price_x64 : 0,
        };
        0x2::transfer::public_transfer<Vault<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun deposit_magma<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::balance::join<T0>(&mut arg0.bal_m, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_usdc<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
    }

    fun i32_to_u32_nonneg(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u32 {
        assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero()), 9001);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0)
    }

    fun is_current_pos_one_of_three(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u32) : bool {
        let v0 = arg2 - arg2 % arg3;
        let v1 = v0 + arg4;
        let v2 = if (v0 >= arg4) {
            v0 - arg4
        } else {
            0
        };
        if (arg0 == v0 && arg1 == v0 + arg4) {
            true
        } else if (arg0 == v1 && arg1 == v1 + arg4) {
            true
        } else {
            arg0 == v2 && arg1 == v2 + arg4
        }
    }

    fun ll_balance_usdc_m_equal_value<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc);
        let v1 = 0x2::balance::value<T0>(&arg0.bal_m);
        if (v0 == 0 && v1 == 0) {
            return
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2);
        assert!(v2 > 0, 7);
        let v3 = v0 + usdc_value_of_m_amount(v1, v2);
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
                ll_swap_usdc_to_m_amount<T0>(arg0, arg1, arg2, arg3, v6);
            };
            return
        };
        if (v4 > v0 + 1) {
            let v7 = m_amount_for_usdc_value(v4 - v0 + 1, v2);
            let v8 = v7;
            if (v7 > 1) {
                v8 = v7 + 1;
            };
            let v9 = 0x2::balance::value<T0>(&arg0.bal_m);
            if (v8 > v9) {
                v8 = v9;
            };
            if (v8 > 0) {
                ll_swap_m_to_usdc_amount<T0>(arg0, arg1, arg2, arg3, v8);
            };
        };
    }

    fun ll_close_stored_position<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::dynamic_object_field::remove<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, 0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, &mut v0, v1, arg3)
        } else {
            (0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::balance::zero<T0>())
        };
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, &v0, false);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v5, v6);
        0x2::balance::join<T0>(&mut v4, v7);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, v5);
        0x2::balance::join<T0>(&mut arg0.bal_m, v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, v0);
        arg0.has_position = false;
        arg0.pos_tick_lower = 0;
        arg0.pos_tick_upper = 0;
    }

    fun ll_open_position_store_inside_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.has_position, 4);
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc);
        let v1 = 0x2::balance::value<T0>(&arg0.bal_m);
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
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc) >= v6, 5);
        assert!(0x2::balance::value<T0>(&arg0.bal_m) >= v7, 5);
        let v8 = if (v6 == 0) {
            0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, v6)
        };
        let v9 = if (v7 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.bal_m, v7)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, v8, v9, v5);
        0x2::dynamic_object_field::add<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, 0, v2);
        arg0.has_position = true;
        arg0.pos_tick_lower = arg3;
        arg0.pos_tick_upper = arg4;
    }

    fun ll_swap_all_m_to_usdc<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.bal_m);
        if (v0 == 0) {
            return
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(&v4);
        assert!(0x2::balance::value<T0>(&arg0.bal_m) >= v5, 5);
        let v6 = if (v5 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.bal_m, v5)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v6, v4);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, v1);
        0x2::balance::join<T0>(&mut arg0.bal_m, v2);
    }

    fun ll_swap_m_to_usdc_amount<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock, arg4: u64) {
        if (arg4 == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.bal_m) >= arg4, 5);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, false, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(&v3);
        assert!(0x2::balance::value<T0>(&arg0.bal_m) >= v4, 5);
        let v5 = if (v4 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.bal_m, v4)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v5, v3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, v0);
        0x2::balance::join<T0>(&mut arg0.bal_m, v1);
    }

    fun ll_swap_usdc_to_m_amount<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock, arg4: u64) {
        if (arg4 == 0) {
            return
        };
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc) >= arg4, 5);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, true, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(&v3);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc) >= v4, 5);
        let v5 = if (v4 == 0) {
            0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, v4)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, v5, 0x2::balance::zero<T0>(), v3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, v0);
        0x2::balance::join<T0>(&mut arg0.bal_m, v1);
    }

    fun m_amount_for_usdc_value(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 > 0, 7);
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg0 as u256) * v1 * v1 / v0 * v0;
        if (v2 > (18446744073709551615 as u256)) {
            18446744073709551615
        } else {
            (v2 as u64)
        }
    }

    fun max_liquidity_for_range(arg0: u64, arg1: u64, arg2: u128, arg3: u32, arg4: u32) : (u128, bool) {
        if (arg3 >= arg4) {
            return (0, true)
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3));
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4));
        let v2 = (arg0 as u128);
        let v3 = (arg1 as u128);
        if (arg2 <= v0) {
            let v4 = v1 - v0;
            if (v2 == 0 || v4 == 0) {
                return (0, true)
            };
            return (mul_div_u128(v2, mul_div_u128(v1, v0, 18446744073709551616), v4), true)
        };
        if (arg2 >= v1) {
            let v5 = v1 - v0;
            if (v3 == 0 || v5 == 0) {
                return (0, false)
            };
            return (mul_div_u128(v3, 18446744073709551616, v5), false)
        };
        let v6 = if (v2 == 0) {
            0
        } else {
            mul_div_u128(v2, mul_div_u128(v1, arg2, 18446744073709551616), v1 - arg2)
        };
        let v7 = if (v3 == 0) {
            0
        } else {
            mul_div_u128(v3, 18446744073709551616, arg2 - v0)
        };
        if (v6 <= v7) {
            (v6, true)
        } else {
            (v7, false)
        }
    }

    fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    fun pick_best_range_and_limit_side(arg0: u64, arg1: u64, arg2: u128, arg3: u32, arg4: u32) : (u32, u32, bool) {
        let v0 = 1 * arg4;
        let v1 = arg3 - arg3 % arg4;
        let v2 = v1 + v0;
        let v3 = if (v1 >= v0) {
            v1 - v0
        } else {
            0
        };
        if (arg0 > 0 && arg1 == 0) {
            return (v2, v2 + v0, true)
        };
        if (arg1 > 0 && arg0 == 0) {
            return (v3, v3 + v0, false)
        };
        let (v4, v5) = max_liquidity_for_range(arg0, arg1, arg2, v1, v1 + v0);
        let (v6, v7) = max_liquidity_for_range(arg0, arg1, arg2, v2, v2 + v0);
        let (v8, v9) = max_liquidity_for_range(arg0, arg1, arg2, v3, v3 + v0);
        let (v10, v11, v12) = if (v4 >= v6 && v4 >= v8) {
            (v5, v1, v1 + v0)
        } else {
            let (v13, v14, v15) = if (v6 >= v8) {
                (v2, v2 + v0, v7)
            } else {
                (v3, v3 + v0, v9)
            };
            (v15, v13, v14)
        };
        (v11, v12, v10)
    }

    public entry fun rebalance<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg6);
        assert_pool<T0>(arg2);
        arg0.last_sqrt_price_x64 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2);
        let v0 = if (arg0.has_position) {
            if (!arg4) {
                !arg5
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2);
            if (is_current_pos_one_of_three(arg0.pos_tick_lower, arg0.pos_tick_upper, i32_to_u32_nonneg(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2)), v1, 1 * v1)) {
                return
            };
        };
        if (arg0.has_position) {
            ll_close_stored_position<T0>(arg0, arg1, arg2, arg3);
        };
        if (arg5) {
            ll_swap_all_m_to_usdc<T0>(arg0, arg1, arg2, arg3, arg6);
            return
        };
        if (arg4) {
            return
        };
        ll_balance_usdc_m_equal_value<T0>(arg0, arg1, arg2, arg3);
        let (v2, v3, v4) = pick_best_range_and_limit_side(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc), 0x2::balance::value<T0>(&arg0.bal_m), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2), i32_to_u32_nonneg(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg2));
        ll_open_position_store_inside_vault<T0>(arg0, arg1, arg2, v2, v3, arg3, v4, arg6);
    }

    fun usdc_value_of_m_amount(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 > 0, 7);
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg0 as u256) * v0 * v0 / v1 * v1;
        if (v2 > (18446744073709551615 as u256)) {
            18446744073709551615
        } else {
            (v2 as u64)
        }
    }

    public fun vault_state<T0>(arg0: &Vault<T0>) : (u64, u64, bool, u32, u32, u128) {
        (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc), 0x2::balance::value<T0>(&arg0.bal_m), arg0.has_position, arg0.pos_tick_lower, arg0.pos_tick_upper, arg0.last_sqrt_price_x64)
    }

    public entry fun withdraw_magma<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal_m, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_usdc<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

