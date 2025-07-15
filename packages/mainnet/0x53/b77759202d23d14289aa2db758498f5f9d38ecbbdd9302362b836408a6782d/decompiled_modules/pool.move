module 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        tick_spacing: u32,
        fee_rate: u64,
        liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
        fee_protocol_coin_a: u64,
        fee_protocol_coin_b: u64,
        tick_manager: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::TickManager,
        rewarder_manager: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderManager,
        position_manager: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::PositionManager,
        is_pause: bool,
        index: u64,
        url: 0x1::string::String,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        steps: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        pay_amount: u64,
    }

    struct AddLiquidityReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct FlashLoanReceipt {
        pool_id: 0x2::object::ID,
        loan_a: bool,
        amount: u64,
        fee_amount: u64,
    }

    struct CalculatedSwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        fee_rate: u64,
        after_sqrt_price: u128,
        is_exceed: bool,
        step_results: vector<SwapStepResult>,
    }

    struct SwapStepResult has copy, drop, store {
        current_sqrt_price: u128,
        target_sqrt_price: u128,
        current_liquidity: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        remainder_amount: u64,
    }

    struct OpenPositionEvent has copy, drop, store {
        pool: 0x2::object::ID,
        tick_lower: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32,
        tick_upper: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32,
        position: 0x2::object::ID,
        lock_until: u64,
    }

    struct ClosePositionEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
    }

    struct LockPositionEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        lock_until: u64,
    }

    struct AddLiquidityEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        tick_lower: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32,
        tick_upper: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32,
        liquidity: u128,
        after_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct RemoveLiquidityEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        tick_lower: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32,
        tick_upper: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32,
        liquidity: u128,
        after_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct SwapEvent has copy, drop, store {
        atob: bool,
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        vault_a_amount: u64,
        vault_b_amount: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        steps: u64,
    }

    struct CollectProtocolFeeEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct CollectFeeEvent has copy, drop, store {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct UpdateFeeRateEvent has copy, drop, store {
        pool: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct UpdateEmissionEvent has copy, drop, store {
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        emissions_per_second: u128,
    }

    struct AddRewarderEvent has copy, drop, store {
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
    }

    struct CollectRewardEvent has copy, drop, store {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct FlashLoanEvent has copy, drop, store {
        pool: 0x2::object::ID,
        loan_a: bool,
        amount: u64,
        fee_amount: u64,
        vault_a_amount: u64,
        vault_b_amount: u64,
    }

    public(friend) fun new<T0, T1>(arg0: u32, arg1: u128, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        Pool<T0, T1>{
            id                  : 0x2::object::new(arg6),
            coin_a              : 0x2::balance::zero<T0>(),
            coin_b              : 0x2::balance::zero<T1>(),
            tick_spacing        : arg0,
            fee_rate            : arg2,
            liquidity           : 0,
            current_sqrt_price  : arg1,
            current_tick_index  : 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_tick_at_sqrt_price(arg1),
            fee_growth_global_a : 0,
            fee_growth_global_b : 0,
            fee_protocol_coin_a : 0,
            fee_protocol_coin_b : 0,
            tick_manager        : 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::new(arg0, 0x2::clock::timestamp_ms(arg5), arg6),
            rewarder_manager    : 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::new(),
            position_manager    : 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::new(arg0, arg6),
            is_pause            : false,
            index               : arg4,
            url                 : arg3,
        }
    }

    public fun get_amount_by_liquidity(arg0: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg1: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg2: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg3: u128, arg4: u128, arg5: bool) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        if (0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::lt(arg2, arg0)) {
            (0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_delta_a(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg0), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), 0)
        } else if (0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::lt(arg2, arg1)) {
            (0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_delta_a(arg3, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_delta_b(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg0), arg3, arg4, arg5))
        } else {
            (0, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_delta_b(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg0), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5))
        }
    }

    public fun add_liquidity<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : AddLiquidityReceipt<T0, T1> {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(arg3 != 0, 3);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::pool_id(arg2), 19);
        add_liquidity_internal<T0, T1>(arg1, arg2, false, arg3, 0, false, 0x2::clock::timestamp_ms(arg4) / 1000)
    }

    public fun add_liquidity_fix_coin<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : AddLiquidityReceipt<T0, T1> {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(arg3 > 0, 0);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::pool_id(arg2), 19);
        add_liquidity_internal<T0, T1>(arg1, arg2, true, 0, arg3, arg4, 0x2::clock::timestamp_ms(arg5) / 1000)
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg2: bool, arg3: u128, arg4: u64, arg5: bool, arg6: u64) : AddLiquidityReceipt<T0, T1> {
        assert!(!arg0.is_pause, 13);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::settle(&mut arg0.rewarder_manager, arg0.liquidity, arg6);
        let (v0, v1) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::tick_range(arg1);
        let (v2, v3, v4) = if (arg2) {
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_liquidity_by_amount(v0, v1, arg0.current_tick_index, arg0.current_sqrt_price, arg4, arg5)
        } else {
            let (v5, v6) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_amount_by_liquidity(v0, v1, arg0.current_tick_index, arg0.current_sqrt_price, arg3, true);
            (arg3, v5, v6)
        };
        assert!(v2 > 0, 3);
        let (v7, v8, v9, v10) = get_fee_rewards_points_in_tick_range<T0, T1>(arg0, v0, v1);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::increase_liquidity(&mut arg0.tick_manager, arg0.current_tick_index, v0, v1, v2, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::points_growth_global(&arg0.rewarder_manager), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::rewards_growth_global(&arg0.rewarder_manager));
        if (0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::gte(arg0.current_tick_index, v0) && 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::lt(arg0.current_tick_index, v1)) {
            assert!(0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u128::add_check(arg0.liquidity, v2), 1);
            arg0.liquidity = arg0.liquidity + v2;
        };
        let v11 = AddLiquidityEvent{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg0),
            position        : 0x2::object::id<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(arg1),
            tick_lower      : v0,
            tick_upper      : v1,
            liquidity       : arg3,
            after_liquidity : 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::increase_liquidity(&mut arg0.position_manager, arg1, v2, v7, v8, v10, v9),
            amount_a        : v3,
            amount_b        : v4,
        };
        0x2::event::emit<AddLiquidityEvent>(v11);
        AddLiquidityReceipt<T0, T1>{
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a : v3,
            amount_b : v4,
        }
    }

    public fun add_liquidity_pay_amount<T0, T1>(arg0: &AddLiquidityReceipt<T0, T1>) : (u64, u64) {
        (arg0.amount_a, arg0.amount_b)
    }

    public fun balances<T0, T1>(arg0: &Pool<T0, T1>) : (&0x2::balance::Balance<T0>, &0x2::balance::Balance<T1>) {
        (&arg0.coin_a, &arg0.coin_b)
    }

    public fun borrow_position_info<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::PositionInfo {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::borrow_position_info(&arg0.position_manager, arg1)
    }

    public fun borrow_tick<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32) : &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::Tick {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::borrow_tick(&arg0.tick_manager, arg1)
    }

    public fun calculate_and_update_fee<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID) : (u64, u64) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_liquidity(v0) != 0) {
            let (v3, v4) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_tick_range(v0);
            let (v5, v6) = get_fee_in_tick_range<T0, T1>(arg1, v3, v4);
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::update_fee(&mut arg1.position_manager, arg2, v5, v6)
        } else {
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_fee_owned(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::borrow_position_info(&arg1.position_manager, arg2))
        }
    }

    public fun calculate_and_update_points<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u128 {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_liquidity(v0) != 0) {
            let (v2, v3) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_tick_range(v0);
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::update_points(&mut arg1.position_manager, arg2, get_points_in_tick_range<T0, T1>(arg1, v2, v3))
        } else {
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_points_owned(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::borrow_position_info(&arg1.position_manager, arg2))
        }
    }

    public fun calculate_and_update_reward<T0, T1, T2>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::rewarder_index<T2>(&arg1.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v0), 17);
        let v1 = calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3);
        *0x1::vector::borrow<u64>(&v1, 0x1::option::extract<u64>(&mut v0))
    }

    public fun calculate_and_update_rewards<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : vector<u64> {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_liquidity(v0) != 0) {
            let (v2, v3) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_tick_range(v0);
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::update_rewards(&mut arg1.position_manager, arg2, get_rewards_in_tick_range<T0, T1>(arg1, v2, v3))
        } else {
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::rewards_amount_owned(&arg1.position_manager, arg2)
        }
    }

    public fun calculate_swap_result<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) : CalculatedSwapResult {
        let v0 = arg0.current_sqrt_price;
        let v1 = arg0.liquidity;
        let v2 = default_swap_result();
        let v3 = arg3;
        let v4 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::first_score_for_swap(&arg0.tick_manager, arg0.current_tick_index, arg1);
        let v5 = CalculatedSwapResult{
            amount_in        : 0,
            amount_out       : 0,
            fee_amount       : 0,
            fee_rate         : arg0.fee_rate,
            after_sqrt_price : arg0.current_sqrt_price,
            is_exceed        : false,
            step_results     : 0x1::vector::empty<SwapStepResult>(),
        };
        while (v3 > 0) {
            if (0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::option_u64::is_none(&v4)) {
                v5.is_exceed = true;
                break
            };
            let (v6, v7) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::borrow_tick_for_swap(&arg0.tick_manager, 0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::option_u64::borrow(&v4), arg1);
            v4 = v7;
            let v8 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::sqrt_price(v6);
            let (v9, v10, v11, v12) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::compute_swap_step(v0, v8, v1, v3, arg0.fee_rate, arg1, arg2);
            if (v9 != 0 || v12 != 0) {
                if (arg2) {
                    let v13 = check_remainer_amount_sub(v3, v9);
                    v3 = check_remainer_amount_sub(v13, v12);
                } else {
                    v3 = check_remainer_amount_sub(v3, v10);
                };
                let v14 = &mut v2;
                update_swap_result(v14, v9, v10, v12);
            };
            let v15 = SwapStepResult{
                current_sqrt_price : v0,
                target_sqrt_price  : v8,
                current_liquidity  : v1,
                amount_in          : v9,
                amount_out         : v10,
                fee_amount         : v12,
                remainder_amount   : v3,
            };
            0x1::vector::push_back<SwapStepResult>(&mut v5.step_results, v15);
            if (v11 == v8) {
                v0 = v8;
                let v16 = if (arg1) {
                    0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i128::neg(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::liquidity_net(v6))
                } else {
                    0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::liquidity_net(v6)
                };
                if (!0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i128::is_neg(v16)) {
                    let v17 = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i128::abs_u128(v16);
                    assert!(0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u128::add_check(v1, v17), 1);
                    v1 = v1 + v17;
                    continue
                };
                let v18 = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i128::abs_u128(v16);
                assert!(v1 >= v18, 1);
                v1 = v1 - v18;
                continue
            };
            v0 = v11;
        };
        v5.amount_in = v2.amount_in;
        v5.amount_out = v2.amount_out;
        v5.fee_amount = v2.fee_amount;
        v5.after_sqrt_price = v0;
        v5
    }

    public fun calculate_swap_result_step_results(arg0: &CalculatedSwapResult) : &vector<SwapStepResult> {
        &arg0.step_results
    }

    public fun calculated_swap_result_after_sqrt_price(arg0: &CalculatedSwapResult) : u128 {
        arg0.after_sqrt_price
    }

    public fun calculated_swap_result_amount_in(arg0: &CalculatedSwapResult) : u64 {
        arg0.amount_in
    }

    public fun calculated_swap_result_amount_out(arg0: &CalculatedSwapResult) : u64 {
        arg0.amount_out
    }

    public fun calculated_swap_result_fee_amount(arg0: &CalculatedSwapResult) : u64 {
        arg0.fee_amount
    }

    public fun calculated_swap_result_is_exceed(arg0: &CalculatedSwapResult) : bool {
        arg0.is_exceed
    }

    public fun calculated_swap_result_step_swap_result(arg0: &CalculatedSwapResult, arg1: u64) : &SwapStepResult {
        0x1::vector::borrow<SwapStepResult>(&arg0.step_results, arg1)
    }

    public fun calculated_swap_result_steps_length(arg0: &CalculatedSwapResult) : u64 {
        0x1::vector::length<SwapStepResult>(&arg0.step_results)
    }

    fun check_remainer_amount_sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 5);
        arg0 - arg1
    }

    public fun close_position<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::pool_id(&arg2), 19);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::close_position(&mut arg1.position_manager, arg2);
        let v0 = ClosePositionEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            position : 0x2::object::id<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(&arg2),
        };
        0x2::event::emit<ClosePositionEvent>(v0);
    }

    public fun collect_fee<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::pool_id(arg2), 19);
        let v0 = 0x2::object::id<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(arg2);
        let (v1, v2) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::tick_range(arg2);
        let (v3, v4) = if (arg3 && 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::liquidity(arg2) != 0) {
            let (v5, v6) = get_fee_in_tick_range<T0, T1>(arg1, v1, v2);
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::update_and_reset_fee(&mut arg1.position_manager, v0, v5, v6)
        } else {
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::reset_fee(&mut arg1.position_manager, v0)
        };
        let v7 = CollectFeeEvent{
            position : v0,
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            amount_a : v3,
            amount_b : v4,
        };
        0x2::event::emit<CollectFeeEvent>(v7);
        (0x2::balance::split<T0>(&mut arg1.coin_a, v3), 0x2::balance::split<T1>(&mut arg1.coin_b, v4))
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = arg1.fee_protocol_coin_a;
        let v1 = arg1.fee_protocol_coin_b;
        arg1.fee_protocol_coin_a = 0;
        arg1.fee_protocol_coin_b = 0;
        let v2 = CollectProtocolFeeEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            amount_a : v0,
            amount_b : v1,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v2);
        (0x2::balance::split<T0>(&mut arg1.coin_a, v0), 0x2::balance::split<T1>(&mut arg1.coin_b, v1))
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderGlobalVault, arg4: bool, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::pool_id(arg2), 19);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v0 = 0x2::object::id<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(arg2);
        let v1 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::rewarder_index<T2>(&arg1.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v1), 17);
        let v2 = 0x1::option::extract<u64>(&mut v1);
        let v3 = if (arg4 && 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::liquidity(arg2) != 0 || 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::inited_rewards_count(&arg1.position_manager, v0) <= v2) {
            let (v4, v5) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::tick_range(arg2);
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::update_and_reset_rewards(&mut arg1.position_manager, v0, get_rewards_in_tick_range<T0, T1>(arg1, v4, v5), v2)
        } else {
            0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::reset_rewarder(&mut arg1.position_manager, v0, v2)
        };
        let v6 = CollectRewardEvent{
            position      : v0,
            pool          : 0x2::object::id<Pool<T0, T1>>(arg1),
            rewarder_type : 0x1::type_name::get<T2>(),
            amount        : v3,
        };
        0x2::event::emit<CollectRewardEvent>(v6);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::withdraw_reward<T2>(arg3, v3)
    }

    public fun current_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.current_sqrt_price
    }

    public fun current_tick_index<T0, T1>(arg0: &Pool<T0, T1>) : 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32 {
        arg0.current_tick_index
    }

    fun default_swap_result() : SwapResult {
        SwapResult{
            amount_in  : 0,
            amount_out : 0,
            fee_amount : 0,
            steps      : 0,
        }
    }

    public fun fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_rate
    }

    public fun fees_growth_global<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128) {
        (arg0.fee_growth_global_a, arg0.fee_growth_global_b)
    }

    public fun fetch_positions<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) : vector<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::PositionInfo> {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::fetch_positions(&arg0.position_manager, arg1, arg2)
    }

    public fun fetch_ticks<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u32>, arg2: u64) : vector<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::Tick> {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::fetch_ticks(&arg0.tick_manager, arg1, arg2)
    }

    public fun flash_loan<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        flash_loan_internal<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun flash_loan_internal<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        if (arg2) {
            assert!(0x2::balance::value<T0>(&arg1.coin_a) >= arg3, 0);
        } else {
            assert!(0x2::balance::value<T1>(&arg1.coin_b) >= arg3, 0);
        };
        let v0 = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::full_math_u64::mul_div_ceil(arg3, arg1.fee_rate, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::fee_rate_denominator());
        let v1 = update_flash_loan_fee<T0, T1>(arg1, v0, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::protocol_fee_rate(arg0), arg2);
        let v2 = FlashLoanReceipt{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg1),
            loan_a     : arg2,
            amount     : arg3,
            fee_amount : v0,
        };
        let v3 = FlashLoanEvent{
            pool           : 0x2::object::id<Pool<T0, T1>>(arg1),
            loan_a         : arg2,
            amount         : arg3,
            fee_amount     : v0,
            vault_a_amount : 0x2::balance::value<T0>(&arg1.coin_a),
            vault_b_amount : 0x2::balance::value<T1>(&arg1.coin_b),
        };
        0x2::event::emit<FlashLoanEvent>(v3);
        let (v4, v5) = if (arg2) {
            arg1.fee_protocol_coin_a = arg1.fee_protocol_coin_a + v1;
            (0x2::balance::split<T0>(&mut arg1.coin_a, arg3), 0x2::balance::zero<T1>())
        } else {
            arg1.fee_protocol_coin_b = arg1.fee_protocol_coin_b + v1;
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg1.coin_b, arg3))
        };
        (v4, v5, v2)
    }

    public fun flash_swap<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        flash_swap_internal<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6)
    }

    fun flash_swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert!(arg4 > 0, 0);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::settle(&mut arg0.rewarder_manager, arg0.liquidity, 0x2::clock::timestamp_ms(arg6) / 1000);
        if (arg2) {
            assert!(arg0.current_sqrt_price > arg5 && arg5 >= 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::min_sqrt_price(), 11);
        } else {
            assert!(arg0.current_sqrt_price < arg5 && arg5 <= 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::max_sqrt_price(), 11);
        };
        let v0 = swap_in_pool<T0, T1>(arg0, arg2, arg3, arg5, arg4, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::protocol_fee_rate(arg1));
        let (v1, v2) = if (arg2) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.coin_b, v0.amount_out))
        } else {
            (0x2::balance::split<T0>(&mut arg0.coin_a, v0.amount_out), 0x2::balance::zero<T1>())
        };
        assert!(v0.amount_out > 0, 18);
        let v3 = SwapEvent{
            atob              : arg2,
            pool              : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_in         : v0.amount_in + v0.fee_amount,
            amount_out        : v0.amount_out,
            fee_amount        : v0.fee_amount,
            vault_a_amount    : 0x2::balance::value<T0>(&arg0.coin_a),
            vault_b_amount    : 0x2::balance::value<T1>(&arg0.coin_b),
            before_sqrt_price : arg0.current_sqrt_price,
            after_sqrt_price  : arg0.current_sqrt_price,
            steps             : v0.steps,
        };
        0x2::event::emit<SwapEvent>(v3);
        let v4 = FlashSwapReceipt<T0, T1>{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            a2b        : arg2,
            pay_amount : v0.amount_in + v0.fee_amount,
        };
        (v1, v2, v4)
    }

    public fun get_fee_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg2: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32) : (u128, u128) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::get_fee_in_range(arg0.current_tick_index, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun get_fee_rewards_points_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg2: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32) : (u128, u128, vector<u128>, u128) {
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::try_borrow_tick(&arg0.tick_manager, arg1);
        let v1 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::try_borrow_tick(&arg0.tick_manager, arg2);
        let (v2, v3) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::get_fee_in_range(arg0.current_tick_index, arg0.fee_growth_global_a, arg0.fee_growth_global_b, v0, v1);
        (v2, v3, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::get_rewards_in_range(arg0.current_tick_index, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::rewards_growth_global(&arg0.rewarder_manager), v0, v1), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::get_points_in_range(arg0.current_tick_index, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::points_growth_global(&arg0.rewarder_manager), v0, v1))
    }

    public fun get_liquidity_from_amount(arg0: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg1: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg2: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg3: u128, arg4: u64, arg5: bool) : (u128, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = if (arg5) {
            v0 = arg4;
            if (0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::lt(arg2, arg0)) {
                0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_liquidity_from_a(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg0), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg1), arg4, false)
            } else {
                assert!(0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::lt(arg2, arg1), 10);
                let v3 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_liquidity_from_a(arg3, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg1), arg4, false);
                v1 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_delta_b(arg3, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg0), v3, true);
                v3
            }
        } else {
            v1 = arg4;
            if (0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::gte(arg2, arg1)) {
                0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_liquidity_from_b(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg0), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg1), arg4, false)
            } else {
                assert!(0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::gte(arg2, arg0), 10);
                let v4 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_liquidity_from_b(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg0), arg3, arg4, false);
                v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_delta_a(arg3, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_sqrt_price_at_tick(arg1), v4, true);
                v4
            }
        };
        (v2, v0, v1)
    }

    public fun get_points_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg2: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32) : u128 {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::get_points_in_range(arg0.current_tick_index, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::points_growth_global(&arg0.rewarder_manager), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun get_position_amounts<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::borrow_position_info(&arg0.position_manager, arg1);
        let (v1, v2) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_tick_range(v0);
        get_amount_by_liquidity(v1, v2, arg0.current_tick_index, arg0.current_sqrt_price, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_liquidity(v0), false)
    }

    public fun get_position_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_fee_owned(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::borrow_position_info(&arg0.position_manager, arg1))
    }

    public fun get_position_points<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::info_points_owned(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::borrow_position_info(&arg0.position_manager, arg1))
    }

    public fun get_position_reward<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::rewarder_index<T2>(&arg0.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v0), 17);
        let v1 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::rewards_amount_owned(&arg0.position_manager, arg1);
        *0x1::vector::borrow<u64>(&v1, 0x1::option::extract<u64>(&mut v0))
    }

    public fun get_position_rewards<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : vector<u64> {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::rewards_amount_owned(&arg0.position_manager, arg1)
    }

    public fun get_rewards_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32, arg2: 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::I32) : vector<u128> {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::get_rewards_in_range(arg0.current_tick_index, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::rewards_growth_global(&arg0.rewarder_manager), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun index<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.index
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun initialize_rewarder<T0, T1, T2>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::check_rewarder_manager_role(arg0, 0x2::tx_context::sender(arg2));
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::add_rewarder<T2>(&mut arg1.rewarder_manager);
        let v0 = AddRewarderEvent{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg1),
            rewarder_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<AddRewarderEvent>(v0);
    }

    public fun is_pause<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.is_pause
    }

    public fun is_position_exist<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::is_position_exist(&arg0.position_manager, arg1)
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun lock_position<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: u64, arg4: &0x2::clock::Clock) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::pool_id(arg2), 19);
        assert!(arg3 > 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::get_lock_until(arg2) && arg3 > 0x2::clock::timestamp_ms(arg4), 23);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::lock_position(arg2, arg3);
        let v0 = LockPositionEvent{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg1),
            position   : 0x2::object::id<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(arg2),
            lock_until : arg3,
        };
        0x2::event::emit<LockPositionEvent>(v0);
    }

    public fun open_position<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let v0 = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::from_u32(arg2);
        let v1 = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::from_u32(arg3);
        let v2 = 0x2::object::id<Pool<T0, T1>>(arg1);
        let v3 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::open_position<T0, T1>(&mut arg1.position_manager, v2, arg1.index, arg1.url, v0, v1, arg4, arg5);
        let v4 = OpenPositionEvent{
            pool       : v2,
            tick_lower : v0,
            tick_upper : v1,
            position   : 0x2::object::id<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(&v3),
            lock_until : arg4,
        };
        0x2::event::emit<OpenPositionEvent>(v4);
        v3
    }

    public fun pause<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = true;
    }

    public fun position_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::PositionManager {
        &arg0.position_manager
    }

    public fun protocol_fee<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.fee_protocol_coin_a, arg0.fee_protocol_coin_b)
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        assert!(arg3 > 0, 3);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::pool_id(arg2), 19);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg4) / 1000);
        let (v0, v1) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::tick_range(arg2);
        let (v2, v3, v4, v5) = get_fee_rewards_points_in_tick_range<T0, T1>(arg1, v0, v1);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::decrease_liquidity(&mut arg1.tick_manager, arg1.current_tick_index, v0, v1, arg3, arg1.fee_growth_global_a, arg1.fee_growth_global_b, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::points_growth_global(&arg1.rewarder_manager), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::rewards_growth_global(&arg1.rewarder_manager));
        if (0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::lte(v0, arg1.current_tick_index) && 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::lt(arg1.current_tick_index, v1)) {
            arg1.liquidity = arg1.liquidity - arg3;
        };
        let (v6, v7) = get_amount_by_liquidity(v0, v1, arg1.current_tick_index, arg1.current_sqrt_price, arg3, false);
        let v8 = RemoveLiquidityEvent{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg1),
            position        : 0x2::object::id<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(arg2),
            tick_lower      : v0,
            tick_upper      : v1,
            liquidity       : arg3,
            after_liquidity : 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::decrease_liquidity(&mut arg1.position_manager, arg2, arg3, v2, v3, v5, v4, arg4),
            amount_a        : v6,
            amount_b        : v7,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v8);
        (0x2::balance::split<T0>(&mut arg1.coin_a, v6), 0x2::balance::split<T1>(&mut arg1.coin_b, v7))
    }

    public fun repay_add_liquidity<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: AddLiquidityReceipt<T0, T1>) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        let AddLiquidityReceipt {
            pool_id  : v0,
            amount_a : v1,
            amount_b : v2,
        } = arg4;
        assert!(0x2::balance::value<T0>(&arg2) == v1, 0);
        assert!(0x2::balance::value<T1>(&arg3) == v2, 0);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == v0, 12);
        0x2::balance::join<T0>(&mut arg1.coin_a, arg2);
        0x2::balance::join<T1>(&mut arg1.coin_b, arg3);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let FlashLoanReceipt {
            pool_id    : v0,
            loan_a     : v1,
            amount     : v2,
            fee_amount : v3,
        } = arg4;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg1), 20);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v2 + v3, 0);
            0x2::balance::join<T0>(&mut arg1.coin_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v2 + v3, 0);
            0x2::balance::join<T1>(&mut arg1.coin_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let FlashSwapReceipt {
            pool_id    : v0,
            a2b        : v1,
            pay_amount : v2,
        } = arg4;
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == v0, 14);
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

    public fun rewarder_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderManager {
        &arg0.rewarder_manager
    }

    public fun set_display<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coin_a"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coin_b"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::vector::push_back<0x1::string::String>(v3, arg5);
        0x1::vector::push_back<0x1::string::String>(v3, arg4);
        0x1::vector::push_back<0x1::string::String>(v3, arg3);
        0x1::vector::push_back<0x1::string::String>(v3, arg6);
        0x1::vector::push_back<0x1::string::String>(v3, arg7);
        let v4 = 0x2::display::new_with_fields<Pool<T0, T1>>(arg1, v0, v2, arg8);
        0x2::display::update_version<Pool<T0, T1>>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Pool<T0, T1>>>(v4, 0x2::tx_context::sender(arg8));
    }

    public fun step_swap_result_amount_in(arg0: &SwapStepResult) : u64 {
        arg0.amount_in
    }

    public fun step_swap_result_amount_out(arg0: &SwapStepResult) : u64 {
        arg0.amount_out
    }

    public fun step_swap_result_current_liquidity(arg0: &SwapStepResult) : u128 {
        arg0.current_liquidity
    }

    public fun step_swap_result_current_sqrt_price(arg0: &SwapStepResult) : u128 {
        arg0.current_sqrt_price
    }

    public fun step_swap_result_fee_amount(arg0: &SwapStepResult) : u64 {
        arg0.fee_amount
    }

    public fun step_swap_result_remainder_amount(arg0: &SwapStepResult) : u64 {
        arg0.remainder_amount
    }

    public fun step_swap_result_target_sqrt_price(arg0: &SwapStepResult) : u128 {
        arg0.target_sqrt_price
    }

    fun swap_in_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u128, arg4: u64, arg5: u64) : SwapResult {
        let v0 = default_swap_result();
        let v1 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::first_score_for_swap(&arg0.tick_manager, arg0.current_tick_index, arg1);
        let v2 = 0;
        while (arg4 > 0 && arg0.current_sqrt_price != arg3) {
            if (0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::option_u64::is_none(&v1)) {
                abort 4
            };
            let (v3, v4) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::borrow_tick_for_swap(&arg0.tick_manager, 0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::option_u64::borrow(&v1), arg1);
            v1 = v4;
            let v5 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::index(v3);
            let v6 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::sqrt_price(v3);
            let v7 = if (arg1) {
                0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u128::max(arg3, v6)
            } else {
                0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u128::min(arg3, v6)
            };
            let (v8, v9, v10, v11) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::compute_swap_step(arg0.current_sqrt_price, v7, arg0.liquidity, arg4, arg0.fee_rate, arg1, arg2);
            if (v8 != 0 || v11 != 0) {
                if (arg2) {
                    let v12 = check_remainer_amount_sub(arg4, v8);
                    arg4 = check_remainer_amount_sub(v12, v11);
                } else {
                    arg4 = check_remainer_amount_sub(arg4, v9);
                };
                let v13 = &mut v0;
                update_swap_result(v13, v8, v9, v11);
                let v14 = update_pool_fee<T0, T1>(arg0, v11, arg5, arg1);
                v2 = v2 + v14;
            };
            if (v10 == v6) {
                arg0.current_sqrt_price = v7;
                let v15 = if (arg1) {
                    0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::sub(v5, 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::from(1))
                } else {
                    v5
                };
                arg0.current_tick_index = v15;
                arg0.liquidity = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::cross_by_swap(&mut arg0.tick_manager, v5, arg1, arg0.liquidity, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::points_growth_global(&arg0.rewarder_manager), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::rewards_growth_global(&arg0.rewarder_manager));
                continue
            };
            if (arg0.current_sqrt_price != v10) {
                arg0.current_sqrt_price = v10;
                arg0.current_tick_index = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_tick_at_sqrt_price(v10);
            };
        };
        if (arg1) {
            arg0.fee_protocol_coin_a = arg0.fee_protocol_coin_a + v2;
        } else {
            arg0.fee_protocol_coin_b = arg0.fee_protocol_coin_b + v2;
        };
        v0
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    public fun tick_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick::TickManager {
        &arg0.tick_manager
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public fun unpause<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = false;
    }

    public fun update_emission<T0, T1, T2>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::check_rewarder_manager_role(arg0, 0x2::tx_context::sender(arg5));
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::update_emission<T2>(arg2, &mut arg1.rewarder_manager, arg1.liquidity, arg3, 0x2::clock::timestamp_ms(arg4) / 1000);
        let v0 = UpdateEmissionEvent{
            pool                 : 0x2::object::id<Pool<T0, T1>>(arg1),
            rewarder_type        : 0x1::type_name::get<T2>(),
            emissions_per_second : arg3,
        };
        0x2::event::emit<UpdateEmissionEvent>(v0);
    }

    public fun update_fee_rate<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        if (arg2 > 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::max_fee_rate()) {
            abort 9
        };
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.fee_rate = arg2;
        let v0 = UpdateFeeRateEvent{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg1),
            old_fee_rate : arg1.fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    fun update_flash_loan_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::full_math_u64::mul_div_ceil(arg1, arg2, 10000);
        let v1 = arg1 - v0;
        if (v1 == 0 || arg0.liquidity == 0) {
            return v0
        };
        if (arg3) {
            arg0.fee_growth_global_a = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u128::wrapping_add(arg0.fee_growth_global_a, ((v1 as u128) << 64) / arg0.liquidity);
        } else {
            arg0.fee_growth_global_b = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u128::wrapping_add(arg0.fee_growth_global_b, ((v1 as u128) << 64) / arg0.liquidity);
        };
        v0
    }

    fun update_pool_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::full_math_u64::mul_div_ceil(arg1, arg2, 10000);
        let v1 = arg1 - v0;
        if (v1 == 0 || arg0.liquidity == 0) {
            return v0
        };
        if (arg3) {
            arg0.fee_growth_global_a = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u128::wrapping_add(arg0.fee_growth_global_a, ((v1 as u128) << 64) / arg0.liquidity);
        } else {
            arg0.fee_growth_global_b = 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u128::wrapping_add(arg0.fee_growth_global_b, ((v1 as u128) << 64) / arg0.liquidity);
        };
        v0
    }

    public fun update_position_url<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.url = arg2;
    }

    fun update_swap_result(arg0: &mut SwapResult, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u64::add_check(arg0.amount_in, arg1), 6);
        assert!(0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u64::add_check(arg0.amount_out, arg2), 7);
        assert!(0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::math_u64::add_check(arg0.fee_amount, arg3), 8);
        arg0.amount_in = arg0.amount_in + arg1;
        arg0.amount_out = arg0.amount_out + arg2;
        arg0.fee_amount = arg0.fee_amount + arg3;
        arg0.steps = arg0.steps + 1;
    }

    public fun url<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

