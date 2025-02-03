module 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::pool {
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
        ticks_manager: 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::TickManager,
        observations_manager: 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::oracle::ObservationManager,
        current_sqrt_price: u128,
        current_tick_index: 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::I32,
        liquidity: u128,
        reward_infos: vector<PoolRewardInfo>,
        is_paused: bool,
        icon_url: 0x1::string::String,
        position_index: u128,
        sequence_number: u128,
    }

    struct PoolRewardInfo has copy, drop, store {
        reward_coin_symbol: 0x1::string::String,
        reward_coin_decimals: u8,
        reward_coin_type: 0x1::string::String,
        last_update_time: u64,
        ended_at_seconds: u64,
        total_reward: u64,
        total_reward_allocated: u64,
        reward_per_seconds: u128,
        reward_growth_global: u128,
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
        current_tick_index: 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::I32,
        is_exceed: bool,
        starting_liquidity: u128,
        liquidity: u128,
        steps: u64,
        step_results: vector<SwapStepResult>,
    }

    struct SwapStepResult has copy, drop, store {
        tick_index_next: 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::I32,
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

    public fun swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg1);
        assert!(!arg2.is_paused, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::pool_is_paused());
        let v0 = swap_in_pool<T0, T1>(arg0, arg2, arg5, arg6, arg7, arg9);
        let (v1, v2) = if (arg6) {
            assert!(v0.amount_calculated >= arg8, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::slippage_exceeds());
            (v0.amount_specified, v0.amount_calculated)
        } else {
            assert!(v0.amount_calculated <= arg8, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::slippage_exceeds());
            (v0.amount_calculated, v0.amount_specified)
        };
        if (arg5) {
            arg3 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::deposit_balance<T0>(&mut arg2.coin_a, arg3, v1);
            0x2::balance::destroy_zero<T1>(arg4);
            arg4 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::withdraw_balance<T1>(&mut arg2.coin_b, v2);
        } else {
            arg4 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::deposit_balance<T1>(&mut arg2.coin_b, arg4, v1);
            0x2::balance::destroy_zero<T0>(arg3);
            arg3 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::withdraw_balance<T0>(&mut arg2.coin_a, v2);
        };
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_swap_event(0x2::object::uid_to_inner(&arg2.id), arg5, v1, v2, 0x2::balance::value<T0>(&arg2.coin_a), 0x2::balance::value<T1>(&arg2.coin_b), v0.fee_amount, v0.starting_liquidity, v0.liquidity, v0.start_sqrt_price, v0.end_sqrt_price, arg2.current_tick_index, v0.is_exceed, arg2.sequence_number);
        (arg3, arg4)
    }

    public fun new<T0, T1>(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: vector<u8>, arg9: u32, arg10: u64, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg12);
        let v1 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::get_tick_at_sqrt_price(arg11);
        let v2 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T0>();
        let v3 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T1>();
        assert!(v2 != v3, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::invalid_coins());
        let v4 = Pool<T0, T1>{
            id                       : v0,
            name                     : 0x1::string::utf8(arg1),
            coin_a                   : 0x2::balance::zero<T0>(),
            coin_b                   : 0x2::balance::zero<T1>(),
            fee_rate                 : arg10,
            protocol_fee_share       : 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::protocol_fee_share(),
            fee_growth_global_coin_a : 0,
            fee_growth_global_coin_b : 0,
            protocol_fee_coin_a      : 0,
            protocol_fee_coin_b      : 0,
            ticks_manager            : 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::initialize_manager(arg9, arg12),
            observations_manager     : 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::oracle::initialize_manager(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::timestamp_seconds(arg0)),
            current_sqrt_price       : arg11,
            current_tick_index       : v1,
            liquidity                : 0,
            reward_infos             : 0x1::vector::empty<PoolRewardInfo>(),
            is_paused                : false,
            icon_url                 : 0x1::string::utf8(arg2),
            position_index           : 0,
            sequence_number          : 0,
        };
        0x2::dynamic_field::add<0x1::string::String, address>(&mut v4.id, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::manager(), 0x2::tx_context::sender(arg12));
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_pool_created_event(0x2::object::uid_to_inner(&v0), v2, 0x1::string::utf8(arg3), arg4, 0x1::string::utf8(arg5), v3, 0x1::string::utf8(arg6), arg7, 0x1::string::utf8(arg8), arg11, v1, arg9, arg10, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::protocol_fee_share());
    }

    public fun add_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &mut 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u128) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg1);
        assert!(0x2::object::id<Pool<T0, T1>>(arg2) == 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::pool_id(arg3), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::position_does_not_belong_to_pool());
        assert!(!arg2.is_paused, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::pool_is_paused());
        let v0 = arg2.liquidity;
        let (v1, v2) = update_data_for_delta_l<T0, T1>(arg0, arg2, arg3, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::from(arg6));
        assert!(0x2::balance::value<T0>(&arg4) >= v1 && 0x2::balance::value<T1>(&arg5) >= v2, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::insufficient_amount());
        arg2.sequence_number = arg2.sequence_number + 1;
        let v3 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::deposit_balance<T0>(&mut arg2.coin_a, arg4, v1);
        let v4 = arg5;
        arg5 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::deposit_balance<T1>(&mut arg2.coin_b, v4, v2);
        arg4 = v3;
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_liquidity_provided_event(0x2::object::id<Pool<T0, T1>>(arg2), 0x2::object::id<0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position>(arg3), v1, v2, 0x2::balance::value<T0>(&arg2.coin_a), 0x2::balance::value<T1>(&arg2.coin_b), arg6, v0, arg2.liquidity, arg2.current_sqrt_price, arg2.current_tick_index, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::lower_tick(arg3), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::upper_tick(arg3), arg2.sequence_number);
        (v1, v2, arg4, arg5)
    }

    public fun add_liquidity_with_fixed_amount<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &mut 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: bool) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg1);
        assert!(0x2::object::id<Pool<T0, T1>>(arg2) == 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::pool_id(arg3), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::position_does_not_belong_to_pool());
        assert!(!arg2.is_paused, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::pool_is_paused());
        let v0 = arg2.liquidity;
        let (v1, _, _) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::swap_math::get_liquidity_by_amount(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::lower_tick(arg3), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::upper_tick(arg3), arg2.current_tick_index, arg2.current_sqrt_price, arg6, arg7);
        let (v4, v5) = update_data_for_delta_l<T0, T1>(arg0, arg2, arg3, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::from(v1));
        arg2.sequence_number = arg2.sequence_number + 1;
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_liquidity_provided_event(0x2::object::id<Pool<T0, T1>>(arg2), 0x2::object::id<0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position>(arg3), v4, v5, 0x2::balance::value<T0>(&arg2.coin_a), 0x2::balance::value<T1>(&arg2.coin_b), v1, v0, arg2.liquidity, arg2.current_sqrt_price, arg2.current_tick_index, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::lower_tick(arg3), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::upper_tick(arg3), arg2.sequence_number);
        (v4, v5, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::deposit_balance<T0>(&mut arg2.coin_a, arg4, v4), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::deposit_balance<T1>(&mut arg2.coin_b, arg5, v5))
    }

    public(friend) fun add_reward_info<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: PoolRewardInfo) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T2>>(&mut arg0.id, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T2>(), 0x2::balance::zero<T2>());
        0x1::vector::push_back<PoolRewardInfo>(&mut arg0.reward_infos, arg1);
    }

    public fun calculate_swap_results<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : SwapResult {
        if (arg1) {
            assert!(arg0.current_sqrt_price > arg4 && arg4 >= 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::min_sqrt_price(), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::invalid_price_limit());
        } else {
            assert!(arg0.current_sqrt_price < arg4 && arg4 <= 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::max_sqrt_price(), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::invalid_price_limit());
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
                tick_index_next  : 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::zero(),
                initialized      : false,
                sqrt_price_start : v1.end_sqrt_price,
                sqrt_price_next  : 0,
                amount_in        : 0,
                amount_out       : 0,
                fee_amount       : 0,
                remaining_amount : 0,
            };
            let (v3, v4) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_bitmap::next_initialized_tick_within_one_word(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::bitmap(&arg0.ticks_manager), v1.current_tick_index, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::tick_spacing(&arg0.ticks_manager), arg1);
            v2.tick_index_next = v3;
            v2.initialized = v4;
            if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::lt(v2.tick_index_next, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::min_tick())) {
                v2.tick_index_next = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::min_tick();
            } else if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::gt(v2.tick_index_next, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::max_tick())) {
                v2.tick_index_next = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::max_tick();
            };
            v2.sqrt_price_next = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::get_sqrt_price_at_tick(v2.tick_index_next);
            let v5 = if (arg1) {
                0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::math_u128::max(v2.sqrt_price_next, arg4)
            } else {
                0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::math_u128::min(v2.sqrt_price_next, arg4)
            };
            let (v6, v7, v8, v9) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::swap_math::compute_swap_step(v1.end_sqrt_price, v5, v1.liquidity, v1.amount_specified_remaining, arg0.fee_rate, arg1, arg2);
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
                let v10 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::full_math_u64::mul_div_floor(v9, arg0.protocol_fee_share, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::fee_rate_denominator());
                v2.fee_amount = v2.fee_amount - v10;
                v1.protocol_fee = v1.protocol_fee + v10;
            };
            if (v1.liquidity > 0) {
                v1.fee_growth_global = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::math_u128::wrapping_add(v1.fee_growth_global, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::full_math_u128::mul_div_floor((v2.fee_amount as u128), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::q64(), v1.liquidity));
            };
            v1.fee_amount = v1.fee_amount + v2.fee_amount;
            v1.steps = v1.steps + 1;
            0x1::vector::push_back<SwapStepResult>(&mut v1.step_results, v2);
            if (v1.end_sqrt_price == v2.sqrt_price_next) {
                if (v2.initialized) {
                    let v11 = if (arg1) {
                        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::neg(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::liquidity_net(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::get_tick_from_manager(&arg0.ticks_manager, v2.tick_index_next)))
                    } else {
                        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::liquidity_net(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::get_tick_from_manager(&arg0.ticks_manager, v2.tick_index_next))
                    };
                    v1.liquidity = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::add_delta(v1.liquidity, v11);
                };
                let v12 = if (arg1) {
                    0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::sub(v2.tick_index_next, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::from(1))
                } else {
                    v2.tick_index_next
                };
                v1.current_tick_index = v12;
                continue
            };
            if (v1.end_sqrt_price != v2.sqrt_price_start) {
                v1.current_tick_index = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::get_tick_at_sqrt_price(v1.end_sqrt_price);
            };
        };
        let v13 = v1.amount_specified_remaining > 0;
        v1.is_exceed = v13;
        0x2::event::emit<SwapResult>(v1);
        v1
    }

    public fun close_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg1);
        let v0 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::liquidity(&arg3);
        let v1 = &mut arg3;
        let (_, _, v4, v5) = collect_fee<T0, T1>(arg0, arg1, arg2, v1);
        let (v6, v7) = if (v0 > 0) {
            let v8 = &mut arg3;
            let (_, _, v11, v12) = remove_liquidity<T0, T1>(arg1, arg2, v8, v0, arg0);
            (v11, v12)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v13 = v7;
        let v14 = v6;
        let (v15, v16, v17, v18) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::del(arg3);
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_position_close_event(v16, v15, v17, v18);
        0x2::balance::join<T0>(&mut v14, v4);
        0x2::balance::join<T1>(&mut v13, v5);
        (v14, v13)
    }

    public fun coin_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    public fun collect_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &mut 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg1);
        assert!(0x2::object::id<Pool<T0, T1>>(arg2) == 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::pool_id(arg3), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::position_does_not_belong_to_pool());
        assert!(!arg2.is_paused, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::pool_is_paused());
        let (v0, v1) = get_accrued_fee<T0, T1>(arg0, arg2, arg3);
        let (v2, v3) = if (v0 > 0 || v1 > 0) {
            let (v4, v5) = withdraw_balances<T0, T1>(arg2, v0, v1);
            0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_user_fee_collected(0x2::object::id<Pool<T0, T1>>(arg2), 0x2::object::id<0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position>(arg3), v0, v1, 0x2::balance::value<T0>(&arg2.coin_a), 0x2::balance::value<T1>(&arg2.coin_b), arg2.sequence_number);
            (v4, v5)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        (v0, v1, v2, v3)
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &mut 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position) : 0x2::balance::Balance<T2> {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg1);
        assert!(0x2::object::id<Pool<T0, T1>>(arg2) == 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::pool_id(arg3), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::position_does_not_belong_to_pool());
        assert!(!arg2.is_paused, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::pool_is_paused());
        let (v0, v1) = get_accrued_rewards<T0, T1, T2>(arg0, arg2, arg3);
        let v2 = v1;
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_user_reward_collected(0x2::object::id<Pool<T0, T1>>(arg2), 0x2::object::id<0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position>(arg3), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T2>(), v2.reward_coin_symbol, v2.reward_coin_decimals, v0, arg2.sequence_number);
        if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T2>() == 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::blue_reward_type()) {
            0x2::balance::zero<T2>()
        } else {
            0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::withdraw_balance<T2>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T2>>(&mut arg2.id, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T2>()), v0)
        }
    }

    public fun current_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.current_sqrt_price
    }

    public fun current_tick_index<T0, T1>(arg0: &Pool<T0, T1>) : 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::I32 {
        arg0.current_tick_index
    }

    public(friend) fun default_reward_info(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64) : PoolRewardInfo {
        PoolRewardInfo{
            reward_coin_symbol     : arg1,
            reward_coin_decimals   : arg2,
            reward_coin_type       : arg0,
            last_update_time       : arg3,
            ended_at_seconds       : arg3,
            total_reward           : 0,
            total_reward_allocated : 0,
            reward_per_seconds     : 0,
            reward_growth_global   : 0,
        }
    }

    fun find_reward_info_index<T0, T1, T2>(arg0: &Pool<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = false;
        while (v0 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos)) {
            if (0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, v0).reward_coin_type == 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T2>()) {
                v1 = v0;
                v2 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v2, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::reward_index_not_found());
        v1
    }

    public fun flash_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg1);
        assert!(!arg2.is_paused, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::pool_is_paused());
        let v0 = swap_in_pool<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
        let (v1, v2) = if (arg4) {
            (v0.amount_specified, v0.amount_calculated)
        } else {
            (v0.amount_calculated, v0.amount_specified)
        };
        let (v3, v4) = if (arg3) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2.coin_b, v2))
        } else {
            (0x2::balance::split<T0>(&mut arg2.coin_a, v2), 0x2::balance::zero<T1>())
        };
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_flash_swap_event(0x2::object::uid_to_inner(&arg2.id), arg3, v1, v2, v0.fee_amount, v0.starting_liquidity, v0.liquidity, v0.start_sqrt_price, v0.end_sqrt_price, arg2.current_tick_index, v0.is_exceed, arg2.sequence_number);
        let v5 = FlashSwapReceipt<T0, T1>{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg2),
            a2b        : arg3,
            pay_amount : v1,
        };
        (v3, v4, v5)
    }

    fun get_accrued_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: &mut 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position) : (u64, u64) {
        if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::liquidity(arg2) > 0) {
            let (_, _) = update_data_for_delta_l<T0, T1>(arg0, arg1, arg2, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::zero());
            arg1.sequence_number = arg1.sequence_number + 1;
        };
        let (v2, v3) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::get_accrued_fee(arg2);
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::set_fee_amounts(arg2, 0, 0);
        (v2, v3)
    }

    fun get_accrued_rewards<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: &mut 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position) : (u64, PoolRewardInfo) {
        if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::liquidity(arg2) > 0) {
            let (_, _) = update_data_for_delta_l<T0, T1>(arg0, arg1, arg2, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::zero());
            arg1.sequence_number = arg1.sequence_number + 1;
        };
        let v2 = find_reward_info_index<T0, T1, T2>(arg1);
        let v3 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::coins_owed_reward(arg2, v2);
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::decrease_reward_amount(arg2, v2, v3);
        (v3, *0x1::vector::borrow<PoolRewardInfo>(&arg1.reward_infos, v2))
    }

    public fun get_pool_manager<T0, T1>(arg0: &Pool<T0, T1>) : address {
        *0x2::dynamic_field::borrow<0x1::string::String, address>(&arg0.id, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::manager())
    }

    public fun get_protocol_fee_for_coin_a<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.protocol_fee_coin_a
    }

    public fun get_protocol_fee_for_coin_b<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.protocol_fee_coin_b
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun open_position<T0, T1>(arg0: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg0);
        let (v0, v1) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::get_tick_range(arg0);
        let v2 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::tick_spacing(&arg1.ticks_manager);
        let v3 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::from_u32(arg2);
        let v4 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::from_u32(arg3);
        assert!(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::lt(v3, v4) && 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::gte(v3, v0) && 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::lte(v4, v1) && 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::abs_u32(v3) % v2 == 0 && 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::abs_u32(v4) % v2 == 0, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::invalid_tick_range());
        let v5 = 0x2::object::id<Pool<T0, T1>>(arg1);
        arg1.position_index = arg1.position_index + 1;
        let v6 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::new(v5, arg1.name, arg1.icon_url, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T0>(), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T1>(), arg1.position_index, v3, v4, arg1.fee_rate, arg4);
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_position_open_event(v5, 0x2::object::id<0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position>(&v6), v3, v4);
        v6
    }

    public fun remove_liquidity<T0, T1>(arg0: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg0);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::pool_id(arg2), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::position_does_not_belong_to_pool());
        assert!(!arg1.is_paused, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::pool_is_paused());
        let v0 = arg1.liquidity;
        let (v1, v2) = update_data_for_delta_l<T0, T1>(arg4, arg1, arg2, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::neg_from(arg3));
        arg1.sequence_number = arg1.sequence_number + 1;
        let (v3, v4) = withdraw_balances<T0, T1>(arg1, v1, v2);
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_liquidity_removed_event(0x2::object::id<Pool<T0, T1>>(arg1), 0x2::object::id<0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position>(arg2), v1, v2, 0x2::balance::value<T0>(&arg1.coin_a), 0x2::balance::value<T1>(&arg1.coin_b), arg3, v0, arg1.liquidity, arg1.current_sqrt_price, arg1.current_tick_index, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::lower_tick(arg2), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::upper_tick(arg2), arg1.sequence_number);
        (v1, v2, v3, v4)
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>) {
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::config::verify_version(arg0);
        assert!(!arg1.is_paused, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::pool_is_paused());
        let FlashSwapReceipt {
            pool_id    : v0,
            a2b        : v1,
            pay_amount : v2,
        } = arg4;
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == v0, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::invalid_pool());
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v2, 0);
            0x2::balance::join<T0>(&mut arg1.coin_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v2, 0);
            0x2::balance::join<T1>(&mut arg1.coin_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
        arg1.sequence_number = arg1.sequence_number + 1;
    }

    public fun sequence_number<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.sequence_number
    }

    public(friend) fun set_protocol_fee_amount<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) {
        arg0.protocol_fee_coin_a = arg1;
        arg0.protocol_fee_coin_b = arg2;
        arg0.sequence_number = arg0.sequence_number + 1;
    }

    fun swap_in_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128) : SwapResult {
        if (arg2) {
            assert!(arg1.current_sqrt_price > arg5 && arg5 >= 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::min_sqrt_price(), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::invalid_price_limit());
        } else {
            assert!(arg1.current_sqrt_price < arg5 && arg5 <= 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::max_sqrt_price(), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::invalid_price_limit());
        };
        let v0 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::timestamp_seconds(arg0);
        let v1 = if (arg2) {
            arg1.fee_growth_global_coin_a
        } else {
            arg1.fee_growth_global_coin_b
        };
        let v2 = SwapResult{
            a2b                        : arg2,
            by_amount_in               : arg3,
            amount_specified           : arg4,
            amount_specified_remaining : arg4,
            amount_calculated          : 0,
            fee_growth_global          : v1,
            fee_amount                 : 0,
            protocol_fee               : 0,
            start_sqrt_price           : arg1.current_sqrt_price,
            end_sqrt_price             : arg1.current_sqrt_price,
            current_tick_index         : arg1.current_tick_index,
            is_exceed                  : false,
            starting_liquidity         : arg1.liquidity,
            liquidity                  : arg1.liquidity,
            steps                      : 0,
            step_results               : 0x1::vector::empty<SwapStepResult>(),
        };
        while (v2.amount_specified_remaining > 0 && v2.end_sqrt_price != arg5) {
            let v3 = SwapStepResult{
                tick_index_next  : 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::zero(),
                initialized      : false,
                sqrt_price_start : v2.end_sqrt_price,
                sqrt_price_next  : 0,
                amount_in        : 0,
                amount_out       : 0,
                fee_amount       : 0,
                remaining_amount : 0,
            };
            let (v4, v5) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_bitmap::next_initialized_tick_within_one_word(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::bitmap(&arg1.ticks_manager), v2.current_tick_index, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::tick_spacing(&arg1.ticks_manager), arg2);
            v3.tick_index_next = v4;
            v3.initialized = v5;
            if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::lt(v3.tick_index_next, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::min_tick())) {
                v3.tick_index_next = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::min_tick();
            } else if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::gt(v3.tick_index_next, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::max_tick())) {
                v3.tick_index_next = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::max_tick();
            };
            v3.sqrt_price_next = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::get_sqrt_price_at_tick(v3.tick_index_next);
            let v6 = if (arg2) {
                0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::math_u128::max(v3.sqrt_price_next, arg5)
            } else {
                0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::math_u128::min(v3.sqrt_price_next, arg5)
            };
            let (v7, v8, v9, v10) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::swap_math::compute_swap_step(v2.end_sqrt_price, v6, v2.liquidity, v2.amount_specified_remaining, arg1.fee_rate, arg2, arg3);
            v2.end_sqrt_price = v9;
            if (arg3) {
                v2.amount_specified_remaining = v2.amount_specified_remaining - v7 - v10;
                v2.amount_calculated = v2.amount_calculated + v8;
            } else {
                v2.amount_specified_remaining = v2.amount_specified_remaining - v8;
                v2.amount_calculated = v2.amount_calculated + v7 + v10;
            };
            v3.amount_in = v7;
            v3.amount_out = v8;
            v3.fee_amount = v10;
            v3.remaining_amount = v2.amount_specified_remaining;
            if (arg1.protocol_fee_share > 0) {
                let v11 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::full_math_u64::mul_div_floor(v10, arg1.protocol_fee_share, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::fee_rate_denominator());
                v3.fee_amount = v3.fee_amount - v11;
                v2.protocol_fee = v2.protocol_fee + v11;
            };
            if (v2.liquidity > 0) {
                v2.fee_growth_global = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::math_u128::wrapping_add(v2.fee_growth_global, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::full_math_u128::mul_div_floor((v3.fee_amount as u128), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::q64(), v2.liquidity));
            };
            v2.fee_amount = v2.fee_amount + v3.fee_amount;
            v2.steps = v2.steps + 1;
            if (v2.end_sqrt_price == v3.sqrt_price_next) {
                let (v12, v13) = if (arg2) {
                    let v13 = arg1.fee_growth_global_coin_b;
                    (v2.fee_growth_global, v13)
                } else {
                    let v12 = arg1.fee_growth_global_coin_a;
                    (v12, v2.fee_growth_global)
                };
                if (v3.initialized) {
                    let (v14, v15) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::oracle::observe_single(&arg1.observations_manager, v0, 0, arg1.current_tick_index, arg1.liquidity);
                    let v16 = update_reward_infos<T0, T1>(arg1, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::timestamp_seconds(arg0));
                    let v17 = if (arg2) {
                        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::neg(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::cross(&mut arg1.ticks_manager, v3.tick_index_next, v12, v13, v16, v14, v15, v0))
                    } else {
                        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::cross(&mut arg1.ticks_manager, v3.tick_index_next, v12, v13, v16, v14, v15, v0)
                    };
                    v2.liquidity = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::add_delta(v2.liquidity, v17);
                };
                let v18 = if (arg2) {
                    0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::sub(v3.tick_index_next, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::from(1))
                } else {
                    v3.tick_index_next
                };
                v2.current_tick_index = v18;
                continue
            };
            if (v2.end_sqrt_price != v3.sqrt_price_start) {
                v2.current_tick_index = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_math::get_tick_at_sqrt_price(v2.end_sqrt_price);
            };
        };
        let v19 = v2.amount_specified_remaining > 0;
        v2.is_exceed = v19;
        update_pool_state<T0, T1>(arg1, v2, v0);
        v2
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    fun update_data_for_delta_l<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Pool<T0, T1>, arg2: &mut 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::Position, arg3: 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::I128) : (u64, u64) {
        let v0 = update_reward_infos<T0, T1>(arg1, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::timestamp_seconds(arg0));
        let v1 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::abs_u128(arg3);
        let v2 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::lower_tick(arg2);
        let v3 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::upper_tick(arg2);
        let v4 = false;
        let v5 = false;
        let v6 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::tick_spacing(&arg1.ticks_manager);
        let v7 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::timestamp_seconds(arg0);
        if (v1 > 0) {
            let (v8, v9) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::oracle::observe_single(&arg1.observations_manager, v7, 0, arg1.current_tick_index, arg1.liquidity);
            let v10 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::update(&mut arg1.ticks_manager, v2, arg1.current_tick_index, arg3, arg1.fee_growth_global_coin_a, arg1.fee_growth_global_coin_b, v0, v8, v9, v7, false);
            v5 = v10;
            let v11 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::update(&mut arg1.ticks_manager, v3, arg1.current_tick_index, arg3, arg1.fee_growth_global_coin_a, arg1.fee_growth_global_coin_b, v0, v8, v9, v7, true);
            v4 = v11;
            if (v10) {
                0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_bitmap::flip_tick(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::mutable_bitmap(&mut arg1.ticks_manager), v2, v6);
            };
            if (v11) {
                0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick_bitmap::flip_tick(0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::mutable_bitmap(&mut arg1.ticks_manager), v3, v6);
            };
        };
        let (v12, v13, v14) = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::get_fee_and_reward_growths_inside(&arg1.ticks_manager, v2, v3, arg1.current_tick_index, arg1.fee_growth_global_coin_a, arg1.fee_growth_global_coin_b, v0);
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::position::update(arg2, arg3, v12, v13, v14);
        if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::lt(arg3, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::zero())) {
            if (v5) {
                0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::remove(&mut arg1.ticks_manager, v2);
            };
            if (v4) {
                0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::tick::remove(&mut arg1.ticks_manager, v3);
            };
        };
        if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::gte(arg1.current_tick_index, v2) && 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::lt(arg1.current_tick_index, v3)) {
            0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::oracle::update(&mut arg1.observations_manager, arg1.current_tick_index, arg1.liquidity, v7);
            arg1.liquidity = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::add_delta(arg1.liquidity, arg3);
        };
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::swap_math::get_amount_by_liquidity(v2, v3, arg1.current_tick_index, arg1.current_sqrt_price, v1, !0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::is_neg(arg3))
    }

    public(friend) fun update_pool_reward_emission<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T2>, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = 0x1::vector::borrow_mut<PoolRewardInfo>(&mut arg0.reward_infos, find_reward_info_index<T0, T1, T2>(arg0));
        let v1 = v0.ended_at_seconds + arg2;
        assert!(v1 > v0.last_update_time, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::invalid_last_update_time());
        if (arg4) {
            v0.total_reward = v0.total_reward + arg3;
        } else {
            v0.total_reward = v0.total_reward + 0x2::balance::value<T2>(&arg1);
        };
        v0.ended_at_seconds = v1;
        v0.reward_per_seconds = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::full_math_u128::mul_div_floor(((v0.total_reward - v0.total_reward_allocated) as u128), (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::q64() as u128), ((v0.ended_at_seconds - v0.last_update_time) as u128));
        0x2::balance::join<T2>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T2>>(&mut arg0.id, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::get_type_string<T2>()), arg1);
        0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::events::emit_update_pool_reward_emission_event(0x2::object::id<Pool<T0, T1>>(arg0), v0.reward_coin_symbol, v0.reward_coin_type, v0.reward_coin_decimals, v0.total_reward, v0.ended_at_seconds, v0.last_update_time, v0.reward_per_seconds);
    }

    fun update_pool_state<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: SwapResult, arg2: u64) {
        if (!0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32::eq(arg0.current_tick_index, arg1.current_tick_index)) {
            arg0.current_sqrt_price = arg1.end_sqrt_price;
            arg0.current_tick_index = arg1.current_tick_index;
            0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::oracle::update(&mut arg0.observations_manager, arg0.current_tick_index, arg0.liquidity, arg2);
        } else {
            arg0.current_sqrt_price = arg1.end_sqrt_price;
        };
        if (arg0.liquidity != arg1.liquidity) {
            arg0.liquidity = arg1.liquidity;
        };
        if (arg1.a2b) {
            arg0.protocol_fee_coin_a = arg0.protocol_fee_coin_a + arg1.protocol_fee;
            arg0.fee_growth_global_coin_a = arg1.fee_growth_global;
        } else {
            arg0.protocol_fee_coin_b = arg0.protocol_fee_coin_b + arg1.protocol_fee;
            arg0.fee_growth_global_coin_b = arg1.fee_growth_global;
        };
        arg0.sequence_number = arg0.sequence_number + 1;
    }

    public(friend) fun update_reward_infos<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos)) {
            let v2 = 0x1::vector::borrow_mut<PoolRewardInfo>(&mut arg0.reward_infos, v1);
            v1 = v1 + 1;
            if (arg1 > v2.last_update_time) {
                let v3 = 0x1::u64::min(arg1, v2.ended_at_seconds);
                if (arg0.liquidity != 0 && v3 > v2.last_update_time) {
                    let v4 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::full_math_u128::full_mul(((v3 - v2.last_update_time) as u128), v2.reward_per_seconds);
                    v2.reward_growth_global = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::math_u128::wrapping_add(v2.reward_growth_global, ((v4 / (arg0.liquidity as u256)) as u128));
                    v2.total_reward_allocated = v2.total_reward_allocated + ((v4 / (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::q64() as u256)) as u64);
                };
                v2.last_update_time = arg1;
            };
            0x1::vector::push_back<u128>(&mut v0, v2.reward_growth_global);
        };
        v0
    }

    public fun verify_pool_manager<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : bool {
        if (*0x2::dynamic_field::borrow<0x1::string::String, address>(&arg0.id, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::manager()) == arg1) {
            return true
        };
        false
    }

    public(friend) fun withdraw_balances<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        arg0.sequence_number = arg0.sequence_number + 1;
        (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::withdraw_balance<T0>(&mut arg0.coin_a, arg1), 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils::withdraw_balance<T1>(&mut arg0.coin_b, arg2))
    }

    // decompiled from Move bytecode v6
}

