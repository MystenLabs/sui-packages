module 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool {
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
        current_tick_index: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
        fee_protocol_coin_a: u64,
        fee_protocol_coin_b: u64,
        tick_manager: 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::TickManager,
        rewarder_manager: 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::RewarderManager,
        position_manager: 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::PositionManager,
        is_pause: bool,
        index: u64,
        url: 0x1::string::String,
        unstaked_liquidity_fee_rate: u64,
        magma_distribution_gauger_id: 0x1::option::Option<0x2::object::ID>,
        magma_distribution_growth_global: u128,
        magma_distribution_rate: u128,
        magma_distribution_reserve: u64,
        magma_distribution_period_finish: u64,
        magma_distribution_rollover: u64,
        magma_distribution_last_updated: u64,
        magma_distribution_staked_liquidity: u128,
        magma_distribution_gauger_fee: PoolFee,
    }

    struct PoolFee has drop, store {
        coin_a: u64,
        coin_b: u64,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        protocol_fee_amount: u64,
        ref_fee_amount: u64,
        gauge_fee_amount: u64,
        steps: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        partner_id: 0x2::object::ID,
        pay_amount: u64,
        fee_amount: u64,
        protocol_fee_amount: u64,
        ref_fee_amount: u64,
        gauge_fee_amount: u64,
    }

    struct AddLiquidityReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct CalculatedSwapResult has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        fee_rate: u64,
        ref_fee_amount: u64,
        gauge_fee_amount: u64,
        protocol_fee_amount: u64,
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
        tick_lower: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32,
        tick_upper: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32,
        position: 0x2::object::ID,
    }

    struct ClosePositionEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        tick_lower: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32,
        tick_upper: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32,
        liquidity: u128,
        after_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct RemoveLiquidityEvent has copy, drop, store {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        tick_lower: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32,
        tick_upper: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32,
        liquidity: u128,
        after_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct SwapEvent has copy, drop, store {
        atob: bool,
        pool: 0x2::object::ID,
        partner: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        magma_fee_amount: u64,
        protocol_fee_amount: u64,
        ref_fee_amount: u64,
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
        amount: u64,
    }

    struct CollectGaugeFeeEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct UpdateUnstakedLiquidityFeeRateEvent has copy, drop, store {
        pool: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    public(friend) fun new<T0, T1>(arg0: u32, arg1: u128, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = PoolFee{
            coin_a : 0,
            coin_b : 0,
        };
        Pool<T0, T1>{
            id                                  : 0x2::object::new(arg6),
            coin_a                              : 0x2::balance::zero<T0>(),
            coin_b                              : 0x2::balance::zero<T1>(),
            tick_spacing                        : arg0,
            fee_rate                            : arg2,
            liquidity                           : 0,
            current_sqrt_price                  : arg1,
            current_tick_index                  : 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_tick_at_sqrt_price(arg1),
            fee_growth_global_a                 : 0,
            fee_growth_global_b                 : 0,
            fee_protocol_coin_a                 : 0,
            fee_protocol_coin_b                 : 0,
            tick_manager                        : 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::new(arg0, 0x2::clock::timestamp_ms(arg5), arg6),
            rewarder_manager                    : 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::new(),
            position_manager                    : 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::new(arg0, arg6),
            is_pause                            : false,
            index                               : arg4,
            url                                 : arg3,
            unstaked_liquidity_fee_rate         : 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::default_unstaked_fee_rate(),
            magma_distribution_gauger_id        : 0x1::option::none<0x2::object::ID>(),
            magma_distribution_growth_global    : 0,
            magma_distribution_rate             : 0,
            magma_distribution_reserve          : 0,
            magma_distribution_period_finish    : 0,
            magma_distribution_rollover         : 0,
            magma_distribution_last_updated     : 0x2::clock::timestamp_ms(arg5) / 1000,
            magma_distribution_staked_liquidity : 0,
            magma_distribution_gauger_fee       : v0,
        }
    }

    public fun get_amount_by_liquidity(arg0: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg2: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg3: u128, arg4: u128, arg5: bool) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        if (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::lt(arg2, arg0)) {
            (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_delta_a(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg0), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), 0)
        } else if (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::lt(arg2, arg1)) {
            (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_delta_a(arg3, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_delta_b(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg0), arg3, arg4, arg5))
        } else {
            (0, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_delta_b(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg0), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5))
        }
    }

    public fun unstaked_liquidity_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.unstaked_liquidity_fee_rate
    }

    public fun add_liquidity<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : AddLiquidityReceipt<T0, T1> {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(arg3 != 0, 3);
        add_liquidity_internal<T0, T1>(arg1, arg2, false, arg3, 0, false, 0x2::clock::timestamp_ms(arg4) / 1000)
    }

    public fun add_liquidity_fix_coin<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : AddLiquidityReceipt<T0, T1> {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(arg3 > 0, 0);
        add_liquidity_internal<T0, T1>(arg1, arg2, true, 0, arg3, arg4, 0x2::clock::timestamp_ms(arg5) / 1000)
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position, arg2: bool, arg3: u128, arg4: u64, arg5: bool, arg6: u64) : AddLiquidityReceipt<T0, T1> {
        assert!(!arg0.is_pause, 13);
        validate_pool_position<T0, T1>(arg0, arg1);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::settle(&mut arg0.rewarder_manager, arg0.liquidity, arg6);
        let (v0, v1) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::tick_range(arg1);
        let (v2, v3, v4) = if (arg2) {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_liquidity_by_amount(v0, v1, arg0.current_tick_index, arg0.current_sqrt_price, arg4, arg5)
        } else {
            let (v5, v6) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_amount_by_liquidity(v0, v1, arg0.current_tick_index, arg0.current_sqrt_price, arg3, true);
            (arg3, v5, v6)
        };
        let (v7, v8, v9, v10, v11) = get_all_growths_in_tick_range<T0, T1>(arg0, v0, v1);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::increase_liquidity(&mut arg0.tick_manager, arg0.current_tick_index, v0, v1, v2, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::points_growth_global(&arg0.rewarder_manager), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::rewards_growth_global(&arg0.rewarder_manager), arg0.magma_distribution_growth_global);
        if (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::gte(arg0.current_tick_index, v0) && 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::lt(arg0.current_tick_index, v1)) {
            assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::add_check(arg0.liquidity, v2), 1);
            arg0.liquidity = arg0.liquidity + v2;
        };
        let v12 = AddLiquidityEvent{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg0),
            position        : 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(arg1),
            tick_lower      : v0,
            tick_upper      : v1,
            liquidity       : arg3,
            after_liquidity : 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::increase_liquidity(&mut arg0.position_manager, arg1, v2, v7, v8, v10, v9, v11),
            amount_a        : v3,
            amount_b        : v4,
        };
        0x2::event::emit<AddLiquidityEvent>(v12);
        AddLiquidityReceipt<T0, T1>{
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a : v3,
            amount_b : v4,
        }
    }

    public fun add_liquidity_pay_amount<T0, T1>(arg0: &AddLiquidityReceipt<T0, T1>) : (u64, u64) {
        (arg0.amount_a, arg0.amount_b)
    }

    fun apply_unstaked_fees(arg0: u128, arg1: u128, arg2: u64) : (u128, u128) {
        let v0 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_ceil(arg0, (arg2 as u128), 10000);
        (arg0 - v0, arg1 + v0)
    }

    public fun balances<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    public fun borrow_position_info<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::PositionInfo {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(&arg0.position_manager, arg1)
    }

    public fun borrow_tick<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32) : &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::Tick {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::borrow_tick(&arg0.tick_manager, arg1)
    }

    public fun calculate_and_update_fee<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID) : (u64, u64) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let v0 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_liquidity(v0) != 0) {
            let (v3, v4) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_tick_range(v0);
            let (v5, v6) = get_fee_in_tick_range<T0, T1>(arg1, v3, v4);
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::update_fee(&mut arg1.position_manager, arg2, v5, v6)
        } else {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_fee_owned(v0)
        }
    }

    public fun calculate_and_update_magma_distribution<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID) : u64 {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let v0 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_liquidity(v0) != 0) {
            let (v2, v3) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_tick_range(v0);
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::update_magma_distribution(&mut arg1.position_manager, arg2, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::get_magma_distribution_growth_in_range(arg1.current_tick_index, arg1.magma_distribution_growth_global, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg1.tick_manager, v2), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg1.tick_manager, v3)))
        } else {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_magma_distribution_owned(v0)
        }
    }

    public fun calculate_and_update_points<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u128 {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v0 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_liquidity(v0) != 0) {
            let (v2, v3) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_tick_range(v0);
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::update_points(&mut arg1.position_manager, arg2, get_points_in_tick_range<T0, T1>(arg1, v2, v3))
        } else {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_points_owned(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(&arg1.position_manager, arg2))
        }
    }

    public fun calculate_and_update_reward<T0, T1, T2>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::rewarder_index<T2>(&arg1.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v0), 17);
        let v1 = calculate_and_update_rewards<T0, T1>(arg0, arg1, arg2, arg3);
        *0x1::vector::borrow<u64>(&v1, 0x1::option::extract<u64>(&mut v0))
    }

    public fun calculate_and_update_rewards<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : vector<u64> {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v0 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(&arg1.position_manager, arg2);
        if (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_liquidity(v0) != 0) {
            let (v2, v3) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_tick_range(v0);
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::update_rewards(&mut arg1.position_manager, arg2, get_rewards_in_tick_range<T0, T1>(arg1, v2, v3))
        } else {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::rewards_amount_owned(&arg1.position_manager, arg2)
        }
    }

    fun calculate_fees<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u128, arg3: u128, arg4: u64) : (u128, u64) {
        if (arg2 == arg0.magma_distribution_staked_liquidity) {
            (0, arg1)
        } else if (arg3 == 0) {
            let (v2, v3) = apply_unstaked_fees((arg1 as u128), 0, arg4);
            (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_floor(v2, 18446744073709551616, arg2), (v3 as u64))
        } else {
            let (v4, v5) = split_fees(arg1, arg2, arg3, arg4);
            (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_floor((v4 as u128), 18446744073709551616, arg2 - arg3), v5)
        }
    }

    public fun calculate_swap_result<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64) : CalculatedSwapResult {
        let v0 = arg1.current_sqrt_price;
        let v1 = arg1.liquidity;
        let v2 = arg1.magma_distribution_staked_liquidity;
        let v3 = default_swap_result();
        let v4 = arg4;
        let v5 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::first_score_for_swap(&arg1.tick_manager, arg1.current_tick_index, arg2);
        let v6 = CalculatedSwapResult{
            amount_in           : 0,
            amount_out          : 0,
            fee_amount          : 0,
            fee_rate            : arg1.fee_rate,
            ref_fee_amount      : 0,
            gauge_fee_amount    : 0,
            protocol_fee_amount : 0,
            after_sqrt_price    : arg1.current_sqrt_price,
            is_exceed           : false,
            step_results        : 0x1::vector::empty<SwapStepResult>(),
        };
        let v7 = if (arg1.unstaked_liquidity_fee_rate == 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::default_unstaked_fee_rate()) {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::unstaked_liquidity_fee_rate(arg0)
        } else {
            arg1.unstaked_liquidity_fee_rate
        };
        while (v4 > 0) {
            if (0x488b927da11f1a626d56d3d000cf49b5cd40b3ed4d989ba15ac35a6c4791f83e::option_u64::is_none(&v5)) {
                v6.is_exceed = true;
                break
            };
            let (v8, v9) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::borrow_tick_for_swap(&arg1.tick_manager, 0x488b927da11f1a626d56d3d000cf49b5cd40b3ed4d989ba15ac35a6c4791f83e::option_u64::borrow(&v5), arg2);
            v5 = v9;
            let v10 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::sqrt_price(v8);
            let (v11, v12, v13, v14) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::compute_swap_step(v0, v10, v1, v4, arg1.fee_rate, arg2, arg3);
            if (v11 != 0 || v14 != 0) {
                let v15 = if (arg3) {
                    check_remainer_amount_sub(check_remainer_amount_sub(v4, v11), v14)
                } else {
                    check_remainer_amount_sub(v4, v12)
                };
                v4 = v15;
                let v16 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(v14, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::protocol_fee_rate(arg0), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::protocol_fee_rate_denom());
                let (_, v18) = calculate_fees<T0, T1>(arg1, v14 - v16, arg1.liquidity, arg1.magma_distribution_staked_liquidity, v7);
                let v19 = &mut v3;
                update_swap_result(v19, v11, v12, v14, v16, 0, v18);
            };
            let v20 = SwapStepResult{
                current_sqrt_price : v0,
                target_sqrt_price  : v10,
                current_liquidity  : v1,
                amount_in          : v11,
                amount_out         : v12,
                fee_amount         : v14,
                remainder_amount   : v4,
            };
            0x1::vector::push_back<SwapStepResult>(&mut v6.step_results, v20);
            if (v13 == v10) {
                v0 = v10;
                let (v21, v22) = if (arg2) {
                    (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::neg(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::liquidity_net(v8)), 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::neg(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::magma_distribution_staked_liquidity_net(v8)))
                } else {
                    (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::liquidity_net(v8), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::magma_distribution_staked_liquidity_net(v8))
                };
                let v23 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::abs_u128(v21);
                let v24 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::abs_u128(v22);
                if (!0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::is_neg(v21)) {
                    assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::add_check(v1, v23), 1);
                    v1 = v1 + v23;
                } else {
                    assert!(v1 >= v23, 1);
                    v1 = v1 - v23;
                };
                if (!0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::is_neg(v22)) {
                    assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::add_check(v2, v24), 1);
                    v2 = v2 + v24;
                    continue
                };
                assert!(v2 >= v24, 1);
                v2 = v2 - v24;
                continue
            };
            v0 = v13;
        };
        v6.amount_in = v3.amount_in;
        v6.amount_out = v3.amount_out;
        v6.fee_amount = v3.fee_amount;
        v6.gauge_fee_amount = v3.gauge_fee_amount;
        v6.protocol_fee_amount = v3.protocol_fee_amount;
        v6.after_sqrt_price = v0;
        v6
    }

    public fun calculate_swap_result_step_results(arg0: &CalculatedSwapResult) : &vector<SwapStepResult> {
        &arg0.step_results
    }

    public fun calculate_swap_result_with_partner<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u64) : CalculatedSwapResult {
        let v0 = arg1.current_sqrt_price;
        let v1 = arg1.liquidity;
        let v2 = arg1.magma_distribution_staked_liquidity;
        let v3 = default_swap_result();
        let v4 = arg4;
        let v5 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::first_score_for_swap(&arg1.tick_manager, arg1.current_tick_index, arg2);
        let v6 = CalculatedSwapResult{
            amount_in           : 0,
            amount_out          : 0,
            fee_amount          : 0,
            fee_rate            : arg1.fee_rate,
            ref_fee_amount      : 0,
            gauge_fee_amount    : 0,
            protocol_fee_amount : 0,
            after_sqrt_price    : arg1.current_sqrt_price,
            is_exceed           : false,
            step_results        : 0x1::vector::empty<SwapStepResult>(),
        };
        let v7 = if (arg1.unstaked_liquidity_fee_rate == 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::default_unstaked_fee_rate()) {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::unstaked_liquidity_fee_rate(arg0)
        } else {
            arg1.unstaked_liquidity_fee_rate
        };
        while (v4 > 0) {
            if (0x488b927da11f1a626d56d3d000cf49b5cd40b3ed4d989ba15ac35a6c4791f83e::option_u64::is_none(&v5)) {
                v6.is_exceed = true;
                break
            };
            let (v8, v9) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::borrow_tick_for_swap(&arg1.tick_manager, 0x488b927da11f1a626d56d3d000cf49b5cd40b3ed4d989ba15ac35a6c4791f83e::option_u64::borrow(&v5), arg2);
            v5 = v9;
            let v10 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::sqrt_price(v8);
            let (v11, v12, v13, v14) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::compute_swap_step(v0, v10, v1, v4, arg1.fee_rate, arg2, arg3);
            if (v11 != 0 || v14 != 0) {
                let v15 = if (arg3) {
                    check_remainer_amount_sub(check_remainer_amount_sub(v4, v11), v14)
                } else {
                    check_remainer_amount_sub(v4, v12)
                };
                v4 = v15;
                let v16 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(v14, arg5, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::protocol_fee_rate_denom());
                let v17 = v14 - v16;
                let v18 = 0;
                let v19 = 0;
                if (v17 > 0) {
                    let v20 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(v17, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::protocol_fee_rate(arg0), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::protocol_fee_rate_denom());
                    v19 = v20;
                    let v21 = v17 - v20;
                    if (v21 > 0) {
                        let (_, v23) = calculate_fees<T0, T1>(arg1, v21, arg1.liquidity, arg1.magma_distribution_staked_liquidity, v7);
                        v18 = v23;
                    };
                };
                let v24 = &mut v3;
                update_swap_result(v24, v11, v12, v14, v19, v16, v18);
            };
            let v25 = SwapStepResult{
                current_sqrt_price : v0,
                target_sqrt_price  : v10,
                current_liquidity  : v1,
                amount_in          : v11,
                amount_out         : v12,
                fee_amount         : v14,
                remainder_amount   : v4,
            };
            0x1::vector::push_back<SwapStepResult>(&mut v6.step_results, v25);
            if (v13 == v10) {
                v0 = v10;
                let (v26, v27) = if (arg2) {
                    (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::neg(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::liquidity_net(v8)), 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::neg(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::magma_distribution_staked_liquidity_net(v8)))
                } else {
                    (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::liquidity_net(v8), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::magma_distribution_staked_liquidity_net(v8))
                };
                let v28 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::abs_u128(v26);
                let v29 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::abs_u128(v27);
                if (!0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::is_neg(v26)) {
                    assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::add_check(v1, v28), 1);
                    v1 = v1 + v28;
                } else {
                    assert!(v1 >= v28, 1);
                    v1 = v1 - v28;
                };
                if (!0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::is_neg(v27)) {
                    assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::add_check(v2, v29), 1);
                    v2 = v2 + v29;
                    continue
                };
                assert!(v2 >= v29, 1);
                v2 = v2 - v29;
                continue
            };
            v0 = v13;
        };
        v6.amount_in = v3.amount_in;
        v6.amount_out = v3.amount_out;
        v6.fee_amount = v3.fee_amount;
        v6.gauge_fee_amount = v3.gauge_fee_amount;
        v6.protocol_fee_amount = v3.protocol_fee_amount;
        v6.ref_fee_amount = v3.ref_fee_amount;
        v6.after_sqrt_price = v0;
        v6
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

    public fun calculated_swap_result_fees_amount(arg0: &CalculatedSwapResult) : (u64, u64, u64, u64) {
        (arg0.fee_amount, arg0.ref_fee_amount, arg0.protocol_fee_amount, arg0.gauge_fee_amount)
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

    fun check_gauge_cap<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap) {
        let v0 = if (0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::get_pool_id(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0)) {
            let v1 = &arg0.magma_distribution_gauger_id;
            if (0x1::option::is_some<0x2::object::ID>(v1)) {
                let v2 = 0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::get_gauge_id(arg1);
                0x1::option::borrow<0x2::object::ID>(v1) == &v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9223379355479048191);
    }

    fun check_remainer_amount_sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 5);
        arg0 - arg1
    }

    fun check_tick_range(arg0: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32) : bool {
        if (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::gte(arg0, arg1) || 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::lt(arg0, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::min_tick()) || 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::gt(arg1, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::max_tick())) {
            return false
        };
        true
    }

    public fun close_position<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::close_position(&mut arg1.position_manager, arg2);
        let v0 = ClosePositionEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            position : 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&arg2),
        };
        0x2::event::emit<ClosePositionEvent>(v0);
    }

    public fun collect_fee<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position, arg3: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let v0 = 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(arg2);
        if (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::is_staked(borrow_position_info<T0, T1>(arg1, v0))) {
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v1, v2) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::tick_range(arg2);
        let (v3, v4) = if (arg3 && 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::liquidity(arg2) != 0) {
            let (v5, v6) = get_fee_in_tick_range<T0, T1>(arg1, v1, v2);
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::update_and_reset_fee(&mut arg1.position_manager, v0, v5, v6)
        } else {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::reset_fee(&mut arg1.position_manager, v0)
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

    public fun collect_magma_distribution_gauger_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.is_pause, 13);
        check_gauge_cap<T0, T1>(arg0, arg1);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        if (arg0.magma_distribution_gauger_fee.coin_a > 0) {
            0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut arg0.coin_a, arg0.magma_distribution_gauger_fee.coin_a));
            arg0.magma_distribution_gauger_fee.coin_a = 0;
        };
        if (arg0.magma_distribution_gauger_fee.coin_b > 0) {
            0x2::balance::join<T1>(&mut v1, 0x2::balance::split<T1>(&mut arg0.coin_b, arg0.magma_distribution_gauger_fee.coin_b));
            arg0.magma_distribution_gauger_fee.coin_b = 0;
        };
        let v2 = CollectGaugeFeeEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a : 0x2::balance::value<T0>(&v0),
            amount_b : 0x2::balance::value<T1>(&v1),
        };
        0x2::event::emit<CollectGaugeFeeEvent>(v2);
        (v0, v1)
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg2));
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

    public fun collect_reward<T0, T1, T2>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position, arg3: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::RewarderGlobalVault, arg4: bool, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v0 = 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(arg2);
        let v1 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::rewarder_index<T2>(&arg1.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v1), 17);
        let v2 = 0x1::option::extract<u64>(&mut v1);
        let v3 = if (arg4 && 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::liquidity(arg2) != 0 || 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::inited_rewards_count(&arg1.position_manager, v0) <= v2) {
            let (v4, v5) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::tick_range(arg2);
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::update_and_reset_rewards(&mut arg1.position_manager, v0, get_rewards_in_tick_range<T0, T1>(arg1, v4, v5), v2)
        } else {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::reset_rewarder(&mut arg1.position_manager, v0, v2)
        };
        let v6 = CollectRewardEvent{
            position : v0,
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            amount   : v3,
        };
        0x2::event::emit<CollectRewardEvent>(v6);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::withdraw_reward<T2>(arg3, v3)
    }

    public fun current_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.current_sqrt_price
    }

    public fun current_tick_index<T0, T1>(arg0: &Pool<T0, T1>) : 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32 {
        arg0.current_tick_index
    }

    fun default_swap_result() : SwapResult {
        SwapResult{
            amount_in           : 0,
            amount_out          : 0,
            fee_amount          : 0,
            protocol_fee_amount : 0,
            ref_fee_amount      : 0,
            gauge_fee_amount    : 0,
            steps               : 0,
        }
    }

    public fun fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_rate
    }

    public fun fees_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.fee_amount, arg0.ref_fee_amount, arg0.protocol_fee_amount, arg0.gauge_fee_amount)
    }

    public fun fees_growth_global<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128) {
        (arg0.fee_growth_global_a, arg0.fee_growth_global_b)
    }

    public fun fetch_positions<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) : vector<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::PositionInfo> {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::fetch_positions(&arg0.position_manager, arg1, arg2)
    }

    public fun fetch_ticks<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u32>, arg2: u64) : vector<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::Tick> {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::fetch_ticks(&arg0.tick_manager, arg1, arg2)
    }

    public fun flash_swap<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        flash_swap_internal<T0, T1>(arg1, arg0, 0x2::object::id_from_address(@0x0), 0, arg2, arg3, arg4, arg5, arg6)
    }

    fun flash_swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg2: 0x2::object::ID, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert!(arg6 > 0, 0);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::settle(&mut arg0.rewarder_manager, arg0.liquidity, 0x2::clock::timestamp_ms(arg8) / 1000);
        if (arg4) {
            assert!(arg0.current_sqrt_price > arg7 && arg7 >= 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::min_sqrt_price(), 11);
        } else {
            assert!(arg0.current_sqrt_price < arg7 && arg7 <= 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::max_sqrt_price(), 11);
        };
        let v0 = arg0.unstaked_liquidity_fee_rate;
        let v1 = if (v0 == 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::default_unstaked_fee_rate()) {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::unstaked_liquidity_fee_rate(arg1)
        } else {
            v0
        };
        let v2 = swap_in_pool<T0, T1>(arg0, arg4, arg5, arg7, arg6, v1, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::protocol_fee_rate(arg1), arg3, arg8);
        assert!(v2.amount_out > 0, 18);
        let (v3, v4) = if (arg4) {
            (0x2::balance::split<T1>(&mut arg0.coin_b, v2.amount_out), 0x2::balance::zero<T0>())
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut arg0.coin_a, v2.amount_out))
        };
        let v5 = SwapEvent{
            atob                : arg4,
            pool                : 0x2::object::id<Pool<T0, T1>>(arg0),
            partner             : arg2,
            amount_in           : v2.amount_in + v2.fee_amount,
            amount_out          : v2.amount_out,
            magma_fee_amount    : v2.gauge_fee_amount,
            protocol_fee_amount : v2.protocol_fee_amount,
            ref_fee_amount      : v2.ref_fee_amount,
            fee_amount          : v2.fee_amount,
            vault_a_amount      : 0x2::balance::value<T0>(&arg0.coin_a),
            vault_b_amount      : 0x2::balance::value<T1>(&arg0.coin_b),
            before_sqrt_price   : arg0.current_sqrt_price,
            after_sqrt_price    : arg0.current_sqrt_price,
            steps               : v2.steps,
        };
        0x2::event::emit<SwapEvent>(v5);
        let v6 = FlashSwapReceipt<T0, T1>{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg0),
            a2b                 : arg4,
            partner_id          : arg2,
            pay_amount          : v2.amount_in + v2.fee_amount,
            fee_amount          : v2.fee_amount,
            protocol_fee_amount : v2.protocol_fee_amount,
            ref_fee_amount      : v2.ref_fee_amount,
            gauge_fee_amount    : v2.gauge_fee_amount,
        };
        (v4, v3, v6)
    }

    public fun flash_swap_with_partner<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::partner::Partner, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        flash_swap_internal<T0, T1>(arg1, arg0, 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::partner::Partner>(arg2), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::partner::current_ref_fee_rate(arg2, 0x2::clock::timestamp_ms(arg7) / 1000), arg3, arg4, arg5, arg6, arg7)
    }

    public fun get_all_growths_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg2: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32) : (u128, u128, vector<u128>, u128, u128) {
        let v0 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg1);
        let v1 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg2);
        let (v2, v3) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::get_fee_in_range(arg0.current_tick_index, arg0.fee_growth_global_a, arg0.fee_growth_global_b, v0, v1);
        (v2, v3, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::get_rewards_in_range(arg0.current_tick_index, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::rewards_growth_global(&arg0.rewarder_manager), v0, v1), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::get_points_in_range(arg0.current_tick_index, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::points_growth_global(&arg0.rewarder_manager), v0, v1), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::get_magma_distribution_growth_in_range(arg0.current_tick_index, arg0.magma_distribution_growth_global, v0, v1))
    }

    public fun get_fee_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg2: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32) : (u128, u128) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::get_fee_in_range(arg0.current_tick_index, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun get_liquidity_from_amount(arg0: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg2: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg3: u128, arg4: u64, arg5: bool) : (u128, u64, u64) {
        if (arg5) {
            let (v3, v4) = if (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::lt(arg2, arg0)) {
                (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_liquidity_from_a(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg0), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg1), arg4, false), 0)
            } else {
                assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::lt(arg2, arg1), 19);
                let v5 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_liquidity_from_a(arg3, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg1), arg4, false);
                (v5, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_delta_b(arg3, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg0), v5, true))
            };
            (v3, arg4, v4)
        } else {
            let (v6, v7) = if (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::gte(arg2, arg1)) {
                (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_liquidity_from_b(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg0), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg1), arg4, false), 0)
            } else {
                assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::gte(arg2, arg0), 19);
                let v8 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_liquidity_from_b(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg0), arg3, arg4, false);
                (v8, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::get_delta_a(arg3, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_sqrt_price_at_tick(arg1), v8, true))
            };
            (v6, v7, arg4)
        }
    }

    public fun get_magma_distribution_gauger_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.magma_distribution_gauger_id), 9223379295349506047);
        *0x1::option::borrow<0x2::object::ID>(&arg0.magma_distribution_gauger_id)
    }

    public fun get_magma_distribution_growth_global<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.magma_distribution_growth_global
    }

    public fun get_magma_distribution_growth_inside<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg2: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg3: u128) : u128 {
        assert!(check_tick_range(arg1, arg2), 9223378947457155071);
        if (arg3 == 0) {
            arg3 = arg0.magma_distribution_growth_global;
        };
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::get_magma_distribution_growth_in_range(arg0.current_tick_index, arg3, 0x1::option::some<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::Tick>(*borrow_tick<T0, T1>(arg0, arg1)), 0x1::option::some<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::Tick>(*borrow_tick<T0, T1>(arg0, arg2)))
    }

    public fun get_magma_distribution_last_updated<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.magma_distribution_last_updated
    }

    public fun get_magma_distribution_reserve<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.magma_distribution_reserve
    }

    public fun get_magma_distribution_rollover<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.magma_distribution_rollover
    }

    public fun get_magma_distribution_staked_liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.magma_distribution_staked_liquidity
    }

    public fun get_points_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg2: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32) : u128 {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::get_points_in_range(arg0.current_tick_index, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::points_growth_global(&arg0.rewarder_manager), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun get_position_amounts<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(&arg0.position_manager, arg1);
        let (v1, v2) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_tick_range(v0);
        get_amount_by_liquidity(v1, v2, arg0.current_tick_index, arg0.current_sqrt_price, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_liquidity(v0), false)
    }

    public fun get_position_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_fee_owned(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(&arg0.position_manager, arg1))
    }

    public fun get_position_points<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::info_points_owned(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(&arg0.position_manager, arg1))
    }

    public fun get_position_reward<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::rewarder_index<T2>(&arg0.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v0), 17);
        let v1 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::rewards_amount_owned(&arg0.position_manager, arg1);
        *0x1::vector::borrow<u64>(&v1, 0x1::option::extract<u64>(&mut v0))
    }

    public fun get_position_rewards<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : vector<u64> {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::rewards_amount_owned(&arg0.position_manager, arg1)
    }

    public fun get_rewards_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg2: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32) : vector<u128> {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::get_rewards_in_range(arg0.current_tick_index, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::rewards_growth_global(&arg0.rewarder_manager), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun index<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.index
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_magma_distribution_gauge<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap) {
        assert!(0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::get_pool_id(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0), 9223379334004211711);
        0x1::option::fill<0x2::object::ID>(&mut arg0.magma_distribution_gauger_id, 0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::get_gauge_id(arg1));
    }

    public fun initialize_rewarder<T0, T1, T2>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::check_rewarder_manager_role(arg0, 0x2::tx_context::sender(arg2));
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::add_rewarder<T2>(&mut arg1.rewarder_manager);
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
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::is_position_exist(&arg0.position_manager, arg1)
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun magma_distribution_gauger_fee<T0, T1>(arg0: &Pool<T0, T1>) : PoolFee {
        PoolFee{
            coin_a : arg0.magma_distribution_gauger_fee.coin_a,
            coin_b : arg0.magma_distribution_gauger_fee.coin_b,
        }
    }

    public fun mark_position_staked<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap, arg2: 0x2::object::ID) {
        assert!(!arg0.is_pause, 13);
        check_gauge_cap<T0, T1>(arg0, arg1);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::mark_position_staked(&mut arg0.position_manager, arg2, true);
    }

    public fun mark_position_unstaked<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap, arg2: 0x2::object::ID) {
        assert!(!arg0.is_pause, 13);
        check_gauge_cap<T0, T1>(arg0, arg1);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::mark_position_staked(&mut arg0.position_manager, arg2, false);
    }

    public fun open_position<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let v0 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::from_u32(arg2);
        let v1 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::from_u32(arg3);
        let v2 = 0x2::object::id<Pool<T0, T1>>(arg1);
        let v3 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::open_position<T0, T1>(&mut arg1.position_manager, v2, arg1.index, arg1.url, v0, v1, arg4);
        let v4 = OpenPositionEvent{
            pool       : v2,
            tick_lower : v0,
            tick_upper : v1,
            position   : 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&v3),
        };
        0x2::event::emit<OpenPositionEvent>(v4);
        v3
    }

    public fun pause<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(!arg1.is_pause, 9223376739843964927);
        arg1.is_pause = true;
    }

    public fun pool_fee_a_b(arg0: &PoolFee) : (u64, u64) {
        (arg0.coin_a, arg0.coin_b)
    }

    public fun position_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::PositionManager {
        &arg0.position_manager
    }

    public fun protocol_fee<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.fee_protocol_coin_a, arg0.fee_protocol_coin_b)
    }

    public fun remove_liquidity<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        assert!(arg3 > 0, 3);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::settle(&mut arg1.rewarder_manager, arg1.liquidity, 0x2::clock::timestamp_ms(arg4) / 1000);
        let (v0, v1) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::tick_range(arg2);
        let (v2, v3, v4, v5, v6) = get_all_growths_in_tick_range<T0, T1>(arg1, v0, v1);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::decrease_liquidity(&mut arg1.tick_manager, arg1.current_tick_index, v0, v1, arg3, arg1.fee_growth_global_a, arg1.fee_growth_global_b, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::points_growth_global(&arg1.rewarder_manager), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::rewards_growth_global(&arg1.rewarder_manager), arg1.magma_distribution_growth_global);
        if (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::lte(v0, arg1.current_tick_index) && 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::lt(arg1.current_tick_index, v1)) {
            arg1.liquidity = arg1.liquidity - arg3;
        };
        let (v7, v8) = get_amount_by_liquidity(v0, v1, arg1.current_tick_index, arg1.current_sqrt_price, arg3, false);
        let v9 = RemoveLiquidityEvent{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg1),
            position        : 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(arg2),
            tick_lower      : v0,
            tick_upper      : v1,
            liquidity       : arg3,
            after_liquidity : 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::decrease_liquidity(&mut arg1.position_manager, arg2, arg3, v2, v3, v5, v4, v6),
            amount_a        : v7,
            amount_b        : v8,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v9);
        (0x2::balance::split<T0>(&mut arg1.coin_a, v7), 0x2::balance::split<T1>(&mut arg1.coin_b, v8))
    }

    public fun repay_add_liquidity<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: AddLiquidityReceipt<T0, T1>) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
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

    public fun repay_flash_swap<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let FlashSwapReceipt {
            pool_id             : v0,
            a2b                 : v1,
            partner_id          : _,
            pay_amount          : v3,
            fee_amount          : _,
            protocol_fee_amount : _,
            ref_fee_amount      : v6,
            gauge_fee_amount    : _,
        } = arg4;
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == v0, 14);
        assert!(v6 == 0, 14);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v3, 0);
            0x2::balance::join<T0>(&mut arg1.coin_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v3, 0);
            0x2::balance::join<T1>(&mut arg1.coin_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun repay_flash_swap_with_partner<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::partner::Partner, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: FlashSwapReceipt<T0, T1>) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        let FlashSwapReceipt {
            pool_id             : v0,
            a2b                 : v1,
            partner_id          : v2,
            pay_amount          : v3,
            fee_amount          : _,
            protocol_fee_amount : _,
            ref_fee_amount      : v6,
            gauge_fee_amount    : _,
        } = arg5;
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == v0, 14);
        assert!(0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::partner::Partner>(arg2) == v2, 14);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg3) == v3, 0);
            if (v6 > 0) {
                0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::partner::receive_ref_fee<T0>(arg2, 0x2::balance::split<T0>(&mut arg3, v6));
            };
            0x2::balance::join<T0>(&mut arg1.coin_a, arg3);
            0x2::balance::destroy_zero<T1>(arg4);
        } else {
            assert!(0x2::balance::value<T1>(&arg4) == v3, 0);
            if (v6 > 0) {
                0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::partner::receive_ref_fee<T1>(arg2, 0x2::balance::split<T1>(&mut arg4, v6));
            };
            0x2::balance::join<T1>(&mut arg1.coin_b, arg4);
            0x2::balance::destroy_zero<T0>(arg3);
        };
    }

    public fun rewarder_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::RewarderManager {
        &arg0.rewarder_manager
    }

    public fun set_display<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_a"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_b"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg5);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg4);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg6);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg7);
        let v2 = 0x2::display::new_with_fields<Pool<T0, T1>>(arg1, v0, v1, arg8);
        0x2::display::update_version<Pool<T0, T1>>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<Pool<T0, T1>>>(v2, 0x2::tx_context::sender(arg8));
    }

    fun split_fees(arg0: u64, arg1: u128, arg2: u128, arg3: u64) : (u64, u64) {
        let v0 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_ceil((arg0 as u128), arg2, arg1);
        let (v1, v2) = apply_unstaked_fees((arg0 as u128) - v0, v0, arg3);
        ((v1 as u64), (v2 as u64))
    }

    public fun stake_in_magma_distribution<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap, arg2: u128, arg3: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg4: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg5: &0x2::clock::Clock) {
        assert!(!arg0.is_pause, 13);
        assert!(arg2 != 0, 9223379140730683391);
        check_gauge_cap<T0, T1>(arg0, arg1);
        update_magma_distribution_internal<T0, T1>(arg0, 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::from(arg2), arg3, arg4, arg5);
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

    fun swap_in_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : SwapResult {
        assert!(arg7 <= 10000, 16);
        let v0 = default_swap_result();
        let v1 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::first_score_for_swap(&arg0.tick_manager, arg0.current_tick_index, arg1);
        while (arg4 > 0 && arg0.current_sqrt_price != arg3) {
            if (0x488b927da11f1a626d56d3d000cf49b5cd40b3ed4d989ba15ac35a6c4791f83e::option_u64::is_none(&v1)) {
                abort 20
            };
            let (v2, v3) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::borrow_tick_for_swap(&arg0.tick_manager, 0x488b927da11f1a626d56d3d000cf49b5cd40b3ed4d989ba15ac35a6c4791f83e::option_u64::borrow(&v1), arg1);
            v1 = v3;
            let v4 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::index(v2);
            let v5 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::sqrt_price(v2);
            let v6 = if (arg1) {
                0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::max(arg3, v5)
            } else {
                0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::min(arg3, v5)
            };
            let (v7, v8, v9, v10) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::clmm_math::compute_swap_step(arg0.current_sqrt_price, v6, arg0.liquidity, arg4, arg0.fee_rate, arg1, arg2);
            if (v7 != 0 || v10 != 0) {
                if (arg2) {
                    let v11 = check_remainer_amount_sub(arg4, v7);
                    arg4 = check_remainer_amount_sub(v11, v10);
                } else {
                    arg4 = check_remainer_amount_sub(arg4, v8);
                };
                let v12 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(v10, arg7, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::protocol_fee_rate_denom());
                let v13 = v10 - v12;
                let v14 = v13;
                let v15 = 0;
                let v16 = 0;
                if (v13 > 0) {
                    let v17 = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(v13, arg6, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::protocol_fee_rate_denom());
                    v16 = v17;
                    let v18 = v13 - v17;
                    v14 = v18;
                    if (v18 > 0) {
                        let (_, v20) = calculate_fees<T0, T1>(arg0, v18, arg0.liquidity, arg0.magma_distribution_staked_liquidity, arg5);
                        v15 = v20;
                        v14 = v18 - v20;
                    };
                };
                let v21 = &mut v0;
                update_swap_result(v21, v7, v8, v10, v16, v12, v15);
                if (v14 > 0) {
                    update_fee_growth_global<T0, T1>(arg0, v14, arg1);
                };
            };
            if (v9 == v5) {
                arg0.current_sqrt_price = v6;
                let v22 = if (arg1) {
                    0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::sub(v4, 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::from(1))
                } else {
                    v4
                };
                arg0.current_tick_index = v22;
                update_magma_distribution_growth_global_internal<T0, T1>(arg0, arg8);
                let (v23, v24) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::cross_by_swap(&mut arg0.tick_manager, v4, arg1, arg0.liquidity, arg0.magma_distribution_staked_liquidity, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::points_growth_global(&arg0.rewarder_manager), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::rewards_growth_global(&arg0.rewarder_manager), arg0.magma_distribution_growth_global);
                arg0.liquidity = v23;
                arg0.magma_distribution_staked_liquidity = v24;
                continue
            };
            if (arg0.current_sqrt_price != v9) {
                arg0.current_sqrt_price = v9;
                arg0.current_tick_index = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick_math::get_tick_at_sqrt_price(v9);
            };
        };
        if (arg1) {
            arg0.fee_protocol_coin_a = arg0.fee_protocol_coin_a + v0.protocol_fee_amount;
            arg0.magma_distribution_gauger_fee.coin_a = arg0.magma_distribution_gauger_fee.coin_a + v0.gauge_fee_amount;
        } else {
            arg0.fee_protocol_coin_b = arg0.fee_protocol_coin_b + v0.protocol_fee_amount;
            arg0.magma_distribution_gauger_fee.coin_b = arg0.magma_distribution_gauger_fee.coin_b + v0.gauge_fee_amount;
        };
        v0
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    public fun sync_magma_distribution_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap, arg2: u128, arg3: u64, arg4: u64) {
        assert!(!arg0.is_pause, 13);
        check_gauge_cap<T0, T1>(arg0, arg1);
        arg0.magma_distribution_rate = arg2;
        arg0.magma_distribution_reserve = arg3;
        arg0.magma_distribution_period_finish = arg4;
        arg0.magma_distribution_rollover = 0;
    }

    public fun tick_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::TickManager {
        &arg0.tick_manager
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public fun unpause<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1.is_pause, 9223378204427812863);
        arg1.is_pause = false;
    }

    public fun unstake_from_magma_distribution<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap, arg2: u128, arg3: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg4: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg5: &0x2::clock::Clock) {
        assert!(!arg0.is_pause, 13);
        assert!(arg2 != 0, 9223379200860225535);
        check_gauge_cap<T0, T1>(arg0, arg1);
        update_magma_distribution_internal<T0, T1>(arg0, 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::neg(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::from(arg2)), arg3, arg4, arg5);
    }

    public fun update_emission<T0, T1, T2>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::check_rewarder_manager_role(arg0, 0x2::tx_context::sender(arg5));
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::update_emission<T2>(arg2, &mut arg1.rewarder_manager, arg1.liquidity, arg3, 0x2::clock::timestamp_ms(arg4) / 1000);
        let v0 = UpdateEmissionEvent{
            pool                 : 0x2::object::id<Pool<T0, T1>>(arg1),
            rewarder_type        : 0x1::type_name::get<T2>(),
            emissions_per_second : arg3,
        };
        0x2::event::emit<UpdateEmissionEvent>(v0);
    }

    fun update_fee_growth_global<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool) {
        if (arg1 == 0 || arg0.liquidity == 0) {
            return
        };
        if (arg2) {
            arg0.fee_growth_global_a = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::wrapping_add(arg0.fee_growth_global_a, ((arg1 as u128) << 64) / arg0.liquidity);
        } else {
            arg0.fee_growth_global_b = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::wrapping_add(arg0.fee_growth_global_b, ((arg1 as u128) << 64) / arg0.liquidity);
        };
    }

    public fun update_fee_rate<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        if (arg2 > 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::max_fee_rate()) {
            abort 9
        };
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.fee_rate = arg2;
        let v0 = UpdateFeeRateEvent{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg1),
            old_fee_rate : arg1.fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    public fun update_magma_distribution_growth_global<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap, arg2: &0x2::clock::Clock) {
        assert!(!arg0.is_pause, 13);
        check_gauge_cap<T0, T1>(arg0, arg1);
        update_magma_distribution_growth_global_internal<T0, T1>(arg0, arg2);
    }

    fun update_magma_distribution_growth_global_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = v0 - arg0.magma_distribution_last_updated;
        let v2 = 0;
        if (v1 != 0) {
            if (arg0.magma_distribution_reserve > 0) {
                let v3 = (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_floor(arg0.magma_distribution_rate, (v1 as u128), 18446744073709551616) as u64);
                let v4 = v3;
                if (v3 > arg0.magma_distribution_reserve) {
                    v4 = arg0.magma_distribution_reserve;
                };
                arg0.magma_distribution_reserve = arg0.magma_distribution_reserve - v4;
                if (arg0.magma_distribution_staked_liquidity > 0) {
                    arg0.magma_distribution_growth_global = arg0.magma_distribution_growth_global + 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_floor((v4 as u128), 18446744073709551616, arg0.magma_distribution_staked_liquidity);
                } else {
                    arg0.magma_distribution_rollover = arg0.magma_distribution_rollover + v4;
                };
                v2 = v4;
            };
            arg0.magma_distribution_last_updated = v0;
        };
        v2
    }

    fun update_magma_distribution_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::I128, arg2: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg3: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg4: &0x2::clock::Clock) {
        if (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::gte(arg0.current_tick_index, arg2) && 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::lt(arg0.current_tick_index, arg3)) {
            update_magma_distribution_growth_global_internal<T0, T1>(arg0, arg4);
            if (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::is_neg(arg1)) {
                assert!(arg0.magma_distribution_staked_liquidity >= 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::abs_u128(arg1), 9223379024766566399);
            } else {
                let (_, v1) = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::overflowing_add(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::from(arg0.magma_distribution_staked_liquidity), arg1);
                assert!(!v1, 9223379033357877270);
            };
            arg0.magma_distribution_staked_liquidity = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::as_u128(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::add(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i128::from(arg0.magma_distribution_staked_liquidity), arg1));
        };
        let v2 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg2);
        let v3 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::try_borrow_tick(&arg0.tick_manager, arg3);
        if (0x1::option::is_some<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::Tick>(&v2)) {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::update_magma_stake(&mut arg0.tick_manager, arg2, arg1, false);
        };
        if (0x1::option::is_some<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::Tick>(&v3)) {
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::tick::update_magma_stake(&mut arg0.tick_manager, arg3, arg1, true);
        };
    }

    public fun update_position_url<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.url = arg2;
    }

    fun update_swap_result(arg0: &mut SwapResult, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u64::add_check(arg0.amount_in, arg1), 6);
        assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u64::add_check(arg0.amount_out, arg2), 7);
        assert!(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u64::add_check(arg0.fee_amount, arg3), 8);
        arg0.amount_in = arg0.amount_in + arg1;
        arg0.amount_out = arg0.amount_out + arg2;
        arg0.fee_amount = arg0.fee_amount + arg3;
        arg0.protocol_fee_amount = arg0.protocol_fee_amount + arg4;
        arg0.gauge_fee_amount = arg0.gauge_fee_amount + arg6;
        arg0.ref_fee_amount = arg0.ref_fee_amount + arg5;
        arg0.steps = arg0.steps + 1;
    }

    public fun update_unstaked_liquidity_fee_rate<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 13);
        assert!(arg2 == 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::default_unstaked_fee_rate() || arg2 <= 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::max_unstaked_liquidity_fee_rate(), 9);
        assert!(arg2 != arg1.unstaked_liquidity_fee_rate, 9);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.unstaked_liquidity_fee_rate = arg2;
        let v0 = UpdateUnstakedLiquidityFeeRateEvent{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg1),
            old_fee_rate : arg1.unstaked_liquidity_fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateUnstakedLiquidityFeeRateEvent>(v0);
    }

    public fun url<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::string::String {
        arg0.url
    }

    fun validate_pool_position<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::pool_id(arg1), 9223373806381301759);
    }

    // decompiled from Move bytecode v6
}

