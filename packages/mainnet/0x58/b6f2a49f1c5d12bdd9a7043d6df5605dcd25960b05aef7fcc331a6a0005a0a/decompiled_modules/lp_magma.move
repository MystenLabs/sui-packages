module 0x58b6f2a49f1c5d12bdd9a7043d6df5605dcd25960b05aef7fcc331a6a0005a0a::lp_magma {
    struct MagmaWitness has drop {
        dummy_field: bool,
    }

    public fun compound<T0, T1>(arg0: &mut 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::Registry, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::compound_fee_pips(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::constants::compound_fee_source(), v0, arg8, arg9);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::events::emit_compounded<MagmaWitness>(arg0, &v5, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    public(friend) fun init_witness() : MagmaWitness {
        MagmaWitness{dummy_field: false}
    }

    public(friend) fun liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        if (arg0 <= arg1) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_from_a(arg1, arg2, arg3, false)
        } else if (arg0 >= arg2) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_from_b(arg1, arg2, arg4, false)
        } else {
            0x1::u128::min(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_from_a(arg0, arg2, arg3, false), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_from_b(arg1, arg0, arg4, false))
        }
    }

    public fun rebalance<T0, T1>(arg0: &mut 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::Registry, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position) {
        let v0 = 0x2::coin::value<T0>(&arg6) > 0 || 0x2::coin::value<T1>(&arg7) > 0;
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg3);
        let (v2, v3) = if (v1 > 0) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v1, arg10)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::into_balance<T1>(arg7);
        let v7 = 0x2::coin::into_balance<T0>(arg6);
        0x2::balance::join<T0>(&mut v7, v5);
        0x2::balance::join<T1>(&mut v6, v4);
        let v8 = 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::rebalance_fee_pips(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg2));
        let v9 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg11);
        let v10 = &mut v9;
        let (v11, v12, v13, v14) = zap_in_int<T0, T1>(arg0, arg1, arg2, v10, v7, v6, 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::constants::rebalance_fee_source(), v8, arg10, arg11);
        assert!(v11 >= arg8 && v12 >= arg9, 1);
        let v15 = init_witness();
        0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::events::emit_rebalanced<MagmaWitness>(arg0, &v15, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg3), 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v9), 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), v11, v12, v0);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg1, arg2, arg3);
        (0x2::coin::from_balance<T0>(v13, arg11), 0x2::coin::from_balance<T1>(v14, arg11), v9)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::Registry, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::tick_range(arg3);
        let (v2, v3, v4, _) = 0x58b6f2a49f1c5d12bdd9a7043d6df5605dcd25960b05aef7fcc331a6a0005a0a::swap_math::optimal_swap<T0, T1>(arg2, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v0), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v1), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
        if (v2 == 0 && v3 == 0) {
            return
        };
        let (v6, v7, v8) = if (v4) {
            (0x2::balance::split<T0>(arg4, v2), 0x2::balance::zero<T1>(), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price() + 1)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg5, v2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price() - 1)
        };
        let (v9, v10, v11) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, v4, true, v2, v8, arg6);
        let v12 = v10;
        let v13 = v9;
        0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::assert_price(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2));
        let v14 = if (v4) {
            0x2::balance::value<T1>(&v12)
        } else {
            0x2::balance::value<T0>(&v13)
        };
        0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::assert_output(arg0, v3, v14);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, v6, v7, v11);
        0x2::balance::join<T0>(arg4, v13);
        0x2::balance::join<T1>(arg5, v12);
    }

    public fun zap_in<T0, T1>(arg0: &mut 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::Registry, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::zap_fee_pips(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::constants::zap_in_fee_source(), v0, arg8, arg9);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::events::emit_zapped_in<MagmaWitness>(arg0, &v5, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    fun zap_in_int<T0, T1>(arg0: &mut 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::Registry, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::collect_fees<T0>(arg0, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), &mut arg4, arg6, arg7);
        0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::collect_fees<T1>(arg0, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), &mut arg5, arg6, arg7);
        let v0 = &mut arg4;
        let v1 = &mut arg5;
        swap_to_optimal<T0, T1>(arg0, arg1, arg2, arg3, v0, v1, arg8);
        let v2 = 0x2::balance::value<T0>(&arg4);
        let v3 = 0x2::balance::value<T1>(&arg5);
        assert!(v2 > 0 || v3 > 0, 0);
        let (v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::tick_range(arg3);
        let v6 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity<T0, T1>(arg1, arg2, arg3, liquidity_for_amounts(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(v4), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(v5), v2, v3), arg8, arg9);
        let (v7, v8) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v6);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg4, v7), 0x2::balance::split<T1>(&mut arg5, v8), v6);
        (v7, v8, arg4, arg5)
    }

    public fun zap_out<T0, T1, T2>(arg0: &mut 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::Registry, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::pool_id(arg2) == 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1), 2);
        let v0 = 0x2::coin::into_balance<T2>(arg3);
        0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::collect_fees<T2>(arg0, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1), &mut v0, 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::constants::zap_out_fee_source(), 0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::registry::zap_fee_pips(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg1)));
        assert!(0x2::balance::value<T2>(&v0) >= arg4, 1);
        let v1 = init_witness();
        0x959b182abc9cfb02be3bd8efa9b96d574fe48a4e28ea6b724fe48b327235242::events::emit_zapped_out<MagmaWitness>(arg0, &v1, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg2), 0x1::type_name::with_original_ids<T2>(), 0x2::balance::value<T2>(&v0));
        0x2::coin::from_balance<T2>(v0, arg5)
    }

    // decompiled from Move bytecode v6
}

