module 0x13da84710a63019deca3e80106e1c86ae531618bdc626944366a6089fb134d67::rebalancer {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        bal_a: 0x2::balance::Balance<T0>,
        bal_b: 0x2::balance::Balance<T1>,
        position_id: 0x1::option::Option<0x2::object::ID>,
        pos_tick_lower: u32,
        pos_tick_upper: u32,
        range_ticks: u32,
        last_sqrt_price_x64: u128,
    }

    fun assert_owner(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x381fa7b8c35ef12b989638c01e3d46ab9839736fdc13bff0bff5b4505a907c80, 1);
    }

    fun compute_tick_bounds(arg0: u32, arg1: u32) : (u32, u32) {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        (v0, arg0 + arg1)
    }

    public entry fun create<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        assert!(v0 == @0x381fa7b8c35ef12b989638c01e3d46ab9839736fdc13bff0bff5b4505a907c80, 1);
        let v1 = Vault<T0, T1>{
            id                  : 0x2::object::new(arg0),
            bal_a               : 0x2::balance::zero<T0>(),
            bal_b               : 0x2::balance::zero<T1>(),
            position_id         : 0x1::option::none<0x2::object::ID>(),
            pos_tick_lower      : 0,
            pos_tick_upper      : 0,
            range_ticks         : 1,
            last_sqrt_price_x64 : 0,
        };
        0x2::transfer::public_transfer<Vault<T0, T1>>(v1, v0);
    }

    public entry fun deposit_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::balance::join<T0>(&mut arg0.bal_a, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::balance::join<T1>(&mut arg0.bal_b, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun get_position_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        *0x1::option::borrow<0x2::object::ID>(&arg0.position_id)
    }

    public fun has_position<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.position_id)
    }

    fun in_range_with_tick<T0, T1>(arg0: &Vault<T0, T1>, arg1: u32) : bool {
        arg1 >= arg0.pos_tick_lower && arg1 <= arg0.pos_tick_upper
    }

    public fun last_sqrt_price_x64<T0, T1>(arg0: &Vault<T0, T1>) : u128 {
        arg0.last_sqrt_price_x64
    }

    fun ll_flash_swap_in_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg3) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg4) {
            assert!(v7 >= arg6, 10001);
        } else {
            assert!(v6 <= arg6, 10001);
        };
        let (v8, v9) = if (arg3) {
            assert!(0x2::balance::value<T0>(&arg0.bal_a) >= v6, 5);
            (0x2::balance::split<T0>(&mut arg0.bal_a, v6), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::balance::value<T1>(&arg0.bal_b) >= v6, 5);
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.bal_b, v6))
        };
        0x2::balance::join<T0>(&mut arg0.bal_a, v5);
        0x2::balance::join<T1>(&mut arg0.bal_b, v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v8, v9, v3);
    }

    fun ll_open_position_and_add_from_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::option::is_some<0x2::object::ID>(&arg0.position_id), 4);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg6);
        let v1 = 0x2::balance::value<T0>(&arg0.bal_a);
        let v2 = 0x2::balance::value<T1>(&arg0.bal_b);
        assert!(v1 > 0 || v2 > 0, 5);
        let v3 = if (v1 > 0) {
            v1
        } else {
            v2
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v0, v3, v1 > 0, arg5);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v4);
        assert!(0x2::balance::value<T0>(&arg0.bal_a) >= v5, 5);
        assert!(0x2::balance::value<T1>(&arg0.bal_b) >= v6, 5);
        let v7 = if (v5 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.bal_a, v5)
        };
        let v8 = if (v6 == 0) {
            0x2::balance::zero<T1>()
        } else {
            0x2::balance::split<T1>(&mut arg0.bal_b, v6)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v7, v8, v4);
        arg0.pos_tick_lower = arg3;
        arg0.pos_tick_upper = arg4;
        arg0.position_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0));
        let v9 = 0x2::object::id<Vault<T0, T1>>(arg0);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, 0x2::object::id_to_address(&v9));
    }

    fun ll_remove_all_fees_and_close<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg1);
        let (v1, v2) = if (v0 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut arg1, v0, arg4)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, &arg1, false);
        0x2::balance::join<T0>(&mut v4, v5);
        0x2::balance::join<T1>(&mut v3, v6);
        0x2::balance::join<T0>(&mut arg0.bal_a, v4);
        0x2::balance::join<T1>(&mut arg0.bal_b, v3);
        arg0.position_id = 0x1::option::none<0x2::object::ID>();
        arg0.pos_tick_lower = 0;
        arg0.pos_tick_upper = 0;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, arg1);
    }

    public fun range_ticks<T0, T1>(arg0: &Vault<T0, T1>) : u32 {
        arg0.range_ticks
    }

    public entry fun rebalance_no_position<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: bool, arg5: bool, arg6: u128, arg7: u32, arg8: u64, arg9: u64, arg10: u128, arg11: &mut 0x2::tx_context::TxContext) {
        rebalance_no_position_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    fun rebalance_no_position_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: bool, arg5: bool, arg6: u128, arg7: u32, arg8: u64, arg9: u64, arg10: u128, arg11: &mut 0x2::tx_context::TxContext) : bool {
        assert_owner(arg11);
        assert!(!0x1::option::is_some<0x2::object::ID>(&arg0.position_id), 4);
        arg0.last_sqrt_price_x64 = arg6;
        let v0 = false;
        if (arg5) {
            let v1 = 0x2::balance::value<T1>(&arg0.bal_b);
            let v2 = if (arg8 == 0 || arg8 > v1) {
                v1
            } else {
                arg8
            };
            if (v2 > 0) {
                ll_flash_swap_in_vault<T0, T1>(arg0, arg1, arg2, false, true, v2, arg9, arg10, arg3, arg11);
                v0 = true;
            };
        };
        if (!arg4) {
            let (v3, v4) = compute_tick_bounds(arg7, arg0.range_ticks);
            ll_open_position_and_add_from_vault<T0, T1>(arg0, arg1, arg2, v3, v4, arg3, arg11);
            v0 = true;
        };
        v0
    }

    public entry fun rebalance_with_position<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: bool, arg6: bool, arg7: u128, arg8: u32, arg9: u64, arg10: u64, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) {
        rebalance_with_position_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun rebalance_with_position_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: bool, arg6: bool, arg7: u128, arg8: u32, arg9: u64, arg10: u64, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) : bool {
        assert_owner(arg12);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.position_id), 3);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.position_id), 3);
        arg0.last_sqrt_price_x64 = arg7;
        if (!in_range_with_tick<T0, T1>(arg0, arg8)) {
            ll_remove_all_fees_and_close<T0, T1>(arg0, arg1, arg2, arg3, arg4);
            if (arg6) {
                let v1 = 0x2::balance::value<T1>(&arg0.bal_b);
                let v2 = if (arg9 == 0 || arg9 > v1) {
                    v1
                } else {
                    arg9
                };
                if (v2 > 0) {
                    ll_flash_swap_in_vault<T0, T1>(arg0, arg2, arg3, false, true, v2, arg10, arg11, arg4, arg12);
                };
            };
            if (!arg5) {
                let (v3, v4) = compute_tick_bounds(arg8, arg0.range_ticks);
                ll_open_position_and_add_from_vault<T0, T1>(arg0, arg2, arg3, v3, v4, arg4, arg12);
            };
            true
        } else {
            let v5 = 0x2::object::id<Vault<T0, T1>>(arg0);
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, 0x2::object::id_to_address(&v5));
            false
        }
    }

    public entry fun set_range_ticks<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        assert!(arg1 <= 2000000, 2);
        arg0.range_ticks = arg1;
    }

    public entry fun withdraw_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal_a, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bal_b, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

