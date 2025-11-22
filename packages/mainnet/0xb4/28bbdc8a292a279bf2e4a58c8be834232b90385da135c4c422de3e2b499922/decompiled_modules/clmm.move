module 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::clmm {
    struct CLMMPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        fee_tier: u64,
        tick_spacing: u64,
        current_tick: u64,
        sqrt_price_x64: u128,
        liquidity: u128,
        ticks: 0x2::table::Table<u64, TickInfo>,
        next_position_id: u64,
        protocol_fee_a: 0x2::balance::Balance<T0>,
        protocol_fee_b: 0x2::balance::Balance<T1>,
        treasury_address: address,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
    }

    struct TickInfo has copy, drop, store {
        liquidity_net: u128,
        liquidity_gross: u128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        initialized: bool,
    }

    struct Position<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position_id: u64,
        owner: address,
        pool_id: 0x2::object::ID,
        tick_lower: u64,
        tick_upper: u64,
        liquidity: u128,
        fee_growth_inside_last_a: u128,
        fee_growth_inside_last_b: u128,
        tokens_owed_a: u64,
        tokens_owed_b: u64,
    }

    struct CLMMRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x2::object::ID, bool>,
        total_pools: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        token_a: vector<u8>,
        token_b: vector<u8>,
        fee_tier: u64,
        tick_spacing: u64,
        initial_sqrt_price: u128,
    }

    struct PositionMinted has copy, drop {
        position_id: u64,
        pool_id: 0x2::object::ID,
        owner: address,
        tick_lower: u64,
        tick_upper: u64,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct PositionBurned has copy, drop {
        position_id: u64,
        pool_id: 0x2::object::ID,
        owner: address,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct SwapExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        token_in: vector<u8>,
        token_out: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        sqrt_price_x64: u128,
        current_tick: u64,
        fee_amount: u64,
    }

    struct FeesCollected has copy, drop {
        position_id: u64,
        owner: address,
        amount_a: u64,
        amount_b: u64,
    }

    public fun swap<T0, T1>(arg0: &mut CLMMPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = v0 * arg0.fee_tier / 10000;
        let v2 = v0 - v1;
        let v3 = v1 * 5 / 100;
        let v4 = calculate_swap_output(arg0.sqrt_price_x64, arg0.liquidity, v2, arg3);
        assert!(v4 >= arg2, 5);
        assert!(v4 <= 0x2::balance::value<T1>(&arg0.reserve_b), 4);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        if (v3 > 0) {
            0x2::balance::join<T0>(&mut arg0.protocol_fee_a, 0x2::coin::into_balance<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v3), arg4)));
        };
        if (arg0.liquidity > 0) {
            arg0.fee_growth_global_a = arg0.fee_growth_global_a + ((v1 - v3) as u128) * 18446744073709551616 / arg0.liquidity;
        };
        arg0.sqrt_price_x64 = calculate_new_sqrt_price(arg0.sqrt_price_x64, arg0.liquidity, v2, v4, arg3);
        arg0.current_tick = sqrt_price_to_tick(arg0.sqrt_price_x64);
        let v5 = SwapExecuted{
            pool_id        : 0x2::object::id<CLMMPool<T0, T1>>(arg0),
            trader         : 0x2::tx_context::sender(arg4),
            token_in       : b"CoinA",
            token_out      : b"CoinB",
            amount_in      : v0,
            amount_out     : v4,
            sqrt_price_x64 : arg0.sqrt_price_x64,
            current_tick   : arg0.current_tick,
            fee_amount     : v1,
        };
        0x2::event::emit<SwapExecuted>(v5);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v4), arg4)
    }

    public fun burn_position<T0, T1>(arg0: &mut CLMMPool<T0, T1>, arg1: Position<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 7);
        let Position {
            id                       : v0,
            position_id              : v1,
            owner                    : v2,
            pool_id                  : _,
            tick_lower               : v4,
            tick_upper               : v5,
            liquidity                : v6,
            fee_growth_inside_last_a : _,
            fee_growth_inside_last_b : _,
            tokens_owed_a            : v9,
            tokens_owed_b            : v10,
        } = arg1;
        let (v11, v12) = calculate_amounts_from_liquidity(arg0.sqrt_price_x64, tick_to_sqrt_price(v4), tick_to_sqrt_price(v5), v6);
        update_tick<T0, T1>(arg0, v4, v6, true, arg2);
        update_tick<T0, T1>(arg0, v5, v6, false, arg2);
        if (arg0.current_tick >= v4 && arg0.current_tick < v5) {
            arg0.liquidity = arg0.liquidity - v6;
        };
        let v13 = v11 + v9;
        let v14 = v12 + v10;
        let v15 = PositionBurned{
            position_id : v1,
            pool_id     : 0x2::object::id<CLMMPool<T0, T1>>(arg0),
            owner       : v2,
            liquidity   : v6,
            amount_a    : v13,
            amount_b    : v14,
        };
        0x2::event::emit<PositionBurned>(v15);
        0x2::object::delete(v0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v13), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v14), arg2))
    }

    fun calculate_amounts_from_liquidity(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : (u64, u64) {
        (((arg3 * 18446744073709551616 / arg0) as u64), ((arg3 * arg0 / 18446744073709551616) as u64))
    }

    fun calculate_liquidity(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        let v0 = (arg3 as u128) * arg0 / 18446744073709551616;
        let v1 = (arg4 as u128) * 18446744073709551616 / arg0;
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    fun calculate_new_sqrt_price(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool) : u128 {
        if (arg4) {
            arg0 - ((arg2 as u128) << 32) / arg1
        } else {
            arg0 + ((arg2 as u128) << 32) / arg1
        }
    }

    fun calculate_swap_output(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (((arg2 as u128) * arg1 / (arg1 + (arg2 as u128)) / 2) as u64)
    }

    public fun collect_fees<T0, T1>(arg0: &mut CLMMPool<T0, T1>, arg1: &mut Position<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 7);
        let (v0, v1) = get_fee_growth_inside<T0, T1>(arg0, arg1.tick_lower, arg1.tick_upper);
        arg1.fee_growth_inside_last_a = v0;
        arg1.fee_growth_inside_last_b = v1;
        let v2 = ((arg1.liquidity * (v0 - arg1.fee_growth_inside_last_a) >> 64) as u64) + arg1.tokens_owed_a;
        let v3 = ((arg1.liquidity * (v1 - arg1.fee_growth_inside_last_b) >> 64) as u64) + arg1.tokens_owed_b;
        arg1.tokens_owed_a = 0;
        arg1.tokens_owed_b = 0;
        let v4 = if (v2 > 0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v2), arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        };
        let v5 = if (v3 > 0) {
            0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v3), arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        };
        let v6 = FeesCollected{
            position_id : arg1.position_id,
            owner       : arg1.owner,
            amount_a    : v2,
            amount_b    : v3,
        };
        0x2::event::emit<FeesCollected>(v6);
        (v4, v5)
    }

    public entry fun create_pool<T0, T1>(arg0: &mut CLMMRegistry, arg1: u64, arg2: u128, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 5) {
            true
        } else if (arg1 == 30) {
            true
        } else {
            arg1 == 100
        };
        assert!(v0, 3);
        let v1 = if (arg1 == 5) {
            10
        } else if (arg1 == 30) {
            60
        } else {
            200
        };
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = CLMMPool<T0, T1>{
            id                  : v2,
            reserve_a           : 0x2::balance::zero<T0>(),
            reserve_b           : 0x2::balance::zero<T1>(),
            fee_tier            : arg1,
            tick_spacing        : v1,
            current_tick        : sqrt_price_to_tick(arg2),
            sqrt_price_x64      : arg2,
            liquidity           : 0,
            ticks               : 0x2::table::new<u64, TickInfo>(arg4),
            next_position_id    : 1,
            protocol_fee_a      : 0x2::balance::zero<T0>(),
            protocol_fee_b      : 0x2::balance::zero<T1>(),
            treasury_address    : arg3,
            fee_growth_global_a : 0,
            fee_growth_global_b : 0,
        };
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.pools, v3, true);
        arg0.total_pools = arg0.total_pools + 1;
        let v5 = PoolCreated{
            pool_id            : v3,
            token_a            : b"CoinA",
            token_b            : b"CoinB",
            fee_tier           : arg1,
            tick_spacing       : v1,
            initial_sqrt_price : arg2,
        };
        0x2::event::emit<PoolCreated>(v5);
        0x2::transfer::share_object<CLMMPool<T0, T1>>(v4);
    }

    fun get_fee_growth_inside<T0, T1>(arg0: &CLMMPool<T0, T1>, arg1: u64, arg2: u64) : (u128, u128) {
        let v0 = arg0.current_tick;
        let (v1, v2) = if (0x2::table::contains<u64, TickInfo>(&arg0.ticks, arg1)) {
            let v3 = 0x2::table::borrow<u64, TickInfo>(&arg0.ticks, arg1);
            if (v0 >= arg1) {
                (v3.fee_growth_outside_a, v3.fee_growth_outside_b)
            } else {
                (arg0.fee_growth_global_a - v3.fee_growth_outside_a, arg0.fee_growth_global_b - v3.fee_growth_outside_b)
            }
        } else {
            (0, 0)
        };
        let (v4, v5) = if (0x2::table::contains<u64, TickInfo>(&arg0.ticks, arg2)) {
            let v6 = 0x2::table::borrow<u64, TickInfo>(&arg0.ticks, arg2);
            if (v0 < arg2) {
                (v6.fee_growth_outside_a, v6.fee_growth_outside_b)
            } else {
                (arg0.fee_growth_global_a - v6.fee_growth_outside_a, arg0.fee_growth_global_b - v6.fee_growth_outside_b)
            }
        } else {
            (0, 0)
        };
        (arg0.fee_growth_global_a - v1 - v4, arg0.fee_growth_global_b - v2 - v5)
    }

    public fun get_pool_state<T0, T1>(arg0: &CLMMPool<T0, T1>) : (u64, u64, u128, u64, u128) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b), arg0.sqrt_price_x64, arg0.current_tick, arg0.liquidity)
    }

    public fun get_position_info<T0, T1>(arg0: &Position<T0, T1>) : (u64, u64, u64, u128) {
        (arg0.position_id, arg0.tick_lower, arg0.tick_upper, arg0.liquidity)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CLMMRegistry{
            id          : 0x2::object::new(arg0),
            pools       : 0x2::table::new<0x2::object::ID, bool>(arg0),
            total_pools : 0,
        };
        0x2::transfer::share_object<CLMMRegistry>(v0);
    }

    public fun mint_position<T0, T1>(arg0: &mut CLMMPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (Position<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg3 < arg4, 1);
        assert!(arg3 >= 0 && arg4 <= 887272, 1);
        assert!(arg3 % arg0.tick_spacing == 0 && arg4 % arg0.tick_spacing == 0, 1);
        let v0 = calculate_liquidity(arg0.sqrt_price_x64, tick_to_sqrt_price(arg3), tick_to_sqrt_price(arg4), arg5, arg6);
        assert!(v0 > 0, 9);
        let (v1, v2) = calculate_amounts_from_liquidity(arg0.sqrt_price_x64, tick_to_sqrt_price(arg3), tick_to_sqrt_price(arg4), v0);
        assert!(v1 >= arg7 && v2 >= arg8, 5);
        assert!(v1 <= 0x2::coin::value<T0>(&arg1) && v2 <= 0x2::coin::value<T1>(&arg2), 2);
        update_tick<T0, T1>(arg0, arg3, v0, false, arg9);
        update_tick<T0, T1>(arg0, arg4, v0, true, arg9);
        if (arg0.current_tick >= arg3 && arg0.current_tick < arg4) {
            arg0.liquidity = arg0.liquidity + v0;
        };
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg9)));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v2, arg9)));
        let v3 = arg0.next_position_id;
        arg0.next_position_id = arg0.next_position_id + 1;
        let v4 = 0x2::object::id<CLMMPool<T0, T1>>(arg0);
        let (v5, v6) = get_fee_growth_inside<T0, T1>(arg0, arg3, arg4);
        let v7 = Position<T0, T1>{
            id                       : 0x2::object::new(arg9),
            position_id              : v3,
            owner                    : 0x2::tx_context::sender(arg9),
            pool_id                  : v4,
            tick_lower               : arg3,
            tick_upper               : arg4,
            liquidity                : v0,
            fee_growth_inside_last_a : v5,
            fee_growth_inside_last_b : v6,
            tokens_owed_a            : 0,
            tokens_owed_b            : 0,
        };
        let v8 = PositionMinted{
            position_id : v3,
            pool_id     : v4,
            owner       : 0x2::tx_context::sender(arg9),
            tick_lower  : arg3,
            tick_upper  : arg4,
            liquidity   : v0,
            amount_a    : v1,
            amount_b    : v2,
        };
        0x2::event::emit<PositionMinted>(v8);
        (v7, arg1, arg2)
    }

    fun sqrt_price_to_tick(arg0: u128) : u64 {
        ((arg0 >> 48) as u64)
    }

    fun tick_to_sqrt_price(arg0: u64) : u128 {
        (arg0 as u128) << 48
    }

    fun update_tick<T0, T1>(arg0: &mut CLMMPool<T0, T1>, arg1: u64, arg2: u128, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<u64, TickInfo>(&arg0.ticks, arg1)) {
            *0x2::table::borrow<u64, TickInfo>(&arg0.ticks, arg1)
        } else {
            TickInfo{liquidity_net: 0, liquidity_gross: 0, fee_growth_outside_a: 0, fee_growth_outside_b: 0, initialized: false}
        };
        let v1 = v0;
        v1.liquidity_gross = v1.liquidity_gross + arg2;
        if (arg3) {
            v1.liquidity_net = v1.liquidity_net - arg2;
        } else {
            v1.liquidity_net = v1.liquidity_net + arg2;
        };
        v1.initialized = true;
        if (0x2::table::contains<u64, TickInfo>(&arg0.ticks, arg1)) {
            *0x2::table::borrow_mut<u64, TickInfo>(&mut arg0.ticks, arg1) = v1;
        } else {
            0x2::table::add<u64, TickInfo>(&mut arg0.ticks, arg1, v1);
        };
    }

    // decompiled from Move bytecode v6
}

