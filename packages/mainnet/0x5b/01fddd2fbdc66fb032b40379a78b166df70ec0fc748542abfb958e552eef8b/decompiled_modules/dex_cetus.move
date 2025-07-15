module 0x5b01fddd2fbdc66fb032b40379a78b166df70ec0fc748542abfb958e552eef8b::dex_cetus {
    struct CetusPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        current_sqrt_price: u256,
        current_tick_index: u32,
        fee_rate: u64,
        tick_spacing: u32,
        liquidity: u128,
        protocol_fee_rate: u64,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
        reward_infos: vector<RewardInfo>,
        is_pause: bool,
    }

    struct RewardInfo has store {
        reward_coin_type: vector<u8>,
        emissions_per_second: u128,
        growth_global: u128,
    }

    struct SwapParams has copy, drop, store {
        pool_id: 0x2::object::ID,
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
        sqrt_price_limit: u256,
        is_exact_in: bool,
    }

    struct SwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        after_sqrt_price: u256,
        is_exceed: bool,
        step_results: vector<u64>,
        reward_amount: u64,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        sqrt_price_before: u256,
        sqrt_price_after: u256,
        liquidity: u128,
        fee_amount: u64,
        timestamp: u64,
    }

    struct PositionInfo has copy, drop, store {
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower_index: u32,
        tick_upper_index: u32,
        liquidity: u128,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        fee_owed_a: u64,
        fee_owed_b: u64,
        reward_amount_owed: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut CetusPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::balance::split<T0>(&mut v0, arg3));
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::balance::split<T1>(&mut v1, arg4));
        arg0.liquidity = arg0.liquidity + (arg3 as u128) + (arg4 as u128);
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        if (0x2::balance::value<T1>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T1>(v1);
        };
    }

    public fun atomic_arbitrage_swap<T0>(arg0: &mut CetusPool<0x2::sui::SUI, T0>, arg1: &mut CetusPool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u256, arg5: u256, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 == 10000000, 4);
        let (v1, _) = swap_a2b<0x2::sui::SUI, T0>(arg0, arg2, v0, arg4, arg6, arg7);
        let v3 = v1;
        let (v4, _) = swap_a2b<T0, 0x2::sui::SUI>(arg1, v3, 0x2::coin::value<T0>(&v3), arg5, arg6, arg7);
        let v6 = v4;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v6) > v0 + arg3, 3);
        v6
    }

    fun calculate_clmm_amount_out(arg0: u64, arg1: u256, arg2: u256, arg3: u64, arg4: u128, arg5: bool) : u64 {
        let v0 = if (arg5) {
            let v1 = (((arg0 * (1000000 - arg3) / 1000000) as u256) << 64) / (arg4 as u256);
            if (arg1 > v1) {
                arg1 - v1
            } else {
                arg2
            }
        } else {
            arg1 + (((arg0 * (1000000 - arg3) / 1000000) as u256) << 64) / (arg4 as u256)
        };
        let v2 = if (arg5) {
            if (v0 < arg2) {
                arg2
            } else {
                v0
            }
        } else if (v0 > arg2) {
            arg2
        } else {
            v0
        };
        let v3 = if (arg1 > v2) {
            arg1 - v2
        } else {
            v2 - arg1
        };
        (((arg4 as u256) * v3 >> 64) as u64)
    }

    public fun calculate_min_amount_out(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 10000
    }

    fun calculate_new_sqrt_price(arg0: u256, arg1: u128, arg2: u64, arg3: bool) : u256 {
        let v0 = ((arg2 as u256) << 64) / (arg1 as u256);
        if (arg3) {
            if (arg0 > v0) {
                arg0 - v0
            } else {
                4295128739
            }
        } else {
            let v2 = arg0 + v0;
            if (v2 > 79226673515401279992447579055) {
                79226673515401279992447579055
            } else {
                v2
            }
        }
    }

    public fun calculate_price_impact<T0, T1>(arg0: &CetusPool<T0, T1>, arg1: u64, arg2: bool) : u256 {
        let v0 = arg0.current_sqrt_price;
        let v1 = calculate_new_sqrt_price(v0, arg0.liquidity, arg1, arg2);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        v2 * 10000 / v0
    }

    public fun create_pool<T0, T1>(arg0: u256, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : CetusPool<T0, T1> {
        CetusPool<T0, T1>{
            id                  : 0x2::object::new(arg3),
            coin_a              : 0x2::balance::zero<T0>(),
            coin_b              : 0x2::balance::zero<T1>(),
            current_sqrt_price  : arg0,
            current_tick_index  : sqrt_price_to_tick(arg0),
            fee_rate            : arg2,
            tick_spacing        : arg1,
            liquidity           : 0,
            protocol_fee_rate   : 0,
            fee_growth_global_a : 0,
            fee_growth_global_b : 0,
            reward_infos        : 0x1::vector::empty<RewardInfo>(),
            is_pause            : false,
        }
    }

    public fun get_current_tick_index<T0, T1>(arg0: &CetusPool<T0, T1>) : u32 {
        arg0.current_tick_index
    }

    public fun get_default_tick_spacing() : u32 {
        60
    }

    public fun get_fee_growth_globals<T0, T1>(arg0: &CetusPool<T0, T1>) : (u128, u128) {
        (arg0.fee_growth_global_a, arg0.fee_growth_global_b)
    }

    public fun get_global_config_address() : address {
        @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f
    }

    public fun get_pool_contract_address() : address {
        @0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be
    }

    public fun get_pool_fee_rate<T0, T1>(arg0: &CetusPool<T0, T1>) : u64 {
        arg0.fee_rate
    }

    public fun get_pool_liquidity<T0, T1>(arg0: &CetusPool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun get_pool_reserves<T0, T1>(arg0: &CetusPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    public fun get_pool_sqrt_price<T0, T1>(arg0: &CetusPool<T0, T1>) : u256 {
        arg0.current_sqrt_price
    }

    public fun get_pool_tick_spacing<T0, T1>(arg0: &CetusPool<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public fun get_protocol_fee_rate() : u64 {
        3000
    }

    public fun get_protocol_package_address() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun is_pool_paused<T0, T1>(arg0: &CetusPool<T0, T1>) : bool {
        arg0.is_pause
    }

    public fun is_valid_sqrt_price(arg0: u256) : bool {
        arg0 >= 4295128739 && arg0 <= 79226673515401279992447579055
    }

    fun sqrt_price_to_tick(arg0: u256) : u32 {
        ((arg0 >> 32) as u32) % 887272
    }

    public fun swap_a2b<T0, T1>(arg0: &mut CetusPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u256, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapResult) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        assert!(arg3 >= 4295128739 && arg3 <= 79226673515401279992447579055, 8);
        assert!(!arg0.is_pause, 2);
        let v1 = arg0.current_sqrt_price;
        let v2 = calculate_clmm_amount_out(v0, v1, arg3, arg0.fee_rate, arg0.liquidity, true);
        let v3 = v0 * arg0.fee_rate / 1000000;
        let v4 = calculate_new_sqrt_price(v1, arg0.liquidity, v0, true);
        arg0.current_sqrt_price = v4;
        arg0.current_tick_index = sqrt_price_to_tick(v4);
        arg0.fee_growth_global_a = arg0.fee_growth_global_a + (v3 as u128) * 18446744073709551616 / arg0.liquidity;
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        let v5 = SwapResult{
            amount_in        : v0,
            amount_out       : v2,
            fee_amount       : v3,
            after_sqrt_price : v4,
            is_exceed        : false,
            step_results     : 0x1::vector::empty<u64>(),
            reward_amount    : 0,
        };
        let v6 = SwapEvent{
            pool_id           : 0x2::object::id<CetusPool<T0, T1>>(arg0),
            user              : 0x2::tx_context::sender(arg5),
            a2b               : true,
            amount_in         : v0,
            amount_out        : v2,
            sqrt_price_before : v1,
            sqrt_price_after  : v4,
            liquidity         : arg0.liquidity,
            fee_amount        : v3,
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SwapEvent>(v6);
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v2), arg5), v5)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut CetusPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u256, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapResult) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 4);
        assert!(arg3 >= 4295128739 && arg3 <= 79226673515401279992447579055, 8);
        assert!(!arg0.is_pause, 2);
        let v1 = arg0.current_sqrt_price;
        let v2 = calculate_clmm_amount_out(v0, v1, arg3, arg0.fee_rate, arg0.liquidity, false);
        let v3 = v0 * arg0.fee_rate / 1000000;
        let v4 = calculate_new_sqrt_price(v1, arg0.liquidity, v0, false);
        arg0.current_sqrt_price = v4;
        arg0.current_tick_index = sqrt_price_to_tick(v4);
        arg0.fee_growth_global_b = arg0.fee_growth_global_b + (v3 as u128) * 18446744073709551616 / arg0.liquidity;
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg1));
        let v5 = SwapResult{
            amount_in        : v0,
            amount_out       : v2,
            fee_amount       : v3,
            after_sqrt_price : v4,
            is_exceed        : false,
            step_results     : 0x1::vector::empty<u64>(),
            reward_amount    : 0,
        };
        let v6 = SwapEvent{
            pool_id           : 0x2::object::id<CetusPool<T0, T1>>(arg0),
            user              : 0x2::tx_context::sender(arg5),
            a2b               : false,
            amount_in         : v0,
            amount_out        : v2,
            sqrt_price_before : v1,
            sqrt_price_after  : v4,
            liquidity         : arg0.liquidity,
            fee_amount        : v3,
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SwapEvent>(v6);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v2), arg5), v5)
    }

    fun tick_to_sqrt_price(arg0: u32) : u256 {
        18446744073709551616 + ((arg0 as u256) << 32)
    }

    // decompiled from Move bytecode v6
}

