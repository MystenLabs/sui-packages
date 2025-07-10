module 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_pair {
    struct SwapEvent has copy, drop {
        sender: address,
        pair: 0x2::object::ID,
        id_before: u32,
        id_after: u32,
        swap_for_y: bool,
        amounts_in: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts,
        amounts_out: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts,
        volatility_accumulator: u32,
        total_fees: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts,
        protocol_fees: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts,
        current_bin: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin,
    }

    struct CollectedProtocolFeesEvent has copy, drop {
        fee_recipient: address,
        protocol_fees: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts,
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
        base_factor: u16,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct CompositionFeesEvent has copy, drop {
        id: u32,
        total_fees: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts,
        protocol_fees: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts,
    }

    struct FeesStatisticEvent has copy, drop {
        total_fee_x: u64,
        total_fee_y: u64,
        flashloan_fee_x: u64,
        flashloan_fee_y: u64,
        swap_fee_x: u64,
        swap_fee_y: u64,
        composition_fee_x: u64,
        composition_fee_y: u64,
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

    struct StaticFeeParametersQueriedEvent has copy, drop {
        base_factor: u16,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct VariableFeeParametersQueriedEvent has copy, drop {
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
        amounts: vector<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts>,
        tokens: vector<u128>,
        bin_after: vector<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin>,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        ids: vector<u32>,
        tokens: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts,
        token_bins: vector<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts>,
        liquidity_burned: vector<u128>,
        bin_before: vector<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin>,
        bin_after: vector<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin>,
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

    struct MintArrays has drop {
        ids: vector<u32>,
        amounts: vector<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts>,
        liquidity_minted: vector<u128>,
    }

    struct FlashLoanReceipt {
        pool_id: 0x2::object::ID,
        loan_x: bool,
        amount: u64,
        fee_amount: u64,
    }

    struct GlobalFeeInfo has copy, drop, store {
        total_fee_x: u64,
        total_fee_y: u64,
        swap_fee_x: u64,
        swap_fee_y: u64,
        flashloan_fee_x: u64,
        flashloan_fee_y: u64,
        composition_fee_x: u64,
        composition_fee_y: u64,
    }

    struct GlobalRewardState has store {
        reward_per_fee_cumulative: vector<u128>,
        total_fees_ever: u128,
        last_update_time: u64,
    }

    struct LBPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        index: u64,
        is_pause: bool,
        bin_step: u16,
        parameters: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::PairParameters,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        bin_manager: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::BinManager,
        oracle: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::Oracle,
        position_manager: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPositionManager,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        global_fee_info: GlobalFeeInfo,
        rewarder_manager: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::RewarderManager,
        global_reward_state: GlobalRewardState,
    }

    public fun swap<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg4);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg5);
        let v0 = if (arg2) {
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0x2::coin::value<T0>(&arg4), 0)
        } else {
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0x2::coin::value<T1>(&arg5))
        };
        let v1 = v0;
        let (v2, v3) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v1);
        assert!(v2 > 0 || v3 > 0, 2005);
        let v4 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0);
        let v5 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_active_id(&arg1.parameters);
        let v6 = arg1.bin_step;
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::update_references(&mut arg1.parameters, 0x2::clock::timestamp_ms(arg6) / 1000);
        let v7 = v5;
        let v8 = 0;
        let v9 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0);
        loop {
            assert!(v8 < 255, 2021);
            v8 = v8 + 1;
            let v10 = if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg1.bin_manager, v7)) {
                *0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg1.bin_manager, v7)
            } else {
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_bin(0, 0, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::price_helper::get_price_from_id(v7, v6))
            };
            let v11 = v10;
            if (!0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::is_empty(&v11, !arg2)) {
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::update_volatility_accumulator(&mut arg1.parameters, v7);
                let (v12, v13, v14) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts(&v11, &arg1.parameters, v6, arg2, &v1);
                let v15 = v14;
                let v16 = v13;
                let v17 = v12;
                let (v18, v19) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v17);
                if (v18 > 0 || v19 > 0) {
                    let v20 = &v1;
                    v1 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::sub_amounts(v20, &v17);
                    let v21 = &v4;
                    v4 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::add_amounts(v21, &v16);
                    let v22 = &v9;
                    v9 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::add_amounts(v22, &v15);
                    let v23 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_protocol_share(&arg1.parameters);
                    let (v24, v25) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v15);
                    let v26 = if (v23 > 0) {
                        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::fee_helper::get_protocol_fee_amount(v24, (v23 as u64)), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::fee_helper::get_protocol_fee_amount(v25, (v23 as u64)))
                    } else {
                        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0)
                    };
                    let v27 = v26;
                    let (v28, v29) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v27);
                    if (v28 > 0 || v29 > 0) {
                        assert!(arg1.protocol_fee_x <= 18446744073709551615 - v28, 2024);
                        assert!(arg1.protocol_fee_y <= 18446744073709551615 - v29, 2024);
                        arg1.protocol_fee_x = arg1.protocol_fee_x + v28;
                        arg1.protocol_fee_y = arg1.protocol_fee_y + v29;
                    };
                    let v30 = v24 - v28;
                    let v31 = v25 - v29;
                    let v32 = *0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin_mut(&mut arg1.bin_manager, v7);
                    let (v33, v34) = if (arg2) {
                        (v18 - v24, 0)
                    } else {
                        (0, v19 - v25)
                    };
                    let (v35, v36) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v16);
                    0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::update_to_reserves(&mut v32, v33, v35, v34, v36, v30, v31);
                    *0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin_mut(&mut arg1.bin_manager, v7) = v32;
                    update_bin_fee_growth<T0, T1>(arg1, v7, v30, v31);
                    let v37 = SwapEvent{
                        sender                 : 0x2::tx_context::sender(arg7),
                        pair                   : 0x2::object::id<LBPair<T0, T1>>(arg1),
                        id_before              : v5,
                        id_after               : v7,
                        swap_for_y             : arg2,
                        amounts_in             : v17,
                        amounts_out            : v16,
                        volatility_accumulator : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_volatility_accumulator(&arg1.parameters),
                        total_fees             : v15,
                        protocol_fees          : v27,
                        current_bin            : *0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg1.bin_manager, v7),
                    };
                    0x2::event::emit<SwapEvent>(v37);
                };
            };
            let (v38, v39) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v1);
            if (v38 == 0 && v39 == 0) {
                break
            };
            let v40 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_next_non_empty_bin(&arg1.bin_manager, arg2, v7);
            if (v40 == 0 || v40 == v5) {
                abort 2011
            };
            v7 = v40;
        };
        let (v41, v42) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v4);
        assert!(v41 > 0 || v42 > 0, 2006);
        if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::update(&mut arg1.oracle, &mut arg1.parameters, v7, arg6)) {
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::set_active_id(&mut arg1.parameters, v7);
        };
        let (v43, v44) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v9);
        arg1.global_fee_info.swap_fee_x = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg1.global_fee_info.swap_fee_x, v43);
        arg1.global_fee_info.swap_fee_y = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg1.global_fee_info.swap_fee_y, v44);
        arg1.global_fee_info.total_fee_x = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg1.global_fee_info.total_fee_x, v43);
        arg1.global_fee_info.total_fee_y = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg1.global_fee_info.total_fee_y, v44);
        arg1.global_reward_state.total_fees_ever = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u128(arg1.global_reward_state.total_fees_ever, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u128((v43 as u128), (v44 as u128)));
        let v45 = FeesStatisticEvent{
            total_fee_x       : v43,
            total_fee_y       : v44,
            flashloan_fee_x   : 0,
            flashloan_fee_y   : 0,
            swap_fee_x        : v43,
            swap_fee_y        : v44,
            composition_fee_x : 0,
            composition_fee_y : 0,
        };
        0x2::event::emit<FeesStatisticEvent>(v45);
        let v46 = 0x2::coin::take<T0>(&mut arg1.balance_x, v41, arg7);
        let v47 = 0x2::coin::take<T1>(&mut arg1.balance_y, v42, arg7);
        if (arg2) {
            assert!(0x2::coin::value<T1>(&v47) >= arg3, 2006);
        } else {
            assert!(0x2::coin::value<T0>(&v46) >= arg3, 2006);
        };
        (v46, v47)
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u32, arg8: u16, arg9: u32, arg10: u32, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : LBPair<T0, T1> {
        let v0 = GlobalFeeInfo{
            total_fee_x       : 0,
            total_fee_y       : 0,
            swap_fee_x        : 0,
            swap_fee_y        : 0,
            flashloan_fee_x   : 0,
            flashloan_fee_y   : 0,
            composition_fee_x : 0,
            composition_fee_y : 0,
        };
        let v1 = GlobalRewardState{
            reward_per_fee_cumulative : 0x1::vector::empty<u128>(),
            total_fees_ever           : 0,
            last_update_time          : 0x2::clock::timestamp_ms(arg11) / 1000,
        };
        let v2 = LBPair<T0, T1>{
            id                  : 0x2::object::new(arg12),
            index               : arg0,
            is_pause            : false,
            bin_step            : arg2,
            parameters          : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::new(arg1),
            protocol_fee_x      : 0,
            protocol_fee_y      : 0,
            bin_manager         : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new(0x2::clock::timestamp_ms(arg11), arg12),
            oracle              : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::new(),
            position_manager    : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::new(arg12),
            balance_x           : 0x2::balance::zero<T0>(),
            balance_y           : 0x2::balance::zero<T1>(),
            global_fee_info     : v0,
            rewarder_manager    : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::new(),
            global_reward_state : v1,
        };
        let v3 = &mut v2;
        set_static_fee_parameters_internal<T0, T1>(v3, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v4 = &mut v2;
        pre_initialize_bins_internal<T0, T1>(v4, arg1, arg10);
        v2
    }

    public fun get_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : (u64, u64) {
        assert!(arg1 <= 16777215, 2020);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin_reserves(&arg0.bin_manager, arg1)
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
        let v3 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::get_rewarders(&arg0.rewarder_manager);
        while (v2 < 0x1::vector::length<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::Rewarder>(v3)) {
            let v4 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_u128(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::get_emissions_per_second(0x1::vector::borrow<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::Rewarder>(v3, v2)), (v1 as u128));
            if (v4 > 0 && arg0.global_reward_state.total_fees_ever > 0) {
                if (v2 >= 0x1::vector::length<u128>(&arg0.global_reward_state.reward_per_fee_cumulative)) {
                    while (0x1::vector::length<u128>(&arg0.global_reward_state.reward_per_fee_cumulative) <= v2) {
                        0x1::vector::push_back<u128>(&mut arg0.global_reward_state.reward_per_fee_cumulative, 0);
                    };
                };
                let v5 = 0x1::vector::borrow_mut<u128>(&mut arg0.global_reward_state.reward_per_fee_cumulative, v2);
                *v5 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u128(*v5, (v4 << 64) / arg0.global_reward_state.total_fees_ever);
            };
            v2 = v2 + 1;
        };
        arg0.global_reward_state.last_update_time = v0;
    }

    public fun add_liquidity<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::pair_id(arg2), 2030);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2002);
        let v1 = create_liquidity_configs_from_params(&arg3, &arg4, &arg5);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg6);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg7);
        let v2 = MintArrays{
            ids              : 0x1::vector::empty<u32>(),
            amounts          : 0x1::vector::empty<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts>(),
            liquidity_minted : 0x1::vector::empty<u128>(),
        };
        let v3 = &mut v2;
        let v4 = mint_bins<T0, T1>(arg1, arg2, &v1, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0x2::coin::value<T0>(&arg6), 0x2::coin::value<T1>(&arg7)), v3, arg8);
        let (v5, v6) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v4);
        if (v5 > 0 || v6 > 0) {
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance_x, v5, arg9), v0);
            };
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v6, arg9), v0);
            };
        };
        let v7 = 0x1::vector::empty<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<u32>(&v2.ids)) {
            0x1::vector::push_back<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin>(&mut v7, *0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg1.bin_manager, *0x1::vector::borrow<u32>(&v2.ids, v8)));
            v8 = v8 + 1;
        };
        let v9 = AddLiquidityEvent{
            pair      : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position  : 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(arg2),
            ids       : v2.ids,
            amounts   : v2.amounts,
            tokens    : v2.liquidity_minted,
            bin_after : v7,
        };
        0x2::event::emit<AddLiquidityEvent>(v9);
    }

    public fun add_rewarder<T0, T1, T2>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::RewarderAdminCap, arg1: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg2: &mut LBPair<T0, T1>) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg1);
        assert!(!arg2.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg2);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::add_rewarder<T2>(&mut arg2.rewarder_manager);
        ensure_reward_vectors_initialized<T0, T1>(arg2);
        let v1 = RewarderAddedEvent{
            pool          : v0,
            rewarder_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<RewarderAddedEvent>(v1);
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

    public fun close_position<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg3: &mut 0x2::tx_context::TxContext) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        assert!(v0 == 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::pair_id(&arg2), 2030);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::close_position(&mut arg1.position_manager, arg2);
        let v1 = ClosePositionEvent{
            pair     : v0,
            position : 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(&arg2),
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClosePositionEvent>(v1);
    }

    public fun collect_position_fees<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg3: vector<u32>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::pair_id(arg2), 2030);
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
            if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg1.bin_manager, v5)) {
                let v8 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg1.bin_manager, v5);
                v6 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_x(v8);
                v7 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_y(v8);
            };
            let (v9, v10) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::collect_fees(&mut arg1.position_manager, arg2, v5, v6, v7);
            v0 = v0 + v9;
            v1 = v1 + v10;
            0x1::vector::push_back<u64>(&mut v2, v9);
            0x1::vector::push_back<u64>(&mut v3, v10);
            v4 = v4 + 1;
        };
        let v11 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u128((v0 as u128), (v1 as u128));
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::add_total_fees_generated(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::borrow_mut_position_info(&mut arg1.position_manager, 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(arg2)), v11);
        arg1.global_reward_state.total_fees_ever = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u128(arg1.global_reward_state.total_fees_ever, v11);
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
            position  : 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(arg2),
            bin_ids   : arg3,
            amounts_x : v2,
            amounts_y : v3,
        };
        0x2::event::emit<FeesCollectedEvent>(v14);
        (v12, v13)
    }

    public fun collect_position_rewards<T0, T1, T2>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg3: &mut 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::pair_id(arg2), 2030);
        accumulate_global_rewards<T0, T1>(arg1, arg4);
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::borrow_mut_position_info(&mut arg1.position_manager, 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(arg2));
        let v1 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::rewarder_index<T2>(&arg1.rewarder_manager);
        if (!0x1::option::is_some<u64>(&v1)) {
            return 0x2::coin::zero<T2>(arg5)
        };
        let v2 = *0x1::option::borrow<u64>(&v1);
        let v3 = *0x1::vector::borrow<u128>(&arg1.global_reward_state.reward_per_fee_cumulative, v2);
        let v4 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_u128(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::get_total_fees_generated(v0), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::sub_u128(v3, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::get_reward_per_fee_snapshot(v0, v2))) >> 64;
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::update_reward_per_fee_snapshot(v0, v2, v3);
        if (v4 > 0) {
            let v6 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::u128_to_u64(v4);
            let v7 = RewardsCollectedEvent{
                pool        : 0x2::object::id<LBPair<T0, T1>>(arg1),
                bucket_id   : 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(arg2),
                reward_type : 0x1::type_name::get<T2>(),
                amount      : v6,
            };
            0x2::event::emit<RewardsCollectedEvent>(v7);
            0x2::coin::from_balance<T2>(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::withdraw_reward<T2>(arg3, v6), arg5)
        } else {
            0x2::coin::zero<T2>(arg5)
        }
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg2));
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
            fee_recipient : 0x2::tx_context::sender(arg2),
            protocol_fees : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(v2, v3),
        };
        0x2::event::emit<CollectedProtocolFeesEvent>(v6);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v2, arg2), 0x2::coin::take<T1>(&mut arg1.balance_y, v3, arg2))
    }

    fun create_liquidity_configs_from_params(arg0: &vector<u32>, arg1: &vector<u64>, arg2: &vector<u64>) : vector<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::liquidity_configurations::LiquidityConfig> {
        let v0 = 0x1::vector::length<u32>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 2007);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 2007);
        let v1 = 0x1::vector::empty<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::liquidity_configurations::LiquidityConfig>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::liquidity_configurations::LiquidityConfig>(&mut v1, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::liquidity_configurations::new_config(*0x1::vector::borrow<u64>(arg1, v2), *0x1::vector::borrow<u64>(arg2, v2), *0x1::vector::borrow<u32>(arg0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    fun ensure_reward_vectors_initialized<T0, T1>(arg0: &mut LBPair<T0, T1>) {
        while (0x1::vector::length<u128>(&arg0.global_reward_state.reward_per_fee_cumulative) < 0x1::vector::length<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::Rewarder>(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::get_rewarders(&arg0.rewarder_manager))) {
            0x1::vector::push_back<u128>(&mut arg0.global_reward_state.reward_per_fee_cumulative, 0);
        };
    }

    public fun flash_loan<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        flash_loan_internal<T0, T1>(arg1, arg2, arg3, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::flash_loan_fee_rate(arg0))
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
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::div_round_up_u64(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_u64(arg2, arg3), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::constants::precision())
        };
        assert!(v0 > 0, 2013);
        if (arg1) {
            assert!(arg0.protocol_fee_x <= 18446744073709551615 - v0, 2024);
            arg0.protocol_fee_x = arg0.protocol_fee_x + v0;
        } else {
            assert!(arg0.protocol_fee_y <= 18446744073709551615 - v0, 2024);
            arg0.protocol_fee_y = arg0.protocol_fee_y + v0;
        };
        let v1 = FlashLoanReceipt{
            pool_id    : 0x2::object::id<LBPair<T0, T1>>(arg0),
            loan_x     : arg1,
            amount     : arg2,
            fee_amount : v0,
        };
        if (arg1) {
            arg0.global_fee_info.flashloan_fee_x = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg0.global_fee_info.flashloan_fee_x, v0);
            arg0.global_fee_info.total_fee_x = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg0.global_fee_info.total_fee_x, v0);
        } else {
            arg0.global_fee_info.flashloan_fee_y = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg0.global_fee_info.flashloan_fee_y, v0);
            arg0.global_fee_info.total_fee_y = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg0.global_fee_info.total_fee_y, v0);
        };
        arg0.global_reward_state.total_fees_ever = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u128(arg0.global_reward_state.total_fees_ever, (v0 as u128));
        let v2 = if (arg1) {
            v0
        } else {
            0
        };
        let v3 = if (!arg1) {
            v0
        } else {
            0
        };
        let v4 = if (arg1) {
            v0
        } else {
            0
        };
        let v5 = if (!arg1) {
            v0
        } else {
            0
        };
        let v6 = FeesStatisticEvent{
            total_fee_x       : v2,
            total_fee_y       : v3,
            flashloan_fee_x   : v4,
            flashloan_fee_y   : v5,
            swap_fee_x        : 0,
            swap_fee_y        : 0,
            composition_fee_x : 0,
            composition_fee_y : 0,
        };
        0x2::event::emit<FeesStatisticEvent>(v6);
        let v7 = FlashLoanEvent{
            pool       : 0x2::object::id<LBPair<T0, T1>>(arg0),
            loan_x     : arg1,
            amount     : arg2,
            fee_amount : v0,
        };
        0x2::event::emit<FlashLoanEvent>(v7);
        let (v8, v9) = if (arg1) {
            (0x2::balance::split<T0>(&mut arg0.balance_x, arg2), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.balance_y, arg2))
        };
        (v8, v9, v1)
    }

    public(friend) fun force_decay<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::update_volatility_reference(&mut arg0.parameters);
        let v0 = ForcedDecayEvent{
            sender               : 0x2::tx_context::sender(arg1),
            id_reference         : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_id_reference(&arg0.parameters),
            volatility_reference : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_volatility_reference(&arg0.parameters),
        };
        0x2::event::emit<ForcedDecayEvent>(v0);
    }

    public fun get_active_id<T0, T1>(arg0: &LBPair<T0, T1>) : u32 {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_active_id(&arg0.parameters)
    }

    public fun get_bin_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::BinManager {
        &arg0.bin_manager
    }

    public fun get_bin_step<T0, T1>(arg0: &LBPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun get_id_from_price<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u128) : u32 {
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::price_helper::get_id_from_price(arg1, arg0.bin_step);
        let v1 = IdFromPriceQueriedEvent{
            price : arg1,
            id    : v0,
        };
        0x2::event::emit<IdFromPriceQueriedEvent>(v1);
        v0
    }

    public fun get_oracle_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u8, u16, u16, u64, u64) {
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let (v1, v2, v3, v4, v5) = if (v0 == 0) {
            (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::get_max_sample_lifetime(), 0, 0, 0, 0)
        } else {
            let (v6, v7) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::get_active_sample_and_size(&arg0.oracle, v0);
            let v8 = v6;
            let v9 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::get_sample_last_update(&v8);
            let v10 = if (v9 == 0) {
                0
            } else {
                v7
            };
            let v11 = if (v10 > 0) {
                let v12 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::get_sample(&arg0.oracle, 1 + v0 % v10);
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::get_sample_last_update(&v12)
            } else {
                0
            };
            (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::get_max_sample_lifetime(), v7, v10, v9, v11)
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
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_oracle_id(&arg0.parameters);
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
        let (v2, v3, v4, v5) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::get_sample_at(&arg0.oracle, v0, arg1);
        let v6 = v4;
        let v7 = v3;
        if (v2 < arg1) {
            let v8 = arg1 - v2;
            v7 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(v3, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_u64((0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_active_id(&arg0.parameters) as u64), v8));
            v6 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(v4, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_u64((0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters) as u64), v8));
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

    public fun get_pending_fees<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg2: vector<u32>) : (vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg2)) {
            let v3 = *0x1::vector::borrow<u32>(&arg2, v2);
            let v4 = 0;
            let v5 = 0;
            if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, v3)) {
                let v6 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg0.bin_manager, v3);
                v4 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_x(v6);
                v5 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_y(v6);
            };
            let (v7, v8) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::get_pending_fees(&arg0.position_manager, arg1, v3, v4, v5);
            0x1::vector::push_back<u64>(&mut v0, v7);
            0x1::vector::push_back<u64>(&mut v1, v8);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_pending_rewards<T0, T1, T2>(arg0: &LBPair<T0, T1>, arg1: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg2: &0x2::clock::Clock) : u64 {
        let v0 = simulate_accumulation<T0, T1>(arg0, arg2);
        let v1 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::borrow_position_info(&arg0.position_manager, 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(arg1));
        let v2 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::rewarder_index<T2>(&arg0.rewarder_manager);
        if (!0x1::option::is_some<u64>(&v2)) {
            return 0
        };
        let v3 = *0x1::option::borrow<u64>(&v2);
        if (v3 >= 0x1::vector::length<u128>(&v0)) {
            return 0
        };
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::u128_to_u64(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_u128(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::get_total_fees_generated(v1), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::sub_u128(*0x1::vector::borrow<u128>(&v0, v3), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::get_reward_per_fee_snapshot(v1, v3))) >> 64)
    }

    public fun get_position_bin_reserves<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg2: u32) : (u64, u64) {
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::position_token_amount(&arg0.position_manager, arg1, arg2);
        if (v0 == 0) {
            return (0, 0)
        };
        if (!0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, arg2)) {
            return (0, 0)
        };
        let (v1, v2) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin_reserves(&arg0.bin_manager, arg2);
        let v3 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_total_supply(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg0.bin_manager, arg2));
        if (v3 == 0) {
            return (0, 0)
        };
        ((0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_div_u128(v0, (v1 as u128), v3) as u64), (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_div_u128(v0, (v2 as u128), v3) as u64))
    }

    public fun get_position_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPositionManager {
        &arg0.position_manager
    }

    public fun get_position_reserves_for_bins<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg2: vector<u32>) : (vector<u64>, vector<u64>) {
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
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::price_helper::get_price_from_id(arg1, arg0.bin_step);
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

    public fun get_rewarder_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::RewarderManager {
        &arg0.rewarder_manager
    }

    public fun get_static_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u16, u16, u16, u16, u32, u16, u32) {
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_base_factor(&arg0.parameters);
        let v1 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_filter_period(&arg0.parameters);
        let v2 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_decay_period(&arg0.parameters);
        let v3 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_reduction_factor(&arg0.parameters);
        let v4 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_variable_fee_control(&arg0.parameters);
        let v5 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_protocol_share(&arg0.parameters);
        let v6 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_max_volatility_accumulator(&arg0.parameters);
        let v7 = StaticFeeParametersQueriedEvent{
            base_factor                : v0,
            filter_period              : v1,
            decay_period               : v2,
            reduction_factor           : v3,
            variable_fee_control       : v4,
            protocol_share             : v5,
            max_volatility_accumulator : v6,
        };
        0x2::event::emit<StaticFeeParametersQueriedEvent>(v7);
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun get_swap_in<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = arg0.parameters;
        let v4 = arg0.bin_step;
        let v5 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_active_id(&v3);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::update_references(&mut v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, v6)) {
                let (v9, v10) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin_reserves(&arg0.bin_manager, v6);
                if (arg2) {
                    v10
                } else {
                    v9
                }
            } else {
                0
            };
            if (v8 > 0) {
                let v11 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg0.bin_manager, v6);
                let v12 = if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_cached_price(v11) > 0) {
                    0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_cached_price(v11)
                } else {
                    0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::price_helper::get_price_from_id(v6, v4)
                };
                let v13 = if (v8 > v0) {
                    v0
                } else {
                    v8
                };
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::update_volatility_accumulator(&mut v3, v6);
                let v14 = if (arg2) {
                    0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::q64x64::get_integer(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::q64x64::div(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::q64x64::from_integer(v13), v12))
                } else {
                    0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::q64x64::get_integer(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::q64x64::mul(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::q64x64::from_integer(v13), v12))
                };
                let v15 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::fee_helper::get_fee_amount(v14, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_total_fee(&v3, v4));
                v1 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(v1, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(v14, v15));
                v0 = v0 - v13;
                v2 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(v2, v15);
            };
            if (v0 == 0) {
                break
            };
            v6 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_next_non_empty_bin(&arg0.bin_manager, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        (v1, v0, v2)
    }

    public fun get_swap_out<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = if (arg2) {
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(arg1, 0)
        } else {
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, arg1)
        };
        let v1 = v0;
        let v2 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0);
        let v3 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0);
        let v4 = arg0.parameters;
        let v5 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_active_id(&v4);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::update_references(&mut v4, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, v6)) {
                let v8 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg0.bin_manager, v6);
                if (!0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::is_empty(v8, !arg2)) {
                    0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::update_volatility_accumulator(&mut v4, v6);
                    let (v9, v10, v11) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts(v8, &v4, arg0.bin_step, arg2, &v1);
                    let v12 = v11;
                    let v13 = v10;
                    let v14 = v9;
                    let (v15, v16) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v14);
                    if (v15 > 0 || v16 > 0) {
                        let v17 = &v1;
                        v1 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::sub_amounts(v17, &v14);
                        let v18 = &v2;
                        v2 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::add_amounts(v18, &v13);
                        let v19 = &v3;
                        v3 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::add_amounts(v19, &v12);
                    };
                };
            };
            let (v20, v21) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v1);
            if (v20 == 0 && v21 == 0) {
                break
            };
            v6 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_next_non_empty_bin(&arg0.bin_manager, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        let (v22, v23) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v1);
        let (v24, v25) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v2);
        let (v26, v27) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v3);
        let v28 = if (arg2) {
            v22
        } else {
            v23
        };
        let v29 = if (arg2) {
            v25
        } else {
            v24
        };
        let v30 = if (arg2) {
            v26
        } else {
            v27
        };
        (v28, v29, v30)
    }

    public fun get_total_pending_fees<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg2: vector<u32>) : (u64, u64) {
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

    public fun get_variable_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u32, u32, u32, u64) {
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters);
        let v1 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_volatility_reference(&arg0.parameters);
        let v2 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_id_reference(&arg0.parameters);
        let v3 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_time_of_last_update(&arg0.parameters);
        let v4 = VariableFeeParametersQueriedEvent{
            volatility_accumulator : v0,
            volatility_reference   : v1,
            id_reference           : v2,
            time_of_last_update    : v3,
        };
        0x2::event::emit<VariableFeeParametersQueriedEvent>(v4);
        (v0, v1, v2, v3)
    }

    public(friend) fun increase_oracle_length<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let v1 = v0;
        if (v0 == 0) {
            let v2 = 1;
            v1 = v2;
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::set_oracle_id(&mut arg0.parameters, v2);
        };
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::increase_length(&mut arg0.oracle, v1, arg1);
        let v3 = OracleLengthIncreasedEvent{
            sender     : 0x2::tx_context::sender(arg2),
            new_length : arg1,
        };
        0x2::event::emit<OracleLengthIncreasedEvent>(v3);
    }

    public fun lock_position<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::pair_id(arg2), 2030);
        assert!(arg3 > 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::get_lock_until(arg2) && arg3 > 0x2::clock::timestamp_ms(arg4), 2031);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::lock_position(arg2, arg3);
        let v0 = LockPositionEvent{
            pair       : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position   : 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(arg2),
            lock_until : arg3,
            owner      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LockPositionEvent>(v0);
    }

    fun mint_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg2: &vector<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::liquidity_configurations::LiquidityConfig>, arg3: 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts, arg4: &mut MintArrays, arg5: &0x2::clock::Clock) : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts {
        let v0 = arg3;
        let v1 = 0;
        let v2 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_active_id(&arg0.parameters);
        let (v3, v4) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&arg3);
        let v5 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0);
        while (v1 < 0x1::vector::length<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::liquidity_configurations::LiquidityConfig>(arg2)) {
            let v6 = 0x1::vector::borrow<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::liquidity_configurations::LiquidityConfig>(arg2, v1);
            let v7 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::liquidity_configurations::get_id(v6);
            let (v8, v9) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::liquidity_configurations::apply_distribution(v6, v3, v4);
            let v10 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(v8, v9);
            let (v11, v12, v13, v14) = update_bin<T0, T1>(arg0, v2, v7, &v10, arg5);
            let v15 = v14;
            let v16 = v12;
            if (v11 > 0) {
                let v17 = &v0;
                v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::sub_amounts(v17, &v16);
                let v18 = &v5;
                v5 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::add_amounts(v18, &v15);
                0x1::vector::push_back<u32>(&mut arg4.ids, v7);
                0x1::vector::push_back<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts>(&mut arg4.amounts, v13);
                0x1::vector::push_back<u128>(&mut arg4.liquidity_minted, v11);
                let v19 = 0;
                let v20 = 0;
                if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, v7)) {
                    let v21 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg0.bin_manager, v7);
                    v19 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_x(v21);
                    v20 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_y(v21);
                };
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::increase_liquidity(&mut arg0.position_manager, &mut arg0.bin_manager, arg1, v7, (v11 as u128));
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::update_fee_info(&mut arg0.position_manager, arg1, v7, v19, v20);
            };
            v1 = v1 + 1;
        };
        let (v22, v23) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v5);
        if (v22 > 0 || v23 > 0) {
            arg0.global_fee_info.composition_fee_x = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg0.global_fee_info.composition_fee_x, v22);
            arg0.global_fee_info.composition_fee_y = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg0.global_fee_info.composition_fee_y, v23);
            arg0.global_fee_info.total_fee_x = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg0.global_fee_info.total_fee_x, v22);
            arg0.global_fee_info.total_fee_y = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(arg0.global_fee_info.total_fee_y, v23);
            arg0.global_reward_state.total_fees_ever = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u128(arg0.global_reward_state.total_fees_ever, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u128((v22 as u128), (v23 as u128)));
            let v24 = FeesStatisticEvent{
                total_fee_x       : v22,
                total_fee_y       : v23,
                flashloan_fee_x   : 0,
                flashloan_fee_y   : 0,
                swap_fee_x        : 0,
                swap_fee_y        : 0,
                composition_fee_x : v22,
                composition_fee_y : v23,
            };
            0x2::event::emit<FeesStatisticEvent>(v24);
        };
        v0
    }

    public fun open_position<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        ensure_reward_vectors_initialized<T0, T1>(arg1);
        let v1 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::open_position<T0, T1>(&mut arg1.position_manager, v0, arg2, arg3);
        let v2 = OpenPositionEvent{
            pair     : v0,
            position : 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(&v1),
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

    fun pre_initialize_bins_internal<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u32) {
        if (arg2 <= 0) {
            return
        };
        let v0 = arg2 / 2;
        let (v1, v2) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::price_helper::get_valid_id_range();
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
            if (!0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, v5)) {
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::add_or_update_bin(&mut arg0.bin_manager, v5, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_bin(0, 0, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::price_helper::get_price_from_id(v5, arg0.bin_step)));
            };
            v6 = v6 + 1;
            v5 = v5 + 1;
        };
    }

    public fun remove_liquidity<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg3: vector<u32>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::pair_id(arg2), 2030);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2007);
        validate_remove_liquidity_inputs<T0, T1>(arg1, arg2, &arg3);
        let v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0);
        let v1 = 0x1::vector::empty<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts>();
        let v2 = 0x1::vector::empty<u128>();
        let v3 = 0x1::vector::empty<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin>();
        let v4 = 0x1::vector::empty<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u32>(&arg3)) {
            let v6 = *0x1::vector::borrow<u32>(&arg3, v5);
            let v7 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::position_token_amount(&arg1.position_manager, arg2, v6);
            let v8 = if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg1.bin_manager, v6)) {
                *0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg1.bin_manager, v6)
            } else {
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_bin(0, 0, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::price_helper::get_price_from_id(v6, arg1.bin_step))
            };
            let v9 = v8;
            let v10 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_total_supply(&v9);
            0x1::vector::push_back<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin>(&mut v3, v9);
            let v11 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amount_out_of_bin(&v9, (v7 as u128), v10);
            let (v12, v13) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v11);
            assert!(v12 > 0 || v13 > 0, 2014);
            let (v14, v15) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_total_amounts(&v9);
            let (v16, v17) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_reserves(&v9);
            let (v18, v19) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fees(&v9);
            let (v20, v21, v22, v23) = calculate_proportional_amounts(v14, v15, v16, v17, v12, v13);
            let v24 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::update_bin_after_remove(&v9, v16 - v20, v17 - v21, v18 - v22, v19 - v23);
            update_bin_liquidity<T0, T1>(arg1, v6, v10 - (v7 as u128));
            let v25 = if (v10 == (v7 as u128)) {
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::remove_bin(&mut arg1.bin_manager, v6);
                true
            } else {
                false
            };
            let (_, _) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::collect_fees(&mut arg1.position_manager, arg2, v6, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_x(&v9), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_y(&v9));
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::decrease_liquidity(&mut arg1.position_manager, &mut arg1.bin_manager, arg2, v6, (v7 as u128), arg4);
            if (!v25) {
                *0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin_mut(&mut arg1.bin_manager, v6) = v24;
            };
            0x1::vector::push_back<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Bin>(&mut v4, v24);
            let v28 = &v0;
            v0 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::add_amounts(v28, &v11);
            0x1::vector::push_back<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts>(&mut v1, v11);
            0x1::vector::push_back<u128>(&mut v2, (v7 as u128));
            v5 = v5 + 1;
        };
        let (v29, v30) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v0);
        let v31 = RemoveLiquidityEvent{
            pair             : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position         : 0x2::object::id<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition>(arg2),
            ids              : arg3,
            tokens           : v0,
            token_bins       : v1,
            liquidity_burned : v2,
            bin_before       : v3,
            bin_after        : v4,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v31);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v29, arg5), 0x2::coin::take<T1>(&mut arg1.balance_y, v30, arg5))
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg0);
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

    public(friend) fun set_static_fee_parameters<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: &0x2::tx_context::TxContext) {
        set_static_fee_parameters_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun set_static_fee_parameters_internal<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: &0x2::tx_context::TxContext) {
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
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = arg0.bin_step;
        let v2 = arg0.parameters;
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::set_volatility_accumulator(&mut v2, arg7);
        assert!(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u64(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_base_fee(&v2, v1), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_variable_fee(&v2, v1)) <= 100000000, 2016);
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
            let v3 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::get_rewarders(&arg0.rewarder_manager);
            while (v2 < 0x1::vector::length<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::Rewarder>(v3)) {
                let v4 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_u128(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::get_emissions_per_second(0x1::vector::borrow<0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::Rewarder>(v3, v2)), (v1 as u128));
                if (v4 > 0) {
                    if (v2 >= 0x1::vector::length<u128>(&v0)) {
                        while (0x1::vector::length<u128>(&v0) <= v2) {
                            0x1::vector::push_back<u128>(&mut v0, 0);
                        };
                    };
                    let v5 = 0x1::vector::borrow_mut<u128>(&mut v0, v2);
                    *v5 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::add_u128(*v5, (v4 << 64) / arg0.global_reward_state.total_fees_ever);
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    fun update_bin<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u32, arg3: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts, arg4: &0x2::clock::Clock) : (u128, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::Amounts) {
        let v0 = if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, arg2)) {
            *0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg0.bin_manager, arg2)
        } else {
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_bin(0, 0, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::price_helper::get_price_from_id(arg2, arg0.bin_step))
        };
        let v1 = v0;
        let v2 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_cached_price(&v1);
        let v3 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_total_supply(&v1);
        let (v4, v5) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_shares_and_effective_amounts_in(&v1, arg3, v2, v3);
        let v6 = v5;
        let v7 = v4;
        if (v4 == 0) {
            return (0, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0))
        };
        let v8 = v6;
        let v9 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0);
        if (arg2 == arg1) {
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::update_volatility_parameters(&mut arg0.parameters, arg2, 0x2::clock::timestamp_ms(arg4) / 1000);
            let v10 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_composition_fees(&v1, &arg0.parameters, arg0.bin_step, &v6, v3, v4);
            let (v11, v12) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v10);
            if (v11 > 0 || v12 > 0) {
                v9 = v10;
                let v13 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::sub_amounts(&v6, &v10);
                let v14 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                let v15 = if (v14 > 0) {
                    0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::fee_helper::get_protocol_fee_amount(v11, (v14 as u64)), 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::fee_helper::get_protocol_fee_amount(v12, (v14 as u64)))
                } else {
                    0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::new_amounts(0, 0)
                };
                let v16 = v15;
                let (v17, v18) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v16);
                if (v17 > 0 || v18 > 0) {
                    let v19 = &v8;
                    v8 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::sub_amounts(v19, &v16);
                    assert!(arg0.protocol_fee_x <= 18446744073709551615 - v17, 2024);
                    assert!(arg0.protocol_fee_y <= 18446744073709551615 - v18, 2024);
                    arg0.protocol_fee_x = arg0.protocol_fee_x + v17;
                    arg0.protocol_fee_y = arg0.protocol_fee_y + v18;
                };
                update_bin_fee_growth<T0, T1>(arg0, arg2, v11 - v17, v12 - v18);
                v7 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::safe_math::mul_div_u128(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_liquidity_from_amounts(&v13, v2), v3, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_liquidity_from_reserves2(&v1, v2, &v10, &v16));
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, arg2, arg4);
                let v20 = CompositionFeesEvent{
                    id            : arg2,
                    total_fees    : v10,
                    protocol_fees : v16,
                };
                0x2::event::emit<CompositionFeesEvent>(v20);
            };
        } else {
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::verify_amounts(&v6, arg1, arg2);
        };
        assert!(v7 > 0, 2015);
        let (v21, v22) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v8);
        assert!(v21 > 0 || v22 > 0, 2015);
        let (v23, v24) = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_amounts_values(&v9);
        let v25 = if (v23 > 0) {
            v23 - 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::fee_helper::get_protocol_fee_amount(v23, (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_protocol_share(&arg0.parameters) as u64))
        } else {
            0
        };
        let v26 = if (v24 > 0) {
            v24 - 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::fee_helper::get_protocol_fee_amount(v24, (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::pair_parameter_helper::get_protocol_share(&arg0.parameters) as u64))
        } else {
            0
        };
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::add_to_reserves(&mut v1, v21, v22, v25, v26);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::add_or_update_bin(&mut arg0.bin_manager, arg2, v1);
        update_bin_liquidity<T0, T1>(arg0, arg2, v3 + v7);
        (v7, v6, v8, v9)
    }

    fun update_bin_fee_growth<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u64, arg3: u64) {
        if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, arg1)) {
            let v0 = *0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin(&arg0.bin_manager, arg1);
            let v1 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_total_supply(&v0);
            if (v1 == 0) {
                return
            };
            if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, arg1)) {
                let v2 = 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin_mut(&mut arg0.bin_manager, arg1);
                0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::set_fee_growth(v2, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_x(v2) + ((arg2 as u128) << 64) / v1, 0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_fee_growth_y(v2) + ((arg3 as u128) << 64) / v1);
                return
            };
            return
        };
    }

    fun update_bin_liquidity<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u128) {
        if (0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::contains(&arg0.bin_manager, arg1)) {
            0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::set_liquidity_info(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::bin_manager::get_bin_mut(&mut arg0.bin_manager, arg1), arg2);
            return
        };
    }

    public fun update_emission<T0, T1, T2>(arg0: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::RewarderAdminCap, arg1: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::GlobalConfig, arg2: &mut LBPair<T0, T1>, arg3: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::RewarderGlobalVault, arg4: u128, arg5: &0x2::clock::Clock) {
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::config::checked_package_version(arg1);
        assert!(!arg2.is_pause, 2033);
        accumulate_global_rewards<T0, T1>(arg2, arg5);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg2);
        0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::rewarder::update_emission<T2>(arg3, &mut arg2.rewarder_manager, v0, arg4);
        let v1 = RewarderEmissionUpdatedEvent{
            pool                 : v0,
            rewarder_type        : 0x1::type_name::get<T2>(),
            emissions_per_second : arg4,
        };
        0x2::event::emit<RewarderEmissionUpdatedEvent>(v1);
    }

    fun validate_remove_liquidity_inputs<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::LBPosition, arg2: &vector<u32>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(arg2)) {
            let v1 = *0x1::vector::borrow<u32>(arg2, v0);
            assert!(v1 <= 16777215, 2020);
            assert!(0xccbf8f677268fc459a9170c65c8916ae7a58bb870d2dd5284dc4330159465342::lb_position::position_token_amount(&arg0.position_manager, arg1, v1) > 0, 2013);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

