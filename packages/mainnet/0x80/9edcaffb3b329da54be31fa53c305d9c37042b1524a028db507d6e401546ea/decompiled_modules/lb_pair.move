module 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_pair {
    struct Amount has copy, drop {
        x: u64,
        y: u64,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        pair: 0x2::object::ID,
        swap_for_y: bool,
        bin_ids: vector<u32>,
        amounts_in_x: vector<u64>,
        amounts_in_y: vector<u64>,
        amounts_out_x: vector<u64>,
        amounts_out_y: vector<u64>,
        total_fees_x: vector<u64>,
        total_fees_y: vector<u64>,
        protocol_fees_x: vector<u64>,
        protocol_fees_y: vector<u64>,
        volatility_accumulators: vector<u32>,
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
        protocol_share: u64,
        max_volatility_accumulator: u32,
    }

    struct CompositionFeesEvent has copy, drop {
        pair: 0x2::object::ID,
        bin_id: u32,
        fee_x: u64,
        fee_y: u64,
    }

    struct FeesCollectedEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        bin_ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
    }

    struct RewarderAddedEvent has copy, drop {
        pair: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
    }

    struct RewardFactorUpdatedEvent has copy, drop {
        pair: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        reward_factor: u128,
    }

    struct RewardsCollectedEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct FeeParametersQueriedEvent has copy, drop {
        base_factor: u32,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u64,
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
        pair: 0x2::object::ID,
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
        pair_id: 0x2::object::ID,
        loan_x: bool,
        amount: u64,
        fee_amount: u64,
    }

    struct LBPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        is_pause: bool,
        bin_step: u16,
        parameters: 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::PairParameters,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        lp_fee_x: u64,
        lp_fee_y: u64,
        bin_manager: 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::BinManager,
        oracle: 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::Oracle,
        position_manager: 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPositionManager,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        reward_manager: 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::RewarderManager,
    }

    public fun swap<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        let v0 = make_amount_with(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&arg5));
        let v1 = if (arg2) {
            if (v0.y == 0) {
                v0.x > 0
            } else {
                false
            }
        } else {
            false
        };
        let v2 = if (v1) {
            true
        } else if (!arg2) {
            if (v0.x == 0) {
                v0.y > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2001);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg4);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg5);
        let v3 = make_amount();
        let v4 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_active_id(&arg1.parameters);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::update_references(&mut arg1.parameters, 0x2::clock::timestamp_ms(arg6) / 1000);
        let v5 = v4;
        let v6 = 0;
        let v7 = make_swap_event<T0, T1>(0x2::tx_context::sender(arg7), arg1, arg2);
        loop {
            assert!(v6 < 70, 2021);
            v6 = v6 + 1;
            if (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg1.bin_manager, v5)) {
                let v8 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin_mut(&mut arg1.bin_manager, v5);
                if (!0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::is_empty(v8, !arg2)) {
                    0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::update_volatility_accumulator(&mut arg1.parameters, v5);
                    let (v9, v10, v11, v12, v13, v14) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_swap_amounts(v8, &arg1.parameters, arg1.bin_step, arg2, v0.x, v0.y);
                    if (v9 > 0 || v10 > 0) {
                        let v15 = &mut v0;
                        sub_amount(v15, v9, v10);
                        let v16 = &mut v3;
                        add_amount(v16, v11, v12);
                        let v17 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_protocol_share(&arg1.parameters);
                        let v18 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::fee_helper::get_protocol_fee_amount(v13, v17);
                        let v19 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::fee_helper::get_protocol_fee_amount(v14, v17);
                        arg1.protocol_fee_x = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg1.protocol_fee_x, v18);
                        arg1.protocol_fee_y = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg1.protocol_fee_y, v19);
                        let v20 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v13, v18);
                        let v21 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v14, v19);
                        arg1.lp_fee_x = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg1.lp_fee_x, v20);
                        arg1.lp_fee_y = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg1.lp_fee_y, v21);
                        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::update_reserves_fees(v8, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v9, v13), v11, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v10, v14), v12, v20, v21);
                        update_bin_fee_and_reward_growth(&arg1.reward_manager, v8, v20, v21);
                        let v22 = &mut v7;
                        push_swap_event(v22, v5, v9, v10, v11, v12, v13, v14, v18, v19, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_volatility_accumulator(&arg1.parameters));
                    };
                };
            };
            if (v0.x == 0 && v0.y == 0) {
                break
            };
            let v23 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_next_non_empty_bin(&arg1.bin_manager, arg2, v5);
            if (v23 == 0 || v23 == v4) {
                abort 2011
            };
            v5 = v23;
        };
        let v24 = if (arg2) {
            v3.y
        } else {
            v3.x
        };
        assert!(v24 > 0 && v24 >= arg3, 2037);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::set_active_id(&mut arg1.parameters, v5);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::update(&mut arg1.oracle, &mut arg1.parameters, v5, arg6);
        0x2::event::emit<SwapEvent>(v7);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v3.x, arg7), 0x2::coin::take<T1>(&mut arg1.balance_y, v3.y, arg7))
    }

    public(friend) fun new<T0, T1>(arg0: u32, arg1: u16, arg2: u32, arg3: u16, arg4: u16, arg5: u16, arg6: u32, arg7: u16, arg8: u32, arg9: u32, arg10: &mut 0x2::tx_context::TxContext) : LBPair<T0, T1> {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::validate_bin_step(arg1);
        let v0 = LBPair<T0, T1>{
            id               : 0x2::object::new(arg10),
            is_pause         : false,
            bin_step         : arg1,
            parameters       : 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::new(arg0),
            protocol_fee_x   : 0,
            protocol_fee_y   : 0,
            lp_fee_x         : 0,
            lp_fee_y         : 0,
            bin_manager      : 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::new(arg10),
            oracle           : 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::new(),
            position_manager : 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::new(arg10),
            balance_x        : 0x2::balance::zero<T0>(),
            balance_y        : 0x2::balance::zero<T1>(),
            reward_manager   : 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::new(),
        };
        let v1 = &mut v0;
        set_static_fee_parameters_internal<T0, T1>(v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
        let v2 = &mut v0;
        pre_initialize_bins<T0, T1>(v2, arg0, arg9);
        v0
    }

    public fun get_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : (u64, u64) {
        assert!(arg1 <= 16777215, 2020);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin_reserves(&arg0.bin_manager, arg1)
    }

    public fun get_reserves<T0, T1>(arg0: &LBPair<T0, T1>) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance_x);
        let v1 = 0x2::balance::value<T1>(&arg0.balance_y);
        let v2 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg0.protocol_fee_x, arg0.lp_fee_x);
        let v3 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg0.protocol_fee_y, arg0.lp_fee_y);
        let v4 = if (v0 > v2) {
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v0, v2)
        } else {
            0
        };
        let v5 = if (v1 > v3) {
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v1, v3)
        } else {
            0
        };
        (v4, v5)
    }

    fun add_amount(arg0: &mut Amount, arg1: u64, arg2: u64) {
        arg0.x = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg0.x, arg1);
        arg0.y = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg0.y, arg2);
    }

    public fun add_liquidity<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::pair_id(arg2), 2030);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::get_lock_until(arg2);
        if (v1 > 0) {
            let v2 = 0x2::clock::timestamp_ms(arg10);
            let v3 = v2 + v2 - 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::get_created_at(arg2);
            if (v3 > v1) {
                0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::lock_position(arg2, v3);
            };
        };
        let v4 = 0x1::vector::length<u32>(&arg3);
        assert!(v4 > 0, 2002);
        assert!(v4 == 0x1::vector::length<u64>(&arg4), 2007);
        assert!(v4 == 0x1::vector::length<u64>(&arg5), 2007);
        let v5 = 0x2::coin::value<T0>(&arg6);
        let v6 = 0x2::coin::value<T1>(&arg7);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg6);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg7);
        let (v7, v8, v9, v10, v11) = mint_bins<T0, T1>(arg1, arg2, &arg3, &arg4, &arg5, v5, v6, arg10);
        assert!(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v5, v7) >= arg8 && 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v6, v8) >= arg9, 2037);
        if (v7 > 0 || v8 > 0) {
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance_x, v7, arg11), v0);
            };
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v8, arg11), v0);
            };
        };
        let v12 = AddLiquidityEvent{
            pair      : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position  : 0x2::object::id<0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition>(arg2),
            ids       : arg3,
            amounts_x : v9,
            amounts_y : v10,
            tokens    : v11,
        };
        0x2::event::emit<AddLiquidityEvent>(v12);
    }

    public fun add_rewarder<T0, T1, T2>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::check_reward_role(arg0, 0x2::tx_context::sender(arg2));
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::add_rewarder<T2>(&mut arg1.reward_manager);
        let v0 = RewarderAddedEvent{
            pair          : 0x2::object::id<LBPair<T0, T1>>(arg1),
            rewarder_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<RewarderAddedEvent>(v0);
    }

    fun apply_distribution(arg0: u64, arg1: u64) : u64 {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::mul_div_u64(arg0, arg1, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::constants::precision())
    }

    public fun close_position<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg3: &mut 0x2::tx_context::TxContext) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        assert!(v0 == 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::pair_id(&arg2), 2030);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::close_position(&mut arg1.position_manager, arg2);
        let v1 = ClosePositionEvent{
            pair     : v0,
            position : 0x2::object::id<0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition>(&arg2),
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClosePositionEvent>(v1);
    }

    public fun collect_position_fees<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg3: vector<u32>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::pair_id(arg2), 2030);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2028);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u32>(&arg3)) {
            let v5 = *0x1::vector::borrow<u32>(&arg3, v4);
            let v6 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin_mut(&mut arg1.bin_manager, v5);
            let (v7, v8) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::collect_fees(&mut arg1.position_manager, arg2, v5, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_fee_growth_x(v6), 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_fee_growth_y(v6));
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::update_reward_growth_baseline(&mut arg1.position_manager, arg2, v5, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_all_reward_growth(v6));
            v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v0, v7);
            v1 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v1, v8);
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::sub_fees(v6, v7, v8);
            0x1::vector::push_back<u64>(&mut v2, v7);
            0x1::vector::push_back<u64>(&mut v3, v8);
            v4 = v4 + 1;
        };
        arg1.lp_fee_x = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64_cape_zero(arg1.lp_fee_x, v0);
        arg1.lp_fee_y = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64_cape_zero(arg1.lp_fee_y, v1);
        let v9 = FeesCollectedEvent{
            pair      : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position  : 0x2::object::id<0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition>(arg2),
            bin_ids   : arg3,
            amounts_x : v2,
            amounts_y : v3,
        };
        0x2::event::emit<FeesCollectedEvent>(v9);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v0, arg4), 0x2::coin::take<T1>(&mut arg1.balance_y, v1, arg4))
    }

    public fun collect_position_rewards<T0, T1, T2>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg3: &mut 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::RewarderGlobalVault, arg4: vector<u32>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::pair_id(arg2), 2030);
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::rewarder_index<T2>(&arg1.reward_manager);
        if (!0x1::option::is_some<u64>(&v0)) {
            return 0x2::coin::zero<T2>(arg5)
        };
        let v1 = *0x1::option::borrow<u64>(&v0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::length<u32>(&arg4);
        while (v3 < v4) {
            let v5 = *0x1::vector::borrow<u32>(&arg4, v3);
            if (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg1.bin_manager, v5)) {
                v2 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v2, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::get_pending_rewards(&arg1.position_manager, arg2, v5, v1, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_reward_growth(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin(&arg1.bin_manager, v5), v1)));
            };
            v3 = v3 + 1;
        };
        v3 = 0;
        while (v3 < v4) {
            let v6 = *0x1::vector::borrow<u32>(&arg4, v3);
            if (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg1.bin_manager, v6)) {
                0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::update_reward_growth_baseline(&mut arg1.position_manager, arg2, v6, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_all_reward_growth(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin(&arg1.bin_manager, v6)));
            };
            v3 = v3 + 1;
        };
        if (v2 > 0) {
            let v8 = RewardsCollectedEvent{
                pair        : 0x2::object::id<LBPair<T0, T1>>(arg1),
                position    : 0x2::object::id<0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition>(arg2),
                reward_type : 0x1::type_name::get<T2>(),
                amount      : v2,
            };
            0x2::event::emit<RewardsCollectedEvent>(v8);
            0x2::coin::from_balance<T2>(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::withdraw_reward<T2>(arg3, v2), arg5)
        } else {
            0x2::coin::zero<T2>(arg5)
        }
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::check_protocol_fee_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::get_fund_receiver(arg0);
        let v1 = arg1.protocol_fee_x;
        let v2 = arg1.protocol_fee_y;
        let v3 = if (v1 > 1) {
            v1 - 1
        } else {
            0
        };
        let v4 = if (v2 > 1) {
            v2 - 1
        } else {
            0
        };
        let (v5, v6) = get_reserves<T0, T1>(arg1);
        if (v3 > 0) {
            arg1.protocol_fee_x = arg1.protocol_fee_x - v3;
            assert!(v5 >= v3, 2023);
        };
        if (v4 > 0) {
            arg1.protocol_fee_y = arg1.protocol_fee_y - v4;
            assert!(v6 >= v4, 2023);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance_x, v3, arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v4, arg2), v0);
        let v7 = CollectedProtocolFeesEvent{
            fee_recipient   : 0x2::tx_context::sender(arg2),
            protocol_fees_x : v3,
            protocol_fees_y : v4,
        };
        0x2::event::emit<CollectedProtocolFeesEvent>(v7);
    }

    public fun flash_loan<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(arg3 > 0, 2034);
        let v0 = if (arg2) {
            0x2::balance::value<T0>(&arg1.balance_x)
        } else {
            0x2::balance::value<T1>(&arg1.balance_y)
        };
        assert!(arg3 <= 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::mul_div_u64(v0, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::flash_loan_max_amount(arg0), 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::constants::flashloan_percentage_precision()), 2005);
        let v1 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::div_round_up_u64(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::mul_u64(arg3, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::flash_loan_fee_rate(arg0)), 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::constants::precision());
        if (arg2) {
            arg1.protocol_fee_x = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg1.protocol_fee_x, v1);
        } else {
            arg1.protocol_fee_y = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg1.protocol_fee_y, v1);
        };
        let v2 = FlashLoanReceipt{
            pair_id    : 0x2::object::id<LBPair<T0, T1>>(arg1),
            loan_x     : arg2,
            amount     : arg3,
            fee_amount : v1,
        };
        let v3 = FlashLoanEvent{
            pair       : 0x2::object::id<LBPair<T0, T1>>(arg1),
            loan_x     : arg2,
            amount     : arg3,
            fee_amount : v1,
        };
        0x2::event::emit<FlashLoanEvent>(v3);
        let (v4, v5) = if (arg2) {
            (0x2::balance::split<T0>(&mut arg1.balance_x, arg3), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg1.balance_y, arg3))
        };
        arg1.is_pause = true;
        (v4, v5, v2)
    }

    public(friend) fun force_decay<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::update_volatility_reference(&mut arg0.parameters);
        let v0 = ForcedDecayEvent{
            sender               : 0x2::tx_context::sender(arg1),
            id_reference         : 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_id_reference(&arg0.parameters),
            volatility_reference : 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_volatility_reference(&arg0.parameters),
        };
        0x2::event::emit<ForcedDecayEvent>(v0);
    }

    public fun get_active_id<T0, T1>(arg0: &LBPair<T0, T1>) : u32 {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_active_id(&arg0.parameters)
    }

    public fun get_bin_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::BinManager {
        &arg0.bin_manager
    }

    public fun get_bin_step<T0, T1>(arg0: &LBPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun get_id_from_price<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u128) : u32 {
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::price_helper::get_id_from_price(arg1, arg0.bin_step);
        let v1 = IdFromPriceQueriedEvent{
            price : arg1,
            id    : v0,
        };
        0x2::event::emit<IdFromPriceQueriedEvent>(v1);
        v0
    }

    public fun get_oracle_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u8, u16, u16, u64, u64) {
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let (v1, v2, v3, v4, v5) = if (v0 == 0) {
            (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::get_max_sample_lifetime(), 0, 0, 0, 0)
        } else {
            let (v6, v7) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::get_active_sample_and_size(&arg0.oracle, v0);
            let v8 = v6;
            let v9 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::get_sample_last_update(&v8);
            let v10 = if (v9 == 0) {
                0
            } else {
                v7
            };
            let v11 = if (v10 > 0) {
                let v12 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::get_sample(&arg0.oracle, 1 + v0 % v10);
                0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::get_sample_last_update(&v12)
            } else {
                0
            };
            (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::get_max_sample_lifetime(), v7, v10, v9, v11)
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
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_oracle_id(&arg0.parameters);
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
        let (v2, v3, v4, v5) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::get_sample_at(&arg0.oracle, v0, arg1);
        let v6 = v4;
        let v7 = v3;
        if (v2 < arg1) {
            let v8 = arg1 - v2;
            v7 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v3, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::mul_u64((0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_active_id(&arg0.parameters) as u64), v8));
            v6 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v4, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::mul_u64((0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters) as u64), v8));
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

    public fun get_pending_fees<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg2: vector<u32>) : (vector<u64>, vector<u64>) {
        let (v0, v1, _) = get_pending_fees_internal<T0, T1>(arg0, arg1, arg2);
        (v0, v1)
    }

    public fun get_pending_fees_and_rewards<T0, T1, T2>(arg0: &LBPair<T0, T1>, arg1: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg2: vector<u32>) : (vector<u64>, vector<u64>, u64) {
        let (v0, v1, _) = get_pending_fees_internal<T0, T1>(arg0, arg1, arg2);
        (v0, v1, get_pending_rewards<T0, T1, T2>(arg0, arg1, arg2))
    }

    fun get_pending_fees_internal<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg2: vector<u32>) : (vector<u64>, vector<u64>, u128) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u32>(&arg2)) {
            let v4 = *0x1::vector::borrow<u32>(&arg2, v3);
            let v5 = 0;
            let v6 = 0;
            if (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg0.bin_manager, v4)) {
                let v7 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin(&arg0.bin_manager, v4);
                let (v8, v9) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::get_pending_fees(&arg0.position_manager, arg1, v4, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_fee_growth_x(v7), 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_fee_growth_y(v7));
                v6 = v9;
                v5 = v8;
                v2 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u128(v2, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::q64x64::liquidity_from_amounts(v8, v9, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_price(v7)));
            };
            0x1::vector::push_back<u64>(&mut v0, v5);
            0x1::vector::push_back<u64>(&mut v1, v6);
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    public fun get_pending_rewards<T0, T1, T2>(arg0: &LBPair<T0, T1>, arg1: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg2: vector<u32>) : u64 {
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::rewarder_index<T2>(&arg0.reward_manager);
        if (!0x1::option::is_some<u64>(&v0)) {
            return 0
        };
        let v1 = *0x1::option::borrow<u64>(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u32>(&arg2)) {
            let v4 = *0x1::vector::borrow<u32>(&arg2, v3);
            if (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg0.bin_manager, v4)) {
                v2 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v2, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::get_pending_rewards(&arg0.position_manager, arg1, v4, v1, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_reward_growth(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin(&arg0.bin_manager, v4), v1)));
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_position_bin_reserves<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg2: u32) : (u64, u64) {
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::position_token_amount(&arg0.position_manager, arg1, arg2);
        if (v0 == 0) {
            return (0, 0)
        };
        if (!0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg0.bin_manager, arg2)) {
            return (0, 0)
        };
        let (v1, v2, v3) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin_reserves_supply(&arg0.bin_manager, arg2);
        if (v3 == 0) {
            return (0, 0)
        };
        (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::mul_div_u128_to_u64(v0, (v1 as u128), v3), 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::mul_div_u128_to_u64(v0, (v2 as u128), v3))
    }

    public fun get_position_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPositionManager {
        &arg0.position_manager
    }

    public fun get_position_reserves_for_bins<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg2: vector<u32>) : (vector<u64>, vector<u64>) {
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
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::price_helper::get_price_from_id(arg1, arg0.bin_step);
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

    public fun get_reward_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::RewarderManager {
        &arg0.reward_manager
    }

    public fun get_static_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u32, u16, u16, u16, u32, u16, u32, u32, u32, u32, u64) {
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_base_factor(&arg0.parameters);
        let v1 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_filter_period(&arg0.parameters);
        let v2 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_decay_period(&arg0.parameters);
        let v3 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_reduction_factor(&arg0.parameters);
        let v4 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_variable_fee_control(&arg0.parameters);
        let v5 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_protocol_share(&arg0.parameters);
        let v6 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_max_volatility_accumulator(&arg0.parameters);
        let v7 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters);
        let v8 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_volatility_reference(&arg0.parameters);
        let v9 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_id_reference(&arg0.parameters);
        let v10 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_time_of_last_update(&arg0.parameters);
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
        (v0, v1, v2, v3, v4, (v5 as u16), v6, v7, v8, v9, v10)
    }

    public fun get_swap_in<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = arg0.parameters;
        let v4 = arg0.bin_step;
        let v5 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_active_id(&v3);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::update_references(&mut v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 70, 2021);
            v7 = v7 + 1;
            let v8 = if (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg0.bin_manager, v6)) {
                let (v9, v10) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin_reserves(&arg0.bin_manager, v6);
                if (arg2) {
                    v10
                } else {
                    v9
                }
            } else {
                0
            };
            if (v8 > 0) {
                let v11 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin(&arg0.bin_manager, v6);
                let v12 = if (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_price(v11) > 0) {
                    0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_price(v11)
                } else {
                    0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::price_helper::get_price_from_id(v6, v4)
                };
                let v13 = if (v8 > v0) {
                    v0
                } else {
                    v8
                };
                0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::update_volatility_accumulator(&mut v3, v6);
                let v14 = if (arg2) {
                    0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::q64x64::get_integer(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::q64x64::div(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::q64x64::from_integer(v13), v12))
                } else {
                    0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::q64x64::get_integer(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::q64x64::mul(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::q64x64::from_integer(v13), v12))
                };
                let v15 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::fee_helper::get_fee_amount_exclusive(v14, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_total_fee_rate(&v3, v4));
                v1 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v1, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v14, v15));
                v0 = v0 - v13;
                v2 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v2, v15);
            };
            if (v0 == 0) {
                break
            };
            v6 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_next_non_empty_bin(&arg0.bin_manager, arg2, v6);
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
        let v9 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_active_id(&v8);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::update_references(&mut v8, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v10 = v9;
        let v11 = 0;
        loop {
            assert!(v11 < 70, 2021);
            v11 = v11 + 1;
            if (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg0.bin_manager, v10)) {
                let v12 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin(&arg0.bin_manager, v10);
                if (!0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::is_empty(v12, !arg2)) {
                    0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::update_volatility_accumulator(&mut v8, v10);
                    let (v13, v14, v15, v16, v17, v18) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_swap_amounts(v12, &v8, arg0.bin_step, arg2, v3, v2);
                    if (v13 > 0 || v14 > 0) {
                        v3 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v3, v13);
                        v2 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v2, v14);
                        v5 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v5, v15);
                        v4 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v4, v16);
                        v7 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v7, v17);
                        v6 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(v6, v18);
                    };
                };
            };
            if (v3 == 0 && v2 == 0) {
                break
            };
            v10 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_next_non_empty_bin(&arg0.bin_manager, arg2, v10);
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

    public(friend) fun increase_oracle_length<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let v1 = v0;
        if (v0 == 0) {
            let v2 = 1;
            v1 = v2;
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::set_oracle_id(&mut arg0.parameters, v2);
        };
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::increase_length(&mut arg0.oracle, v1, arg1);
        let v3 = OracleLengthIncreasedEvent{
            sender     : 0x2::tx_context::sender(arg2),
            new_length : arg1,
        };
        0x2::event::emit<OracleLengthIncreasedEvent>(v3);
    }

    public fun lock_position<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::pair_id(arg2), 2030);
        assert!(arg3 > 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::get_lock_until(arg2) && arg3 > 0x2::clock::timestamp_ms(arg4), 2031);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::lock_position(arg2, arg3);
        let v0 = LockPositionEvent{
            pair       : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position   : 0x2::object::id<0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition>(arg2),
            lock_until : arg3,
            owner      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LockPositionEvent>(v0);
    }

    fun make_amount() : Amount {
        Amount{
            x : 0,
            y : 0,
        }
    }

    fun make_amount_with(arg0: u64, arg1: u64) : Amount {
        Amount{
            x : arg0,
            y : arg1,
        }
    }

    fun make_swap_event<T0, T1>(arg0: address, arg1: &LBPair<T0, T1>, arg2: bool) : SwapEvent {
        SwapEvent{
            sender                  : arg0,
            pair                    : 0x2::object::id<LBPair<T0, T1>>(arg1),
            swap_for_y              : arg2,
            bin_ids                 : 0x1::vector::empty<u32>(),
            amounts_in_x            : 0x1::vector::empty<u64>(),
            amounts_in_y            : 0x1::vector::empty<u64>(),
            amounts_out_x           : 0x1::vector::empty<u64>(),
            amounts_out_y           : 0x1::vector::empty<u64>(),
            total_fees_x            : 0x1::vector::empty<u64>(),
            total_fees_y            : 0x1::vector::empty<u64>(),
            protocol_fees_x         : 0x1::vector::empty<u64>(),
            protocol_fees_y         : 0x1::vector::empty<u64>(),
            volatility_accumulators : 0x1::vector::empty<u32>(),
        }
    }

    fun mint_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg2: &vector<u32>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : (u64, u64, vector<u64>, vector<u64>, vector<u128>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u128>();
        let v3 = arg5;
        let v4 = arg6;
        let v5 = 0;
        let v6 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_active_id(&arg0.parameters);
        while (v5 < 0x1::vector::length<u32>(arg2)) {
            let v7 = *0x1::vector::borrow<u32>(arg2, v5);
            let v8 = *0x1::vector::borrow<u64>(arg3, v5);
            let v9 = *0x1::vector::borrow<u64>(arg4, v5);
            validate_distribution(v8);
            validate_distribution(v9);
            let (v10, v11, v12, v13, v14) = update_bin<T0, T1>(arg0, v6, v7, apply_distribution(arg5, v8), apply_distribution(arg6, v9), arg7);
            if (v10 > 0) {
                v3 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v3, v11);
                v4 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v4, v12);
                let v15 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin(&arg0.bin_manager, v7);
                0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::increase_liquidity(&mut arg0.position_manager, &mut arg0.bin_manager, arg1, v7, v10, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_fee_growth_x(v15), 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_fee_growth_y(v15), *0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_all_reward_growth(v15));
                0x1::vector::push_back<u64>(&mut v0, v13);
                0x1::vector::push_back<u64>(&mut v1, v14);
                0x1::vector::push_back<u128>(&mut v2, v10);
            };
            v5 = v5 + 1;
        };
        (v3, v4, v0, v1, v2)
    }

    public fun open_position<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        let v1 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::open_position<T0, T1>(&mut arg1.position_manager, v0, arg2, 0x2::clock::timestamp_ms(arg3), arg4);
        let v2 = OpenPositionEvent{
            pair     : v0,
            position : 0x2::object::id<0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition>(&v1),
            owner    : 0x2::tx_context::sender(arg4),
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
        let (v1, v2) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::price_helper::get_valid_id_range();
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
            if (!0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg0.bin_manager, v5)) {
                0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::put_bin(&mut arg0.bin_manager, v5, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::new_bin(0, 0, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::price_helper::get_price_from_id(v5, arg0.bin_step)));
            };
            v6 = v6 + 1;
            v5 = v5 + 1;
        };
    }

    fun push_swap_event(arg0: &mut SwapEvent, arg1: u32, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u32) {
        0x1::vector::push_back<u32>(&mut arg0.bin_ids, arg1);
        0x1::vector::push_back<u64>(&mut arg0.amounts_in_x, arg2);
        0x1::vector::push_back<u64>(&mut arg0.amounts_in_y, arg3);
        0x1::vector::push_back<u64>(&mut arg0.amounts_out_x, arg4);
        0x1::vector::push_back<u64>(&mut arg0.amounts_out_y, arg5);
        0x1::vector::push_back<u64>(&mut arg0.total_fees_x, arg6);
        0x1::vector::push_back<u64>(&mut arg0.total_fees_y, arg7);
        0x1::vector::push_back<u64>(&mut arg0.protocol_fees_x, arg8);
        0x1::vector::push_back<u64>(&mut arg0.protocol_fees_y, arg9);
        0x1::vector::push_back<u32>(&mut arg0.volatility_accumulators, arg10);
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition, arg3: vector<u32>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2007);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::pair_id(arg2), 2030);
        let v0 = make_amount();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u128>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u32>(&arg3)) {
            let v5 = *0x1::vector::borrow<u32>(&arg3, v4);
            let v6 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin_mut(&mut arg1.bin_manager, v5);
            let v7 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::position_token_amount(&arg1.position_manager, arg2, v5);
            assert!(v7 > 0, 2013);
            let (v8, v9, v10) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::fee_growth_and_supply(v6);
            let (v11, v12) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_amount_out_of_bin(v6, v7, v10);
            assert!(v11 > 0 || v12 > 0, 2014);
            let (v13, v14) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::collect_fees(&mut arg1.position_manager, arg2, v5, v8, v9);
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::update_reward_growth_baseline(&mut arg1.position_manager, arg2, v5, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_all_reward_growth(v6));
            let v15 = &mut v0;
            add_amount(v15, v13, v14);
            let v16 = &mut v0;
            add_amount(v16, v11, v12);
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::decrease_liquidity(&mut arg1.position_manager, arg2, v5, v7, arg6);
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::subtract_bin(v6, v11, v12, v13, v14, v7);
            if (0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::bin_empty(v6)) {
                0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::remove_bin(&mut arg1.bin_manager, v5);
            };
            0x1::vector::push_back<u64>(&mut v1, v11);
            0x1::vector::push_back<u64>(&mut v2, v12);
            0x1::vector::push_back<u128>(&mut v3, v7);
            v4 = v4 + 1;
        };
        assert!(v0.x >= arg4 && v0.y >= arg5, 2037);
        let v17 = RemoveLiquidityEvent{
            pair             : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position         : 0x2::object::id<0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::lb_position::LBPosition>(arg2),
            ids              : arg3,
            tokens_x         : v0.x,
            tokens_y         : v0.y,
            token_bins_x     : v1,
            token_bins_y     : v2,
            liquidity_burned : v3,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v17);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v0.x, arg7), 0x2::coin::take<T1>(&mut arg1.balance_y, v0.y, arg7))
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        let FlashLoanReceipt {
            pair_id    : v0,
            loan_x     : v1,
            amount     : v2,
            fee_amount : v3,
        } = arg4;
        assert!(v0 == 0x2::object::id<LBPair<T0, T1>>(arg1), 2007);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v2 + v3, 2005);
            0x2::balance::join<T0>(&mut arg1.balance_x, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v2 + v3, 2005);
            0x2::balance::join<T1>(&mut arg1.balance_y, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
        arg1.is_pause = false;
    }

    public(friend) fun set_static_fee_parameters<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: &0x2::tx_context::TxContext) {
        set_static_fee_parameters_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun set_static_fee_parameters_internal<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: &0x2::tx_context::TxContext) {
        let v0 = if (arg1 != 0) {
            if (arg2 != 0) {
                if (arg3 != 0) {
                    if (arg4 != 0) {
                        if (arg5 != 0) {
                            if (arg6 != 0) {
                                arg7 != 0
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2008);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = arg0.bin_step;
        let v2 = arg0.parameters;
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::set_volatility_accumulator(&mut v2, arg7);
        assert!(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_base_fee(&v2, v1), 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_variable_fee(&v2, v1)) <= 100000000, 2016);
        let v3 = StaticFeeParametersSetEvent{
            sender                     : 0x2::tx_context::sender(arg8),
            base_factor                : arg1,
            filter_period              : arg2,
            decay_period               : arg3,
            reduction_factor           : arg4,
            variable_fee_control       : arg5,
            protocol_share             : (arg6 as u64),
            max_volatility_accumulator : arg7,
        };
        0x2::event::emit<StaticFeeParametersSetEvent>(v3);
    }

    fun sub_amount(arg0: &mut Amount, arg1: u64, arg2: u64) {
        arg0.x = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(arg0.x, arg1);
        arg0.y = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(arg0.y, arg2);
    }

    fun update_bin<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u128, u64, u64, u64, u64) {
        let v0 = if (!0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::contains(&arg0.bin_manager, arg2)) {
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::put_bin(&mut arg0.bin_manager, arg2, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::new_bin(0, 0, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::price_helper::get_price_from_id(arg2, arg0.bin_step)));
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin_mut(&mut arg0.bin_manager, arg2)
        } else {
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_bin_mut(&mut arg0.bin_manager, arg2)
        };
        let v1 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_price(v0);
        let v2 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_total_supply(v0);
        let (v3, v4, v5) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_shares_and_effective_amounts_in(v0, arg3, arg4, v1, v2);
        let v6 = v3;
        if (v3 == 0) {
            return (0, 0, 0, 0, 0)
        };
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        if (arg2 == arg1) {
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::update_volatility_parameters(&mut arg0.parameters, arg2, 0x2::clock::timestamp_ms(arg5) / 1000);
            let (v11, v12) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_composition_fees(v0, &arg0.parameters, arg0.bin_step, v4, v5, v2, v3);
            v8 = v12;
            v7 = v11;
            if (v11 > 0 || v12 > 0) {
                let v13 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                let v14 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::fee_helper::get_protocol_fee_amount(v11, v13);
                let v15 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::fee_helper::get_protocol_fee_amount(v12, v13);
                arg0.protocol_fee_x = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg0.protocol_fee_x, v14);
                arg0.protocol_fee_y = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg0.protocol_fee_y, v15);
                let v16 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v11, v14);
                v9 = v16;
                let v17 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v12, v15);
                v10 = v17;
                arg0.lp_fee_x = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg0.lp_fee_x, v16);
                arg0.lp_fee_y = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::add_u64(arg0.lp_fee_y, v17);
                update_bin_fee_and_reward_growth(&arg0.reward_manager, v0, v16, v17);
                let (v18, v19) = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_reserves(v0);
                v6 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::mul_div_u128(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::q64x64::liquidity_from_amounts(0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v4, v11), 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v5, v12), v1), v2, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::q64x64::liquidity_from_amounts(v18, v19, v1));
                0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, arg2, arg5);
                let v20 = CompositionFeesEvent{
                    pair   : 0x2::object::id<LBPair<T0, T1>>(arg0),
                    bin_id : arg2,
                    fee_x  : v11,
                    fee_y  : v12,
                };
                0x2::event::emit<CompositionFeesEvent>(v20);
            };
        } else {
            0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::verify_lp_amounts(v4, v5, arg1, arg2);
        };
        assert!(v6 > 0, 2015);
        let v21 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v4, v7);
        let v22 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::safe_math::sub_u64(v5, v8);
        assert!(v21 > 0 || v22 > 0, 2015);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::add_reserves_fees(v0, v21, v22, v9, v10);
        (v6, v4, v5, v21, v22)
    }

    fun update_bin_fee_and_reward_growth(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::RewarderManager, arg1: &mut 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::Bin, arg2: u64, arg3: u64) {
        if (arg2 == 0 && arg3 == 0) {
            return
        };
        let v0 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::get_total_supply(arg1);
        if (v0 == 0) {
            return
        };
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::add_fee_growth(arg1, ((arg2 as u128) << 64) / v0, ((arg3 as u128) << 64) / v0);
        let v1 = 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::get_rewarders(arg0);
        let v2 = 0x1::vector::empty<u128>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::Rewarder>(v1)) {
            0x1::vector::push_back<u128>(&mut v2, 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::get_rewarder_factor(0x1::vector::borrow<0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::Rewarder>(v1, v3)));
            v3 = v3 + 1;
        };
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::bin_manager::update_reward_growth(arg1, arg2, arg3, &v2);
    }

    public fun update_reward_factor<T0, T1, T2>(arg0: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::RewarderGlobalVault, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::config::check_reward_role(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::rewarder::update_reward_factor<T2>(arg2, &mut arg1.reward_manager, v0, arg3);
        let v1 = RewardFactorUpdatedEvent{
            pair          : v0,
            rewarder_type : 0x1::type_name::get<T2>(),
            reward_factor : arg3,
        };
        0x2::event::emit<RewardFactorUpdatedEvent>(v1);
    }

    fun validate_distribution(arg0: u64) {
        assert!(arg0 <= 0x809edcaffb3b329da54be31fa53c305d9c37042b1524a028db507d6e401546ea::constants::precision(), 2035);
    }

    // decompiled from Move bytecode v6
}

