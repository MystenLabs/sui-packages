module 0xcfdf422e99550a786bbca6a478a4d319c348ea172dd64b62d93b96c91ebf4731::tick {
    struct TickManager has store {
        tick_spacing: u32,
        ticks: 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>,
        bitmap: 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>,
    }

    struct TickInfo has copy, drop, store {
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        liquidity_gross: u128,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        tick_cumulative_out_side: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64,
        seconds_per_liquidity_out_side: u256,
        seconds_out_side: u64,
        reward_growths_outside: vector<u128>,
    }

    public(friend) fun remove(arg0: &mut TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        0x2::table::remove<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>(&mut arg0.ticks, arg1);
    }

    public fun bitmap(arg0: &TickManager) : &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256> {
        &arg0.bitmap
    }

    fun compute_reward_growths(arg0: vector<u128>, arg1: vector<u128>) : vector<u128> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u128>();
        while (v0 < 0x1::vector::length<u128>(&arg0)) {
            let v2 = if (v0 >= 0x1::vector::length<u128>(&arg1)) {
                0
            } else {
                *0x1::vector::borrow<u128>(&arg1, v0)
            };
            0x1::vector::push_back<u128>(&mut v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(*0x1::vector::borrow<u128>(&arg0, v0), v2));
            v0 = v0 + 1;
        };
        v1
    }

    public fun create_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : TickInfo {
        TickInfo{
            index                          : arg0,
            sqrt_price                     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg0),
            liquidity_gross                : 0,
            liquidity_net                  : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::zero(),
            fee_growth_outside_a           : 0,
            fee_growth_outside_b           : 0,
            tick_cumulative_out_side       : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::zero(),
            seconds_per_liquidity_out_side : 0,
            seconds_out_side               : 0,
            reward_growths_outside         : 0x1::vector::empty<u128>(),
        }
    }

    public(friend) fun cross(arg0: &mut TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u128, arg4: vector<u128>, arg5: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg6: u256, arg7: u64) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128 {
        let v0 = get_mutable_tick_from_manager(arg0, arg1);
        v0.fee_growth_outside_a = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg2, v0.fee_growth_outside_a);
        v0.fee_growth_outside_b = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg3, v0.fee_growth_outside_b);
        v0.reward_growths_outside = compute_reward_growths(arg4, v0.reward_growths_outside);
        v0.seconds_per_liquidity_out_side = arg6 - v0.seconds_per_liquidity_out_side;
        v0.tick_cumulative_out_side = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::sub(arg5, v0.tick_cumulative_out_side);
        v0.seconds_out_side = arg7 - v0.seconds_out_side;
        v0.liquidity_net
    }

    public fun get_fee_and_reward_growths_inside(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: u128, arg5: u128, arg6: vector<u128>) : (u128, u128, vector<u128>) {
        let (v0, v1, v2) = get_fee_and_reward_growths_outside(arg0, arg1);
        let (v3, v4, v5) = get_fee_and_reward_growths_outside(arg0, arg2);
        let (v6, v7, v8) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg3, arg1)) {
            (v0, v1, v2)
        } else {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg4, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg5, v1), compute_reward_growths(arg6, v2))
        };
        let (v9, v10, v11) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg3, arg2)) {
            (v3, v4, v5)
        } else {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg4, v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg5, v4), compute_reward_growths(arg6, v5))
        };
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg4, v6), v9), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::wrapping_sub(arg5, v7), v10), compute_reward_growths(compute_reward_growths(arg6, v8), v11))
    }

    public fun get_fee_and_reward_growths_outside(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (u128, u128, vector<u128>) {
        if (!is_tick_initialized(arg0, arg1)) {
            (0, 0, 0x1::vector::empty<u128>())
        } else {
            let v3 = 0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>(&arg0.ticks, arg1);
            (v3.fee_growth_outside_a, v3.fee_growth_outside_b, v3.reward_growths_outside)
        }
    }

    public(friend) fun get_mutable_tick_from_manager(arg0: &mut TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &mut TickInfo {
        let v0 = &mut arg0.ticks;
        get_mutable_tick_from_table(v0, arg1)
    }

    public(friend) fun get_mutable_tick_from_table(arg0: &mut 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &mut TickInfo {
        if (!0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>(arg0, arg1)) {
            0x2::table::add<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>(arg0, arg1, create_tick(arg1));
        };
        0x2::table::borrow_mut<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>(arg0, arg1)
    }

    public fun get_tick_from_manager(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &TickInfo {
        get_tick_from_table(&arg0.ticks, arg1)
    }

    public fun get_tick_from_table(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &TickInfo {
        0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>(arg0, arg1)
    }

    public(friend) fun initialize_manager(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : TickManager {
        TickManager{
            tick_spacing : arg0,
            ticks        : 0x2::table::new<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>(arg1),
            bitmap       : 0x2::table::new<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg1),
        }
    }

    public fun is_tick_initialized(arg0: &TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, TickInfo>(&arg0.ticks, arg1)
    }

    public fun liquidity_gross(arg0: &TickInfo) : u128 {
        arg0.liquidity_gross
    }

    public fun liquidity_net(arg0: &TickInfo) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128 {
        arg0.liquidity_net
    }

    public(friend) fun mutable_bitmap(arg0: &mut TickManager) : &mut 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256> {
        &mut arg0.bitmap
    }

    public fun sqrt_price(arg0: &TickInfo) : u128 {
        arg0.sqrt_price
    }

    public fun tick_spacing(arg0: &TickManager) : u32 {
        arg0.tick_spacing
    }

    public(friend) fun update(arg0: &mut TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128, arg4: u128, arg5: u128, arg6: vector<u128>, arg7: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg8: u256, arg9: u64, arg10: bool) : bool {
        let v0 = &mut arg0.ticks;
        let v1 = get_mutable_tick_from_table(v0, arg1);
        let v2 = v1.liquidity_gross;
        let v3 = 0xcfdf422e99550a786bbca6a478a4d319c348ea172dd64b62d93b96c91ebf4731::utils::add_delta(v2, arg3);
        if (v2 == 0) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg1, arg2)) {
                v1.fee_growth_outside_a = arg4;
                v1.fee_growth_outside_b = arg5;
                v1.seconds_per_liquidity_out_side = arg8;
                v1.tick_cumulative_out_side = arg7;
                v1.seconds_out_side = arg9;
                v1.reward_growths_outside = arg6;
            } else {
                let v4 = 0;
                while (v4 < 0x1::vector::length<u128>(&arg6)) {
                    0x1::vector::push_back<u128>(&mut v1.reward_growths_outside, 0);
                    v4 = v4 + 1;
                };
            };
        };
        v1.liquidity_gross = v3;
        let v5 = if (arg10) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::sub(v1.liquidity_net, arg3)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::add(v1.liquidity_net, arg3)
        };
        v1.liquidity_net = v5;
        v3 == 0 != v2 == 0
    }

    // decompiled from Move bytecode v6
}

