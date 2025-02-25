module 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault {
    struct LiquidityRange has drop, store {
        lower_offset: u32,
        upper_offset: u32,
        rebalance_threshold: u32,
    }

    struct ClmmVault has store {
        pool_id: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        liquidity_range: LiquidityRange,
        wrapped_position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
    }

    struct MigrateLiquidity has copy, drop {
        old_position: 0x2::object::ID,
        new_position: 0x2::object::ID,
        old_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        old_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        new_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        new_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        amount_a: u64,
        amount_b: u64,
    }

    public fun collect_fee<T0, T1>(arg0: &ClmmVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.wrapped_position), true)
    }

    public fun collect_reward<T0, T1, T2>(arg0: &ClmmVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.wrapped_position), arg3, true, arg4)
    }

    public fun borrow_position(arg0: &ClmmVault) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.wrapped_position)
    }

    public fun coin_types(arg0: &ClmmVault) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_a, arg0.coin_b)
    }

    public fun decrease_liquidity<T0, T1>(arg0: &mut ClmmVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.wrapped_position), arg3, arg4)
    }

    public fun get_liquidity_range(arg0: &ClmmVault) : (u32, u32, u32) {
        let v0 = &arg0.liquidity_range;
        (v0.lower_offset, v0.upper_offset, v0.rebalance_threshold)
    }

    public fun get_position_liquidity(arg0: &ClmmVault) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.wrapped_position))
    }

    public fun increase_liquidity<T0, T1>(arg0: &mut ClmmVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) : (u64, u64, u128) {
        let v0 = 0x2::balance::value<T1>(arg4);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg2);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.wrapped_position));
        let (v5, _, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v3, v4, v1, v2, 0x2::balance::value<T0>(arg3), true);
        let v8 = if (v7 <= v0) {
            v5
        } else {
            let (v9, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v3, v4, v1, v2, v0, false);
            v9
        };
        if (v8 == 0) {
            return (0, 0, 0)
        };
        increase_liquidity_to_clmm<T0, T1>(arg0, arg1, arg2, arg3, arg4, v8, arg5)
    }

    fun increase_liquidity_to_clmm<T0, T1>(arg0: &mut ClmmVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: u128, arg6: &0x2::clock::Clock) : (u64, u64, u128) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.wrapped_position), arg5, arg6);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v0);
        assert!(v1 <= 0x2::balance::value<T0>(arg3), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::amount_in_above_max_limit());
        assert!(v2 <= 0x2::balance::value<T1>(arg4), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::amount_in_above_max_limit());
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(arg3, v1), 0x2::balance::split<T1>(arg4, v2), v0);
        (v1, v2, arg5)
    }

    public fun liquidity_value<T0, T1>(arg0: &ClmmVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.wrapped_position);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), false)
    }

    public fun new<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : ClmmVault {
        let v0 = LiquidityRange{
            lower_offset        : arg2,
            upper_offset        : arg3,
            rebalance_threshold : arg4,
        };
        let (v1, v2) = next_position_range(v0.lower_offset, v0.upper_offset, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1));
        ClmmVault{
            pool_id          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            coin_a           : 0x1::type_name::get<T0>(),
            coin_b           : 0x1::type_name::get<T1>(),
            liquidity_range  : v0,
            wrapped_position : 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2), arg5)),
        }
    }

    public fun next_position_range(arg0: u32, arg1: u32, arg2: u32, arg3: u128) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg3);
        (round_tick_to_spacing(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0)), arg2), round_tick_to_spacing(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1)), arg2))
    }

    public fun pool_id(arg0: &ClmmVault) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun rebalance<T0, T1>(arg0: &mut ClmmVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg6: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, MigrateLiquidity) {
        let v0 = 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.wrapped_position);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v0);
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0);
        let (v4, v5) = decrease_liquidity<T0, T1>(arg0, arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), arg7);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9) = collect_fee<T0, T1>(arg0, arg1, arg2);
        0x2::balance::join<T0>(&mut v7, v8);
        0x2::balance::join<T1>(&mut v6, v9);
        0x2::balance::join<T0>(&mut v7, arg3);
        0x2::balance::join<T1>(&mut v6, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.wrapped_position));
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg6), arg8);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.wrapped_position, v10);
        let v11 = &mut v7;
        let v12 = &mut v6;
        let (_, _, _) = increase_liquidity<T0, T1>(arg0, arg1, arg2, v11, v12, arg7);
        let v16 = MigrateLiquidity{
            old_position   : v3,
            new_position   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v10),
            old_tick_lower : v1,
            old_tick_upper : v2,
            new_tick_upper : arg5,
            new_tick_lower : arg6,
            amount_a       : 0x2::balance::value<T0>(&v7),
            amount_b       : 0x2::balance::value<T1>(&v6),
        };
        (v7, v6, v16)
    }

    public fun rebalance_threshold(arg0: &ClmmVault) : u32 {
        arg0.liquidity_range.rebalance_threshold
    }

    fun round_tick_to_spacing(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) % arg1))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) % arg1))
        }
    }

    public fun update_liquidity_offset(arg0: &mut ClmmVault, arg1: u32, arg2: u32) {
        assert!(arg1 > 0 && arg2 > 0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::invalid_liquidity_range());
        arg0.liquidity_range.lower_offset = arg1;
        arg0.liquidity_range.upper_offset = arg2;
    }

    public fun update_rebalance_threshold(arg0: &mut ClmmVault, arg1: u32) {
        arg0.liquidity_range.rebalance_threshold = arg1;
    }

    // decompiled from Move bytecode v6
}

