module 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_pair {
    struct Swap has copy, drop {
        sender: address,
        id: u32,
        amounts_in: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
        amounts_out: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
        volatility_accumulator: u32,
        total_fees: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
        protocol_fees: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
        current_bin_reserves: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves,
    }

    struct CollectedProtocolFees has copy, drop {
        fee_recipient: address,
        protocol_fees: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
    }

    struct FlashLoan has copy, drop {
        sender: address,
        receiver: address,
        active_id: u32,
        amounts: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
        total_fees: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
        protocol_fees: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
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
        total_fees: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
        protocol_fees: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
    }

    struct FeesCharged has copy, drop {
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

    struct NextNonEmptyBinQueried has copy, drop {
        swap_for_y: bool,
        id: u32,
        next_id: u32,
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
        amounts: vector<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts>,
        tokens: vector<u128>,
        bin_reserves_after: vector<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        ids: vector<u32>,
        tokens: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts,
        token_bins: vector<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts>,
        liquidity_burned: vector<u128>,
        bin_reserves_before: vector<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>,
        bin_reserves_after: vector<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>,
    }

    struct MintArrays has drop {
        ids: vector<u32>,
        amounts: vector<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts>,
        liquidity_minted: vector<u128>,
    }

    struct FlashLoanReceipt {
        pool_id: 0x2::object::ID,
        loan_x: bool,
        amount: u64,
        fee_amount: u64,
    }

    struct BinFeeGrowth has copy, drop, store {
        fee_growth_x: u128,
        fee_growth_y: u128,
    }

    struct BinRewardGrowth has copy, drop, store {
        rewards_growth: vector<u128>,
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

    struct BinLiquidityInfo has copy, drop, store {
        liquidity: u128,
        last_update_time: u64,
    }

    struct LBPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        index: u64,
        is_pause: bool,
        bin_step: u16,
        parameters: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::PairParameters,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        bins: 0x2::table::Table<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>,
        tree: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::tree_math::TreeUint24,
        oracle: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::Oracle,
        position_manager: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPositionManager,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        bin_fee_growths: 0x2::table::Table<u32, BinFeeGrowth>,
        global_fee_info: GlobalFeeInfo,
        rewarder_manager: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::RewarderManager,
        bin_reward_growths: 0x2::table::Table<u32, BinRewardGrowth>,
        bin_liquidity_infos: 0x2::table::Table<u32, BinLiquidityInfo>,
        total_active_liquidity: u128,
    }

    public fun swap<T0, T1>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        settle_all_bins<T0, T1>(arg1, arg5);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg3);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg4);
        let v0 = if (arg2) {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0x2::coin::value<T0>(&arg3), 0)
        } else {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0x2::coin::value<T1>(&arg4))
        };
        let v1 = v0;
        let (v2, v3) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v1);
        assert!(v2 > 0 || v3 > 0, 2005);
        let v4 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0);
        let v5 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_active_id(&arg1.parameters);
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::update_references(&mut arg1.parameters, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v6 = v5;
        let v7 = 0;
        let v8 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0);
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v9 = if (0x2::table::contains<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg1.bins, v6)) {
                *0x2::table::borrow<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg1.bins, v6)
            } else {
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_bin_reserves(0, 0)
            };
            let v10 = v9;
            if (!0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::is_empty(&v10, !arg2)) {
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::update_volatility_accumulator(&mut arg1.parameters, v6);
                let (v11, v12, v13) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts(&v10, &arg1.parameters, arg1.bin_step, arg2, v6, &v1);
                let v14 = v13;
                let v15 = v12;
                let v16 = v11;
                let (v17, v18) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v16);
                if (v17 > 0 || v18 > 0) {
                    let v19 = &v1;
                    v1 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::sub_amounts(v19, &v16);
                    let v20 = &v4;
                    v4 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::add_amounts(v20, &v15);
                    let v21 = &v8;
                    v8 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::add_amounts(v21, &v14);
                    let v22 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_protocol_share(&arg1.parameters);
                    let (v23, v24) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v14);
                    let v25 = if (v22 > 0) {
                        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::fee_helper::get_protocol_fee_amount(v23, (v22 as u64)), 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::fee_helper::get_protocol_fee_amount(v24, (v22 as u64)))
                    } else {
                        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0)
                    };
                    let v26 = v25;
                    let (v27, v28) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v26);
                    if (v27 > 0 || v28 > 0) {
                        assert!(arg1.protocol_fee_x <= 18446744073709551615 - v27, 2024);
                        assert!(arg1.protocol_fee_y <= 18446744073709551615 - v28, 2024);
                        arg1.protocol_fee_x = arg1.protocol_fee_x + v27;
                        arg1.protocol_fee_y = arg1.protocol_fee_y + v28;
                    };
                    let v29 = v23 - v27;
                    let v30 = v24 - v28;
                    let v31 = *0x2::table::borrow_mut<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&mut arg1.bins, v6);
                    let (v32, v33) = if (arg2) {
                        (v17 - v23, 0)
                    } else {
                        (0, v18 - v24)
                    };
                    let (v34, v35) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v15);
                    *0x2::table::borrow_mut<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&mut arg1.bins, v6) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::create_from_reserves_with_arithmetic(&v31, v32, v34, v33, v35, v29, v30);
                    update_bin_fee_growth<T0, T1>(arg1, v6, v29, v30);
                    let v36 = Swap{
                        sender                 : 0x2::tx_context::sender(arg6),
                        id                     : v6,
                        amounts_in             : v16,
                        amounts_out            : v15,
                        volatility_accumulator : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_volatility_accumulator(&arg1.parameters),
                        total_fees             : v14,
                        protocol_fees          : v26,
                        current_bin_reserves   : *0x2::table::borrow<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg1.bins, v6),
                    };
                    0x2::event::emit<Swap>(v36);
                };
            };
            let (v37, v38) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v1);
            if (v37 == 0 && v38 == 0) {
                break
            };
            let v39 = get_next_non_empty_bin<T0, T1>(arg1, arg2, v6);
            if (v39 == 0 || v39 == v5) {
                abort 2011
            };
            v6 = v39;
        };
        let (v40, v41) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v4);
        assert!(v40 > 0 || v41 > 0, 2006);
        if (0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::update(&mut arg1.oracle, &mut arg1.parameters, v6, arg5)) {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::set_active_id(&mut arg1.parameters, v6);
        };
        let (v42, v43) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v8);
        arg1.global_fee_info.swap_fee_x = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg1.global_fee_info.swap_fee_x, v42);
        arg1.global_fee_info.swap_fee_y = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg1.global_fee_info.swap_fee_y, v43);
        arg1.global_fee_info.total_fee_x = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg1.global_fee_info.total_fee_x, v42);
        arg1.global_fee_info.total_fee_y = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg1.global_fee_info.total_fee_y, v43);
        let v44 = FeesCharged{
            total_fee_x       : v42,
            total_fee_y       : v43,
            flashloan_fee_x   : 0,
            flashloan_fee_y   : 0,
            swap_fee_x        : v42,
            swap_fee_y        : v43,
            composition_fee_x : 0,
            composition_fee_y : 0,
        };
        0x2::event::emit<FeesCharged>(v44);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v40, arg6), 0x2::coin::take<T1>(&mut arg1.balance_y, v41, arg6))
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u32, arg8: u16, arg9: u32, arg10: &mut 0x2::tx_context::TxContext) : LBPair<T0, T1> {
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
            id                     : 0x2::object::new(arg10),
            index                  : arg0,
            is_pause               : false,
            bin_step               : arg2,
            parameters             : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::new(arg1),
            protocol_fee_x         : 0,
            protocol_fee_y         : 0,
            bins                   : 0x2::table::new<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(arg10),
            tree                   : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::tree_math::empty(arg10),
            oracle                 : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::new(),
            position_manager       : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::new(arg10),
            balance_x              : 0x2::balance::zero<T0>(),
            balance_y              : 0x2::balance::zero<T1>(),
            bin_fee_growths        : 0x2::table::new<u32, BinFeeGrowth>(arg10),
            global_fee_info        : v0,
            rewarder_manager       : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::new(),
            bin_reward_growths     : 0x2::table::new<u32, BinRewardGrowth>(arg10),
            bin_liquidity_infos    : 0x2::table::new<u32, BinLiquidityInfo>(arg10),
            total_active_liquidity : 0,
        };
        let v2 = &mut v1;
        set_static_fee_parameters_internal<T0, T1>(v2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        v1
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

    public fun add_liquidity<T0, T1>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::pair_id(arg2), 2030);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2002);
        settle_all_bins<T0, T1>(arg1, arg8);
        let v1 = create_liquidity_configs_from_params(&arg3, &arg4, &arg5);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg6);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg7);
        let v2 = MintArrays{
            ids              : 0x1::vector::empty<u32>(),
            amounts          : 0x1::vector::empty<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts>(),
            liquidity_minted : 0x1::vector::empty<u128>(),
        };
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = &mut v2;
        let v5 = &mut v3;
        let v6 = mint_bins<T0, T1>(arg1, arg2, &v1, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0x2::coin::value<T0>(&arg6), 0x2::coin::value<T1>(&arg7)), v4, v5, arg8, arg9);
        let (v7, v8) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v6);
        if (v7 > 0 || v8 > 0) {
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance_x, v7, arg9), v0);
            };
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v8, arg9), v0);
            };
        };
        let v9 = 0x1::vector::empty<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<u32>(&v2.ids)) {
            0x1::vector::push_back<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&mut v9, *0x2::table::borrow<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg1.bins, *0x1::vector::borrow<u32>(&v2.ids, v10)));
            v10 = v10 + 1;
        };
        let v11 = AddLiquidityEvent{
            pair               : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position           : 0x2::object::id<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition>(arg2),
            ids                : v2.ids,
            amounts            : v2.amounts,
            tokens             : v2.liquidity_minted,
            bin_reserves_after : v9,
        };
        0x2::event::emit<AddLiquidityEvent>(v11);
    }

    public fun add_rewarder<T0, T1, T2>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::RewarderAdminCap, arg2: &mut LBPair<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg2);
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::add_rewarder<T2>(&mut arg2.rewarder_manager, v0);
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
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::div_round_up_u64(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::mul_u64(arg0, arg1), 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::constants::precision())
    }

    public fun close_position<T0, T1>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition, arg3: &mut 0x2::tx_context::TxContext) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        assert!(v0 == 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::pair_id(&arg2), 2030);
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::close_position(&mut arg1.position_manager, arg2);
        let v1 = ClosePositionEvent{
            pair     : v0,
            position : 0x2::object::id<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition>(&arg2),
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClosePositionEvent>(v1);
    }

    public fun collect_position_fees<T0, T1>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition, arg3: vector<u32>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::pair_id(arg2), 2030);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2028);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u32>(&arg3)) {
            let v5 = *0x1::vector::borrow<u32>(&arg3, v4);
            let v6 = if (0x2::table::contains<u32, BinFeeGrowth>(&arg1.bin_fee_growths, v5)) {
                *0x2::table::borrow<u32, BinFeeGrowth>(&arg1.bin_fee_growths, v5)
            } else {
                BinFeeGrowth{fee_growth_x: 0, fee_growth_y: 0}
            };
            let v7 = v6;
            let (_, _) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::collect_fees(&mut arg1.position_manager, arg2, v5, v7.fee_growth_x, v7.fee_growth_y);
            let (v10, v11) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::withdraw_fees(&mut arg1.position_manager, arg2, v5);
            v0 = v0 + v10;
            v1 = v1 + v11;
            0x1::vector::push_back<u64>(&mut v2, v10);
            0x1::vector::push_back<u64>(&mut v3, v11);
            v4 = v4 + 1;
        };
        let v12 = if (v0 > 0) {
            0x2::coin::take<T0>(&mut arg1.balance_x, v0, arg4)
        } else {
            0x2::coin::zero<T0>(arg4)
        };
        let v13 = if (v1 > 0) {
            0x2::coin::take<T1>(&mut arg1.balance_y, v1, arg4)
        } else {
            0x2::coin::zero<T1>(arg4)
        };
        let v14 = FeesCollected{
            bucket_id : 0x2::object::id<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition>(arg2),
            bin_ids   : arg3,
            amounts_x : v2,
            amounts_y : v3,
        };
        0x2::event::emit<FeesCollected>(v14);
        (v12, v13)
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg2));
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
            protocol_fees : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(v2, v3),
        };
        0x2::event::emit<CollectedProtocolFees>(v6);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v2, arg2), 0x2::coin::take<T1>(&mut arg1.balance_y, v3, arg2))
    }

    fun create_liquidity_configs_from_params(arg0: &vector<u32>, arg1: &vector<u64>, arg2: &vector<u64>) : vector<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::liquidity_configurations::LiquidityConfig> {
        let v0 = 0x1::vector::length<u32>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 2007);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 2007);
        let v1 = 0x1::vector::empty<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::liquidity_configurations::LiquidityConfig>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::liquidity_configurations::LiquidityConfig>(&mut v1, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::liquidity_configurations::new_config(*0x1::vector::borrow<u64>(arg1, v2), *0x1::vector::borrow<u64>(arg2, v2), *0x1::vector::borrow<u32>(arg0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun flash_loan<T0, T1>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        flash_loan_internal<T0, T1>(arg1, arg2, arg3, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::flash_loan_fee_rate(arg0))
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
            arg0.global_fee_info.flashloan_fee_x = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg0.global_fee_info.flashloan_fee_x, v0);
            arg0.global_fee_info.total_fee_x = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg0.global_fee_info.total_fee_x, v0);
        } else {
            arg0.global_fee_info.flashloan_fee_y = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg0.global_fee_info.flashloan_fee_y, v0);
            arg0.global_fee_info.total_fee_y = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg0.global_fee_info.total_fee_y, v0);
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
        let v6 = FeesCharged{
            total_fee_x       : v2,
            total_fee_y       : v3,
            flashloan_fee_x   : v4,
            flashloan_fee_y   : v5,
            swap_fee_x        : 0,
            swap_fee_y        : 0,
            composition_fee_x : 0,
            composition_fee_y : 0,
        };
        0x2::event::emit<FeesCharged>(v6);
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
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::update_volatility_reference(&mut arg0.parameters);
        let v0 = ForcedDecay{
            sender               : 0x2::tx_context::sender(arg1),
            id_reference         : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_id_reference(&arg0.parameters),
            volatility_reference : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_volatility_reference(&arg0.parameters),
        };
        0x2::event::emit<ForcedDecay>(v0);
    }

    public fun get_active_id<T0, T1>(arg0: &LBPair<T0, T1>) : u32 {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_active_id(&arg0.parameters)
    }

    public fun get_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : (u64, u64) {
        assert!(arg1 <= 16777215, 2020);
        if (0x2::table::contains<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg0.bins, arg1)) {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_total_amounts(0x2::table::borrow<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg0.bins, arg1))
        } else {
            (0, 0)
        }
    }

    public fun get_bin_step<T0, T1>(arg0: &LBPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun get_id_from_price<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u128) : u32 {
        let v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::price_helper::get_id_from_price(arg1, arg0.bin_step);
        let v1 = IdFromPriceQueried{
            price : arg1,
            id    : v0,
        };
        0x2::event::emit<IdFromPriceQueried>(v1);
        v0
    }

    public fun get_next_non_empty_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: bool, arg2: u32) : u32 {
        let v0 = if (arg1) {
            let v1 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::tree_math::find_first_right(&arg0.tree, arg2);
            if (v1 == 16777215) {
                0
            } else {
                v1
            }
        } else {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::tree_math::find_first_left(&arg0.tree, arg2)
        };
        let v2 = NextNonEmptyBinQueried{
            swap_for_y : arg1,
            id         : arg2,
            next_id    : v0,
        };
        0x2::event::emit<NextNonEmptyBinQueried>(v2);
        v0
    }

    public fun get_oracle_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u8, u16, u16, u64, u64) {
        let v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let (v1, v2, v3, v4, v5) = if (v0 == 0) {
            (0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::get_max_sample_lifetime(), 0, 0, 0, 0)
        } else {
            let (v6, v7) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::get_active_sample_and_size(&arg0.oracle, v0);
            let v8 = v6;
            let v9 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::get_sample_last_update(&v8);
            let v10 = if (v9 == 0) {
                0
            } else {
                v7
            };
            let v11 = if (v10 > 0) {
                let v12 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::get_sample(&arg0.oracle, 1 + v0 % v10);
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::get_sample_last_update(&v12)
            } else {
                0
            };
            (0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::get_max_sample_lifetime(), 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::get_oracle_length(&v8), v10, v9, v11)
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
        let v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_oracle_id(&arg0.parameters);
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
        let (v2, v3, v4, v5) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::get_sample_at(&arg0.oracle, v0, arg1);
        let v6 = v4;
        let v7 = v3;
        if (v2 < arg1) {
            let v8 = arg1 - v2;
            v7 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(v3, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::mul_u64((0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_active_id(&arg0.parameters) as u64), v8));
            v6 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(v4, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::mul_u64((0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters) as u64), v8));
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

    public fun get_price_from_id<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : u128 {
        let v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::price_helper::get_price_from_id(arg1, arg0.bin_step);
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
        let v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_base_factor(&arg0.parameters);
        let v1 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_filter_period(&arg0.parameters);
        let v2 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_decay_period(&arg0.parameters);
        let v3 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_reduction_factor(&arg0.parameters);
        let v4 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_variable_fee_control(&arg0.parameters);
        let v5 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_protocol_share(&arg0.parameters);
        let v6 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_max_volatility_accumulator(&arg0.parameters);
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
        let v5 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_active_id(&v3);
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::update_references(&mut v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = if (0x2::table::contains<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg0.bins, v6)) {
                *0x2::table::borrow<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg0.bins, v6)
            } else {
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_bin_reserves(0, 0)
            };
            let v9 = v8;
            let v10 = if (arg2) {
                let (_, v12) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_reserves(&v9);
                v12
            } else {
                let (v13, _) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_reserves(&v9);
                v13
            };
            if (v10 > 0) {
                let v15 = if (v10 > v0) {
                    v0
                } else {
                    v10
                };
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::update_volatility_accumulator(&mut v3, v6);
                let v16 = if (arg2) {
                    0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::q40x88::get_integer(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::q40x88::div(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::q40x88::from_integer(v15), 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::price_helper::get_price_from_id(v6, v4)))
                } else {
                    0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::q40x88::get_integer(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::q40x88::mul(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::q40x88::from_integer(v15), 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::price_helper::get_price_from_id(v6, v4)))
                };
                let v17 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::fee_helper::get_fee_amount(v16, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_total_fee(&v3, v4));
                v1 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(v1, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(v16, v17));
                v0 = v0 - v15;
                v2 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(v2, v17);
            };
            if (v0 == 0) {
                break
            };
            v6 = get_next_non_empty_bin<T0, T1>(arg0, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        (v1, v0, v2)
    }

    public fun get_swap_out<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = if (arg2) {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(arg1, 0)
        } else {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, arg1)
        };
        let v1 = v0;
        let v2 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0);
        let v3 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0);
        let v4 = arg0.parameters;
        let v5 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_active_id(&v4);
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::update_references(&mut v4, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = if (0x2::table::contains<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg0.bins, v6)) {
                *0x2::table::borrow<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg0.bins, v6)
            } else {
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_bin_reserves(0, 0)
            };
            let v9 = v8;
            if (!0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::is_empty(&v9, !arg2)) {
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::update_volatility_accumulator(&mut v4, v6);
                let (v10, v11, v12) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts(&v9, &v4, arg0.bin_step, arg2, v6, &v1);
                let v13 = v12;
                let v14 = v11;
                let v15 = v10;
                let (v16, v17) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v15);
                if (v16 > 0 || v17 > 0) {
                    let v18 = &v1;
                    v1 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::sub_amounts(v18, &v15);
                    let v19 = &v2;
                    v2 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::add_amounts(v19, &v14);
                    let v20 = &v3;
                    v3 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::add_amounts(v20, &v13);
                };
            };
            let (v21, v22) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v1);
            if (v21 == 0 && v22 == 0) {
                break
            };
            v6 = get_next_non_empty_bin<T0, T1>(arg0, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        let (v23, v24) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v1);
        let (v25, v26) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v2);
        let (v27, v28) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v3);
        let v29 = if (arg2) {
            v23
        } else {
            v24
        };
        let v30 = if (arg2) {
            v26
        } else {
            v25
        };
        let v31 = if (arg2) {
            v27
        } else {
            v28
        };
        (v29, v30, v31)
    }

    public fun get_variable_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u32, u32, u32, u64) {
        let v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters);
        let v1 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_volatility_reference(&arg0.parameters);
        let v2 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_id_reference(&arg0.parameters);
        let v3 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_time_of_last_update(&arg0.parameters);
        let v4 = VariableFeeParametersQueried{
            volatility_accumulator : v0,
            volatility_reference   : v1,
            id_reference           : v2,
            time_of_last_update    : v3,
        };
        0x2::event::emit<VariableFeeParametersQueried>(v4);
        (v0, v1, v2, v3)
    }

    public(friend) fun increase_oracle_length<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let v1 = v0;
        if (v0 == 0) {
            let v2 = 1;
            v1 = v2;
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::set_oracle_id(&mut arg0.parameters, v2);
        };
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::increase_length(&mut arg0.oracle, v1, arg1);
        let v3 = OracleLengthIncreased{
            sender     : 0x2::tx_context::sender(arg2),
            new_length : arg1,
        };
        0x2::event::emit<OracleLengthIncreased>(v3);
    }

    fun mint_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &mut 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition, arg2: &vector<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::liquidity_configurations::LiquidityConfig>, arg3: 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts, arg4: &mut MintArrays, arg5: &mut vector<0x2::object::ID>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts {
        let v0 = arg3;
        let v1 = 0;
        let v2 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_active_id(&arg0.parameters);
        let v3 = arg0.bin_step;
        let (v4, v5) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&arg3);
        let v6 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0);
        while (v1 < 0x1::vector::length<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::liquidity_configurations::LiquidityConfig>(arg2)) {
            let v7 = 0x1::vector::borrow<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::liquidity_configurations::LiquidityConfig>(arg2, v1);
            let v8 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::liquidity_configurations::get_id(v7);
            let (v9, v10) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::liquidity_configurations::apply_distribution(v7, v4, v5);
            let v11 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(v9, v10);
            let (v12, v13, v14, v15) = update_bin<T0, T1>(arg0, v3, v2, v8, &v11, arg6, 0x2::tx_context::sender(arg7));
            let v16 = v15;
            let v17 = v13;
            if (v12 > 0) {
                let v18 = &v0;
                v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::sub_amounts(v18, &v17);
                let v19 = &v6;
                v6 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::add_amounts(v19, &v16);
                0x1::vector::push_back<u32>(&mut arg4.ids, v8);
                0x1::vector::push_back<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts>(&mut arg4.amounts, v14);
                0x1::vector::push_back<u128>(&mut arg4.liquidity_minted, v12);
                let v20 = if (0x2::table::contains<u32, BinFeeGrowth>(&arg0.bin_fee_growths, v8)) {
                    0x2::table::borrow<u32, BinFeeGrowth>(&arg0.bin_fee_growths, v8)
                } else {
                    let v21 = BinFeeGrowth{
                        fee_growth_x : 0,
                        fee_growth_y : 0,
                    };
                    &v21
                };
                if (0x2::table::contains<u32, BinRewardGrowth>(&arg0.bin_reward_growths, v8)) {
                } else {
                    let _ = BinRewardGrowth{rewards_growth: 0x1::vector::empty<u128>()};
                };
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::increase_liquidity(&mut arg0.position_manager, arg1, v8, (v12 as u128));
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::update_fee_info(&mut arg0.position_manager, arg1, v8, v20.fee_growth_x, v20.fee_growth_y);
            };
            v1 = v1 + 1;
        };
        let (v23, v24) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v6);
        if (v23 > 0 || v24 > 0) {
            arg0.global_fee_info.composition_fee_x = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg0.global_fee_info.composition_fee_x, v23);
            arg0.global_fee_info.composition_fee_y = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg0.global_fee_info.composition_fee_y, v24);
            arg0.global_fee_info.total_fee_x = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg0.global_fee_info.total_fee_x, v23);
            arg0.global_fee_info.total_fee_y = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(arg0.global_fee_info.total_fee_y, v24);
            let v25 = FeesCharged{
                total_fee_x       : v23,
                total_fee_y       : v24,
                flashloan_fee_x   : 0,
                flashloan_fee_y   : 0,
                swap_fee_x        : 0,
                swap_fee_y        : 0,
                composition_fee_x : v23,
                composition_fee_y : v24,
            };
            0x2::event::emit<FeesCharged>(v25);
        };
        v0
    }

    public fun open_position<T0, T1>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        let v1 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::open_position<T0, T1>(&mut arg1.position_manager, v0, arg2);
        let v2 = OpenPositionEvent{
            pair     : v0,
            position : 0x2::object::id<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition>(&v1),
            owner    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<OpenPositionEvent>(v2);
        v1
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition, arg3: vector<u32>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::pair_id(arg2), 2030);
        settle_all_bins<T0, T1>(arg1, arg4);
        assert!(0x1::vector::length<u32>(&arg3) > 0, 2007);
        let v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0);
        let v1 = 0x1::vector::empty<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts>();
        let v2 = 0x1::vector::empty<u128>();
        let v3 = 0x1::vector::empty<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>();
        let v4 = 0x1::vector::empty<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u32>(&arg3)) {
            let v6 = *0x1::vector::borrow<u32>(&arg3, v5);
            let v7 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::position_token_amount(&arg1.position_manager, arg2, v6);
            assert!(v7 > 0, 2013);
            assert!(v6 <= 16777215, 2020);
            let v8 = if (0x2::table::contains<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg1.bins, v6)) {
                *0x2::table::borrow<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg1.bins, v6)
            } else {
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_bin_reserves(0, 0)
            };
            let v9 = v8;
            let v10 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::total_supply(&arg1.position_manager, v6);
            0x1::vector::push_back<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&mut v3, v9);
            let v11 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amount_out_of_bin(&v9, v7, v10);
            let (v12, v13) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v11);
            assert!(v12 > 0 || v13 > 0, 2014);
            let (v14, v15) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_total_amounts(&v9);
            let (v16, v17) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_reserves(&v9);
            let (v18, v19) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_fees(&v9);
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
            let v22 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_bin_reserves_with_fees(v16 - (v20 as u64), v17 - (v21 as u64), v18 - v12 - (v20 as u64), v19 - v13 - (v21 as u64));
            update_bin_liquidity<T0, T1>(arg1, v6, v10 - v7);
            if (v10 == v7) {
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::tree_math::remove(&mut arg1.tree, v6);
            };
            let v23 = if (0x2::table::contains<u32, BinFeeGrowth>(&arg1.bin_fee_growths, v6)) {
                *0x2::table::borrow<u32, BinFeeGrowth>(&arg1.bin_fee_growths, v6)
            } else {
                BinFeeGrowth{fee_growth_x: 0, fee_growth_y: 0}
            };
            let v24 = v23;
            let (_, _) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::collect_fees(&mut arg1.position_manager, arg2, v6, v24.fee_growth_x, v24.fee_growth_y);
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::decrease_liquidity(&mut arg1.position_manager, arg2, v6, v7);
            *0x2::table::borrow_mut<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&mut arg1.bins, v6) = v22;
            0x1::vector::push_back<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&mut v4, v22);
            let v27 = &v0;
            v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::add_amounts(v27, &v11);
            0x1::vector::push_back<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts>(&mut v1, v11);
            0x1::vector::push_back<u128>(&mut v2, v7);
            v5 = v5 + 1;
        };
        let (v28, v29) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v0);
        let v30 = RemoveLiquidityEvent{
            pair                : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position            : 0x2::object::id<0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::LBPosition>(arg2),
            ids                 : arg3,
            tokens              : v0,
            token_bins          : v1,
            liquidity_burned    : v2,
            bin_reserves_before : v3,
            bin_reserves_after  : v4,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v30);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v28, arg5), 0x2::coin::take<T1>(&mut arg1.balance_y, v29, arg5))
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
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
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = arg0.bin_step;
        let v2 = arg0.parameters;
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::set_volatility_accumulator(&mut v2, arg7);
        assert!(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::add_u64(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_base_fee(&v2, v1), 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_variable_fee(&v2, v1)) <= 100000000, 2016);
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
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::last_update_time(&arg0.rewarder_manager);
        if (v0 <= v1) {
            return
        };
        let v2 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_active_id(&arg0.parameters);
        if (0x2::table::contains<u32, BinLiquidityInfo>(&arg0.bin_liquidity_infos, v2)) {
            let v3 = 0x2::table::borrow<u32, BinLiquidityInfo>(&arg0.bin_liquidity_infos, v2);
            if (v3.liquidity > 0) {
                let v4 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::update_rewards_growth(&mut arg0.rewarder_manager, v3.liquidity, v0 - v1);
                update_bin_reward_growth<T0, T1>(arg0, v2, &v4);
            };
        };
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::settle_rewards(&mut arg0.rewarder_manager, v0);
    }

    fun update_bin<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: u32, arg3: u32, arg4: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts, arg5: &0x2::clock::Clock, arg6: address) : (u128, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::Amounts) {
        let v0 = if (0x2::table::contains<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg0.bins, arg3)) {
            *0x2::table::borrow<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg0.bins, arg3)
        } else {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_bin_reserves(0, 0)
        };
        let v1 = v0;
        let v2 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::price_helper::get_price_from_id(arg3, arg1);
        let v3 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::total_supply(&arg0.position_manager, arg3);
        let (v4, v5) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_shares_and_effective_amounts_in(&v1, arg4, v2, v3);
        let v6 = v5;
        let v7 = v4;
        if (v4 == 0) {
            return (0, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0), 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0), 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0))
        };
        let v8 = v6;
        let v9 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0);
        if (arg3 == arg2) {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::update_volatility_parameters(&mut arg0.parameters, arg3, 0x2::clock::timestamp_ms(arg5) / 1000);
            let v10 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_composition_fees(&v1, &arg0.parameters, arg1, &v6, v3, v4);
            let (v11, v12) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v10);
            if (v11 > 0 || v12 > 0) {
                v9 = v10;
                let v13 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::sub_amounts(&v6, &v10);
                let v14 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                let v15 = if (v14 > 0) {
                    0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::fee_helper::get_protocol_fee_amount(v11, (v14 as u64)), 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::fee_helper::get_protocol_fee_amount(v12, (v14 as u64)))
                } else {
                    0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::new_amounts(0, 0)
                };
                let v16 = v15;
                let (v17, v18) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v16);
                if (v17 > 0 || v18 > 0) {
                    let v19 = &v8;
                    v8 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::sub_amounts(v19, &v16);
                    assert!(arg0.protocol_fee_x <= 18446744073709551615 - v17, 2024);
                    assert!(arg0.protocol_fee_y <= 18446744073709551615 - v18, 2024);
                    arg0.protocol_fee_x = arg0.protocol_fee_x + v17;
                    arg0.protocol_fee_y = arg0.protocol_fee_y + v18;
                };
                update_bin_fee_growth<T0, T1>(arg0, arg3, v11 - v17, v12 - v18);
                let v20 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::sub_amounts(&v10, &v16);
                let v21 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::amounts_to_reserves(&v20);
                let v22 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::add_reserves(&v1, &v21);
                v7 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::safe_math::mul_div_u128(0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_liquidity_from_amounts(&v13, v2), v3, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_liquidity_from_reserves(&v22, v2));
                0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, arg3, arg5);
                let v23 = CompositionFees{
                    sender        : arg6,
                    id            : arg3,
                    total_fees    : v10,
                    protocol_fees : v16,
                };
                0x2::event::emit<CompositionFees>(v23);
            };
        } else {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::verify_amounts(&v6, arg2, arg3);
        };
        assert!(v7 > 0, 2015);
        let (v24, v25) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v8);
        assert!(v24 > 0 || v25 > 0, 2015);
        if (v3 == 0) {
            0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::tree_math::add(&mut arg0.tree, arg3);
        };
        let (v26, v27) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::get_amounts_values(&v9);
        let v28 = if (v26 > 0) {
            v26 - 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::fee_helper::get_protocol_fee_amount(v26, (0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_protocol_share(&arg0.parameters) as u64))
        } else {
            0
        };
        let v29 = if (v27 > 0) {
            v27 - 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::fee_helper::get_protocol_fee_amount(v27, (0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_protocol_share(&arg0.parameters) as u64))
        } else {
            0
        };
        if (!0x2::table::contains<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&arg0.bins, arg3)) {
            0x2::table::add<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&mut arg0.bins, arg3, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::add_to_bin(&v1, v24, v25, v28, v29));
        } else {
            *0x2::table::borrow_mut<u32, 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::BinReserves>(&mut arg0.bins, arg3) = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::bin_helper::add_to_bin(&v1, v24, v25, v28, v29);
        };
        update_bin_liquidity<T0, T1>(arg0, arg3, v3 + v7);
        (v7, v6, v8, v9)
    }

    fun update_bin_fee_growth<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u64, arg3: u64) {
        let v0 = 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::lb_position::total_supply(&arg0.position_manager, arg1);
        if (v0 == 0) {
            return
        };
        let v1 = if (0x2::table::contains<u32, BinFeeGrowth>(&arg0.bin_fee_growths, arg1)) {
            *0x2::table::borrow<u32, BinFeeGrowth>(&arg0.bin_fee_growths, arg1)
        } else {
            BinFeeGrowth{fee_growth_x: 0, fee_growth_y: 0}
        };
        let v2 = v1;
        let v3 = BinFeeGrowth{
            fee_growth_x : v2.fee_growth_x + ((arg2 as u128) << 64) / v0,
            fee_growth_y : v2.fee_growth_y + ((arg3 as u128) << 64) / v0,
        };
        if (!0x2::table::contains<u32, BinFeeGrowth>(&arg0.bin_fee_growths, arg1)) {
            0x2::table::add<u32, BinFeeGrowth>(&mut arg0.bin_fee_growths, arg1, v3);
        } else {
            *0x2::table::borrow_mut<u32, BinFeeGrowth>(&mut arg0.bin_fee_growths, arg1) = v3;
        };
    }

    fun update_bin_liquidity<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: u128) {
        let v0 = if (0x2::table::contains<u32, BinLiquidityInfo>(&arg0.bin_liquidity_infos, arg1)) {
            *0x2::table::borrow<u32, BinLiquidityInfo>(&arg0.bin_liquidity_infos, arg1)
        } else {
            BinLiquidityInfo{liquidity: 0, last_update_time: 0}
        };
        let v1 = v0;
        if (arg1 == 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::pair_parameter_helper::get_active_id(&arg0.parameters)) {
            arg0.total_active_liquidity = arg0.total_active_liquidity - v1.liquidity + arg2;
        };
        let v2 = BinLiquidityInfo{
            liquidity        : arg2,
            last_update_time : 0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::last_update_time(&arg0.rewarder_manager),
        };
        if (!0x2::table::contains<u32, BinLiquidityInfo>(&arg0.bin_liquidity_infos, arg1)) {
            0x2::table::add<u32, BinLiquidityInfo>(&mut arg0.bin_liquidity_infos, arg1, v2);
        } else {
            *0x2::table::borrow_mut<u32, BinLiquidityInfo>(&mut arg0.bin_liquidity_infos, arg1) = v2;
        };
    }

    fun update_bin_reward_growth<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u32, arg2: &vector<u128>) {
        let v0 = if (0x2::table::contains<u32, BinRewardGrowth>(&arg0.bin_reward_growths, arg1)) {
            *0x2::table::borrow<u32, BinRewardGrowth>(&arg0.bin_reward_growths, arg1)
        } else {
            BinRewardGrowth{rewards_growth: 0x1::vector::empty<u128>()}
        };
        let v1 = v0;
        let v2 = 0x1::vector::empty<u128>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(arg2)) {
            let v4 = if (v3 < 0x1::vector::length<u128>(&v1.rewards_growth)) {
                *0x1::vector::borrow<u128>(&v1.rewards_growth, v3)
            } else {
                0
            };
            0x1::vector::push_back<u128>(&mut v2, v4 + *0x1::vector::borrow<u128>(arg2, v3));
            v3 = v3 + 1;
        };
        let v5 = BinRewardGrowth{rewards_growth: v2};
        if (!0x2::table::contains<u32, BinRewardGrowth>(&arg0.bin_reward_growths, arg1)) {
            0x2::table::add<u32, BinRewardGrowth>(&mut arg0.bin_reward_growths, arg1, v5);
        } else {
            *0x2::table::borrow_mut<u32, BinRewardGrowth>(&mut arg0.bin_reward_growths, arg1) = v5;
        };
    }

    public fun update_emission<T0, T1, T2>(arg0: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::RewarderGlobalVault, arg3: &0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::RewarderAdminCap, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::config::checked_package_version(arg0);
        settle_all_bins<T0, T1>(arg1, arg5);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        0x88b5bfc07a78185ccdc15d8a88d14a20e8337b5546ab4b3da57091bf042f4a4e::rewarder::update_emission<T2>(arg2, &mut arg1.rewarder_manager, v0, arg4, 0x2::clock::timestamp_ms(arg5) / 1000);
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

    // decompiled from Move bytecode v6
}

