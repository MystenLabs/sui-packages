module 0x5b01fddd2fbdc66fb032b40379a78b166df70ec0fc748542abfb958e552eef8b::dex_aftermath {
    struct AftermathPool has store, key {
        id: 0x2::object::UID,
        token_a_reserve: u64,
        token_b_reserve: u64,
        lp_token_supply: u64,
        fee_rate: u64,
        is_stable: bool,
        pool_type: u8,
        created_at: u64,
    }

    struct AftermathRouter has store, key {
        id: 0x2::object::UID,
        pools: vector<0x2::object::ID>,
        protocol_fee: u64,
        max_hops: u8,
        slippage_tolerance: u64,
    }

    struct SwapRoute has copy, drop, store {
        pool_id: 0x2::object::ID,
        token_in: vector<u8>,
        token_out: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        pool_type: u8,
    }

    struct SwapParams has copy, drop, store {
        pool_id: 0x2::object::ID,
        token_in_type: vector<u8>,
        token_out_type: vector<u8>,
        amount_in: u64,
        min_amount_out: u64,
        deadline: u64,
        slippage_tolerance: u64,
    }

    struct SwapEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        user: address,
        token_in: vector<u8>,
        token_out: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        fee_paid: u64,
        timestamp: u64,
    }

    public fun atomic_arbitrage_swap<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 == 10000000, 4);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 6);
        let v1 = swap_exact_input<0x2::sui::SUI, T0>(arg0, arg2, 0, arg4, arg5, arg6);
        let v2 = swap_exact_input<T0, 0x2::sui::SUI>(arg1, v1, v0 + arg3, arg4, arg5, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) > v0 + arg3, 3);
        v2
    }

    public fun balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun build_swap_route(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u8) : SwapRoute {
        SwapRoute{
            pool_id    : arg0,
            token_in   : arg1,
            token_out  : arg2,
            amount_in  : arg3,
            amount_out : calculate_swap_amount_out(arg3, arg0),
            fee        : arg3 * 30 / 10000,
            pool_type  : arg4,
        }
    }

    fun calculate_constant_product_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg2 / (arg1 + arg0)
    }

    fun calculate_stable_swap_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 - arg1 * arg2 / (arg1 + arg0)
    }

    public fun calculate_swap_amount_out(arg0: u64, arg1: 0x2::object::ID) : u64 {
        let (v0, v1, v2, v3) = get_pool_info(arg1);
        if (v3) {
            calculate_stable_swap_amount_out(arg0 * (10000 - v2) / 10000, v0, v1)
        } else {
            calculate_constant_product_amount_out(arg0 * (10000 - v2) / 10000, v0, v1)
        }
    }

    public fun coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun create_pool(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : AftermathPool {
        AftermathPool{
            id              : 0x2::object::new(arg5),
            token_a_reserve : arg0,
            token_b_reserve : arg1,
            lp_token_supply : 0,
            fee_rate        : arg2,
            is_stable       : arg3,
            pool_type       : arg4,
            created_at      : 0,
        }
    }

    public fun create_router(arg0: vector<0x2::object::ID>, arg1: u64, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : AftermathRouter {
        AftermathRouter{
            id                 : 0x2::object::new(arg4),
            pools              : arg0,
            protocol_fee       : arg1,
            max_hops           : arg2,
            slippage_tolerance : arg3,
        }
    }

    public fun get_pool_fee_rate(arg0: &AftermathPool) : u64 {
        arg0.fee_rate
    }

    public fun get_pool_info(arg0: 0x2::object::ID) : (u64, u64, u64, bool) {
        (1000000000, 1000000000, 30, false)
    }

    public fun get_pool_reserves(arg0: &AftermathPool) : (u64, u64) {
        (arg0.token_a_reserve, arg0.token_b_reserve)
    }

    public fun get_pool_type(arg0: &AftermathPool) : u8 {
        arg0.pool_type
    }

    public fun get_router_max_hops(arg0: &AftermathRouter) : u8 {
        arg0.max_hops
    }

    public fun get_router_slippage_tolerance(arg0: &AftermathRouter) : u64 {
        arg0.slippage_tolerance
    }

    public fun is_stable_pool(arg0: &AftermathPool) : bool {
        arg0.is_stable
    }

    public fun merge_balances<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(arg0, arg1);
    }

    public fun multi_hop_swap<T0, T1, T2>(arg0: vector<SwapRoute>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 6);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 4);
        assert!(0x1::vector::length<SwapRoute>(&arg0) > 0, 2);
        let v0 = 0x1::vector::borrow<SwapRoute>(&arg0, 0);
        let v1 = swap_exact_input<T0, T1>(v0.pool_id, arg1, v0.amount_out, arg3, arg4, arg5);
        if (0x1::vector::length<SwapRoute>(&arg0) > 1) {
            swap_exact_input<T1, T2>(0x1::vector::borrow<SwapRoute>(&arg0, 1).pool_id, v1, arg2, arg3, arg4, arg5)
        } else {
            let v3 = 0x2::coin::into_balance<T1>(v1);
            0x2::balance::value<T1>(&v3);
            0x2::balance::destroy_zero<T1>(v3);
            0x2::coin::from_balance<T2>(0x2::balance::zero<T2>(), arg5)
        }
    }

    public fun split_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg2)
    }

    public fun swap_exact_input<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg3, 6);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 4);
        let v2 = calculate_swap_amount_out(v1, arg0);
        assert!(v2 >= arg2, 3);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(arg1));
        let v3 = SwapEvent{
            pool_id    : arg0,
            user       : 0x2::tx_context::sender(arg5),
            token_in   : b"TokenIn",
            token_out  : b"TokenOut",
            amount_in  : v1,
            amount_out : v2,
            fee_paid   : v1 * 30 / 10000,
            timestamp  : v0,
        };
        0x2::event::emit<SwapEvent>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5)
    }

    // decompiled from Move bytecode v6
}

