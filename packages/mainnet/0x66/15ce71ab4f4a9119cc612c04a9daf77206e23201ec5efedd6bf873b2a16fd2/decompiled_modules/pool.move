module 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        creator: address,
        parameters: 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::PairParameters,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        liquidity: u128,
        whitelisted: 0x2::vec_set::VecSet<address>,
        collect_fee_mode: u8,
        is_quote_y: bool,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
        fee_protocol_coin_a: u64,
        fee_protocol_coin_b: u64,
        tick_manager: 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::TickManager,
        rewarder_manager: 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::RewarderManager,
        position_manager: 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::PositionManager,
        is_pause: bool,
        index: u64,
        url: 0x1::string::String,
    }

    struct StaticFeeParametersSetEvent has copy, drop {
        sender: address,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        max_volatility_accumulator: u32,
        cliff_fee_numerator: u64,
        scheduler_number_of_period: u16,
        scheduler_period_frequency: u64,
        scheduler_reduction_factor: u64,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        atob: bool,
        collect_fee_on_input: bool,
        fee_amount: u64,
        base_fee: u64,
        dynamic_fee: u64,
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
        atob: bool,
        collect_fee_on_input: bool,
        fee_amount: u64,
        base_fee: u64,
        dynamic_fee: u64,
        before_sqrt_price: u128,
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
        tick_lower: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32,
        tick_upper: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32,
        position: 0x2::object::ID,
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
        tick_lower: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32,
        tick_upper: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32,
        liquidity: u128,
        after_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct RemoveLiquidityEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        tick_lower: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32,
        tick_upper: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32,
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
        fee_a: u64,
        fee_b: u64,
        base_fee: u64,
        dynamic_fee: u64,
        collect_fee_on_input: bool,
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
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
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
        emissions_per_ms: u128,
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

    struct DynamicFeeParametersSetEvent has copy, drop {
        pool: 0x2::object::ID,
        enabled: bool,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        max_volatility_accumulator: u32,
    }

    struct ForcedDecayEvent has copy, drop {
        pool: 0x2::object::ID,
        sender: address,
        tick_reference: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32,
        volatility_reference: u32,
    }

    public(friend) fun new<T0, T1>(arg0: u32, arg1: u128, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u8, arg7: bool, arg8: bool, arg9: u16, arg10: u16, arg11: u16, arg12: u32, arg13: u32, arg14: u8, arg15: bool, arg16: u64, arg17: u16, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = Pool<T0, T1>{
            id                  : 0x2::object::new(arg21),
            creator             : 0x2::tx_context::sender(arg21),
            parameters          : 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::new(arg1, arg2, arg0, arg14, arg15, arg8, arg5),
            coin_a              : 0x2::balance::zero<T0>(),
            coin_b              : 0x2::balance::zero<T1>(),
            liquidity           : 0,
            whitelisted         : 0x2::vec_set::empty<address>(),
            collect_fee_mode    : arg6,
            is_quote_y          : arg7,
            fee_growth_global_a : 0,
            fee_growth_global_b : 0,
            fee_protocol_coin_a : 0,
            fee_protocol_coin_b : 0,
            tick_manager        : 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::new(arg0, 0x2::clock::timestamp_ms(arg20), arg21),
            rewarder_manager    : 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::new(),
            position_manager    : 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::new(arg0, arg21),
            is_pause            : false,
            index               : arg4,
            url                 : arg3,
        };
        let v1 = &mut v0;
        set_static_fee_parameters_internal<T0, T1>(v1, arg9, arg10, arg11, arg12, arg13, arg16, arg17, arg18, arg19, arg21);
        v0
    }

    public fun disable_dynamic_fee<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::disable_dynamic_fee(&mut arg1.parameters);
    }

    public fun disable_fee_scheduler<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::disable_fee_scheduler(&mut arg1.parameters);
    }

    public fun enable_dynamic_fee<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::fee_helper::validate_dynamic_fee_parameters(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_dynamic_filter_period(&arg1.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_dynamic_decay_period(&arg1.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_dynamic_reduction_factor(&arg1.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_dynamic_variable_fee_control(&arg1.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_dynamic_max_volatility_accumulator(&arg1.parameters));
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::enable_dynamic_fee(&mut arg1.parameters);
    }

    public fun enable_fee_scheduler<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::fee_helper::validate_base_fee(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_fee_rate(&arg1.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_fee_scheduler_mode(&arg1.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_cliff_fee_numerator(&arg1.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_scheduler_number_of_period(&arg1.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_scheduler_period_frequency(&arg1.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_scheduler_reduction_factor(&arg1.parameters));
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::enable_fee_scheduler(&mut arg1.parameters);
    }

    public fun get_total_fee_rate<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_total_fee_rate(&arg0.parameters, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_tick_spacing(&arg0.parameters), arg1)
    }

    public fun add_liquidity<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : AddLiquidityReceipt<T0, T1> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0), 413);
        assert!(arg3 != 0, 403);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::pool_id(arg2), 419);
        add_liquidity_internal<T0, T1>(arg1, arg2, false, arg3, 0, false, 0x2::clock::timestamp_ms(arg4))
    }

    public fun add_liquidity_fix_coin<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : AddLiquidityReceipt<T0, T1> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        assert!(arg3 > 0, 400);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::pool_id(arg2), 419);
        add_liquidity_internal<T0, T1>(arg1, arg2, true, 0, arg3, arg4, 0x2::clock::timestamp_ms(arg5))
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position, arg2: bool, arg3: u128, arg4: u64, arg5: bool, arg6: u64) : AddLiquidityReceipt<T0, T1> {
        assert!(!arg0.is_pause, 413);
        assert!(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::get_lock_until(arg1) == 0 || arg6 >= 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::get_lock_until(arg1), 424);
        mark_pending_add_liquidity<T0, T1>(arg0);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::settle(&mut arg0.rewarder_manager, arg0.liquidity, arg6);
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters);
        let (v1, v2) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::tick_range(arg1);
        let (v3, v4, v5) = if (arg2) {
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_liquidity_by_amount(v1, v2, v0, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters), arg4, arg5)
        } else {
            let (v6, v7) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_amount_by_liquidity(v1, v2, v0, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters), arg3, true);
            (arg3, v6, v7)
        };
        assert!(v3 > 0, 403);
        let (v8, v9, v10, v11) = get_fee_rewards_points_in_tick_range<T0, T1>(arg0, v1, v2);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::increase_liquidity(&mut arg0.tick_manager, v0, v1, v2, v3, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::points_growth_global(&arg0.rewarder_manager), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::rewards_growth_global(&arg0.rewarder_manager));
        if (0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::gte(v0, v1) && 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::lt(v0, v2)) {
            assert!(0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u128::add_check(arg0.liquidity, v3), 401);
            arg0.liquidity = arg0.liquidity + v3;
        };
        let v12 = AddLiquidityEvent{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg0),
            position        : 0x2::object::id<0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position>(arg1),
            tick_lower      : v1,
            tick_upper      : v2,
            liquidity       : arg3,
            after_liquidity : 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::increase_liquidity(&mut arg0.position_manager, arg1, v3, v8, v9, v11, v10),
            amount_a        : v4,
            amount_b        : v5,
        };
        0x2::event::emit<AddLiquidityEvent>(v12);
        AddLiquidityReceipt<T0, T1>{
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a : v4,
            amount_b : v5,
        }
    }

    public fun add_liquidity_pay_amount<T0, T1>(arg0: &AddLiquidityReceipt<T0, T1>) : (u64, u64) {
        (arg0.amount_a, arg0.amount_b)
    }

    public fun add_whitelist<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.creator || 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::is_config_role(arg0, v0), 434);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (!0x2::vec_set::contains<address>(&arg1.whitelisted, &v2)) {
                0x2::vec_set::insert<address>(&mut arg1.whitelisted, v2);
            };
            v1 = v1 + 1;
        };
    }

    fun assert_no_pending_add_liquidity<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"pending_add_liquidity"), 431);
    }

    public fun balances<T0, T1>(arg0: &Pool<T0, T1>) : (&0x2::balance::Balance<T0>, &0x2::balance::Balance<T1>) {
        (&arg0.coin_a, &arg0.coin_b)
    }

    public fun borrow_position_info<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::PositionInfo {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::borrow_position_info(&arg0.position_manager, arg1)
    }

    public fun borrow_tick<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32) : &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::Tick {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::borrow_tick(&arg0.tick_manager, arg1)
    }

    public fun calculate_and_update_fee<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID) : (u64, u64) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_liquidity(v0) != 0) {
            let (v3, v4) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_tick_range(v0);
            let (v5, v6) = get_fee_in_tick_range<T0, T1>(arg1, v3, v4);
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::update_fee(&mut arg1.position_manager, arg2, v5, v6)
        } else {
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_fee_owned(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::borrow_position_info(&arg1.position_manager, arg2))
        }
    }

    public fun calculate_and_update_points<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u128 {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg3));
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_liquidity(v0) != 0) {
            let (v2, v3) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_tick_range(v0);
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::update_points(&mut arg1.position_manager, arg2, get_points_in_tick_range<T0, T1>(arg1, v2, v3))
        } else {
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_points_owned(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::borrow_position_info(&arg1.position_manager, arg2))
        }
    }

    public fun calculate_and_update_reward<T0, T1, T2>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::rewarder_index<T2>(&arg1.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v0), 417);
        let v1 = calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3);
        *0x1::vector::borrow<u64>(&v1, 0x1::option::extract<u64>(&mut v0))
    }

    public fun calculate_and_update_rewards<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : vector<u64> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg3));
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_liquidity(v0) != 0) {
            let (v2, v3) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_tick_range(v0);
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::update_rewards(&mut arg1.position_manager, arg2, get_rewards_in_tick_range<T0, T1>(arg1, v2, v3))
        } else {
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::rewards_amount_owned(&arg1.position_manager, arg2)
        }
    }

    public fun calculate_swap_result<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : CalculatedSwapResult {
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters);
        let v1 = v0;
        let v2 = arg0.liquidity;
        let v3 = arg0.parameters;
        let v4 = 0x2::clock::timestamp_ms(arg4) / 1000;
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::update_references(&mut v3, v4);
        let v5 = arg3;
        let v6 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::first_score_for_swap(&arg0.tick_manager, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters), arg1);
        let v7 = arg0.collect_fee_mode;
        let v8 = arg0.is_quote_y;
        let v9 = v7 == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::constants::collect_fee_mode_on_both() || v7 == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::constants::collect_fee_mode_on_quote() && (arg1 && !v8 || !arg1 && v8) || true;
        let v10 = CalculatedSwapResult{
            amount_in            : 0,
            amount_out           : 0,
            atob                 : arg1,
            collect_fee_on_input : v9,
            fee_amount           : 0,
            base_fee             : 0,
            dynamic_fee          : 0,
            before_sqrt_price    : v0,
            after_sqrt_price     : v0,
            is_exceed            : false,
            step_results         : 0x1::vector::empty<SwapStepResult>(),
        };
        while (v5 > 0) {
            if (0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::is_none(&v6)) {
                v10.is_exceed = true;
                break
            };
            let (v11, v12) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::borrow_tick_for_swap(&arg0.tick_manager, 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::borrow(&v6), arg1);
            v6 = v12;
            let v13 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::sqrt_price(v11);
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::update_volatility_accumulator(&mut v3, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::index(v11));
            let v14 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_total_fee_rate(&v3, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_tick_spacing(&arg0.parameters), 0x2::clock::timestamp_ms(arg4));
            let (v15, v16, v17, v18) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::compute_swap_step(v1, v13, v2, v5, v9, v14, arg1, arg2);
            if (v15 != 0 || v18 != 0) {
                if (arg2) {
                    if (v9) {
                        let v19 = check_remainer_amount_sub(v5, v15);
                        v5 = check_remainer_amount_sub(v19, v18);
                    } else {
                        v5 = check_remainer_amount_sub(v5, v15);
                    };
                } else {
                    v5 = check_remainer_amount_sub(v5, v16);
                };
                let v20 = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::full_math_u64::mul_div_ceil(v18, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_base_fee(&v3, v4), v14);
                v10.amount_in = v10.amount_in + v15;
                v10.amount_out = v10.amount_out + v16;
                v10.fee_amount = v10.fee_amount + v18;
                v10.base_fee = v10.base_fee + v20;
                v10.dynamic_fee = v10.dynamic_fee + v18 - v20;
            };
            let v21 = SwapStepResult{
                current_sqrt_price : v0,
                target_sqrt_price  : v13,
                current_liquidity  : v2,
                amount_in          : v15,
                amount_out         : v16,
                fee_amount         : v18,
                remainder_amount   : v5,
            };
            0x1::vector::push_back<SwapStepResult>(&mut v10.step_results, v21);
            if (v17 == v13) {
                v1 = v13;
                let v22 = if (arg1) {
                    0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i128::neg(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::liquidity_net(v11))
                } else {
                    0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::liquidity_net(v11)
                };
                if (!0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i128::is_neg(v22)) {
                    let v23 = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i128::abs_u128(v22);
                    assert!(0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u128::add_check(v2, v23), 401);
                    v2 = v2 + v23;
                    continue
                };
                let v24 = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i128::abs_u128(v22);
                assert!(v2 >= v24, 401);
                v2 = v2 - v24;
                continue
            };
            v1 = v17;
        };
        if (v9) {
            v10.amount_in = v10.amount_in + v10.fee_amount;
        };
        v10.after_sqrt_price = v1;
        v10
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
        assert!(arg0 >= arg1, 405);
        arg0 - arg1
    }

    fun clear_pending_add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>) {
        let v0 = b"pending_add_liquidity";
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, v0);
        *v1 = *v1 - 1;
        if (*v1 == 0) {
            0x2::dynamic_field::remove<vector<u8>, u64>(&mut arg0.id, v0);
        };
    }

    public fun close_position<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::pool_id(&arg2), 419);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::close_position(&mut arg1.position_manager, arg2);
        let v0 = ClosePositionEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            position : 0x2::object::id<0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position>(&arg2),
        };
        0x2::event::emit<ClosePositionEvent>(v0);
    }

    public fun collect_fee<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position, arg3: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::pool_id(arg2), 419);
        let v0 = 0x2::object::id<0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position>(arg2);
        let (v1, v2) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::tick_range(arg2);
        let (v3, v4) = if (arg3 && 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::liquidity(arg2) != 0) {
            let (v5, v6) = get_fee_in_tick_range<T0, T1>(arg1, v1, v2);
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::update_and_reset_fee(&mut arg1.position_manager, v0, v5, v6)
        } else {
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::reset_fee(&mut arg1.position_manager, v0)
        };
        let v7 = CollectFeeEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            position : v0,
            amount_a : v3,
            amount_b : v4,
        };
        0x2::event::emit<CollectFeeEvent>(v7);
        (0x2::balance::split<T0>(&mut arg1.coin_a, v3), 0x2::balance::split<T1>(&mut arg1.coin_b, v4))
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::get_fund_receiver(arg0);
        let v1 = arg1.fee_protocol_coin_a;
        let v2 = arg1.fee_protocol_coin_b;
        arg1.fee_protocol_coin_a = 0;
        arg1.fee_protocol_coin_b = 0;
        let v3 = CollectProtocolFeeEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            amount_a : v1,
            amount_b : v2,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.coin_a, v1, arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.coin_b, v2, arg2), v0);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position, arg3: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::RewarderGlobalVault, arg4: bool, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::pool_id(arg2), 419);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg5));
        let v0 = 0x2::object::id<0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position>(arg2);
        let v1 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::rewarder_index<T2>(&arg1.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v1), 417);
        let v2 = 0x1::option::extract<u64>(&mut v1);
        let v3 = if (arg4 && 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::liquidity(arg2) != 0 || 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::inited_rewards_count(&arg1.position_manager, v0) <= v2) {
            let (v4, v5) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::tick_range(arg2);
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::update_and_reset_rewards(&mut arg1.position_manager, v0, get_rewards_in_tick_range<T0, T1>(arg1, v4, v5), v2)
        } else {
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::reset_rewarder(&mut arg1.position_manager, v0, v2)
        };
        let v6 = CollectRewardEvent{
            position      : v0,
            pool          : 0x2::object::id<Pool<T0, T1>>(arg1),
            rewarder_type : 0x1::type_name::get<T2>(),
            amount        : v3,
        };
        0x2::event::emit<CollectRewardEvent>(v6);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::withdraw_reward<T2>(arg3, v3)
    }

    public fun current_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters)
    }

    public fun current_tick_index<T0, T1>(arg0: &Pool<T0, T1>) : 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32 {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters)
    }

    fun default_swap_result() : SwapResult {
        SwapResult{
            amount_in            : 0,
            amount_out           : 0,
            atob                 : false,
            collect_fee_on_input : true,
            fee_amount           : 0,
            base_fee             : 0,
            dynamic_fee          : 0,
            steps                : 0,
        }
    }

    public fun fees_growth_global<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128) {
        (arg0.fee_growth_global_a, arg0.fee_growth_global_b)
    }

    public fun fetch_positions<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) : vector<0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::PositionInfo> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::fetch_positions(&arg0.position_manager, arg1, arg2)
    }

    public fun fetch_ticks<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u32>, arg2: u64) : vector<0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::Tick> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::fetch_ticks(&arg0.tick_manager, arg1, arg2)
    }

    public fun flash_loan<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        assert!(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::flash_loan_enable(arg0), 430);
        flash_loan_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun flash_loan_internal<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        if (arg2) {
            assert!(0x2::balance::value<T0>(&arg1.coin_a) >= arg3, 400);
        } else {
            assert!(0x2::balance::value<T1>(&arg1.coin_b) >= arg3, 400);
        };
        let v0 = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::full_math_u64::mul_div_ceil(arg3, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_total_fee_rate(&arg1.parameters, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_tick_spacing(&arg1.parameters), 0x2::clock::timestamp_ms(arg4)), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::constants::precision());
        let v1 = update_flash_loan_fee<T0, T1>(arg1, v0, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::protocol_fee_rate(arg0), arg2);
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

    public fun flash_swap<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        let v0 = 0x2::tx_context::sender(arg7);
        if (0x2::clock::timestamp_ms(arg6) < 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_activation_timestamp(&arg1.parameters)) {
            assert!(0x2::vec_set::contains<address>(&arg1.whitelisted, &v0), 432);
        };
        flash_swap_internal<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6)
    }

    fun flash_swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert!(arg4 > 0, 400);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::settle(&mut arg0.rewarder_manager, arg0.liquidity, 0x2::clock::timestamp_ms(arg6));
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters);
        if (arg2) {
            assert!(v0 > arg5 && arg5 >= 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::min_sqrt_price(), 11);
        } else {
            assert!(v0 < arg5 && arg5 <= 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::max_sqrt_price(), 11);
        };
        let v1 = swap_in_pool<T0, T1>(arg0, arg2, arg3, arg5, arg4, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::protocol_fee_rate(arg1), 0x2::clock::timestamp_ms(arg6));
        let (v2, v3) = if (arg2) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.coin_b, v1.amount_out))
        } else {
            (0x2::balance::split<T0>(&mut arg0.coin_a, v1.amount_out), 0x2::balance::zero<T1>())
        };
        assert!(v1.amount_out > 0, 418);
        let v4 = if (v1.collect_fee_on_input) {
            v1.amount_in + v1.fee_amount
        } else {
            v1.amount_in
        };
        let (v5, v6) = if (arg2) {
            if (v1.collect_fee_on_input) {
                (v1.fee_amount, 0)
            } else {
                (0, v1.fee_amount)
            }
        } else if (v1.collect_fee_on_input) {
            (0, v1.fee_amount)
        } else {
            (v1.fee_amount, 0)
        };
        let v7 = SwapEvent{
            atob                 : arg2,
            pool                 : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_in            : v4,
            amount_out           : v1.amount_out,
            fee_a                : v5,
            fee_b                : v6,
            base_fee             : v1.base_fee,
            dynamic_fee          : v1.dynamic_fee,
            collect_fee_on_input : v1.collect_fee_on_input,
            vault_a_amount       : 0x2::balance::value<T0>(&arg0.coin_a),
            vault_b_amount       : 0x2::balance::value<T1>(&arg0.coin_b),
            before_sqrt_price    : v0,
            after_sqrt_price     : 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters),
            steps                : v1.steps,
        };
        0x2::event::emit<SwapEvent>(v7);
        let v8 = if (v1.collect_fee_on_input) {
            v1.amount_in + v1.fee_amount
        } else {
            v1.amount_in
        };
        let v9 = FlashSwapReceipt<T0, T1>{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            a2b        : arg2,
            pay_amount : v8,
        };
        (v2, v3, v9)
    }

    public fun get_fee_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32, arg2: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32) : (u128, u128) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::get_fee_in_range(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters), arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun get_fee_rewards_points_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32, arg2: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32) : (u128, u128, vector<u128>, u128) {
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::try_borrow_tick(&arg0.tick_manager, arg1);
        let v1 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::try_borrow_tick(&arg0.tick_manager, arg2);
        let (v2, v3) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::get_fee_in_range(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters), arg0.fee_growth_global_a, arg0.fee_growth_global_b, v0, v1);
        (v2, v3, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::get_rewards_in_range(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::rewards_growth_global(&arg0.rewarder_manager), v0, v1), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::get_points_in_range(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::points_growth_global(&arg0.rewarder_manager), v0, v1))
    }

    public fun get_liquidity_from_amount(arg0: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32, arg1: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32, arg2: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32, arg3: u128, arg4: u64, arg5: bool) : (u128, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = if (arg5) {
            v0 = arg4;
            if (0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::lt(arg2, arg0)) {
                0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_liquidity_from_a(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::get_sqrt_price_at_tick(arg0), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::get_sqrt_price_at_tick(arg1), arg4, false)
            } else {
                assert!(0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::lt(arg2, arg1), 410);
                let v3 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_liquidity_from_a(arg3, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::get_sqrt_price_at_tick(arg1), arg4, false);
                v1 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_delta_b(arg3, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::get_sqrt_price_at_tick(arg0), v3, true);
                v3
            }
        } else {
            v1 = arg4;
            if (0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::gte(arg2, arg1)) {
                0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_liquidity_from_b(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::get_sqrt_price_at_tick(arg0), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::get_sqrt_price_at_tick(arg1), arg4, false)
            } else {
                assert!(0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::gte(arg2, arg0), 410);
                let v4 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_liquidity_from_b(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::get_sqrt_price_at_tick(arg0), arg3, arg4, false);
                v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_delta_a(arg3, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::get_sqrt_price_at_tick(arg1), v4, true);
                v4
            }
        };
        (v2, v0, v1)
    }

    public fun get_pair_parameters<T0, T1>(arg0: &Pool<T0, T1>) : &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::PairParameters {
        &arg0.parameters
    }

    public fun get_points_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32, arg2: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32) : u128 {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::get_points_in_range(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::points_growth_global(&arg0.rewarder_manager), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun get_position_amounts<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::borrow_position_info(&arg0.position_manager, arg1);
        let (v1, v2) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_tick_range(v0);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_amount_by_liquidity(v1, v2, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_liquidity(v0), false)
    }

    public fun get_position_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_fee_owned(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::borrow_position_info(&arg0.position_manager, arg1))
    }

    public fun get_position_points<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::info_points_owned(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::borrow_position_info(&arg0.position_manager, arg1))
    }

    public fun get_position_reward<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::rewarder_index<T2>(&arg0.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v0), 417);
        let v1 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::rewards_amount_owned(&arg0.position_manager, arg1);
        *0x1::vector::borrow<u64>(&v1, 0x1::option::extract<u64>(&mut v0))
    }

    public fun get_position_rewards<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : vector<u64> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::rewards_amount_owned(&arg0.position_manager, arg1)
    }

    public fun get_rewards_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32, arg2: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32) : vector<u128> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::get_rewards_in_range(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::rewards_growth_global(&arg0.rewarder_manager), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun index<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.index
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun initialize_rewarder<T0, T1, T2>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_reward_role(arg0, 0x2::tx_context::sender(arg2));
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::add_rewarder<T2>(&mut arg1.rewarder_manager);
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
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::is_position_exist(&arg0.position_manager, arg1)
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun lock_position<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position, arg3: u64, arg4: &0x2::clock::Clock) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::pool_id(arg2), 419);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = if (arg3 > 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::get_lock_until(arg2)) {
            if (arg3 > v0) {
                arg3 - v0 < 5315360000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 423);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::lock_position(arg2, arg3);
        let v2 = LockPositionEvent{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg1),
            position   : 0x2::object::id<0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position>(arg2),
            lock_until : arg3,
        };
        0x2::event::emit<LockPositionEvent>(v2);
    }

    fun mark_pending_add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>) {
        let v0 = b"pending_add_liquidity";
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, v0, 1);
        } else {
            let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, v0);
            *v1 = *v1 + 1;
        };
    }

    public fun open_position<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        let v0 = 0x2::object::id<Pool<T0, T1>>(arg1);
        let v1 = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::from_u32(arg2);
        let v2 = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::from_u32(arg3);
        let v3 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::open_position<T0, T1>(&mut arg1.position_manager, v0, arg1.index, arg1.url, v1, v2, arg4);
        let v4 = OpenPositionEvent{
            pool       : v0,
            tick_lower : v1,
            tick_upper : v2,
            position   : 0x2::object::id<0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position>(&v3),
        };
        0x2::event::emit<OpenPositionEvent>(v4);
        v3
    }

    public fun pause<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = true;
    }

    public fun position_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::PositionManager {
        &arg0.position_manager
    }

    public fun protocol_fee<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.fee_protocol_coin_a, arg0.fee_protocol_coin_b)
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        assert!(arg3 > 0, 403);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::pool_id(arg2), 419);
        assert_no_pending_add_liquidity<T0, T1>(arg1);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg4));
        let v0 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg1.parameters);
        let (v1, v2) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::tick_range(arg2);
        let (v3, v4, v5, v6) = get_fee_rewards_points_in_tick_range<T0, T1>(arg1, v1, v2);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::decrease_liquidity(&mut arg1.tick_manager, v0, v1, v2, arg3, arg1.fee_growth_global_a, arg1.fee_growth_global_b, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::points_growth_global(&arg1.rewarder_manager), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::rewards_growth_global(&arg1.rewarder_manager));
        if (0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::lte(v1, v0) && 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::lt(v0, v2)) {
            arg1.liquidity = arg1.liquidity - arg3;
        };
        let (v7, v8) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::get_amount_by_liquidity(v1, v2, v0, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg1.parameters), arg3, false);
        let v9 = RemoveLiquidityEvent{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg1),
            position        : 0x2::object::id<0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::Position>(arg2),
            tick_lower      : v1,
            tick_upper      : v2,
            liquidity       : arg3,
            after_liquidity : 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::position::decrease_liquidity(&mut arg1.position_manager, arg2, arg3, v3, v4, v6, v5, arg4),
            amount_a        : v7,
            amount_b        : v8,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v9);
        (0x2::balance::split<T0>(&mut arg1.coin_a, v7), 0x2::balance::split<T1>(&mut arg1.coin_b, v8))
    }

    public fun remove_whitelist<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.creator || 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::is_config_role(arg0, v0), 434);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (0x2::vec_set::contains<address>(&arg1.whitelisted, &v2)) {
                0x2::vec_set::remove<address>(&mut arg1.whitelisted, &v2);
            };
            v1 = v1 + 1;
        };
    }

    public fun repay_add_liquidity<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: AddLiquidityReceipt<T0, T1>) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        let AddLiquidityReceipt {
            pool_id  : v0,
            amount_a : v1,
            amount_b : v2,
        } = arg4;
        assert!(0x2::balance::value<T0>(&arg2) == v1, 400);
        assert!(0x2::balance::value<T1>(&arg3) == v2, 400);
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == v0, 412);
        clear_pending_add_liquidity<T0, T1>(arg1);
        0x2::balance::join<T0>(&mut arg1.coin_a, arg2);
        0x2::balance::join<T1>(&mut arg1.coin_b, arg3);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        let FlashLoanReceipt {
            pool_id    : v0,
            loan_a     : v1,
            amount     : v2,
            fee_amount : v3,
        } = arg4;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg1), 412);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v2 + v3, 400);
            0x2::balance::join<T0>(&mut arg1.coin_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v2 + v3, 400);
            0x2::balance::join<T1>(&mut arg1.coin_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        let FlashSwapReceipt {
            pool_id    : v0,
            a2b        : v1,
            pay_amount : v2,
        } = arg4;
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == v0, 412);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v2, 400);
            0x2::balance::join<T0>(&mut arg1.coin_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v2, 400);
            0x2::balance::join<T1>(&mut arg1.coin_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun rewarder_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::RewarderManager {
        &arg0.rewarder_manager
    }

    public fun set_display<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
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

    fun set_static_fee_parameters_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u16, arg2: u16, arg3: u16, arg4: u32, arg5: u32, arg6: u64, arg7: u16, arg8: u64, arg9: u64, arg10: &0x2::tx_context::TxContext) {
        let v0 = arg0.parameters;
        let v1 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_fee_rate(&v0);
        assert!(arg6 >= v1, 435);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::fee_helper::validate_dynamic_fee_parameters(arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::is_fee_scheduler_enabled(&arg0.parameters);
        if (v2) {
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::fee_helper::validate_base_fee(v1, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_fee_scheduler_mode(&arg0.parameters), arg6, arg7, arg8, arg9);
        };
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = if (0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::is_dynamic_fee_enabled(&arg0.parameters)) {
            let v4 = arg0.parameters;
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::set_volatility_accumulator(&mut v4, arg5);
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_variable_fee(&v4, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_tick_spacing(&arg0.parameters))
        } else {
            0
        };
        let v5 = if (v2) {
            arg6
        } else {
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_fee_rate(&arg0.parameters)
        };
        assert!(0x1::u64::max(v3, v5) <= 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::constants::max_fee(), 433);
        let v6 = StaticFeeParametersSetEvent{
            sender                     : 0x2::tx_context::sender(arg10),
            filter_period              : arg1,
            decay_period               : arg2,
            reduction_factor           : arg3,
            variable_fee_control       : arg4,
            max_volatility_accumulator : arg5,
            cliff_fee_numerator        : arg6,
            scheduler_number_of_period : arg7,
            scheduler_period_frequency : arg8,
            scheduler_reduction_factor : arg9,
        };
        0x2::event::emit<StaticFeeParametersSetEvent>(v6);
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

    fun swap_in_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: u64) : SwapResult {
        let v0 = default_swap_result();
        let v1 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::first_score_for_swap(&arg0.tick_manager, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters), arg1);
        let v2 = 0;
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::update_references(&mut arg0.parameters, arg6 / 1000);
        let v3 = arg0.collect_fee_mode;
        let v4 = arg0.is_quote_y;
        let v5 = v3 == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::constants::collect_fee_mode_on_both() || v3 == 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::constants::collect_fee_mode_on_quote() && (arg1 && !v4 || !arg1 && v4) || true;
        while (arg4 > 0 && 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters) != arg3) {
            0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::update_volatility_accumulator(&mut arg0.parameters, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_tick_index(&arg0.parameters));
            if (0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::is_none(&v1)) {
                abort 4
            };
            let (v6, v7) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::borrow_tick_for_swap(&arg0.tick_manager, 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::borrow(&v1), arg1);
            v1 = v7;
            let v8 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::index(v6);
            let v9 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::sqrt_price(v6);
            let v10 = if (arg1) {
                0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u128::max(arg3, v9)
            } else {
                0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u128::min(arg3, v9)
            };
            let v11 = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_total_fee_rate(&arg0.parameters, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_tick_spacing(&arg0.parameters), arg6);
            let (v12, v13, v14, v15) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::clmm_math::compute_swap_step(0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters), v10, arg0.liquidity, arg4, v5, v11, arg1, arg2);
            if (v12 != 0 || v15 != 0) {
                if (arg2) {
                    if (v5) {
                        let v16 = check_remainer_amount_sub(arg4, v12);
                        arg4 = check_remainer_amount_sub(v16, v15);
                    } else {
                        arg4 = check_remainer_amount_sub(arg4, v12);
                    };
                } else {
                    arg4 = check_remainer_amount_sub(arg4, v13);
                };
                let v17 = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::full_math_u64::mul_div_ceil(v15, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_base_fee(&arg0.parameters, arg6), v11);
                let v18 = &mut v0;
                update_swap_result(v18, v12, v13, v15, v17, v15 - v17);
                let v19 = update_pool_fee<T0, T1>(arg0, v15, arg5, arg1, v5);
                v2 = v2 + v19;
            };
            if (v14 == v9) {
                0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::set_current_sqrt_price(&mut arg0.parameters, v14);
                let v20 = if (arg1) {
                    0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::sub(v8, 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::from(1))
                } else {
                    v8
                };
                0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::set_current_tick_index(&mut arg0.parameters, v20);
                arg0.liquidity = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::cross_by_swap(&mut arg0.tick_manager, v8, arg1, arg0.liquidity, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::points_growth_global(&arg0.rewarder_manager), 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::rewards_growth_global(&arg0.rewarder_manager));
                continue
            };
            if (0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_current_sqrt_price(&arg0.parameters) != v14) {
                0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::set_current_sqrt_price(&mut arg0.parameters, v14);
                0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::set_current_tick_index(&mut arg0.parameters, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick_math::get_tick_at_sqrt_price(v14));
            };
        };
        if (v5 && arg1 || !arg1) {
            arg0.fee_protocol_coin_a = arg0.fee_protocol_coin_a + v2;
        } else {
            arg0.fee_protocol_coin_b = arg0.fee_protocol_coin_b + v2;
        };
        v0.collect_fee_on_input = v5;
        v0
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    public fun tick_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::tick::TickManager {
        &arg0.tick_manager
    }

    public fun unpause<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = false;
    }

    public fun update_emission<T0, T1, T2>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_reward_role(arg0, 0x2::tx_context::sender(arg5));
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::rewarder::update_emission<T2>(arg2, &mut arg1.rewarder_manager, arg1.liquidity, arg3, 0x2::clock::timestamp_ms(arg4));
        let v0 = UpdateEmissionEvent{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg1),
            rewarder_type    : 0x1::type_name::get<T2>(),
            emissions_per_ms : arg3,
        };
        0x2::event::emit<UpdateEmissionEvent>(v0);
    }

    public fun update_fee_rate<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        assert!(arg2 <= 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::constants::max_fee_rate(), 433);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::set_fee_rate(&mut arg1.parameters, arg2);
        let v0 = UpdateFeeRateEvent{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg1),
            old_fee_rate : 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pair_parameter_helper::get_fee_rate(&arg1.parameters),
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    fun update_flash_loan_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::full_math_u64::mul_div_ceil(arg1, arg2, 10000);
        let v1 = arg1 - v0;
        if (v1 == 0 || arg0.liquidity == 0) {
            return v0
        };
        if (arg3) {
            arg0.fee_growth_global_a = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u128::wrapping_add(arg0.fee_growth_global_a, ((v1 as u128) << 64) / arg0.liquidity);
        } else {
            arg0.fee_growth_global_b = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u128::wrapping_add(arg0.fee_growth_global_b, ((v1 as u128) << 64) / arg0.liquidity);
        };
        v0
    }

    fun update_pool_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: bool) : u64 {
        let v0 = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::full_math_u64::mul_div_ceil(arg1, arg2, 10000);
        let v1 = arg1 - v0;
        if (v1 == 0 || arg0.liquidity == 0) {
            return v0
        };
        if (arg4 && arg3 || !arg3) {
            arg0.fee_growth_global_a = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u128::wrapping_add(arg0.fee_growth_global_a, ((v1 as u128) << 64) / arg0.liquidity);
        } else {
            arg0.fee_growth_global_b = 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u128::wrapping_add(arg0.fee_growth_global_b, ((v1 as u128) << 64) / arg0.liquidity);
        };
        v0
    }

    public fun update_position_url<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::checked_package_version(arg0);
        assert!(!0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::global_paused(arg0) && !arg1.is_pause, 413);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.url = arg2;
    }

    fun update_swap_result(arg0: &mut SwapResult, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u64::add_check(arg0.amount_in, arg1), 406);
        assert!(0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u64::add_check(arg0.amount_out, arg2), 407);
        assert!(0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::math_u64::add_check(arg0.fee_amount, arg3), 408);
        arg0.amount_in = arg0.amount_in + arg1;
        arg0.amount_out = arg0.amount_out + arg2;
        arg0.fee_amount = arg0.fee_amount + arg3;
        arg0.base_fee = arg0.base_fee + arg4;
        arg0.dynamic_fee = arg0.dynamic_fee + arg5;
        arg0.steps = arg0.steps + 1;
    }

    public fun url<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

