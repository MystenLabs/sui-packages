module 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_pair {
    struct Swap has copy, drop {
        sender: address,
        id: u32,
        swap_for_y: bool,
        amounts_in: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts,
        amounts_out: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts,
        volatility_accumulator: u32,
        total_fees: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts,
        protocol_fees: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts,
        current_bin_reserves: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves,
    }

    struct CollectedProtocolFees has copy, drop {
        fee_recipient: address,
        protocol_fees: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts,
    }

    struct OracleLengthIncreased has copy, drop {
        sender: address,
        new_length: u16,
    }

    struct ForcedDecay has copy, drop {
        sender: address,
        id_reference: u32,
        volatility_reference: u32,
    }

    struct StaticFeeParametersSet has copy, drop {
        sender: address,
        base_factor: u16,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct CompositionFees has copy, drop {
        sender: address,
        id: u32,
        total_fees: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts,
        protocol_fees: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts,
    }

    struct FeesStatistic has copy, drop {
        total_fee_x: u64,
        total_fee_y: u64,
        flashloan_fee_x: u64,
        flashloan_fee_y: u64,
        swap_fee_x: u64,
        swap_fee_y: u64,
        composition_fee_x: u64,
        composition_fee_y: u64,
    }

    struct FeesCollected has copy, drop {
        bucket_id: 0x2::object::ID,
        bin_ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
    }

    struct RewarderAdded has copy, drop {
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
    }

    struct RewarderEmissionUpdated has copy, drop {
        pool: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        emissions_per_second: u128,
    }

    struct RewardsCollected has copy, drop {
        pool: 0x2::object::ID,
        bucket_id: 0x2::object::ID,
        bin_ids: vector<u32>,
        reward_type: 0x1::type_name::TypeName,
        amounts: vector<u64>,
    }

    struct StaticFeeParametersQueried has copy, drop {
        base_factor: u16,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct VariableFeeParametersQueried has copy, drop {
        volatility_accumulator: u32,
        volatility_reference: u32,
        id_reference: u32,
        time_of_last_update: u64,
    }

    struct OracleParametersQueried has copy, drop {
        sample_lifetime: u8,
        size: u16,
        active_size: u16,
        last_updated: u64,
        first_timestamp: u64,
    }

    struct OracleSampleQueried has copy, drop {
        time: u64,
        cumulative_id: u64,
        cumulative_volatility: u64,
        cumulative_bin_crossed: u64,
    }

    struct PriceFromIdQueried has copy, drop {
        id: u32,
        price: u128,
    }

    struct IdFromPriceQueried has copy, drop {
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
        amounts: vector<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts>,
        tokens: vector<u128>,
        bin_reserves_after: vector<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves>,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        ids: vector<u32>,
        tokens: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts,
        token_bins: vector<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts>,
        liquidity_burned: vector<u128>,
        bin_reserves_before: vector<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves>,
        bin_reserves_after: vector<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves>,
    }

    struct LockPositionEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        lock_until: u64,
        owner: address,
    }

    struct MintArrays has drop {
        ids: vector<u32>,
        amounts: vector<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts>,
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

    struct LBPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        index: u64,
        is_pause: bool,
        bin_step: u16,
        parameters: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::PairParameters,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        bin_manager: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinManager,
        oracle: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::Oracle,
        position_manager: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPositionManager,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        global_fee_info: GlobalFeeInfo,
        rewarder_manager: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::RewarderManager,
    }

    public fun swap<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg3);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg4);
        let v1 = if (arg2) {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0x2::coin::value<T0>(&arg3), 0)
        } else {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0x2::coin::value<T1>(&arg4))
        };
        let v2 = v1;
        let (v3, v4) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v2);
        assert!(v3 > 0 || v4 > 0, 2005);
        let v5 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0);
        let v6 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_active_id(&arg1.parameters);
        let v7 = arg1.bin_step;
        let v8 = 0x2::clock::timestamp_ms(arg5) / 1000;
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::update_references(&mut arg1.parameters, v8);
        let v9 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::new_fee_tracking(arg6);
        let v10 = v6;
        let v11 = 0;
        let v12 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0);
        loop {
            assert!(v11 < 255, 2021);
            v11 = v11 + 1;
            let v13 = if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg1.bin_manager, v10)) {
                *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg1.bin_manager, v10)
            } else {
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_bin_reserves(0, 0, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::price_helper::get_price_from_id(v10, v7))
            };
            let v14 = v13;
            if (!0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::is_empty(&v14, !arg2)) {
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::update_volatility_accumulator(&mut arg1.parameters, v10);
                let (v15, v16, v17) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts(&v14, &arg1.parameters, v7, arg2, v10, &v2);
                let v18 = v17;
                let v19 = v16;
                let v20 = v15;
                let (v21, v22) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v20);
                if (v21 > 0 || v22 > 0) {
                    let v23 = &v2;
                    v2 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::sub_amounts(v23, &v20);
                    let v24 = &v5;
                    v5 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::add_amounts(v24, &v19);
                    let v25 = &v12;
                    v12 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::add_amounts(v25, &v18);
                    let v26 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_protocol_share(&arg1.parameters);
                    let (v27, v28) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v18);
                    let v29 = if (v26 > 0) {
                        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::fee_helper::get_protocol_fee_amount(v27, (v26 as u64)), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::fee_helper::get_protocol_fee_amount(v28, (v26 as u64)))
                    } else {
                        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0)
                    };
                    let v30 = v29;
                    let (v31, v32) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v30);
                    if (v31 > 0 || v32 > 0) {
                        assert!(arg1.protocol_fee_x <= 18446744073709551615 - v31, 2024);
                        assert!(arg1.protocol_fee_y <= 18446744073709551615 - v32, 2024);
                        arg1.protocol_fee_x = arg1.protocol_fee_x + v31;
                        arg1.protocol_fee_y = arg1.protocol_fee_y + v32;
                    };
                    let v33 = v27 - v31;
                    let v34 = v28 - v32;
                    0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::track_bin_fees(&mut v9, v10, v33, v34);
                    let v35 = *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin_mut(&mut arg1.bin_manager, v10);
                    let (v36, v37) = if (arg2) {
                        (v21 - v27, 0)
                    } else {
                        (0, v22 - v28)
                    };
                    let (v38, v39) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v19);
                    0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::update_to_reserves(&mut v35, v36, v38, v37, v39, v33, v34);
                    *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin_mut(&mut arg1.bin_manager, v10) = v35;
                    update_bin_fee_growth<T0, T1>(arg1, v10, v33, v34);
                    let v40 = Swap{
                        sender                 : 0x2::tx_context::sender(arg6),
                        id                     : v10,
                        swap_for_y             : arg2,
                        amounts_in             : v20,
                        amounts_out            : v19,
                        volatility_accumulator : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_volatility_accumulator(&arg1.parameters),
                        total_fees             : v18,
                        protocol_fees          : v30,
                        current_bin_reserves   : *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg1.bin_manager, v10),
                    };
                    0x2::event::emit<Swap>(v40);
                };
            };
            let (v41, v42) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v2);
            if (v41 == 0 && v42 == 0) {
                break
            };
            let v43 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_next_non_empty_bin(&arg1.bin_manager, arg2, v10);
            if (v43 == 0 || v43 == v6) {
                abort 2011
            };
            v10 = v43;
        };
        let (v44, v45) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v5);
        assert!(v44 > 0 || v45 > 0, 2006);
        if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::update(&mut arg1.oracle, &mut arg1.parameters, v10, arg5)) {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::set_active_id(&mut arg1.parameters, v10);
        };
        distribute_rewards_by_fees<T0, T1>(arg1, v9, v0, v8);
        let (v46, v47) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v12);
        arg1.global_fee_info.swap_fee_x = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg1.global_fee_info.swap_fee_x, v46);
        arg1.global_fee_info.swap_fee_y = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg1.global_fee_info.swap_fee_y, v47);
        arg1.global_fee_info.total_fee_x = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg1.global_fee_info.total_fee_x, v46);
        arg1.global_fee_info.total_fee_y = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg1.global_fee_info.total_fee_y, v47);
        let v48 = FeesStatistic{
            total_fee_x       : v46,
            total_fee_y       : v47,
            flashloan_fee_x   : 0,
            flashloan_fee_y   : 0,
            swap_fee_x        : v46,
            swap_fee_y        : v47,
            composition_fee_x : 0,
            composition_fee_y : 0,
        };
        0x2::event::emit<FeesStatistic>(v48);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v44, arg6), 0x2::coin::take<T1>(&mut arg1.balance_y, v45, arg6))
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u32, arg8: u16, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : LBPair<T0, T1> {
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
        let v1 = LBPair<T0, T1>{
            id               : 0x2::object::new(arg11),
            index            : arg0,
            is_pause         : false,
            bin_step         : arg2,
            parameters       : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::new(arg1),
            protocol_fee_x   : 0,
            protocol_fee_y   : 0,
            bin_manager      : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new(arg2, 0x2::clock::timestamp_ms(arg10), arg11),
            oracle           : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::new(),
            position_manager : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::new(arg11),
            balance_x        : 0x2::balance::zero<T0>(),
            balance_y        : 0x2::balance::zero<T1>(),
            global_fee_info  : v0,
            rewarder_manager : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::new(),
        };
        let v2 = &mut v1;
        set_static_fee_parameters_internal<T0, T1>(v2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
        v1
    }

    public fun get_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : (u64, u64) {
        assert!(arg1 <= 16777215, 2020);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin_reserves(&arg0.bin_manager, arg1)
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

    public fun add_liquidity<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::pair_id(arg2), 2030);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2002);
        settle_all_bins<T0, T1>(arg1, arg8);
        let v1 = create_liquidity_configs_from_params(&arg3, &arg4, &arg5);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg6);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg7);
        let v2 = MintArrays{
            ids              : 0x1::vector::empty<u32>(),
            amounts          : 0x1::vector::empty<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts>(),
            liquidity_minted : 0x1::vector::empty<u128>(),
        };
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = &mut v2;
        let v5 = &mut v3;
        let v6 = mint_bins<T0, T1>(arg1, arg2, &v1, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0x2::coin::value<T0>(&arg6), 0x2::coin::value<T1>(&arg7)), v4, v5, arg8, arg9);
        let (v7, v8) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v6);
        if (v7 > 0 || v8 > 0) {
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance_x, v7, arg9), v0);
            };
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v8, arg9), v0);
            };
        };
        let v9 = 0x1::vector::empty<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<u32>(&v2.ids)) {
            0x1::vector::push_back<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves>(&mut v9, *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg1.bin_manager, *0x1::vector::borrow<u32>(&v2.ids, v10)));
            v10 = v10 + 1;
        };
        let v11 = AddLiquidityEvent{
            pair               : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position           : 0x2::object::id<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition>(arg2),
            ids                : v2.ids,
            amounts            : v2.amounts,
            tokens             : v2.liquidity_minted,
            bin_reserves_after : v9,
        };
        0x2::event::emit<AddLiquidityEvent>(v11);
    }

    public fun add_rewarder<T0, T1, T2>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::RewarderAdminCap, arg2: &mut LBPair<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg2);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::add_rewarder<T2>(&mut arg2.rewarder_manager, v0);
        let v1 = RewarderAdded{
            pool          : v0,
            rewarder_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<RewarderAdded>(v1);
    }

    fun calculate_flash_loan_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::div_round_up_u64(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u64(arg0, arg1), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::constants::precision())
    }

    public fun close_position<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition, arg3: &mut 0x2::tx_context::TxContext) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        assert!(v0 == 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::pair_id(&arg2), 2030);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::close_position(&mut arg1.position_manager, arg2);
        let v1 = ClosePositionEvent{
            pair     : v0,
            position : 0x2::object::id<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition>(&arg2),
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClosePositionEvent>(v1);
    }

    public fun collect_position_fees<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition, arg3: vector<u32>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::pair_id(arg2), 2030);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2028);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u32>(&arg3)) {
            let v5 = *0x1::vector::borrow<u32>(&arg3, v4);
            let v6 = 0;
            let v7 = 0;
            if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg1.bin_manager, v5)) {
                let v8 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg1.bin_manager, v5);
                v6 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_fee_growth_x(v8);
                v7 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_fee_growth_y(v8);
            };
            let (_, _) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::collect_fees(&mut arg1.position_manager, arg2, v5, v6, v7);
            let (v11, v12) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::withdraw_fees(&mut arg1.position_manager, arg2, v5);
            v0 = v0 + v11;
            v1 = v1 + v12;
            0x1::vector::push_back<u64>(&mut v2, v11);
            0x1::vector::push_back<u64>(&mut v3, v12);
            v4 = v4 + 1;
        };
        let v13 = if (v0 > 0) {
            0x2::coin::take<T0>(&mut arg1.balance_x, v0, arg4)
        } else {
            0x2::coin::zero<T0>(arg4)
        };
        let v14 = if (v1 > 0) {
            0x2::coin::take<T1>(&mut arg1.balance_y, v1, arg4)
        } else {
            0x2::coin::zero<T1>(arg4)
        };
        let v15 = FeesCollected{
            bucket_id : 0x2::object::id<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition>(arg2),
            bin_ids   : arg3,
            amounts_x : v2,
            amounts_y : v3,
        };
        0x2::event::emit<FeesCollected>(v15);
        (v13, v14)
    }

    public fun collect_position_rewards<T0, T1, T2>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition, arg3: &mut 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::RewarderGlobalVault, arg4: vector<u32>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::pair_id(arg2), 2030);
        assert!(0x1::vector::length<u32>(&arg4) > 0, 2028);
        settle_all_bins<T0, T1>(arg1, arg5);
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg4)) {
            let v3 = *0x1::vector::borrow<u32>(&arg4, v2);
            let v4 = 0x1::vector::empty<u128>();
            if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg1.bin_manager, v3)) {
                v4 = *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_rewards_growth(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg1.bin_manager, v3));
            } else {
                let v5 = 0;
                while (v5 < 0x1::vector::length<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::Rewarder>(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::get_rewarders(&arg1.rewarder_manager))) {
                    0x1::vector::push_back<u128>(&mut v4, 0);
                    v5 = v5 + 1;
                };
            };
            let v6 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::collect_and_withdraw_rewards<T2>(&mut arg1.position_manager, arg2, v3, &v4, &arg1.rewarder_manager);
            v0 = v0 + v6;
            0x1::vector::push_back<u64>(&mut v1, v6);
            v2 = v2 + 1;
        };
        let v7 = if (v0 > 0) {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::withdraw_reward<T2>(arg3, v0)
        } else {
            0x2::balance::zero<T2>()
        };
        let v8 = RewardsCollected{
            pool        : 0x2::object::id<LBPair<T0, T1>>(arg1),
            bucket_id   : 0x2::object::id<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition>(arg2),
            bin_ids     : arg4,
            reward_type : 0x1::type_name::get<T2>(),
            amounts     : v1,
        };
        0x2::event::emit<RewardsCollected>(v8);
        v7
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg2));
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
        let v6 = CollectedProtocolFees{
            fee_recipient : 0x2::tx_context::sender(arg2),
            protocol_fees : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(v2, v3),
        };
        0x2::event::emit<CollectedProtocolFees>(v6);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v2, arg2), 0x2::coin::take<T1>(&mut arg1.balance_y, v3, arg2))
    }

    fun create_liquidity_configs_from_params(arg0: &vector<u32>, arg1: &vector<u64>, arg2: &vector<u64>) : vector<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::liquidity_configurations::LiquidityConfig> {
        let v0 = 0x1::vector::length<u32>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 2007);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 2007);
        let v1 = 0x1::vector::empty<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::liquidity_configurations::LiquidityConfig>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::liquidity_configurations::LiquidityConfig>(&mut v1, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::liquidity_configurations::new_config(*0x1::vector::borrow<u64>(arg1, v2), *0x1::vector::borrow<u64>(arg2, v2), *0x1::vector::borrow<u32>(arg0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    fun distribute_rewards_by_fees<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::FeeTracking, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::calculate_reward_distributions(&mut arg0.rewarder_manager, arg1, arg2, arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::RewardDistribution>(&v0)) {
            let (v2, v3, v4) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::get_distribution_info(0x1::vector::borrow<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::RewardDistribution>(&v0, v1));
            update_single_bin_reward_growth<T0, T1>(arg0, v2, v3, v4);
            v1 = v1 + 1;
        };
    }

    public fun flash_loan<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        flash_loan_internal<T0, T1>(arg1, arg2, arg3, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::flash_loan_fee_rate(arg0))
    }

    fun flash_loan_internal<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: bool, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        if (arg1) {
            assert!(0x2::balance::value<T0>(&arg0.balance_x) >= arg2, 2005);
        } else {
            assert!(0x2::balance::value<T1>(&arg0.balance_y) >= arg2, 2005);
        };
        let v0 = calculate_flash_loan_fee(arg2, arg3);
        update_flash_loan_fee<T0, T1>(arg0, v0, arg1);
        let v1 = FlashLoanReceipt{
            pool_id    : 0x2::object::id<LBPair<T0, T1>>(arg0),
            loan_x     : arg1,
            amount     : arg2,
            fee_amount : v0,
        };
        if (arg1) {
            arg0.global_fee_info.flashloan_fee_x = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg0.global_fee_info.flashloan_fee_x, v0);
            arg0.global_fee_info.total_fee_x = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg0.global_fee_info.total_fee_x, v0);
        } else {
            arg0.global_fee_info.flashloan_fee_y = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg0.global_fee_info.flashloan_fee_y, v0);
            arg0.global_fee_info.total_fee_y = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg0.global_fee_info.total_fee_y, v0);
        };
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
        let v6 = FeesStatistic{
            total_fee_x       : v2,
            total_fee_y       : v3,
            flashloan_fee_x   : v4,
            flashloan_fee_y   : v5,
            swap_fee_x        : 0,
            swap_fee_y        : 0,
            composition_fee_x : 0,
            composition_fee_y : 0,
        };
        0x2::event::emit<FeesStatistic>(v6);
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
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::update_volatility_reference(&mut arg0.parameters);
        let v0 = ForcedDecay{
            sender               : 0x2::tx_context::sender(arg1),
            id_reference         : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_id_reference(&arg0.parameters),
            volatility_reference : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_volatility_reference(&arg0.parameters),
        };
        0x2::event::emit<ForcedDecay>(v0);
    }

    public fun get_active_id<T0, T1>(arg0: &LBPair<T0, T1>) : u32 {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_active_id(&arg0.parameters)
    }

    public fun get_bin_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinManager {
        &arg0.bin_manager
    }

    public fun get_bin_step<T0, T1>(arg0: &LBPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun get_id_from_price<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u128) : u32 {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::price_helper::get_id_from_price(arg1, arg0.bin_step);
        let v1 = IdFromPriceQueried{
            price : arg1,
            id    : v0,
        };
        0x2::event::emit<IdFromPriceQueried>(v1);
        v0
    }

    public fun get_oracle_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u8, u16, u16, u64, u64) {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let (v1, v2, v3, v4, v5) = if (v0 == 0) {
            (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::get_max_sample_lifetime(), 0, 0, 0, 0)
        } else {
            let (v6, v7) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::get_active_sample_and_size(&arg0.oracle, v0);
            let v8 = v6;
            let v9 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::get_sample_last_update(&v8);
            let v10 = if (v9 == 0) {
                0
            } else {
                v7
            };
            let v11 = if (v10 > 0) {
                let v12 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::get_sample(&arg0.oracle, 1 + v0 % v10);
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::get_sample_last_update(&v12)
            } else {
                0
            };
            (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::get_max_sample_lifetime(), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::get_oracle_length(&v8), v10, v9, v11)
        };
        let v13 = OracleParametersQueried{
            sample_lifetime : v1,
            size            : v2,
            active_size     : v3,
            last_updated    : v4,
            first_timestamp : v5,
        };
        0x2::event::emit<OracleParametersQueried>(v13);
        (v1, v2, v3, v4, v5)
    }

    public fun get_oracle_sample_at<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        if (v0 == 0 || arg1 > 0x2::clock::timestamp_ms(arg2) / 1000) {
            let v1 = OracleSampleQueried{
                time                   : 0,
                cumulative_id          : 0,
                cumulative_volatility  : 0,
                cumulative_bin_crossed : 0,
            };
            0x2::event::emit<OracleSampleQueried>(v1);
            return (0, 0, 0)
        };
        let (v2, v3, v4, v5) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::get_sample_at(&arg0.oracle, v0, arg1);
        let v6 = v4;
        let v7 = v3;
        if (v2 < arg1) {
            let v8 = arg1 - v2;
            v7 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(v3, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u64((0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_active_id(&arg0.parameters) as u64), v8));
            v6 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(v4, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u64((0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters) as u64), v8));
        };
        let v9 = OracleSampleQueried{
            time                   : v2,
            cumulative_id          : v7,
            cumulative_volatility  : v6,
            cumulative_bin_crossed : v5,
        };
        0x2::event::emit<OracleSampleQueried>(v9);
        (v7, v6, v5)
    }

    public fun get_pending_rewards<T0, T1, T2>(arg0: &LBPair<T0, T1>, arg1: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition, arg2: vector<u32>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg2)) {
            let v2 = *0x1::vector::borrow<u32>(&arg2, v1);
            let v3 = 0x1::vector::empty<u128>();
            if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg0.bin_manager, v2)) {
                v3 = *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_rewards_growth(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg0.bin_manager, v2));
            } else {
                let v4 = 0;
                while (v4 < 0x1::vector::length<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::Rewarder>(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::get_rewarders(&arg0.rewarder_manager))) {
                    0x1::vector::push_back<u128>(&mut v3, 0);
                    v4 = v4 + 1;
                };
            };
            0x1::vector::push_back<u64>(&mut v0, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::calculate_pending_rewards<T2>(&arg0.position_manager, arg1, v2, &v3, &arg0.rewarder_manager));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_position_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPositionManager {
        &arg0.position_manager
    }

    public fun get_price_from_id<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : u128 {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::price_helper::get_price_from_id(arg1, arg0.bin_step);
        let v1 = PriceFromIdQueried{
            id    : arg1,
            price : v0,
        };
        0x2::event::emit<PriceFromIdQueried>(v1);
        v0
    }

    public fun get_protocol_fees<T0, T1>(arg0: &LBPair<T0, T1>) : (u64, u64) {
        (arg0.protocol_fee_x, arg0.protocol_fee_y)
    }

    public fun get_static_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u16, u16, u16, u16, u32, u16, u32) {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_base_factor(&arg0.parameters);
        let v1 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_filter_period(&arg0.parameters);
        let v2 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_decay_period(&arg0.parameters);
        let v3 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_reduction_factor(&arg0.parameters);
        let v4 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_variable_fee_control(&arg0.parameters);
        let v5 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_protocol_share(&arg0.parameters);
        let v6 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_max_volatility_accumulator(&arg0.parameters);
        let v7 = StaticFeeParametersQueried{
            base_factor                : v0,
            filter_period              : v1,
            decay_period               : v2,
            reduction_factor           : v3,
            variable_fee_control       : v4,
            protocol_share             : v5,
            max_volatility_accumulator : v6,
        };
        0x2::event::emit<StaticFeeParametersQueried>(v7);
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun get_swap_in<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = arg0.parameters;
        let v4 = arg0.bin_step;
        let v5 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_active_id(&v3);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::update_references(&mut v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg0.bin_manager, v6)) {
                let (v9, v10) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin_reserves(&arg0.bin_manager, v6);
                if (arg2) {
                    v10
                } else {
                    v9
                }
            } else {
                0
            };
            if (v8 > 0) {
                let v11 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg0.bin_manager, v6);
                let v12 = if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_cached_price(v11) > 0) {
                    0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_cached_price(v11)
                } else {
                    0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::price_helper::get_price_from_id(v6, v4)
                };
                let v13 = if (v8 > v0) {
                    v0
                } else {
                    v8
                };
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::update_volatility_accumulator(&mut v3, v6);
                let v14 = if (arg2) {
                    0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::q64x64::get_integer(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::q64x64::div(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::q64x64::from_integer(v13), v12))
                } else {
                    0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::q64x64::get_integer(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::q64x64::mul(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::q64x64::from_integer(v13), v12))
                };
                let v15 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::fee_helper::get_fee_amount(v14, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_total_fee(&v3, v4));
                v1 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(v1, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(v14, v15));
                v0 = v0 - v13;
                v2 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(v2, v15);
            };
            if (v0 == 0) {
                break
            };
            v6 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_next_non_empty_bin(&arg0.bin_manager, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        (v1, v0, v2)
    }

    public fun get_swap_out<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = if (arg2) {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(arg1, 0)
        } else {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, arg1)
        };
        let v1 = v0;
        let v2 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0);
        let v3 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0);
        let v4 = arg0.parameters;
        let v5 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_active_id(&v4);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::update_references(&mut v4, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg0.bin_manager, v6)) {
                let v8 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg0.bin_manager, v6);
                if (!0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::is_empty(v8, !arg2)) {
                    0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::update_volatility_accumulator(&mut v4, v6);
                    let (v9, v10, v11) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts(v8, &v4, arg0.bin_step, arg2, v6, &v1);
                    let v12 = v11;
                    let v13 = v10;
                    let v14 = v9;
                    let (v15, v16) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v14);
                    if (v15 > 0 || v16 > 0) {
                        let v17 = &v1;
                        v1 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::sub_amounts(v17, &v14);
                        let v18 = &v2;
                        v2 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::add_amounts(v18, &v13);
                        let v19 = &v3;
                        v3 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::add_amounts(v19, &v12);
                    };
                };
            };
            let (v20, v21) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v1);
            if (v20 == 0 && v21 == 0) {
                break
            };
            v6 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_next_non_empty_bin(&arg0.bin_manager, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        let (v22, v23) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v1);
        let (v24, v25) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v2);
        let (v26, v27) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v3);
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

    public fun get_variable_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u32, u32, u32, u64) {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters);
        let v1 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_volatility_reference(&arg0.parameters);
        let v2 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_id_reference(&arg0.parameters);
        let v3 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_time_of_last_update(&arg0.parameters);
        let v4 = VariableFeeParametersQueried{
            volatility_accumulator : v0,
            volatility_reference   : v1,
            id_reference           : v2,
            time_of_last_update    : v3,
        };
        0x2::event::emit<VariableFeeParametersQueried>(v4);
        (v0, v1, v2, v3)
    }

    public(friend) fun increase_oracle_length<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let v1 = v0;
        if (v0 == 0) {
            let v2 = 1;
            v1 = v2;
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::set_oracle_id(&mut arg0.parameters, v2);
        };
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::increase_length(&mut arg0.oracle, v1, arg1);
        let v3 = OracleLengthIncreased{
            sender     : 0x2::tx_context::sender(arg2),
            new_length : arg1,
        };
        0x2::event::emit<OracleLengthIncreased>(v3);
    }

    public fun lock_position<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::pair_id(arg2), 2030);
        assert!(arg3 > 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::get_lock_until(arg2) && arg3 > 0x2::clock::timestamp_ms(arg4), 2031);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::lock_position(arg2, arg3);
        let v0 = LockPositionEvent{
            pair       : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position   : 0x2::object::id<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition>(arg2),
            lock_until : arg3,
            owner      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LockPositionEvent>(v0);
    }

    fun mint_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition, arg2: &vector<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::liquidity_configurations::LiquidityConfig>, arg3: 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts, arg4: &mut MintArrays, arg5: &mut vector<0x2::object::ID>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts {
        let v0 = arg3;
        let v1 = 0;
        let v2 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_active_id(&arg0.parameters);
        let v3 = arg0.bin_step;
        let (v4, v5) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&arg3);
        let v6 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0);
        while (v1 < 0x1::vector::length<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::liquidity_configurations::LiquidityConfig>(arg2)) {
            let v7 = 0x1::vector::borrow<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::liquidity_configurations::LiquidityConfig>(arg2, v1);
            let v8 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::liquidity_configurations::get_id(v7);
            let (v9, v10) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::liquidity_configurations::apply_distribution(v7, v4, v5);
            let v11 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(v9, v10);
            let (v12, v13, v14, v15) = update_bin<T0, T1>(arg0, v3, v2, v8, &v11, arg6, 0x2::tx_context::sender(arg7));
            let v16 = v15;
            let v17 = v13;
            if (v12 > 0) {
                let v18 = &v0;
                v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::sub_amounts(v18, &v17);
                let v19 = &v6;
                v6 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::add_amounts(v19, &v16);
                0x1::vector::push_back<u32>(&mut arg4.ids, v8);
                0x1::vector::push_back<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts>(&mut arg4.amounts, v14);
                0x1::vector::push_back<u128>(&mut arg4.liquidity_minted, v12);
                let v20 = 0;
                let v21 = 0;
                if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg0.bin_manager, v8)) {
                    let v22 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg0.bin_manager, v8);
                    v20 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_fee_growth_x(v22);
                    v21 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_fee_growth_y(v22);
                };
                let v23 = 0x1::vector::empty<u128>();
                if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg0.bin_manager, v8)) {
                    v23 = *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_rewards_growth(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg0.bin_manager, v8));
                };
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::increase_liquidity(&mut arg0.position_manager, arg1, v8, (v12 as u128));
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::update_fee_info(&mut arg0.position_manager, arg1, v8, v20, v21);
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::update_reward_info(&mut arg0.position_manager, arg1, v8, &v23, &arg0.rewarder_manager);
            };
            v1 = v1 + 1;
        };
        let (v24, v25) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v6);
        if (v24 > 0 || v25 > 0) {
            arg0.global_fee_info.composition_fee_x = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg0.global_fee_info.composition_fee_x, v24);
            arg0.global_fee_info.composition_fee_y = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg0.global_fee_info.composition_fee_y, v25);
            arg0.global_fee_info.total_fee_x = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg0.global_fee_info.total_fee_x, v24);
            arg0.global_fee_info.total_fee_y = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg0.global_fee_info.total_fee_y, v25);
            let v26 = FeesStatistic{
                total_fee_x       : v24,
                total_fee_y       : v25,
                flashloan_fee_x   : 0,
                flashloan_fee_y   : 0,
                swap_fee_x        : 0,
                swap_fee_y        : 0,
                composition_fee_x : v24,
                composition_fee_y : v25,
            };
            0x2::event::emit<FeesStatistic>(v26);
        };
        v0
    }

    public fun open_position<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        let v1 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::open_position<T0, T1>(&mut arg1.position_manager, v0, arg2, arg3);
        let v2 = OpenPositionEvent{
            pair     : v0,
            position : 0x2::object::id<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition>(&v1),
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OpenPositionEvent>(v2);
        v1
    }

    public fun remove_liquidity<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition, arg3: vector<u32>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::pair_id(arg2), 2030);
        settle_all_bins<T0, T1>(arg1, arg4);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2007);
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0);
        let v1 = 0x1::vector::empty<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts>();
        let v2 = 0x1::vector::empty<u128>();
        let v3 = 0x1::vector::empty<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves>();
        let v4 = 0x1::vector::empty<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u32>(&arg3)) {
            let v6 = *0x1::vector::borrow<u32>(&arg3, v5);
            let v7 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::position_token_amount(&arg1.position_manager, arg2, v6);
            assert!(v7 > 0, 2013);
            assert!(v6 <= 16777215, 2020);
            let v8 = if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg1.bin_manager, v6)) {
                *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg1.bin_manager, v6)
            } else {
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_bin_reserves(0, 0, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::price_helper::get_price_from_id(v6, arg1.bin_step))
            };
            let v9 = v8;
            let v10 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::total_supply(&arg1.position_manager, v6);
            0x1::vector::push_back<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves>(&mut v3, v9);
            let v11 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amount_out_of_bin(&v9, v7, v10);
            let (v12, v13) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v11);
            assert!(v12 > 0 || v13 > 0, 2014);
            let (v14, v15) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_total_amounts(&v9);
            let (v16, v17) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_reserves(&v9);
            let (v18, v19) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_fees(&v9);
            let v20 = if (v14 > 0) {
                (v12 as u128) * (v16 as u128) / (v14 as u128)
            } else {
                0
            };
            let v21 = if (v15 > 0) {
                (v13 as u128) * (v17 as u128) / (v15 as u128)
            } else {
                0
            };
            let v22 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::update_bin_reserves_after_remove(&v9, v16 - (v20 as u64), v17 - (v21 as u64), v18 - v12 - (v20 as u64), v19 - v13 - (v21 as u64));
            update_bin_liquidity<T0, T1>(arg1, v6, v10 - v7);
            let v23 = if (v10 == v7) {
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::remove_bin(&mut arg1.bin_manager, v6);
                true
            } else {
                false
            };
            let (_, _) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::collect_fees(&mut arg1.position_manager, arg2, v6, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_fee_growth_x(&v9), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_fee_growth_y(&v9));
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::decrease_liquidity(&mut arg1.position_manager, arg2, v6, v7, arg4);
            if (!v23) {
                *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin_mut(&mut arg1.bin_manager, v6) = v22;
            };
            0x1::vector::push_back<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::BinReserves>(&mut v4, v22);
            let v26 = &v0;
            v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::add_amounts(v26, &v11);
            0x1::vector::push_back<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts>(&mut v1, v11);
            0x1::vector::push_back<u128>(&mut v2, v7);
            v5 = v5 + 1;
        };
        let (v27, v28) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v0);
        let v29 = RemoveLiquidityEvent{
            pair                : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position            : 0x2::object::id<0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::LBPosition>(arg2),
            ids                 : arg3,
            tokens              : v0,
            token_bins          : v1,
            liquidity_burned    : v2,
            bin_reserves_before : v3,
            bin_reserves_after  : v4,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v29);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v27, arg5), 0x2::coin::take<T1>(&mut arg1.balance_y, v28, arg5))
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
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

    public fun rewarder_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::RewarderManager {
        &arg0.rewarder_manager
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
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = arg0.bin_step;
        let v2 = arg0.parameters;
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::set_volatility_accumulator(&mut v2, arg7);
        assert!(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_base_fee(&v2, v1), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_variable_fee(&v2, v1)) <= 100000000, 2016);
        let v3 = StaticFeeParametersSet{
            sender                     : 0x2::tx_context::sender(arg8),
            base_factor                : arg1,
            filter_period              : arg2,
            decay_period               : arg3,
            reduction_factor           : arg4,
            variable_fee_control       : arg5,
            protocol_share             : arg6,
            max_volatility_accumulator : arg7,
        };
        0x2::event::emit<StaticFeeParametersSet>(v3);
    }

    fun settle_all_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x2::clock::Clock) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::settle_rewards(&mut arg0.rewarder_manager, 0x2::clock::timestamp_ms(arg1) / 1000);
    }

    fun update_bin<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: u32, arg3: u32, arg4: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts, arg5: &0x2::clock::Clock, arg6: address) : (u128, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::Amounts) {
        let v0 = if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg0.bin_manager, arg3)) {
            *0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin(&arg0.bin_manager, arg3)
        } else {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_bin_reserves(0, 0, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::price_helper::get_price_from_id(arg3, arg1))
        };
        let v1 = v0;
        let v2 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_cached_price(&v1);
        let v3 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::total_supply(&arg0.position_manager, arg3);
        let (v4, v5) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_shares_and_effective_amounts_in(&v1, arg4, v2, v3);
        let v6 = v5;
        let v7 = v4;
        if (v4 == 0) {
            return (0, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0))
        };
        let v8 = v6;
        let v9 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0);
        if (arg3 == arg2) {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::update_volatility_parameters(&mut arg0.parameters, arg3, 0x2::clock::timestamp_ms(arg5) / 1000);
            let v10 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_composition_fees(&v1, &arg0.parameters, arg1, &v6, v3, v4);
            let (v11, v12) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v10);
            if (v11 > 0 || v12 > 0) {
                v9 = v10;
                let v13 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::sub_amounts(&v6, &v10);
                let v14 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                let v15 = if (v14 > 0) {
                    0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::fee_helper::get_protocol_fee_amount(v11, (v14 as u64)), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::fee_helper::get_protocol_fee_amount(v12, (v14 as u64)))
                } else {
                    0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::new_amounts(0, 0)
                };
                let v16 = v15;
                let (v17, v18) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v16);
                if (v17 > 0 || v18 > 0) {
                    let v19 = &v8;
                    v8 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::sub_amounts(v19, &v16);
                    assert!(arg0.protocol_fee_x <= 18446744073709551615 - v17, 2024);
                    assert!(arg0.protocol_fee_y <= 18446744073709551615 - v18, 2024);
                    arg0.protocol_fee_x = arg0.protocol_fee_x + v17;
                    arg0.protocol_fee_y = arg0.protocol_fee_y + v18;
                };
                update_bin_fee_growth<T0, T1>(arg0, arg3, v11 - v17, v12 - v18);
                v7 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_div_u128(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_liquidity_from_amounts(&v13, v2), v3, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_liquidity_from_reserves2(&v1, v2, &v10, &v16));
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, arg3, arg5);
                let v20 = CompositionFees{
                    sender        : arg6,
                    id            : arg3,
                    total_fees    : v10,
                    protocol_fees : v16,
                };
                0x2::event::emit<CompositionFees>(v20);
            };
        } else {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::verify_amounts(&v6, arg2, arg3);
        };
        assert!(v7 > 0, 2015);
        let (v21, v22) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v8);
        assert!(v21 > 0 || v22 > 0, 2015);
        let (v23, v24) = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_amounts_values(&v9);
        let v25 = if (v23 > 0) {
            v23 - 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::fee_helper::get_protocol_fee_amount(v23, (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_protocol_share(&arg0.parameters) as u64))
        } else {
            0
        };
        let v26 = if (v24 > 0) {
            v24 - 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::fee_helper::get_protocol_fee_amount(v24, (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_protocol_share(&arg0.parameters) as u64))
        } else {
            0
        };
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::add_to_reserves(&mut v1, v21, v22, v25, v26);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::add_or_update_bin(&mut arg0.bin_manager, arg3, v1);
        update_bin_liquidity<T0, T1>(arg0, arg3, v3 + v7);
        (v7, v6, v8, v9)
    }

    fun update_bin_fee_growth<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u64, arg3: u64) {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::lb_position::total_supply(&arg0.position_manager, arg1);
        if (v0 == 0) {
            return
        };
        if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg0.bin_manager, arg1)) {
            let v1 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin_mut(&mut arg0.bin_manager, arg1);
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::set_fee_growth(v1, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_fee_growth_x(v1) + ((arg2 as u128) << 64) / v0, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_fee_growth_y(v1) + ((arg3 as u128) << 64) / v0);
            return
        };
    }

    fun update_bin_liquidity<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u128) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_active_id(&arg0.parameters);
        if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg0.bin_manager, arg1)) {
            0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::set_liquidity_info(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin_mut(&mut arg0.bin_manager, arg1), arg2, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::last_update_time(&arg0.rewarder_manager));
            return
        };
    }

    public fun update_emission<T0, T1, T2>(arg0: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::RewarderGlobalVault, arg3: &0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::RewarderAdminCap, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::update_emission<T2>(arg2, &mut arg1.rewarder_manager, v0, arg4, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v1 = RewarderEmissionUpdated{
            pool                 : v0,
            rewarder_type        : 0x1::type_name::get<T2>(),
            emissions_per_second : arg4,
        };
        0x2::event::emit<RewarderEmissionUpdated>(v1);
    }

    fun update_flash_loan_fee<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u64, arg2: bool) {
        assert!(arg1 > 0, 2013);
        if (arg2) {
            assert!(arg0.protocol_fee_x <= 18446744073709551615 - arg1, 2024);
            arg0.protocol_fee_x = arg0.protocol_fee_x + arg1;
        } else {
            assert!(arg0.protocol_fee_y <= 18446744073709551615 - arg1, 2024);
            arg0.protocol_fee_y = arg0.protocol_fee_y + arg1;
        };
    }

    fun update_single_bin_reward_growth<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u128, arg3: u64) {
        if (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::contains(&arg0.bin_manager, arg1)) {
            let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_bin_mut(&mut arg0.bin_manager, arg1);
            let v1 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_liquidity(v0);
            if (v1 > 0) {
                let v2 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::rewarder::calculate_reward_growth(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::u128_to_u64(arg2), v1);
                let v3 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::get_rewards_growth(v0);
                let v4 = 0x1::vector::empty<u128>();
                let v5 = 0;
                while (v5 < 0x1::vector::length<u128>(v3)) {
                    if (v5 == arg3) {
                        0x1::vector::push_back<u128>(&mut v4, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u128(*0x1::vector::borrow<u128>(v3, v5), v2));
                    } else {
                        0x1::vector::push_back<u128>(&mut v4, *0x1::vector::borrow<u128>(v3, v5));
                    };
                    v5 = v5 + 1;
                };
                while (0x1::vector::length<u128>(&v4) <= arg3) {
                    if (0x1::vector::length<u128>(&v4) == arg3) {
                        0x1::vector::push_back<u128>(&mut v4, v2);
                        continue
                    };
                    0x1::vector::push_back<u128>(&mut v4, 0);
                };
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bin_helper::set_rewards_growth(v0, v4);
            };
        };
    }

    // decompiled from Move bytecode v6
}

