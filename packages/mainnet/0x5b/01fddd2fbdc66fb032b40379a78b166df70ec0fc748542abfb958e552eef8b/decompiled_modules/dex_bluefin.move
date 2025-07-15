module 0x5b01fddd2fbdc66fb032b40379a78b166df70ec0fc748542abfb958e552eef8b::dex_bluefin {
    struct BluefinPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        token_a_balance: 0x2::balance::Balance<T0>,
        token_b_balance: 0x2::balance::Balance<T1>,
        current_sqrt_price: u128,
        current_tick: u64,
        liquidity: u128,
        fee_rate: u64,
        tick_spacing: u64,
        position_manager: PositionManager,
        protocol_fee_rate: u64,
    }

    struct PositionManager has store {
        positions: vector<LiquidityPosition>,
        next_position_id: u64,
        total_positions: u64,
    }

    struct LiquidityPosition has store, key {
        id: 0x2::object::UID,
        position_id: u64,
        pool_id: 0x2::object::ID,
        owner: address,
        lower_tick: u64,
        upper_tick: u64,
        liquidity: u128,
        fees_earned_a: u64,
        fees_earned_b: u64,
        created_at: u64,
    }

    struct SwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        sqrt_price_after: u128,
        tick_after: u64,
        liquidity_after: u128,
        protocol_fee: u64,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        token_in: vector<u8>,
        token_out: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        tick_before: u64,
        tick_after: u64,
        timestamp: u64,
    }

    public fun atomic_arbitrage_swap<T0>(arg0: &mut BluefinPool<0x2::sui::SUI, T0>, arg1: &mut BluefinPool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u128, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, SwapResult, SwapResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 == 10000000, 1);
        let (v1, v2) = swap_exact_sui_for_token<T0>(arg0, arg2, 1000, arg4, arg6);
        let (v3, v4) = swap_exact_token_for_sui<T0>(arg1, v1, v0 + arg3, arg5, arg6);
        let v5 = v3;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v5) > v0 + arg3, 4);
        (v5, v2, v4)
    }

    fun calculate_active_liquidity_for_tick(arg0: u64, arg1: &PositionManager) : u128 {
        let v0 = arg1.total_positions;
        if (v0 > 0) {
            1000000000 * (v0 as u128)
        } else {
            1000000000
        }
    }

    fun calculate_clmm_output_amount(arg0: u128, arg1: u128, arg2: u128, arg3: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        ((arg2 * v0 >> 64) as u64) + calculate_tick_adjustment(arg3)
    }

    fun calculate_new_sqrt_price_a_to_b(arg0: u128, arg1: u128, arg2: u64, arg3: u128) : u128 {
        let v0 = arg0 - ((arg2 as u128) << 64) / arg1;
        if (v0 < arg3) {
            arg3
        } else {
            v0
        }
    }

    fun calculate_new_sqrt_price_b_to_a(arg0: u128, arg1: u128, arg2: u64, arg3: u128) : u128 {
        let v0 = arg0 + ((arg2 as u128) << 64) / arg1;
        if (v0 > arg3) {
            arg3
        } else {
            v0
        }
    }

    fun calculate_tick_adjustment(arg0: u64) : u64 {
        if (arg0 % 60 == 0) {
            500
        } else {
            0
        }
    }

    fun calculate_tick_from_sqrt_price(arg0: u128) : u64 {
        ((arg0 >> 32) as u64) / 1000
    }

    public fun create_pool<T0, T1>(arg0: u128, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : BluefinPool<T0, T1> {
        let v0 = PositionManager{
            positions        : 0x1::vector::empty<LiquidityPosition>(),
            next_position_id : 1,
            total_positions  : 0,
        };
        BluefinPool<T0, T1>{
            id                 : 0x2::object::new(arg3),
            token_a_balance    : 0x2::balance::zero<T0>(),
            token_b_balance    : 0x2::balance::zero<T1>(),
            current_sqrt_price : arg0,
            current_tick       : arg1,
            liquidity          : 0,
            fee_rate           : arg2,
            tick_spacing       : 60,
            position_manager   : v0,
            protocol_fee_rate  : 500,
        }
    }

    public fun estimate_swap_output<T0, T1>(arg0: &BluefinPool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let v0 = if (arg2) {
            calculate_new_sqrt_price_a_to_b(arg0.current_sqrt_price, arg0.liquidity, arg1 - arg1 * arg0.fee_rate / 1000000, arg0.current_sqrt_price / 2)
        } else {
            calculate_new_sqrt_price_b_to_a(arg0.current_sqrt_price, arg0.liquidity, arg1 - arg1 * arg0.fee_rate / 1000000, arg0.current_sqrt_price * 2)
        };
        calculate_clmm_output_amount(arg0.current_sqrt_price, v0, arg0.liquidity, arg0.current_tick)
    }

    fun execute_real_bluefin_swap_a_to_b<T0, T1>(arg0: &mut BluefinPool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, SwapResult) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = arg0.current_tick;
        let v2 = v0 * arg0.fee_rate / 1000000;
        let v3 = v2 * arg0.protocol_fee_rate / 1000000;
        let v4 = v2 - v3;
        let v5 = calculate_new_sqrt_price_a_to_b(arg0.current_sqrt_price, arg0.liquidity, v0 - v2, arg3);
        let v6 = calculate_clmm_output_amount(arg0.current_sqrt_price, v5, arg0.liquidity, arg0.current_tick);
        assert!(v6 >= arg2, 3);
        assert!(0x2::balance::value<T1>(&arg0.token_b_balance) >= v6, 7);
        0x2::balance::join<T0>(&mut arg0.token_a_balance, arg1);
        arg0.current_sqrt_price = v5;
        arg0.current_tick = calculate_tick_from_sqrt_price(v5);
        arg0.liquidity = update_liquidity_for_tick_crossing(arg0.liquidity, v1, arg0.current_tick, &arg0.position_manager);
        let v7 = SwapResult{
            amount_in        : v0,
            amount_out       : v6,
            fee_amount       : v4,
            sqrt_price_after : v5,
            tick_after       : arg0.current_tick,
            liquidity_after  : arg0.liquidity,
            protocol_fee     : v3,
        };
        let v8 = SwapEvent{
            pool_id           : 0x2::object::id<BluefinPool<T0, T1>>(arg0),
            trader            : 0x2::tx_context::sender(arg4),
            token_in          : b"TokenA",
            token_out         : b"TokenB",
            amount_in         : v0,
            amount_out        : v6,
            fee_amount        : v4,
            sqrt_price_before : arg0.current_sqrt_price,
            sqrt_price_after  : v5,
            tick_before       : v1,
            tick_after        : arg0.current_tick,
            timestamp         : 0,
        };
        0x2::event::emit<SwapEvent>(v8);
        (0x2::balance::split<T1>(&mut arg0.token_b_balance, v6), v7)
    }

    fun execute_real_bluefin_swap_b_to_a<T0, T1>(arg0: &mut BluefinPool<T1, T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, SwapResult) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = arg0.current_tick;
        let v2 = v0 * arg0.fee_rate / 1000000;
        let v3 = v2 * arg0.protocol_fee_rate / 1000000;
        let v4 = v2 - v3;
        let v5 = calculate_new_sqrt_price_b_to_a(arg0.current_sqrt_price, arg0.liquidity, v0 - v2, arg3);
        let v6 = calculate_clmm_output_amount(arg0.current_sqrt_price, v5, arg0.liquidity, arg0.current_tick);
        assert!(v6 >= arg2, 3);
        assert!(0x2::balance::value<T1>(&arg0.token_a_balance) >= v6, 7);
        0x2::balance::join<T0>(&mut arg0.token_b_balance, arg1);
        arg0.current_sqrt_price = v5;
        arg0.current_tick = calculate_tick_from_sqrt_price(v5);
        arg0.liquidity = update_liquidity_for_tick_crossing(arg0.liquidity, v1, arg0.current_tick, &arg0.position_manager);
        let v7 = SwapResult{
            amount_in        : v0,
            amount_out       : v6,
            fee_amount       : v4,
            sqrt_price_after : v5,
            tick_after       : arg0.current_tick,
            liquidity_after  : arg0.liquidity,
            protocol_fee     : v3,
        };
        let v8 = SwapEvent{
            pool_id           : 0x2::object::id<BluefinPool<T1, T0>>(arg0),
            trader            : 0x2::tx_context::sender(arg4),
            token_in          : b"TokenB",
            token_out         : b"TokenA",
            amount_in         : v0,
            amount_out        : v6,
            fee_amount        : v4,
            sqrt_price_before : arg0.current_sqrt_price,
            sqrt_price_after  : v5,
            tick_before       : v1,
            tick_after        : arg0.current_tick,
            timestamp         : 0,
        };
        0x2::event::emit<SwapEvent>(v8);
        (0x2::balance::split<T1>(&mut arg0.token_a_balance, v6), v7)
    }

    public fun get_bluefin_package_id() : address {
        @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267
    }

    public fun get_fee_rate() : u64 {
        3000
    }

    public fun get_pool_info<T0, T1>(arg0: &BluefinPool<T0, T1>) : (u128, u64, u64, u128, u64) {
        (arg0.current_sqrt_price, arg0.current_tick, arg0.fee_rate, arg0.liquidity, arg0.position_manager.total_positions)
    }

    public fun get_pool_reserves<T0, T1>(arg0: &BluefinPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.token_a_balance), 0x2::balance::value<T1>(&arg0.token_b_balance))
    }

    public fun get_tick_spacing() : u64 {
        60
    }

    public fun is_swap_profitable<T0, T1>(arg0: &BluefinPool<T0, T1>, arg1: &BluefinPool<T1, T0>, arg2: u64, arg3: u64) : bool {
        estimate_swap_output<T1, T0>(arg1, estimate_swap_output<T0, T1>(arg0, arg2, true), true) > arg2 + arg3
    }

    public fun swap_exact_sui_for_token<T0>(arg0: &mut BluefinPool<0x2::sui::SUI, T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000, 1);
        assert!(v0 == 10000000, 1);
        let (v1, v2) = execute_real_bluefin_swap_a_to_b<0x2::sui::SUI, T0>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), arg2, arg3, arg4);
        (0x2::coin::from_balance<T0>(v1, arg4), v2)
    }

    public fun swap_exact_token_for_sui<T0>(arg0: &mut BluefinPool<T0, 0x2::sui::SUI>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, SwapResult) {
        assert!(0x2::coin::value<T0>(&arg1) >= 1000, 1);
        let (v0, v1) = execute_real_bluefin_swap_a_to_b<T0, 0x2::sui::SUI>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3, arg4);
        (0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), v1)
    }

    fun update_liquidity_for_tick_crossing(arg0: u128, arg1: u64, arg2: u64, arg3: &PositionManager) : u128 {
        if (arg1 == arg2) {
            arg0
        } else {
            calculate_active_liquidity_for_tick(arg2, arg3)
        }
    }

    // decompiled from Move bytecode v6
}

