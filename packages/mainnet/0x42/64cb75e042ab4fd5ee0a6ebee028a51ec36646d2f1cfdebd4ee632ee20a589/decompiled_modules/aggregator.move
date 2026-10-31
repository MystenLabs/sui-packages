module 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator {
    struct Step has copy, drop, store {
        provider: u8,
        pool: 0x2::object::ID,
        a2b: bool,
        input: 0x1::type_name::TypeName,
        output: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct Route<phantom T0, phantom T1> {
        claim: 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Claim<T0, T1>,
        original_amount: u64,
        virtual_coins: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        coins: 0x2::bag::Bag,
        steps: vector<Step>,
        invalid: bool,
        sealed: bool,
        sell: bool,
        cursor: u64,
    }

    fun amount_for<T0, T1, T2>(arg0: &mut Route<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: bool) : u64 {
        assert!(!arg0.sealed && 0x1::vector::length<Step>(&arg0.steps) < 16, 0);
        let v0 = &arg0.steps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Step>(v0)) {
            if (0x1::vector::borrow<Step>(v0, v1).pool == arg1) {
                v2 = true;
                /* label 11 */
                assert!(!v2, 1);
                let v3 = 0x1::type_name::with_defining_ids<T2>();
                if (arg0.invalid || !0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.virtual_coins, &v3)) {
                    arg0.invalid = true;
                    return 0
                };
                let v4 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.virtual_coins, &v3);
                let v5 = if (arg3) {
                    v4
                } else {
                    arg2
                };
                if (v5 == 0 || v5 > v4) {
                    arg0.invalid = true;
                    return 0
                };
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.virtual_coins, &v3) = v4 - v5;
                return v5
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 11 */
    }

    public fun begin<T0, T1>(arg0: 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Claim<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Route<T0, T1> {
        let v0 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::claim_amount<T0, T1>(&arg0);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::type_name::with_defining_ids<T0>());
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, v0);
        let v3 = v0 == 0 || v0 != arg1;
        Route<T0, T1>{
            claim           : arg0,
            original_amount : v0,
            virtual_coins   : 0x2::vec_map::from_keys_values<0x1::type_name::TypeName, u64>(v1, v2),
            coins           : 0x2::bag::new(arg2),
            steps           : 0x1::vector::empty<Step>(),
            invalid         : v3,
            sealed          : false,
            sell            : false,
            cursor          : 0,
        }
    }

    fun put_output<T0, T1, T2>(arg0: &mut Route<T0, T1>, arg1: 0x2::coin::Coin<T2>) {
        let v0 = *0x1::vector::borrow<Step>(&arg0.steps, arg0.cursor - 1);
        assert!(v0.output == 0x1::type_name::with_defining_ids<T2>() && 0x2::coin::value<T2>(&arg1) == v0.amount_out, 2);
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v1)) {
            0x2::coin::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T2>>(&mut arg0.coins, v1), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T2>>(&mut arg0.coins, v1, arg1);
        };
    }

    public fun quote_cetus<T0, T1, T2, T3>(arg0: &mut Route<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: bool, arg3: u64, arg4: bool) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1);
        let v1 = if (arg2) {
            amount_for<T0, T1, T2>(arg0, v0, arg3, arg4)
        } else {
            amount_for<T0, T1, T3>(arg0, v0, arg3, arg4)
        };
        let (v2, v3) = if (v1 == 0) {
            (0, false)
        } else {
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, T3>(arg1, arg2, true, v1);
            let v5 = !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v4) && (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v4) as u128) + (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v4) as u128) == (v1 as u128);
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4), v5)
        };
        if (arg2) {
            record<T0, T1, T2, T3>(arg0, 0, v0, arg2, v1, v2, v3);
        } else {
            record<T0, T1, T3, T2>(arg0, 0, v0, arg2, v1, v2, v3);
        };
    }

    public fun quote_turbos<T0, T1, T2, T3, T4>(arg0: &mut Route<T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg2: bool, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>>(arg1);
        let v1 = if (arg2) {
            amount_for<T0, T1, T2>(arg0, v0, arg3, arg4)
        } else {
            amount_for<T0, T1, T3>(arg0, v0, arg3, arg4)
        };
        let (v2, v3) = if (v1 == 0) {
            (false, 0)
        } else {
            let v4 = if (arg2) {
                4295048016
            } else {
                79226673515401279992447579055
            };
            let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T2, T3, T4>(arg1, arg2, (v1 as u128), true, v4, arg5, arg6, arg7);
            let (v6, v7, v8) = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::quote_amounts(0x1::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&v5), arg2);
            let (v9, v10) = if (0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell(v1, v6, v7, v8, 0)) {
                ((v7 as u64), true)
            } else {
                (0, false)
            };
            (v10, v9)
        };
        if (arg2) {
            record<T0, T1, T2, T3>(arg0, 1, v0, arg2, v1, v3, v2);
        } else {
            record<T0, T1, T3, T2>(arg0, 1, v0, arg2, v1, v3, v2);
        };
    }

    fun record<T0, T1, T2, T3>(arg0: &mut Route<T0, T1>, arg1: u8, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: u64, arg6: bool) {
        let v0 = if (arg0.invalid) {
            true
        } else if (!arg6) {
            true
        } else {
            arg5 == 0
        };
        arg0.invalid = v0;
        let v1 = 0x1::type_name::with_defining_ids<T3>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.virtual_coins, &v1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.virtual_coins, v1, 0);
        };
        let v2 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.virtual_coins, &v1);
        if ((v2 as u128) + (arg5 as u128) > 18446744073709551615) {
            arg0.invalid = true;
        } else {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.virtual_coins, &v1) = v2 + arg5;
        };
        let v3 = Step{
            provider   : arg1,
            pool       : arg2,
            a2b        : arg3,
            input      : 0x1::type_name::with_defining_ids<T2>(),
            output     : v1,
            amount_in  : arg4,
            amount_out : arg5,
        };
        0x1::vector::push_back<Step>(&mut arg0.steps, v3);
    }

    public fun seal<T0, T1>(arg0: &mut Route<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.sealed && !0x1::vector::is_empty<Step>(&arg0.steps), 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(&arg0.virtual_coins)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&arg0.virtual_coins, v1);
            if (*v2 == 0x1::type_name::with_defining_ids<T1>()) {
                v0 = *v3;
            } else if (*v3 != 0) {
                arg0.invalid = true;
            };
            v1 = v1 + 1;
        };
        let v4 = !arg0.invalid && v0 > 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::claim_minimum<T0, T1>(&arg0.claim);
        arg0.sell = v4;
        arg0.sealed = true;
        if (arg0.sell) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.coins, 0x1::type_name::with_defining_ids<T0>(), 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::withdraw_for_route<T0, T1>(&mut arg0.claim, arg1));
        };
    }

    public fun settle<T0, T1>(arg0: Route<T0, T1>) {
        let Route {
            claim           : v0,
            original_amount : v1,
            virtual_coins   : _,
            coins           : v3,
            steps           : v4,
            invalid         : _,
            sealed          : v6,
            sell            : v7,
            cursor          : v8,
        } = arg0;
        let v9 = v4;
        let v10 = v3;
        assert!(v6 && v8 == 0x1::vector::length<Step>(&v9), 0);
        if (v7) {
            0x2::bag::destroy_empty(v10);
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::finish_route<T0, T1>(v0, 0x2::bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut v10, 0x1::type_name::with_defining_ids<T1>()), v1);
        } else {
            0x2::bag::destroy_empty(v10);
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::claim_only<T0, T1>(v0);
        };
    }

    public fun swap_cetus<T0, T1, T2, T3>(arg0: &mut Route<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            let v0 = take_input<T0, T1, T2, T3>(arg0, 0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), true, arg5);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v0)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v0);
                return
            };
            let v1 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(v0);
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg1, arg2, true, true, 0x2::coin::value<T2>(&v1), 4295048016, arg4);
            let v5 = v4;
            0x2::balance::destroy_zero<T2>(v2);
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v5) == 0x2::coin::value<T2>(&v1), 2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg1, arg2, 0x2::coin::into_balance<T2>(v1), 0x2::balance::zero<T3>(), v5);
            put_output<T0, T1, T3>(arg0, 0x2::coin::from_balance<T3>(v3, arg5));
        } else {
            let v6 = take_input<T0, T1, T3, T2>(arg0, 0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), false, arg5);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v6)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v6);
                return
            };
            let v7 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v6);
            let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg1, arg2, false, true, 0x2::coin::value<T3>(&v7), 79226673515401279992447579055, arg4);
            let v11 = v10;
            0x2::balance::destroy_zero<T3>(v9);
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v11) == 0x2::coin::value<T3>(&v7), 2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg1, arg2, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(v7), v11);
            put_output<T0, T1, T2>(arg0, 0x2::coin::from_balance<T2>(v8, arg5));
        };
    }

    public fun swap_turbos<T0, T1, T2, T3, T4>(arg0: &mut Route<T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            let v0 = take_input<T0, T1, T2, T3>(arg0, 1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>>(arg1), true, arg5);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v0)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v0);
                return
            };
            let v1 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(v0);
            let v2 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
            0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v2, v1);
            let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T2, T3, T4>(arg1, v2, 0x2::coin::value<T2>(&v1), 0, 4295048016, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3), arg3, arg4, arg5);
            0x2::coin::destroy_zero<T2>(v4);
            put_output<T0, T1, T3>(arg0, v3);
        } else {
            let v5 = take_input<T0, T1, T3, T2>(arg0, 1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>>(arg1), false, arg5);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v5)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v5);
                return
            };
            let v6 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v5);
            let v7 = 0x1::vector::empty<0x2::coin::Coin<T3>>();
            0x1::vector::push_back<0x2::coin::Coin<T3>>(&mut v7, v6);
            let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T2, T3, T4>(arg1, v7, 0x2::coin::value<T3>(&v6), 0, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3), arg3, arg4, arg5);
            0x2::coin::destroy_zero<T3>(v9);
            put_output<T0, T1, T2>(arg0, v8);
        };
    }

    fun take_input<T0, T1, T2, T3>(arg0: &mut Route<T0, T1>, arg1: u8, arg2: 0x2::object::ID, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T2>> {
        assert!(arg0.sealed && arg0.cursor < 0x1::vector::length<Step>(&arg0.steps), 0);
        let v0 = *0x1::vector::borrow<Step>(&arg0.steps, arg0.cursor);
        let v1 = if (v0.provider == arg1) {
            if (v0.pool == arg2) {
                if (v0.a2b == arg3) {
                    if (v0.input == 0x1::type_name::with_defining_ids<T2>()) {
                        v0.output == 0x1::type_name::with_defining_ids<T3>()
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        arg0.cursor = arg0.cursor + 1;
        if (!arg0.sell) {
            return 0x1::option::none<0x2::coin::Coin<T2>>()
        };
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        let v3 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T2>>(&mut arg0.coins, v2);
        if (0x2::coin::value<T2>(&v3) == 0) {
            0x2::coin::destroy_zero<T2>(v3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T2>>(&mut arg0.coins, v2, v3);
        };
        0x1::option::some<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut v3, v0.amount_in, arg4))
    }

    // decompiled from Move bytecode v7
}

