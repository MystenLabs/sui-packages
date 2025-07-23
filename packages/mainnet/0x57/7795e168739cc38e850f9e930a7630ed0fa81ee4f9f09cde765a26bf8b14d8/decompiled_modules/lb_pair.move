module 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_pair {
    struct SwapEvent has copy, drop {
        sender: address,
        pair: 0x2::object::ID,
        id_before: u32,
        id_after: u32,
        swap_for_y: bool,
        amounts_in_x: u64,
        amounts_in_y: u64,
        amounts_out_x: u64,
        amounts_out_y: u64,
        volatility_accumulator: u32,
        total_fees_x: u64,
        total_fees_y: u64,
        protocol_fees_x: u64,
        protocol_fees_y: u64,
        current_bin: 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::Bin,
    }

    struct CollectedProtocolFeesEvent has copy, drop {
        fee_recipient: address,
        protocol_fees_x: u64,
        protocol_fees_y: u64,
    }

    struct OracleLengthIncreasedEvent has copy, drop {
        sender: address,
        new_length: u16,
    }

    struct ForcedDecayEvent has copy, drop {
        sender: address,
        id_reference: u32,
        volatility_reference: u32,
    }

    struct StaticFeeParametersSetEvent has copy, drop {
        sender: address,
        base_factor: u32,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct CompositionFeesEvent has copy, drop {
        id: u32,
        fee_x: u64,
        fee_y: u64,
    }

    struct FeesCollectedEvent has copy, drop {
        position: 0x2::object::ID,
        bin_ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
    }

    struct RewarderAddedEvent has copy, drop {
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
    }

    struct RewarderEmissionUpdatedEvent has copy, drop {
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        emissions_per_second: u128,
    }

    struct RewardsCollectedEvent has copy, drop {
        pool: 0x2::object::ID,
        bucket_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct FeeParametersQueriedEvent has copy, drop {
        base_factor: u32,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
        volatility_accumulator: u32,
        volatility_reference: u32,
        id_reference: u32,
        time_of_last_update: u64,
    }

    struct OracleParametersQueriedEvent has copy, drop {
        sample_lifetime: u8,
        size: u16,
        active_size: u16,
        last_updated: u64,
        first_timestamp: u64,
    }

    struct OracleSampleQueriedEvent has copy, drop {
        time: u64,
        cumulative_id: u64,
        cumulative_volatility: u64,
        cumulative_bin_crossed: u64,
    }

    struct PriceFromIdQueriedEvent has copy, drop {
        id: u32,
        price: u128,
    }

    struct IdFromPriceQueriedEvent has copy, drop {
        price: u128,
        id: u32,
    }

    struct FlashLoanEvent has copy, drop {
        pool: 0x2::object::ID,
        loan_x: bool,
        amount: u64,
        fee_amount: u64,
    }

    struct OpenPositionEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
    }

    struct ClosePositionEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
    }

    struct AddLiquidityEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
        tokens: vector<u128>,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        ids: vector<u32>,
        tokens_x: u64,
        tokens_y: u64,
        token_bins_x: vector<u64>,
        token_bins_y: vector<u64>,
        liquidity_burned: vector<u128>,
    }

    struct LockPositionEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        lock_until: u64,
        owner: address,
    }

    struct PairPausedEvent has copy, drop {
        pair: 0x2::object::ID,
        paused: bool,
    }

    struct FlashLoanReceipt {
        pool_id: 0x2::object::ID,
        loan_x: bool,
        amount: u64,
        fee_amount: u64,
    }

    struct GlobalRewardState has store {
        reward_per_fee_cumulative: vector<u128>,
        total_fees_ever: u128,
        last_update_time: u64,
    }

    struct LBPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        is_pause: bool,
        bin_step: u16,
        parameters: 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::PairParameters,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        bin_manager: 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::BinManager,
        oracle: 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::Oracle,
        position_manager: 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPositionManager,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        rewarder_manager: 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::RewarderManager,
        global_reward_state: GlobalRewardState,
    }

    public fun swap<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg4);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg5);
        let (v0, v1) = if (arg2) {
            (0x2::coin::value<T0>(&arg4), 0)
        } else {
            (0, 0x2::coin::value<T1>(&arg5))
        };
        let v2 = v1;
        let v3 = v0;
        assert!(v0 > 0 || v1 > 0, 2005);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_active_id(&arg1.parameters);
        let v7 = arg1.bin_step;
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::update_references(&mut arg1.parameters, 0x2::clock::timestamp_ms(arg6) / 1000);
        let v8 = v6;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        loop {
            assert!(v9 < 255, 2021);
            v9 = v9 + 1;
            let v12 = if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg1.bin_manager, v8)) {
                *0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg1.bin_manager, v8)
            } else {
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::new_bin(0, 0, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::price_helper::get_price_from_id(v8, v7))
            };
            let v13 = v12;
            if (!0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::is_empty(&v13, !arg2)) {
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::update_volatility_accumulator(&mut arg1.parameters, v8);
                let (v14, v15, v16, v17, v18, v19) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_swap_amounts(&v13, &arg1.parameters, v7, arg2, v3, v2);
                if (v14 > 0 || v15 > 0) {
                    v3 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v3, v14);
                    v2 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v2, v15);
                    v5 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v5, v16);
                    v4 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v4, v17);
                    v11 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v11, v18);
                    v10 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v10, v19);
                    let v20 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_protocol_share(&arg1.parameters);
                    let (v21, v22) = if (v20 > 0) {
                        (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::fee_helper::get_protocol_fee_amount(v18, (v20 as u64)), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::fee_helper::get_protocol_fee_amount(v19, (v20 as u64)))
                    } else {
                        (0, 0)
                    };
                    if (v21 > 0 || v22 > 0) {
                        assert!(arg1.protocol_fee_x <= 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::constants::max_u64() - v21, 2024);
                        assert!(arg1.protocol_fee_y <= 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::constants::max_u64() - v22, 2024);
                        arg1.protocol_fee_x = arg1.protocol_fee_x + v21;
                        arg1.protocol_fee_y = arg1.protocol_fee_y + v22;
                    };
                    let v23 = v18 - v21;
                    let v24 = v19 - v22;
                    let v25 = *0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin_mut(&mut arg1.bin_manager, v8);
                    let (v26, v27) = if (arg2) {
                        (0, v14 - v18)
                    } else {
                        (v15 - v19, 0)
                    };
                    0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::update_reserves_fees(&mut v25, v27, v16, v26, v17, v23, v24);
                    *0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin_mut(&mut arg1.bin_manager, v8) = v25;
                    update_bin_fee_growth<T0, T1>(arg1, v8, v23, v24);
                    let v28 = SwapEvent{
                        sender                 : 0x2::tx_context::sender(arg7),
                        pair                   : 0x2::object::id<LBPair<T0, T1>>(arg1),
                        id_before              : v6,
                        id_after               : v8,
                        swap_for_y             : arg2,
                        amounts_in_x           : v14,
                        amounts_in_y           : v15,
                        amounts_out_x          : v16,
                        amounts_out_y          : v17,
                        volatility_accumulator : 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_volatility_accumulator(&arg1.parameters),
                        total_fees_x           : v18,
                        total_fees_y           : v19,
                        protocol_fees_x        : v21,
                        protocol_fees_y        : v22,
                        current_bin            : *0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg1.bin_manager, v8),
                    };
                    0x2::event::emit<SwapEvent>(v28);
                };
            };
            if (v3 == 0 && v2 == 0) {
                break
            };
            let v29 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_next_non_empty_bin(&arg1.bin_manager, arg2, v8);
            if (v29 == 0 || v29 == v6) {
                abort 2011
            };
            v8 = v29;
        };
        assert!(v5 > 0 || v4 > 0, 2006);
        if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::update(&mut arg1.oracle, &mut arg1.parameters, v8, arg6)) {
            0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::set_active_id(&mut arg1.parameters, v8);
        };
        arg1.global_reward_state.total_fees_ever = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u128(arg1.global_reward_state.total_fees_ever, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u128((v11 as u128), (v10 as u128)));
        let v30 = 0x2::coin::take<T0>(&mut arg1.balance_x, v5, arg7);
        let v31 = 0x2::coin::take<T1>(&mut arg1.balance_y, v4, arg7);
        if (arg2) {
            assert!(0x2::coin::value<T1>(&v31) >= arg3, 2006);
        } else {
            assert!(0x2::coin::value<T0>(&v30) >= arg3, 2006);
        };
        (v30, v31)
    }

    public(friend) fun new<T0, T1>(arg0: u32, arg1: u16, arg2: u32, arg3: u16, arg4: u16, arg5: u16, arg6: u32, arg7: u16, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : LBPair<T0, T1> {
        let v0 = GlobalRewardState{
            reward_per_fee_cumulative : 0x1::vector::empty<u128>(),
            total_fees_ever           : 0,
            last_update_time          : 0x2::clock::timestamp_ms(arg10) / 1000,
        };
        let v1 = LBPair<T0, T1>{
            id                  : 0x2::object::new(arg11),
            is_pause            : false,
            bin_step            : arg1,
            parameters          : 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::new(arg0),
            protocol_fee_x      : 0,
            protocol_fee_y      : 0,
            bin_manager         : 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::new(0x2::clock::timestamp_ms(arg10), arg11),
            oracle              : 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::new(),
            position_manager    : 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::new(arg11),
            balance_x           : 0x2::balance::zero<T0>(),
            balance_y           : 0x2::balance::zero<T1>(),
            rewarder_manager    : 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::new(),
            global_reward_state : v0,
        };
        let v2 = &mut v1;
        set_static_fee_parameters_internal<T0, T1>(v2, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11);
        let v3 = &mut v1;
        pre_initialize_bins<T0, T1>(v3, arg0, arg9);
        v1
    }

    public fun get_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : (u64, u64) {
        assert!(arg1 <= 16777215, 2020);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin_reserves(&arg0.bin_manager, arg1)
    }

    public fun get_reserves<T0, T1>(arg0: &LBPair<T0, T1>) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance_x);
        let v1 = 0x2::balance::value<T1>(&arg0.balance_y);
        let v2 = if (v0 > arg0.protocol_fee_x) {
            v0 - arg0.protocol_fee_x
        } else {
            0
        };
        let v3 = if (v1 > arg0.protocol_fee_y) {
            v1 - arg0.protocol_fee_y
        } else {
            0
        };
        (v2, v3)
    }

    fun accumulate_global_rewards<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = v0 - arg0.global_reward_state.last_update_time;
        if (v1 == 0) {
            return
        };
        let v2 = 0;
        let v3 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::get_rewarders(&arg0.rewarder_manager);
        while (v2 < 0x1::vector::length<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::Rewarder>(v3)) {
            let v4 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_u128(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::get_emissions_per_second(0x1::vector::borrow<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::Rewarder>(v3, v2)), (v1 as u128));
            if (v4 > 0 && arg0.global_reward_state.total_fees_ever > 0) {
                if (v2 >= 0x1::vector::length<u128>(&arg0.global_reward_state.reward_per_fee_cumulative)) {
                    while (0x1::vector::length<u128>(&arg0.global_reward_state.reward_per_fee_cumulative) <= v2) {
                        0x1::vector::push_back<u128>(&mut arg0.global_reward_state.reward_per_fee_cumulative, 0);
                    };
                };
                let v5 = 0x1::vector::borrow_mut<u128>(&mut arg0.global_reward_state.reward_per_fee_cumulative, v2);
                *v5 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u128(*v5, (v4 << 64) / arg0.global_reward_state.total_fees_ever);
            };
            v2 = v2 + 1;
        };
        arg0.global_reward_state.last_update_time = v0;
    }

    public fun add_liquidity<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::pair_id(arg2), 2030);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::length<u32>(&arg3);
        assert!(v1 > 0, 2002);
        assert!(v1 == 0x1::vector::length<u64>(&arg4), 2007);
        assert!(v1 == 0x1::vector::length<u64>(&arg5), 2007);
        let v2 = 0;
        while (v2 < v1) {
            validate_distribution(*0x1::vector::borrow<u64>(&arg4, v2));
            validate_distribution(*0x1::vector::borrow<u64>(&arg5, v2));
            v2 = v2 + 1;
        };
        0x2::coin::put<T0>(&mut arg1.balance_x, arg6);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg7);
        let v3 = 0x1::vector::empty<u32>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u128>();
        let v7 = &mut v3;
        let v8 = &mut v4;
        let v9 = &mut v5;
        let v10 = &mut v6;
        let (v11, v12) = mint_bins<T0, T1>(arg1, arg2, &arg3, &arg4, &arg5, 0x2::coin::value<T0>(&arg6), 0x2::coin::value<T1>(&arg7), v7, v8, v9, v10, arg8);
        if (v11 > 0 || v12 > 0) {
            if (v11 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance_x, v11, arg9), v0);
            };
            if (v12 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v12, arg9), v0);
            };
        };
        let v13 = AddLiquidityEvent{
            pair      : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position  : 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(arg2),
            ids       : v3,
            amounts_x : v4,
            amounts_y : v5,
            tokens    : v6,
        };
        0x2::event::emit<AddLiquidityEvent>(v13);
    }

    public fun add_rewarder<T0, T1, T2>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::check_rewarder_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::add_rewarder<T2>(&mut arg1.rewarder_manager);
        ensure_reward_vectors_initialized<T0, T1>(arg1);
        let v1 = RewarderAddedEvent{
            pool          : v0,
            rewarder_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<RewarderAddedEvent>(v1);
    }

    fun apply_distribution(arg0: u64, arg1: u64) : u64 {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_div_u64(arg0, arg1, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::constants::precision())
    }

    fun calculate_proportional_amounts(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        let (v0, v1) = if (arg0 > 0) {
            let v2 = (((arg4 as u128) * (arg2 as u128) / (arg0 as u128)) as u64);
            (v2, arg4 - v2)
        } else {
            (0, 0)
        };
        let (v3, v4) = if (arg1 > 0) {
            let v5 = (((arg5 as u128) * (arg3 as u128) / (arg1 as u128)) as u64);
            (v5, arg5 - v5)
        } else {
            (0, 0)
        };
        (v0, v3, v1, v4)
    }

    public fun check_balance<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2005);
    }

    public fun close_position<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg3: &mut 0x2::tx_context::TxContext) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        assert!(v0 == 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::pair_id(&arg2), 2030);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::close_position(&mut arg1.position_manager, arg2);
        let v1 = ClosePositionEvent{
            pair     : v0,
            position : 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(&arg2),
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClosePositionEvent>(v1);
    }

    public fun collect_position_fees<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg3: vector<u32>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::pair_id(arg2), 2030);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2028);
        accumulate_global_rewards<T0, T1>(arg1, arg4);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u32>(&arg3)) {
            let v5 = *0x1::vector::borrow<u32>(&arg3, v4);
            let v6 = 0;
            let v7 = 0;
            if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg1.bin_manager, v5)) {
                let v8 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg1.bin_manager, v5);
                v6 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_fee_growth_x(v8);
                v7 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_fee_growth_y(v8);
            };
            let (v9, v10) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::collect_fees(&mut arg1.position_manager, arg2, v5, v6, v7);
            v0 = v0 + v9;
            v1 = v1 + v10;
            0x1::vector::push_back<u64>(&mut v2, v9);
            0x1::vector::push_back<u64>(&mut v3, v10);
            v4 = v4 + 1;
        };
        let v11 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u128((v0 as u128), (v1 as u128));
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::add_total_fees_generated(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::borrow_mut_position_info(&mut arg1.position_manager, 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(arg2)), v11);
        arg1.global_reward_state.total_fees_ever = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u128(arg1.global_reward_state.total_fees_ever, v11);
        let v12 = if (v0 > 0) {
            0x2::coin::take<T0>(&mut arg1.balance_x, v0, arg5)
        } else {
            0x2::coin::zero<T0>(arg5)
        };
        let v13 = if (v1 > 0) {
            0x2::coin::take<T1>(&mut arg1.balance_y, v1, arg5)
        } else {
            0x2::coin::zero<T1>(arg5)
        };
        let v14 = FeesCollectedEvent{
            position  : 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(arg2),
            bin_ids   : arg3,
            amounts_x : v2,
            amounts_y : v3,
        };
        0x2::event::emit<FeesCollectedEvent>(v14);
        (v12, v13)
    }

    public fun collect_position_rewards<T0, T1, T2>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg3: &mut 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::pair_id(arg2), 2030);
        accumulate_global_rewards<T0, T1>(arg1, arg4);
        let v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::borrow_mut_position_info(&mut arg1.position_manager, 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(arg2));
        let v1 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::rewarder_index<T2>(&arg1.rewarder_manager);
        if (!0x1::option::is_some<u64>(&v1)) {
            return 0x2::coin::zero<T2>(arg5)
        };
        let v2 = *0x1::option::borrow<u64>(&v1);
        let v3 = *0x1::vector::borrow<u128>(&arg1.global_reward_state.reward_per_fee_cumulative, v2);
        let v4 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_u128(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::get_total_fees_generated(v0), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u128(v3, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::get_reward_per_fee_snapshot(v0, v2))) >> 64;
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::update_reward_per_fee_snapshot(v0, v2, v3);
        if (v4 > 0) {
            let v6 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::u128_to_u64(v4);
            let v7 = RewardsCollectedEvent{
                pool        : 0x2::object::id<LBPair<T0, T1>>(arg1),
                bucket_id   : 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(arg2),
                reward_type : 0x1::type_name::get<T2>(),
                amount      : v6,
            };
            0x2::event::emit<RewardsCollectedEvent>(v7);
            0x2::coin::from_balance<T2>(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::withdraw_reward<T2>(arg3, v6), arg5)
        } else {
            0x2::coin::zero<T2>(arg5)
        }
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = arg1.protocol_fee_x;
        let v1 = arg1.protocol_fee_y;
        let v2 = if (v0 > 1) {
            v0 - 1
        } else {
            0
        };
        let v3 = if (v1 > 1) {
            v1 - 1
        } else {
            0
        };
        let (v4, v5) = get_reserves<T0, T1>(arg1);
        if (v2 > 0) {
            arg1.protocol_fee_x = arg1.protocol_fee_x - v2;
            assert!(v4 >= v2, 2023);
        };
        if (v3 > 0) {
            arg1.protocol_fee_y = arg1.protocol_fee_y - v3;
            assert!(v5 >= v3, 2023);
        };
        let v6 = CollectedProtocolFeesEvent{
            fee_recipient   : 0x2::tx_context::sender(arg2),
            protocol_fees_x : v2,
            protocol_fees_y : v3,
        };
        0x2::event::emit<CollectedProtocolFeesEvent>(v6);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v2, arg2), 0x2::coin::take<T1>(&mut arg1.balance_y, v3, arg2))
    }

    fun ensure_reward_vectors_initialized<T0, T1>(arg0: &mut LBPair<T0, T1>) {
        while (0x1::vector::length<u128>(&arg0.global_reward_state.reward_per_fee_cumulative) < 0x1::vector::length<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::Rewarder>(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::get_rewarders(&arg0.rewarder_manager))) {
            0x1::vector::push_back<u128>(&mut arg0.global_reward_state.reward_per_fee_cumulative, 0);
        };
    }

    public fun flash_loan<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        flash_loan_internal<T0, T1>(arg1, arg2, arg3, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::flash_loan_fee_rate(arg0))
    }

    fun flash_loan_internal<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: bool, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        if (arg1) {
            assert!(0x2::balance::value<T0>(&arg0.balance_x) >= arg2, 2005);
        } else {
            assert!(0x2::balance::value<T1>(&arg0.balance_y) >= arg2, 2005);
        };
        let v0 = if (arg2 == 0 || arg3 == 0) {
            0
        } else {
            0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::div_round_up_u64(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_u64(arg2, arg3), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::constants::precision())
        };
        assert!(v0 > 0, 2013);
        if (arg1) {
            assert!(arg0.protocol_fee_x <= 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::constants::max_u64() - v0, 2024);
            arg0.protocol_fee_x = arg0.protocol_fee_x + v0;
        } else {
            assert!(arg0.protocol_fee_y <= 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::constants::max_u64() - v0, 2024);
            arg0.protocol_fee_y = arg0.protocol_fee_y + v0;
        };
        let v1 = FlashLoanReceipt{
            pool_id    : 0x2::object::id<LBPair<T0, T1>>(arg0),
            loan_x     : arg1,
            amount     : arg2,
            fee_amount : v0,
        };
        arg0.global_reward_state.total_fees_ever = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u128(arg0.global_reward_state.total_fees_ever, (v0 as u128));
        let v2 = FlashLoanEvent{
            pool       : 0x2::object::id<LBPair<T0, T1>>(arg0),
            loan_x     : arg1,
            amount     : arg2,
            fee_amount : v0,
        };
        0x2::event::emit<FlashLoanEvent>(v2);
        let (v3, v4) = if (arg1) {
            (0x2::balance::split<T0>(&mut arg0.balance_x, arg2), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.balance_y, arg2))
        };
        (v3, v4, v1)
    }

    public(friend) fun force_decay<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::update_volatility_reference(&mut arg0.parameters);
        let v0 = ForcedDecayEvent{
            sender               : 0x2::tx_context::sender(arg1),
            id_reference         : 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_id_reference(&arg0.parameters),
            volatility_reference : 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_volatility_reference(&arg0.parameters),
        };
        0x2::event::emit<ForcedDecayEvent>(v0);
    }

    public fun get_active_id<T0, T1>(arg0: &LBPair<T0, T1>) : u32 {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_active_id(&arg0.parameters)
    }

    public fun get_bin_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::BinManager {
        &arg0.bin_manager
    }

    public fun get_bin_step<T0, T1>(arg0: &LBPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun get_id_from_price<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u128) : u32 {
        let v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::price_helper::get_id_from_price(arg1, arg0.bin_step);
        let v1 = IdFromPriceQueriedEvent{
            price : arg1,
            id    : v0,
        };
        0x2::event::emit<IdFromPriceQueriedEvent>(v1);
        v0
    }

    public fun get_oracle_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u8, u16, u16, u64, u64) {
        let v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let (v1, v2, v3, v4, v5) = if (v0 == 0) {
            (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::get_max_sample_lifetime(), 0, 0, 0, 0)
        } else {
            let (v6, v7) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::get_active_sample_and_size(&arg0.oracle, v0);
            let v8 = v6;
            let v9 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::get_sample_last_update(&v8);
            let v10 = if (v9 == 0) {
                0
            } else {
                v7
            };
            let v11 = if (v10 > 0) {
                let v12 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::get_sample(&arg0.oracle, 1 + v0 % v10);
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::get_sample_last_update(&v12)
            } else {
                0
            };
            (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::get_max_sample_lifetime(), v7, v10, v9, v11)
        };
        let v13 = OracleParametersQueriedEvent{
            sample_lifetime : v1,
            size            : v2,
            active_size     : v3,
            last_updated    : v4,
            first_timestamp : v5,
        };
        0x2::event::emit<OracleParametersQueriedEvent>(v13);
        (v1, v2, v3, v4, v5)
    }

    public fun get_oracle_sample_at<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        if (v0 == 0 || arg1 > 0x2::clock::timestamp_ms(arg2) / 1000) {
            let v1 = OracleSampleQueriedEvent{
                time                   : 0,
                cumulative_id          : 0,
                cumulative_volatility  : 0,
                cumulative_bin_crossed : 0,
            };
            0x2::event::emit<OracleSampleQueriedEvent>(v1);
            return (0, 0, 0)
        };
        let (v2, v3, v4, v5) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::get_sample_at(&arg0.oracle, v0, arg1);
        let v6 = v4;
        let v7 = v3;
        if (v2 < arg1) {
            let v8 = arg1 - v2;
            v7 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v3, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_u64((0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_active_id(&arg0.parameters) as u64), v8));
            v6 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v4, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_u64((0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters) as u64), v8));
        };
        let v9 = OracleSampleQueriedEvent{
            time                   : v2,
            cumulative_id          : v7,
            cumulative_volatility  : v6,
            cumulative_bin_crossed : v5,
        };
        0x2::event::emit<OracleSampleQueriedEvent>(v9);
        (v7, v6, v5)
    }

    public fun get_pending_fees<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg2: vector<u32>) : (vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg2)) {
            let v3 = *0x1::vector::borrow<u32>(&arg2, v2);
            let v4 = 0;
            let v5 = 0;
            if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, v3)) {
                let v6 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg0.bin_manager, v3);
                v4 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_fee_growth_x(v6);
                v5 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_fee_growth_y(v6);
            };
            let (v7, v8) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::get_pending_fees(&arg0.position_manager, arg1, v3, v4, v5);
            0x1::vector::push_back<u64>(&mut v0, v7);
            0x1::vector::push_back<u64>(&mut v1, v8);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_pending_rewards<T0, T1, T2>(arg0: &LBPair<T0, T1>, arg1: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg2: &0x2::clock::Clock) : u64 {
        let v0 = simulate_accumulation<T0, T1>(arg0, arg2);
        let v1 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::borrow_position_info(&arg0.position_manager, 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(arg1));
        let v2 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::rewarder_index<T2>(&arg0.rewarder_manager);
        if (!0x1::option::is_some<u64>(&v2)) {
            return 0
        };
        let v3 = *0x1::option::borrow<u64>(&v2);
        if (v3 >= 0x1::vector::length<u128>(&v0)) {
            return 0
        };
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::u128_to_u64(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_u128(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::get_total_fees_generated(v1), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u128(*0x1::vector::borrow<u128>(&v0, v3), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::get_reward_per_fee_snapshot(v1, v3))) >> 64)
    }

    public fun get_position_bin_reserves<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg2: u32) : (u64, u64) {
        let v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::position_token_amount(&arg0.position_manager, arg1, arg2);
        if (v0 == 0) {
            return (0, 0)
        };
        if (!0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, arg2)) {
            return (0, 0)
        };
        let (v1, v2) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin_reserves(&arg0.bin_manager, arg2);
        let v3 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_total_supply(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg0.bin_manager, arg2));
        if (v3 == 0) {
            return (0, 0)
        };
        ((0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_div_u128(v0, (v1 as u128), v3) as u64), (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_div_u128(v0, (v2 as u128), v3) as u64))
    }

    public fun get_position_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPositionManager {
        &arg0.position_manager
    }

    public fun get_position_reserves_for_bins<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg2: vector<u32>) : (vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg2)) {
            let (v3, v4) = get_position_bin_reserves<T0, T1>(arg0, arg1, *0x1::vector::borrow<u32>(&arg2, v2));
            0x1::vector::push_back<u64>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_price_from_id<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : u128 {
        let v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::price_helper::get_price_from_id(arg1, arg0.bin_step);
        let v1 = PriceFromIdQueriedEvent{
            id    : arg1,
            price : v0,
        };
        0x2::event::emit<PriceFromIdQueriedEvent>(v1);
        v0
    }

    public fun get_protocol_fees<T0, T1>(arg0: &LBPair<T0, T1>) : (u64, u64) {
        (arg0.protocol_fee_x, arg0.protocol_fee_y)
    }

    public fun get_rewarder_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::RewarderManager {
        &arg0.rewarder_manager
    }

    public fun get_static_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u32, u16, u16, u16, u32, u16, u32, u32, u32, u32, u64) {
        let v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_base_factor(&arg0.parameters);
        let v1 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_filter_period(&arg0.parameters);
        let v2 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_decay_period(&arg0.parameters);
        let v3 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_reduction_factor(&arg0.parameters);
        let v4 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_variable_fee_control(&arg0.parameters);
        let v5 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_protocol_share(&arg0.parameters);
        let v6 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_max_volatility_accumulator(&arg0.parameters);
        let v7 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters);
        let v8 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_volatility_reference(&arg0.parameters);
        let v9 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_id_reference(&arg0.parameters);
        let v10 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_time_of_last_update(&arg0.parameters);
        let v11 = FeeParametersQueriedEvent{
            base_factor                : v0,
            filter_period              : v1,
            decay_period               : v2,
            reduction_factor           : v3,
            variable_fee_control       : v4,
            protocol_share             : v5,
            max_volatility_accumulator : v6,
            volatility_accumulator     : v7,
            volatility_reference       : v8,
            id_reference               : v9,
            time_of_last_update        : v10,
        };
        0x2::event::emit<FeeParametersQueriedEvent>(v11);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10)
    }

    public fun get_swap_in<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = arg0.parameters;
        let v4 = arg0.bin_step;
        let v5 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_active_id(&v3);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::update_references(&mut v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, v6)) {
                let (v9, v10) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin_reserves(&arg0.bin_manager, v6);
                if (arg2) {
                    v10
                } else {
                    v9
                }
            } else {
                0
            };
            if (v8 > 0) {
                let v11 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg0.bin_manager, v6);
                let v12 = if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_price(v11) > 0) {
                    0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_price(v11)
                } else {
                    0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::price_helper::get_price_from_id(v6, v4)
                };
                let v13 = if (v8 > v0) {
                    v0
                } else {
                    v8
                };
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::update_volatility_accumulator(&mut v3, v6);
                let v14 = if (arg2) {
                    0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::q64x64::get_integer(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::q64x64::div(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::q64x64::from_integer(v13), v12))
                } else {
                    0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::q64x64::get_integer(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::q64x64::mul(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::q64x64::from_integer(v13), v12))
                };
                let v15 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::fee_helper::get_fee_amount(v14, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_total_fee(&v3, v4));
                v1 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v1, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v14, v15));
                v0 = v0 - v13;
                v2 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v2, v15);
            };
            if (v0 == 0) {
                break
            };
            v6 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_next_non_empty_bin(&arg0.bin_manager, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        (v1, v0, v2)
    }

    public fun get_swap_out<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = if (arg2) {
            (arg1, 0)
        } else {
            (0, arg1)
        };
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = arg0.parameters;
        let v9 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_active_id(&v8);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::update_references(&mut v8, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v10 = v9;
        let v11 = 0;
        loop {
            assert!(v11 < 255, 2021);
            v11 = v11 + 1;
            if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, v10)) {
                let v12 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg0.bin_manager, v10);
                if (!0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::is_empty(v12, !arg2)) {
                    0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::update_volatility_accumulator(&mut v8, v10);
                    let (v13, v14, v15, v16, v17, v18) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_swap_amounts(v12, &v8, arg0.bin_step, arg2, v3, v2);
                    if (v13 > 0 || v14 > 0) {
                        v3 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v3, v13);
                        v2 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v2, v14);
                        v5 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v5, v15);
                        v4 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v4, v16);
                        v7 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v7, v17);
                        v6 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v6, v18);
                    };
                };
            };
            if (v3 == 0 && v2 == 0) {
                break
            };
            v10 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_next_non_empty_bin(&arg0.bin_manager, arg2, v10);
            if (v10 == 0 || v10 == v9) {
                break
            };
        };
        let v19 = if (arg2) {
            v3
        } else {
            v2
        };
        let v20 = if (arg2) {
            v4
        } else {
            v5
        };
        let v21 = if (arg2) {
            v7
        } else {
            v6
        };
        (v19, v20, v21)
    }

    public fun get_total_pending_fees<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg2: vector<u32>) : (u64, u64) {
        let (v0, v1) = get_pending_fees<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v3)) {
            v4 = v4 + *0x1::vector::borrow<u64>(&v3, v6);
            v5 = v5 + *0x1::vector::borrow<u64>(&v2, v6);
            v6 = v6 + 1;
        };
        (v4, v5)
    }

    public(friend) fun increase_oracle_length<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let v1 = v0;
        if (v0 == 0) {
            let v2 = 1;
            v1 = v2;
            0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::set_oracle_id(&mut arg0.parameters, v2);
        };
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::increase_length(&mut arg0.oracle, v1, arg1);
        let v3 = OracleLengthIncreasedEvent{
            sender     : 0x2::tx_context::sender(arg2),
            new_length : arg1,
        };
        0x2::event::emit<OracleLengthIncreasedEvent>(v3);
    }

    public fun lock_position<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::pair_id(arg2), 2030);
        assert!(arg3 > 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::get_lock_until(arg2) && arg3 > 0x2::clock::timestamp_ms(arg4), 2031);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::lock_position(arg2, arg3);
        let v0 = LockPositionEvent{
            pair       : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position   : 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(arg2),
            lock_until : arg3,
            owner      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LockPositionEvent>(v0);
    }

    fun mint_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg2: &vector<u32>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: u64, arg6: u64, arg7: &mut vector<u32>, arg8: &mut vector<u64>, arg9: &mut vector<u64>, arg10: &mut vector<u128>, arg11: &0x2::clock::Clock) : (u64, u64) {
        let v0 = arg5;
        let v1 = arg6;
        let v2 = 0;
        let v3 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_active_id(&arg0.parameters);
        let v4 = 0;
        let v5 = 0;
        while (v2 < 0x1::vector::length<u32>(arg2)) {
            let v6 = *0x1::vector::borrow<u32>(arg2, v2);
            let (v7, v8, v9, v10, v11, v12, v13) = update_bin<T0, T1>(arg0, v3, v6, apply_distribution(arg5, *0x1::vector::borrow<u64>(arg3, v2)), apply_distribution(arg6, *0x1::vector::borrow<u64>(arg4, v2)), arg11);
            if (v7 > 0) {
                v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v0, v8);
                v1 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v1, v9);
                v4 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v4, v12);
                v5 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v5, v13);
                0x1::vector::push_back<u32>(arg7, v6);
                0x1::vector::push_back<u64>(arg8, v10);
                0x1::vector::push_back<u64>(arg9, v11);
                0x1::vector::push_back<u128>(arg10, v7);
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::increase_liquidity(&mut arg0.position_manager, &mut arg0.bin_manager, arg1, v6, v7);
                if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, v6)) {
                    let v14 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg0.bin_manager, v6);
                    0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::update_fee_info(&mut arg0.position_manager, arg1, v6, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_fee_growth_x(v14), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_fee_growth_y(v14));
                };
            };
            v2 = v2 + 1;
        };
        if (v4 > 0 || v5 > 0) {
            arg0.global_reward_state.total_fees_ever = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u128(arg0.global_reward_state.total_fees_ever, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u128((v4 as u128), (v5 as u128)));
        };
        (v0, v1)
    }

    public fun open_position<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        ensure_reward_vectors_initialized<T0, T1>(arg1);
        let v1 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::open_position<T0, T1>(&mut arg1.position_manager, v0, arg2, arg3);
        let v2 = OpenPositionEvent{
            pair     : v0,
            position : 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(&v1),
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OpenPositionEvent>(v2);
        v1
    }

    public(friend) fun pause_pair<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: bool) {
        assert!(arg0.is_pause != arg1, 2032);
        arg0.is_pause = arg1;
        let v0 = PairPausedEvent{
            pair   : 0x2::object::id<LBPair<T0, T1>>(arg0),
            paused : arg1,
        };
        0x2::event::emit<PairPausedEvent>(v0);
    }

    fun pre_initialize_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u32) {
        if (arg2 <= 0) {
            return
        };
        let v0 = arg2 / 2;
        let (v1, v2) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::price_helper::get_valid_id_range();
        let v3 = if (arg1 > v0 && arg1 - v0 >= v1) {
            arg1 - v0
        } else {
            v1
        };
        let v4 = if (arg1 + v0 <= v2) {
            arg1 + v0
        } else {
            v2
        };
        let v5 = v3;
        let v6 = 0;
        while (v5 <= v4 && v6 < arg2) {
            if (!0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, v5)) {
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::add_or_update_bin(&mut arg0.bin_manager, v5, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::new_bin(0, 0, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::price_helper::get_price_from_id(v5, arg0.bin_step)));
            };
            v6 = v6 + 1;
            v5 = v5 + 1;
        };
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg3: vector<u32>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::pair_id(arg2), 2030);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2007);
        validate_remove_liquidity_inputs<T0, T1>(arg1, arg2, &arg3);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u128>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u32>(&arg3)) {
            let v6 = *0x1::vector::borrow<u32>(&arg3, v5);
            let v7 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::position_token_amount(&arg1.position_manager, arg2, v6);
            let v8 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg1.bin_manager, v6);
            let (v9, v10, v11, v12, v13, v14, v15) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::bin_details(v8);
            let (v16, v17) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_amount_out_of_bin(v8, (v7 as u128), v15);
            assert!(v16 > 0 || v17 > 0, 2014);
            let (v18, v19, v20, v21) = calculate_proportional_amounts(v9, v10, v11, v12, v16, v17);
            let (_, _) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::collect_fees(&mut arg1.position_manager, arg2, v6, v13, v14);
            0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::decrease_liquidity(&mut arg1.position_manager, &mut arg1.bin_manager, arg2, v6, (v7 as u128), arg4);
            if (v15 == (v7 as u128)) {
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::remove_bin(&mut arg1.bin_manager, v6);
            } else {
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::subtract_reserves_and_fees(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin_mut(&mut arg1.bin_manager, v6), v18, v19, v20, v21);
            };
            v1 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v1, v16);
            v0 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v0, v17);
            0x1::vector::push_back<u64>(&mut v2, v16);
            0x1::vector::push_back<u64>(&mut v3, v17);
            0x1::vector::push_back<u128>(&mut v4, (v7 as u128));
            v5 = v5 + 1;
        };
        let v24 = RemoveLiquidityEvent{
            pair             : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position         : 0x2::object::id<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition>(arg2),
            ids              : arg3,
            tokens_x         : v1,
            tokens_y         : v0,
            token_bins_x     : v2,
            token_bins_y     : v3,
            liquidity_burned : v4,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v24);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v1, arg5), 0x2::coin::take<T1>(&mut arg1.balance_y, v0, arg5))
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        let FlashLoanReceipt {
            pool_id    : v0,
            loan_x     : v1,
            amount     : v2,
            fee_amount : v3,
        } = arg4;
        assert!(v0 == 0x2::object::id<LBPair<T0, T1>>(arg1), 2007);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) >= v2 + v3, 2005);
            0x2::balance::join<T0>(&mut arg1.balance_x, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) >= v2 + v3, 2005);
            0x2::balance::join<T1>(&mut arg1.balance_y, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public(friend) fun set_static_fee_parameters<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: &0x2::tx_context::TxContext) {
        set_static_fee_parameters_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun set_static_fee_parameters_internal<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: &0x2::tx_context::TxContext) {
        let v0 = if (arg1 != 0) {
            true
        } else if (arg2 != 0) {
            true
        } else if (arg3 != 0) {
            true
        } else if (arg4 != 0) {
            true
        } else if (arg5 != 0) {
            true
        } else if (arg6 != 0) {
            true
        } else {
            arg7 != 0
        };
        assert!(v0, 2008);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = arg0.bin_step;
        let v2 = arg0.parameters;
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::set_volatility_accumulator(&mut v2, arg7);
        assert!(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_base_fee(&v2, v1), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_variable_fee(&v2, v1)) <= 100000000, 2016);
        let v3 = StaticFeeParametersSetEvent{
            sender                     : 0x2::tx_context::sender(arg8),
            base_factor                : arg1,
            filter_period              : arg2,
            decay_period               : arg3,
            reduction_factor           : arg4,
            variable_fee_control       : arg5,
            protocol_share             : arg6,
            max_volatility_accumulator : arg7,
        };
        0x2::event::emit<StaticFeeParametersSetEvent>(v3);
    }

    fun simulate_accumulation<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x2::clock::Clock) : vector<u128> {
        let v0 = arg0.global_reward_state.reward_per_fee_cumulative;
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000 - arg0.global_reward_state.last_update_time;
        if (v1 > 0 && arg0.global_reward_state.total_fees_ever > 0) {
            let v2 = 0;
            let v3 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::get_rewarders(&arg0.rewarder_manager);
            while (v2 < 0x1::vector::length<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::Rewarder>(v3)) {
                let v4 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_u128(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::get_emissions_per_second(0x1::vector::borrow<0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::Rewarder>(v3, v2)), (v1 as u128));
                if (v4 > 0) {
                    if (v2 >= 0x1::vector::length<u128>(&v0)) {
                        while (0x1::vector::length<u128>(&v0) <= v2) {
                            0x1::vector::push_back<u128>(&mut v0, 0);
                        };
                    };
                    let v5 = 0x1::vector::borrow_mut<u128>(&mut v0, v2);
                    *v5 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u128(*v5, (v4 << 64) / arg0.global_reward_state.total_fees_ever);
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    fun update_bin<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u128, u64, u64, u64, u64, u64, u64) {
        let v0 = if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, arg2)) {
            *0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg0.bin_manager, arg2)
        } else {
            0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::new_bin(0, 0, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::price_helper::get_price_from_id(arg2, arg0.bin_step))
        };
        let v1 = v0;
        let v2 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_price(&v1);
        let v3 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_total_supply(&v1);
        let (v4, v5, v6) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_shares_and_effective_amounts_in(&v1, arg3, arg4, v2, v3);
        let v7 = v4;
        if (v4 == 0) {
            return (0, 0, 0, 0, 0, 0, 0)
        };
        let v8 = v5;
        let v9 = v6;
        let v10 = 0;
        let v11 = 0;
        if (arg2 == arg1) {
            0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::update_volatility_parameters(&mut arg0.parameters, arg2, 0x2::clock::timestamp_ms(arg5) / 1000);
            let (v12, v13) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_composition_fees(&v1, &arg0.parameters, arg0.bin_step, v5, v6, v3, v4);
            if (v12 > 0 || v13 > 0) {
                v10 = v12;
                v11 = v13;
                let v14 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                let (v15, v16) = if (v14 > 0) {
                    (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::fee_helper::get_protocol_fee_amount(v12, (v14 as u64)), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::fee_helper::get_protocol_fee_amount(v13, (v14 as u64)))
                } else {
                    (0, 0)
                };
                if (v15 > 0 || v16 > 0) {
                    v8 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v5, v15);
                    v9 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v6, v16);
                    arg0.protocol_fee_x = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(arg0.protocol_fee_x, v15);
                    arg0.protocol_fee_y = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(arg0.protocol_fee_y, v16);
                };
                let v17 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v12, v15);
                let v18 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v13, v16);
                update_bin_fee_growth<T0, T1>(arg0, arg2, v17, v18);
                let (v19, v20) = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_reserves(&v1);
                v7 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::mul_div_u128(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::q64x64::liquidity_from_amounts(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v5, v12), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v6, v13), v2), v3, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::q64x64::liquidity_from_amounts(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v19, v17), 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::add_u64(v20, v18), v2));
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, arg2, arg5);
                let v21 = CompositionFeesEvent{
                    id    : arg2,
                    fee_x : v12,
                    fee_y : v13,
                };
                0x2::event::emit<CompositionFeesEvent>(v21);
            };
        } else {
            0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::verify_amounts(v5, v6, arg1, arg2);
        };
        assert!(v7 > 0, 2015);
        assert!(v8 > 0 || v9 > 0, 2015);
        let v22 = if (v10 > 0) {
            0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v10, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::fee_helper::get_protocol_fee_amount(v10, (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_protocol_share(&arg0.parameters) as u64)))
        } else {
            0
        };
        let v23 = if (v11 > 0) {
            0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::safe_math::sub_u64(v11, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::fee_helper::get_protocol_fee_amount(v11, (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::pair_parameter_helper::get_protocol_share(&arg0.parameters) as u64)))
        } else {
            0
        };
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::add_reserves_fees(&mut v1, v8, v9, v22, v23);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::add_or_update_bin(&mut arg0.bin_manager, arg2, v1);
        (v7, v5, v6, v8, v9, v10, v11)
    }

    fun update_bin_fee_growth<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u64, arg3: u64) {
        if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, arg1)) {
            let v0 = *0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin(&arg0.bin_manager, arg1);
            let v1 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_total_supply(&v0);
            if (v1 == 0) {
                return
            };
            if (0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, arg1)) {
                let v2 = 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_bin_mut(&mut arg0.bin_manager, arg1);
                0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::set_fee_growth(v2, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_fee_growth_x(v2) + ((arg2 as u128) << 64) / v1, 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::get_fee_growth_y(v2) + ((arg3 as u128) << 64) / v1);
                return
            };
            return
        };
    }

    public fun update_emission<T0, T1, T2>(arg0: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::config::check_rewarder_manager_role(arg0, 0x2::tx_context::sender(arg5));
        accumulate_global_rewards<T0, T1>(arg1, arg4);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::rewarder::update_emission<T2>(arg2, &mut arg1.rewarder_manager, v0, arg3);
        let v1 = RewarderEmissionUpdatedEvent{
            pool                 : v0,
            rewarder_type        : 0x1::type_name::get<T2>(),
            emissions_per_second : arg3,
        };
        0x2::event::emit<RewarderEmissionUpdatedEvent>(v1);
    }

    fun validate_distribution(arg0: u64) {
        assert!(arg0 <= 0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::constants::precision(), 401);
    }

    fun validate_remove_liquidity_inputs<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::LBPosition, arg2: &vector<u32>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(arg2)) {
            let v1 = *0x1::vector::borrow<u32>(arg2, v0);
            assert!(v1 <= 16777215, 2020);
            assert!(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::lb_position::position_token_amount(&arg0.position_manager, arg1, v1) > 0, 2013);
            assert!(0x577795e168739cc38e850f9e930a7630ed0fa81ee4f9f09cde765a26bf8b14d8::bin_manager::contains(&arg0.bin_manager, v1), 402);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

