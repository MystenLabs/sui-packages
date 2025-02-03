module 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick {
    struct TickManager has store {
        tick_spacing: u32,
        ticks: 0x2::table::Table<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>,
        bitmap: 0x2::table::Table<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, u256>,
    }

    struct TickInfo has copy, drop, store {
        index: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        sqrt_price: u128,
        liquidity_gross: u128,
        liquidity_net: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::I128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        tick_cumulative_out_side: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i64::I64,
        seconds_per_liquidity_out_side: u256,
        seconds_out_side: u64,
    }

    public(friend) fun remove(arg0: &mut TickManager, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) {
        0x2::table::remove<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>(&mut arg0.ticks, arg1);
    }

    public fun bitmap(arg0: &TickManager) : &0x2::table::Table<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, u256> {
        &arg0.bitmap
    }

    public fun create_tick(arg0: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) : TickInfo {
        TickInfo{
            index                          : arg0,
            sqrt_price                     : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::get_sqrt_price_at_tick(arg0),
            liquidity_gross                : 0,
            liquidity_net                  : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::zero(),
            fee_growth_outside_a           : 0,
            fee_growth_outside_b           : 0,
            tick_cumulative_out_side       : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i64::zero(),
            seconds_per_liquidity_out_side : 0,
            seconds_out_side               : 0,
        }
    }

    public fun get_growth_inside(arg0: &TickManager, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg2: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg3: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg4: u128, arg5: u128) : (u128, u128) {
        let (v0, v1) = get_growth_outside(arg0, arg1);
        let (v2, v3) = get_growth_outside(arg0, arg2);
        let (v4, v5) = if (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::gte(arg3, arg1)) {
            (v0, v1)
        } else {
            (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(arg4, v0), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(arg5, v1))
        };
        let (v6, v7) = if (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::lt(arg3, arg2)) {
            (v2, v3)
        } else {
            (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(arg4, v2), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(arg5, v3))
        };
        (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(arg4, v4), v6), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_sub(arg5, v5), v7))
    }

    public fun get_growth_outside(arg0: &TickManager, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) : (u128, u128) {
        if (!is_tick_initialized(arg0, arg1)) {
            (0, 0)
        } else {
            let v2 = 0x2::table::borrow<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>(&arg0.ticks, arg1);
            (v2.fee_growth_outside_a, v2.fee_growth_outside_b)
        }
    }

    public(friend) fun get_mutable_tick_from_manager(arg0: &mut TickManager, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) : &mut TickInfo {
        let v0 = &mut arg0.ticks;
        get_mutable_tick_from_table(v0, arg1)
    }

    public(friend) fun get_mutable_tick_from_table(arg0: &mut 0x2::table::Table<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) : &mut TickInfo {
        if (!0x2::table::contains<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>(arg0, arg1)) {
            0x2::table::add<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>(arg0, arg1, create_tick(arg1));
        };
        0x2::table::borrow_mut<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>(arg0, arg1)
    }

    public fun get_tick_from_manager(arg0: &TickManager, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) : &TickInfo {
        get_tick_from_table(&arg0.ticks, arg1)
    }

    public fun get_tick_from_table(arg0: &0x2::table::Table<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) : &TickInfo {
        0x2::table::borrow<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>(arg0, arg1)
    }

    public(friend) fun initialize_manager(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : TickManager {
        TickManager{
            tick_spacing : arg0,
            ticks        : 0x2::table::new<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>(arg1),
            bitmap       : 0x2::table::new<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, u256>(arg1),
        }
    }

    public fun is_tick_initialized(arg0: &TickManager, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32) : bool {
        0x2::table::contains<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, TickInfo>(&arg0.ticks, arg1)
    }

    public fun liquidity_gross(arg0: &TickInfo) : u128 {
        arg0.liquidity_gross
    }

    public fun liquidity_net(arg0: &TickInfo) : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::I128 {
        arg0.liquidity_net
    }

    public(friend) fun mutable_bitmap(arg0: &mut TickManager) : &mut 0x2::table::Table<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, u256> {
        &mut arg0.bitmap
    }

    public fun sqrt_price(arg0: &TickInfo) : u128 {
        arg0.sqrt_price
    }

    public fun tick_spacing(arg0: &TickManager) : u32 {
        arg0.tick_spacing
    }

    public(friend) fun update(arg0: &mut TickManager, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg2: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32, arg3: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::I128, arg4: u128, arg5: u128, arg6: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i64::I64, arg7: u256, arg8: u64, arg9: bool) : bool {
        let v0 = &mut arg0.ticks;
        let v1 = get_mutable_tick_from_table(v0, arg1);
        let v2 = v1.liquidity_gross;
        let v3 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::liquidity_math::add_delta(v2, arg3);
        if (v2 == 0) {
            if (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::lte(arg1, arg2)) {
                v1.fee_growth_outside_a = arg4;
                v1.fee_growth_outside_b = arg5;
                v1.seconds_per_liquidity_out_side = arg7;
                v1.tick_cumulative_out_side = arg6;
                v1.seconds_out_side = arg8;
            };
        };
        v1.liquidity_gross = v3;
        let v4 = if (arg9) {
            0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::sub(v1.liquidity_net, arg3)
        } else {
            0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::add(v1.liquidity_net, arg3)
        };
        v1.liquidity_net = v4;
        v3 == 0 != v2 == 0
    }

    // decompiled from Move bytecode v6
}

