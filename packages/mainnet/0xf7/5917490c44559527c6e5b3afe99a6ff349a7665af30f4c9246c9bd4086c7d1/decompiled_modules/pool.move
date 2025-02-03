module 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        fee_rate: u64,
        protocol_fee_share: u64,
        fee_growth_global_coin_a: u128,
        fee_growth_global_coin_b: u128,
        protocol_fee_coin_a: u64,
        protocol_fee_coin_b: u64,
        ticks_manager: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::TickManager,
        observations_manager: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::oracle::ObservationManager,
        current_sqrt_price: u128,
        current_tick_index: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        liquidity: u128,
        is_paused: bool,
    }

    struct SwapResult has copy, drop {
        a2b: bool,
        by_amount_in: bool,
        amount_specified: u64,
        amount_specified_remaining: u64,
        amount_calculated: u64,
        fee_growth_global: u128,
        fee_amount: u64,
        protocol_fee: u64,
        start_sqrt_price: u128,
        end_sqrt_price: u128,
        current_tick_index: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        is_exceed: bool,
        starting_liquidity: u128,
        liquidity: u128,
        steps: u64,
        step_results: vector<SwapStepResult>,
    }

    struct SwapStepResult has copy, drop, store {
        tick_index_next: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::I32,
        initialized: bool,
        sqrt_price_start: u128,
        sqrt_price_next: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        remaining_amount: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        pay_amount: u64,
    }

    public fun swap<T0, T1>(arg0: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::verify_version(arg0);
        assert!(!arg1.is_paused, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::pool_is_paused());
        let v0 = calculate_swap_results<T0, T1>(arg1, arg4, arg5, arg6, arg8);
        let (v1, v2) = if (arg5) {
            assert!(v0.amount_calculated >= arg7, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::slippage_exceeds());
            (v0.amount_specified, v0.amount_calculated)
        } else {
            assert!(v0.amount_calculated <= arg7, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::slippage_exceeds());
            (v0.amount_calculated, v0.amount_specified)
        };
        if (arg4) {
            arg2 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::deposit_balance<T0>(&mut arg1.coin_a, arg2, v1);
            0x2::balance::destroy_zero<T1>(arg3);
            arg3 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::withdraw_balance<T1>(&mut arg1.coin_b, v2);
        } else {
            arg3 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::deposit_balance<T1>(&mut arg1.coin_b, arg3, v1);
            0x2::balance::destroy_zero<T0>(arg2);
            arg2 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::withdraw_balance<T0>(&mut arg1.coin_a, v2);
        };
        update_pool_state<T0, T1>(arg1, v0);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_swap_event(0x2::object::uid_to_inner(&arg1.id), 0x2::tx_context::sender(arg9), arg4, v1, v2, v0.fee_amount, v0.starting_liquidity, v0.liquidity, v0.start_sqrt_price, v0.end_sqrt_price, arg1.current_tick_index, v0.is_exceed);
        (arg2, arg3)
    }

    public fun new<T0, T1>(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: address, arg3: address, arg4: u32, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg8);
        let v1 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::get_tick_at_sqrt_price(arg7);
        let v2 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::get_type_string<T0>();
        let v3 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::get_type_string<T1>();
        assert!(v2 != v3, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::invalid_coins());
        let v4 = Pool<T0, T1>{
            id                       : v0,
            name                     : 0x1::string::utf8(arg1),
            coin_a                   : 0x2::balance::zero<T0>(),
            coin_b                   : 0x2::balance::zero<T1>(),
            fee_rate                 : arg5,
            protocol_fee_share       : arg6,
            fee_growth_global_coin_a : 0,
            fee_growth_global_coin_b : 0,
            protocol_fee_coin_a      : 0,
            protocol_fee_coin_b      : 0,
            ticks_manager            : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::initialize_manager(arg4, arg8),
            observations_manager     : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::oracle::initialize_manager(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::timestamp_seconds(arg0)),
            current_sqrt_price       : arg7,
            current_tick_index       : v1,
            liquidity                : 0,
            is_paused                : false,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_pool_created_event(0x2::object::uid_to_inner(&v0), v2, v3, arg2, arg3, arg7, v1, arg4, arg5, arg6);
    }

    public fun add_liquidity<T0, T1>(arg0: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u128, arg6: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::verify_version(arg0);
        assert!(!arg1.is_paused, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::pool_is_paused());
        let v0 = arg1.liquidity;
        let (v1, v2) = update_data_for_delta_l<T0, T1>(arg1, arg2, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::from(arg5), arg6);
        assert!(0x2::balance::value<T0>(&arg3) >= v1 && 0x2::balance::value<T1>(&arg4) >= v2, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::insufficient_amount());
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_liquidity_provided_event(0x2::object::id<Pool<T0, T1>>(arg1), 0x2::object::id<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position>(arg2), v1, v2, arg5, v0, arg1.liquidity, arg1.current_sqrt_price, arg1.current_tick_index);
        (v1, v2, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::deposit_balance<T0>(&mut arg1.coin_a, arg3, v1), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::deposit_balance<T1>(&mut arg1.coin_b, arg4, v2))
    }

    public fun calculate_swap_results<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : SwapResult {
        if (arg1) {
            assert!(arg0.current_sqrt_price > arg4 && arg4 >= 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::min_sqrt_price(), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::invalid_price_limit());
        } else {
            assert!(arg0.current_sqrt_price < arg4 && arg4 <= 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::max_sqrt_price(), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::invalid_price_limit());
        };
        let v0 = if (arg1) {
            arg0.fee_growth_global_coin_a
        } else {
            arg0.fee_growth_global_coin_b
        };
        let v1 = SwapResult{
            a2b                        : arg1,
            by_amount_in               : arg2,
            amount_specified           : arg3,
            amount_specified_remaining : arg3,
            amount_calculated          : 0,
            fee_growth_global          : v0,
            fee_amount                 : 0,
            protocol_fee               : 0,
            start_sqrt_price           : arg0.current_sqrt_price,
            end_sqrt_price             : arg0.current_sqrt_price,
            current_tick_index         : arg0.current_tick_index,
            is_exceed                  : false,
            starting_liquidity         : arg0.liquidity,
            liquidity                  : arg0.liquidity,
            steps                      : 0,
            step_results               : 0x1::vector::empty<SwapStepResult>(),
        };
        while (v1.amount_specified_remaining > 0 && v1.end_sqrt_price != arg4) {
            let v2 = SwapStepResult{
                tick_index_next  : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::zero(),
                initialized      : false,
                sqrt_price_start : v1.end_sqrt_price,
                sqrt_price_next  : 0,
                amount_in        : 0,
                amount_out       : 0,
                fee_amount       : 0,
                remaining_amount : 0,
            };
            let (v3, v4) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_bitmap::next_initialized_tick_within_one_word(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::bitmap(&arg0.ticks_manager), v1.current_tick_index, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::tick_spacing(&arg0.ticks_manager), arg1);
            v2.tick_index_next = v3;
            v2.initialized = v4;
            if (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::lt(v2.tick_index_next, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::min_tick())) {
                v2.tick_index_next = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::min_tick();
            } else if (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::gt(v2.tick_index_next, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::max_tick())) {
                v2.tick_index_next = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::max_tick();
            };
            v2.sqrt_price_next = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::get_sqrt_price_at_tick(v2.tick_index_next);
            let v5 = if (arg1) {
                0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::max(v2.sqrt_price_next, arg4)
            } else {
                0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::min(v2.sqrt_price_next, arg4)
            };
            let (v6, v7, v8, v9) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::swap_math::compute_swap_step(v1.end_sqrt_price, v5, v1.liquidity, v1.amount_specified_remaining, arg0.fee_rate, arg1, arg2);
            v1.end_sqrt_price = v8;
            if (arg2) {
                v1.amount_specified_remaining = v1.amount_specified_remaining - v6 - v9;
                v1.amount_calculated = v1.amount_calculated + v7;
            } else {
                v1.amount_specified_remaining = v1.amount_specified_remaining - v7;
                v1.amount_calculated = v1.amount_calculated + v6 + v9;
            };
            v2.amount_in = v6;
            v2.amount_out = v7;
            v2.fee_amount = v9;
            v2.remaining_amount = v1.amount_specified_remaining;
            if (arg0.protocol_fee_share > 0) {
                let v10 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::full_math_u64::mul_div_floor(v9, arg0.protocol_fee_share, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::constants::fee_rate_denominator());
                v2.fee_amount = v2.fee_amount - v10;
                v1.protocol_fee = v1.protocol_fee + v10;
            };
            if (v1.liquidity > 0) {
                v1.fee_growth_global = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::math_u128::wrapping_add(v1.fee_growth_global, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::full_math_u128::mul_div_floor((v2.fee_amount as u128), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::constants::q64(), v1.liquidity));
            };
            v1.fee_amount = v1.fee_amount + v2.fee_amount;
            v1.steps = v1.steps + 1;
            0x1::vector::push_back<SwapStepResult>(&mut v1.step_results, v2);
            if (v1.end_sqrt_price == v2.sqrt_price_next) {
                if (v2.initialized) {
                    let v11 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::liquidity_net(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::get_tick_from_manager(&arg0.ticks_manager, v2.tick_index_next));
                    if (arg1) {
                        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::neg(v11);
                    };
                    v1.liquidity = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::liquidity_math::add_delta(v1.liquidity, v11);
                };
                let v12 = if (arg1) {
                    0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::sub(v2.tick_index_next, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::from(1))
                } else {
                    v2.tick_index_next
                };
                v1.current_tick_index = v12;
                continue
            };
            if (v1.end_sqrt_price != v2.sqrt_price_start) {
                v1.current_tick_index = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::get_tick_at_sqrt_price(v1.end_sqrt_price);
            };
        };
        let v13 = v1.amount_specified_remaining > 0;
        v1.is_exceed = v13;
        0x2::event::emit<SwapResult>(v1);
        v1
    }

    public fun flash_swap<T0, T1>(arg0: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::verify_version(arg0);
        assert!(!arg1.is_paused, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::pool_is_paused());
        let v0 = calculate_swap_results<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let (v1, v2) = if (arg3) {
            (v0.amount_specified, v0.amount_calculated)
        } else {
            (v0.amount_calculated, v0.amount_specified)
        };
        let (v3, v4) = if (arg2) {
            let v4 = 0x2::balance::split<T1>(&mut arg1.coin_b, v2);
            (0x2::balance::zero<T0>(), v4)
        } else {
            let v3 = 0x2::balance::split<T0>(&mut arg1.coin_a, v2);
            (v3, 0x2::balance::zero<T1>())
        };
        update_pool_state<T0, T1>(arg1, v0);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_flash_swap_event(0x2::object::uid_to_inner(&arg1.id), arg6, arg2, v1, v2, v0.fee_amount, v0.starting_liquidity, v0.liquidity, v0.start_sqrt_price, v0.end_sqrt_price, arg1.current_tick_index, v0.is_exceed);
        let v5 = FlashSwapReceipt<T0, T1>{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg1),
            a2b        : arg2,
            pay_amount : v1,
        };
        (v3, v4, v5)
    }

    public fun get_protocol_fee_for_coin_a<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.protocol_fee_coin_a
    }

    public fun get_protocol_fee_for_coin_b<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.protocol_fee_coin_b
    }

    public fun open_position<T0, T1>(arg0: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg1: &Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position {
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::verify_version(arg0);
        let (v0, v1) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::get_tick_range(arg0);
        let v2 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::tick_spacing(&arg1.ticks_manager);
        let v3 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::from_u32(arg2);
        let v4 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::from_u32(arg3);
        assert!(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::lt(v3, v4) && 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::gte(v3, v0) && 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::lte(v4, v1) && 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::abs_u32(v3) % v2 == 0 && 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::abs_u32(v4) % v2 == 0, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::invalid_tick_range());
        let v5 = 0x2::object::id<Pool<T0, T1>>(arg1);
        let v6 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::new(v5, v3, v4, arg1.fee_rate, arg4);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_position_open_event(0x2::tx_context::sender(arg4), v5, 0x2::object::id<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position>(&v6), v3, v4);
        v6
    }

    public fun remove_liquidity<T0, T1>(arg0: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::verify_version(arg0);
        assert!(!arg1.is_paused, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::pool_is_paused());
        let v0 = arg1.liquidity;
        let (v1, v2) = update_data_for_delta_l<T0, T1>(arg1, arg2, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::neg_from(arg3), arg4);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_liquidity_removed_event(0x2::object::id<Pool<T0, T1>>(arg1), 0x2::object::id<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position>(arg2), v1, v2, arg3, v0, arg1.liquidity, arg1.current_sqrt_price, arg1.current_tick_index);
        (v1, v2, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::withdraw_balance<T0>(&mut arg1.coin_a, v1), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::withdraw_balance<T1>(&mut arg1.coin_b, v2))
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>) {
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::verify_version(arg0);
        let FlashSwapReceipt {
            pool_id    : v0,
            a2b        : v1,
            pay_amount : v2,
        } = arg4;
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == v0, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::invalid_pool());
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v2, 0);
            0x2::balance::join<T0>(&mut arg1.coin_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v2, 0);
            0x2::balance::join<T1>(&mut arg1.coin_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public(friend) fun set_protocol_fee_coin_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.protocol_fee_coin_a = arg1;
    }

    public(friend) fun set_protocol_fee_coin_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.protocol_fee_coin_b = arg1;
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    fun update_data_for_delta_l<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position, arg2: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::I128, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::abs_u128(arg2);
        let v1 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::lower_tick(arg1);
        let v2 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::upper_tick(arg1);
        let v3 = false;
        let v4 = false;
        let v5 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::tick_spacing(&arg0.ticks_manager);
        let v6 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::timestamp_seconds(arg3);
        if (v0 > 0) {
            let (v7, v8) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::oracle::observe_single(&arg0.observations_manager, v6, 0, arg0.current_tick_index, arg0.liquidity);
            let v9 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::update(&mut arg0.ticks_manager, v1, arg0.current_tick_index, arg2, arg0.fee_growth_global_coin_a, arg0.fee_growth_global_coin_b, v7, v8, v6, false);
            v4 = v9;
            let v10 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::update(&mut arg0.ticks_manager, v2, arg0.current_tick_index, arg2, arg0.fee_growth_global_coin_a, arg0.fee_growth_global_coin_b, v7, v8, v6, true);
            v3 = v10;
            if (v9) {
                0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_bitmap::flip_tick(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::mutable_bitmap(&mut arg0.ticks_manager), v1, v5);
            };
            if (v10) {
                0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_bitmap::flip_tick(0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::mutable_bitmap(&mut arg0.ticks_manager), v2, v5);
            };
        };
        let (v11, v12) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::get_growth_inside(&arg0.ticks_manager, v1, v2, arg0.current_tick_index, arg0.fee_growth_global_coin_a, arg0.fee_growth_global_coin_b);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::update(arg1, arg2, v11, v12);
        if (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::lt(arg2, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::zero())) {
            if (v4) {
                0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::remove(&mut arg0.ticks_manager, v1);
            };
            if (v3) {
                0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick::remove(&mut arg0.ticks_manager, v2);
            };
        };
        if (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::gte(arg0.current_tick_index, v1) && 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i32::lt(arg0.current_tick_index, v2)) {
            0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::oracle::update(&mut arg0.observations_manager, v6, arg0.current_tick_index, arg0.liquidity);
            arg0.liquidity = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::liquidity_math::add_delta(arg0.liquidity, arg2);
        };
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::swap_math::get_amount_by_liquidity(v1, v2, arg0.current_tick_index, arg0.current_sqrt_price, v0, !0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::is_neg(arg2))
    }

    fun update_pool_state<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: SwapResult) {
        arg0.current_sqrt_price = arg1.end_sqrt_price;
        arg0.current_tick_index = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::tick_math::get_tick_at_sqrt_price(arg1.end_sqrt_price);
        arg0.liquidity = arg1.liquidity;
        if (arg1.a2b) {
            arg0.protocol_fee_coin_a = arg0.protocol_fee_coin_a + arg1.protocol_fee;
            arg0.fee_growth_global_coin_a = arg1.fee_growth_global;
        } else {
            arg0.protocol_fee_coin_b = arg0.protocol_fee_coin_b + arg1.protocol_fee;
            arg0.fee_growth_global_coin_b = arg1.fee_growth_global;
        };
    }

    public(friend) fun withdraw_balances<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::withdraw_balance<T0>(&mut arg0.coin_a, arg1), 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::withdraw_balance<T1>(&mut arg0.coin_b, arg2))
    }

    // decompiled from Move bytecode v6
}

