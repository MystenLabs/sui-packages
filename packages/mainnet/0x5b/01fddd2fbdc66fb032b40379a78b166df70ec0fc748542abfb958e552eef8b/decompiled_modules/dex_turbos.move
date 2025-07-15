module 0x5b01fddd2fbdc66fb032b40379a78b166df70ec0fc748542abfb958e552eef8b::dex_turbos {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        sqrt_price: u128,
        tick_current_index: u32,
        tick_spacing: u32,
        fee_rate: u64,
        liquidity: u128,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
        fee_protocol_coin_a: u64,
        fee_protocol_coin_b: u64,
        tick_manager: TickManager,
        position_manager: PositionManager,
        is_pause: bool,
    }

    struct TickManager has store {
        ticks: vector<Tick>,
        tick_spacing: u32,
    }

    struct PositionManager has store {
        positions: vector<Position>,
        next_position_id: u64,
    }

    struct Tick has store {
        index: u32,
        sqrt_price: u128,
        liquidity_net: u128,
        liquidity_gross: u128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        initialized: bool,
    }

    struct Position has store {
        id: u64,
        owner: address,
        tick_lower_index: u32,
        tick_upper_index: u32,
        liquidity: u128,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        fee_owed_a: u64,
        fee_owed_b: u64,
    }

    struct SwapResult has drop {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        sqrt_price_new: u128,
        tick_current_index: u32,
    }

    fun calculate_amount_out(arg0: u128, arg1: u128, arg2: u128) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        ((arg2 * v0 >> 64) as u64)
    }

    public fun calculate_min_amount_out(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 10000
    }

    fun calculate_sqrt_price_new(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        if (arg3) {
            arg0 - ((arg2 as u128) << 64) / arg1
        } else {
            arg0 + ((arg2 as u128) << 64) / arg1
        }
    }

    public fun get_current_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        let v0 = arg0.sqrt_price;
        (v0 >> 32) * (v0 >> 32) >> 64
    }

    public fun get_fee_tier<T0, T1>() : u64 {
        3000
    }

    public fun get_pool_info<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u32, u64, u128) {
        (arg0.sqrt_price, arg0.tick_current_index, arg0.fee_rate, arg0.liquidity)
    }

    public fun get_protocol_constants() : (u64, u64, u32) {
        (3000, 1000000, 60)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    fun price_to_tick(arg0: u128) : u32 {
        ((arg0 >> 32) as u32) % 887272
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = arg0.sqrt_price;
        let v2 = arg0.liquidity;
        let v3 = v0 * arg0.fee_rate / 1000000;
        let v4 = calculate_sqrt_price_new(v1, v2, v0 - v3, true);
        let v5 = calculate_amount_out(v1, v4, v2);
        assert!(v5 >= arg2, 1);
        assert!(v4 >= arg3, 2);
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        arg0.sqrt_price = v4;
        arg0.tick_current_index = price_to_tick(v4);
        arg0.fee_growth_global_a = arg0.fee_growth_global_a + (v3 as u128) * 18446744073709551616 / v2;
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v5), arg5)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = arg0.sqrt_price;
        let v2 = arg0.liquidity;
        let v3 = v0 * arg0.fee_rate / 1000000;
        let v4 = calculate_sqrt_price_new(v1, v2, v0 - v3, false);
        let v5 = calculate_amount_out(v1, v4, v2);
        assert!(v5 >= arg2, 1);
        assert!(v4 <= arg3, 2);
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg1));
        arg0.sqrt_price = v4;
        arg0.tick_current_index = price_to_tick(v4);
        arg0.fee_growth_global_b = arg0.fee_growth_global_b + (v3 as u128) * 18446744073709551616 / v2;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v5), arg5)
    }

    fun tick_to_price(arg0: u32) : u128 {
        18446744073709551616 + ((arg0 as u128) << 32)
    }

    // decompiled from Move bytecode v6
}

