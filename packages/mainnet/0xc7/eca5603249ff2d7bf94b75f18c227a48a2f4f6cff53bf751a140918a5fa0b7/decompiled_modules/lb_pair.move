module 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_pair {
    struct MintArrays has drop {
        ids: vector<u32>,
        amounts: vector<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts>,
        liquidity_minted: vector<u256>,
    }

    struct LBPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        index: u64,
        is_pause: bool,
        bin_step: u16,
        parameters: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::PairParameters,
        reserve_x: u128,
        reserve_y: u128,
        protocol_fee_x: u128,
        protocol_fee_y: u128,
        bins: 0x2::table::Table<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>,
        tree: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::tree_math::TreeUint24,
        oracle: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::Oracle,
        position_manager: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPositionManager,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
    }

    struct Swap has copy, drop {
        sender: address,
        to: address,
        id: u32,
        amounts_in: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
        amounts_out: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
        volatility_accumulator: u32,
        total_fees: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
        protocol_fees: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
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
        amounts: vector<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts>,
        tokens: vector<u256>,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        ids: vector<u32>,
        amounts: vector<u128>,
        tokens: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
    }

    struct CollectedProtocolFees has copy, drop {
        fee_recipient: address,
        protocol_fees: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
    }

    struct FlashLoan has copy, drop {
        sender: address,
        receiver: address,
        active_id: u32,
        amounts: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
        total_fees: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
        protocol_fees: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
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
        total_fees: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
        protocol_fees: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts,
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
        price: u256,
    }

    struct IdFromPriceQueried has copy, drop {
        price: u256,
        id: u32,
    }

    public fun swap<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: bool, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::coin::value<T1>(&arg4);
        0x2::coin::put<T0>(&mut arg0.balance_x, arg3);
        0x2::coin::put<T1>(&mut arg0.balance_y, arg4);
        let v2 = if (arg1) {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u64_to_u128(v0), 0)
        } else {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u64_to_u128(v1))
        };
        let v3 = v2;
        let (v4, v5) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v3);
        assert!(v4 > 0 || v5 > 0, 2005);
        let v6 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u64_to_u128(v0);
        let v7 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u64_to_u128(v1);
        assert!(arg0.reserve_x <= 340282366920938463463374607431768211455 - v6, 2022);
        assert!(arg0.reserve_y <= 340282366920938463463374607431768211455 - v7, 2022);
        arg0.reserve_x = arg0.reserve_x + v6;
        arg0.reserve_y = arg0.reserve_y + v7;
        let v8 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0);
        let v9 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_active_id(&arg0.parameters);
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::update_references(&mut arg0.parameters, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v10 = v9;
        let v11 = 0;
        loop {
            assert!(v11 < 255, 2021);
            v11 = v11 + 1;
            let v12 = if (0x2::table::contains<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, v10)) {
                *0x2::table::borrow<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, v10)
            } else {
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_bin_reserves(0, 0)
            };
            let v13 = v12;
            if (!0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::is_empty(&v13, !arg1)) {
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::update_volatility_accumulator(&mut arg0.parameters, v10);
                let (v14, v15, v16) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts(&v13, &arg0.parameters, arg0.bin_step, arg1, v10, &v3);
                let v17 = v16;
                let v18 = v15;
                let v19 = v14;
                let (v20, v21) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v19);
                if (v20 > 0 || v21 > 0) {
                    let v22 = &v3;
                    v3 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::sub_amounts(v22, &v19);
                    let v23 = &v8;
                    v8 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::add_amounts(v23, &v18);
                    let v24 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                    let (v25, v26) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v17);
                    let v27 = if (v24 > 0) {
                        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::fee_helper::get_protocol_fee_amount(v25, (v24 as u128)), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::fee_helper::get_protocol_fee_amount(v26, (v24 as u128)))
                    } else {
                        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0)
                    };
                    let v28 = v27;
                    let (v29, v30) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v28);
                    if (v29 > 0 || v30 > 0) {
                        assert!(arg0.protocol_fee_x <= 340282366920938463463374607431768211455 - v29, 2024);
                        assert!(arg0.protocol_fee_y <= 340282366920938463463374607431768211455 - v30, 2024);
                        arg0.protocol_fee_x = arg0.protocol_fee_x + v29;
                        arg0.protocol_fee_y = arg0.protocol_fee_y + v30;
                        let v31 = &v19;
                        v19 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::sub_amounts(v31, &v28);
                    };
                    let v32 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::amounts_to_reserves(&v19);
                    let v33 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::add_reserves(&v13, &v32);
                    let v34 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::amounts_to_reserves(&v18);
                    *0x2::table::borrow_mut<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&mut arg0.bins, v10) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::sub_reserves(&v33, &v34);
                    let v35 = Swap{
                        sender                 : 0x2::tx_context::sender(arg6),
                        to                     : arg2,
                        id                     : v10,
                        amounts_in             : v19,
                        amounts_out            : v18,
                        volatility_accumulator : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters),
                        total_fees             : v17,
                        protocol_fees          : v28,
                    };
                    0x2::event::emit<Swap>(v35);
                };
            };
            let (v36, v37) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v3);
            if (v36 == 0 && v37 == 0) {
                break
            };
            let v38 = next_non_empty_bin<T0, T1>(arg0, arg1, v10);
            if (v38 == 0 || v38 == v9) {
                abort 2011
            };
            v10 = v38;
        };
        let (v39, v40) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v8);
        assert!(v39 > 0 || v40 > 0, 2006);
        if (0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, v10, arg5)) {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::set_active_id(&mut arg0.parameters, v10);
        };
        assert!(arg0.reserve_x >= v39, 2023);
        assert!(arg0.reserve_y >= v40, 2023);
        arg0.reserve_x = arg0.reserve_x - v39;
        arg0.reserve_y = arg0.reserve_y - v40;
        (0x2::coin::take<T0>(&mut arg0.balance_x, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v39), arg6), 0x2::coin::take<T1>(&mut arg0.balance_y, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v40), arg6))
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u32, arg8: u16, arg9: u32, arg10: &mut 0x2::tx_context::TxContext) : LBPair<T0, T1> {
        let v0 = LBPair<T0, T1>{
            id               : 0x2::object::new(arg10),
            index            : arg0,
            is_pause         : false,
            bin_step         : arg2,
            parameters       : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::new(arg1),
            reserve_x        : 0,
            reserve_y        : 0,
            protocol_fee_x   : 0,
            protocol_fee_y   : 0,
            bins             : 0x2::table::new<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(arg10),
            tree             : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::tree_math::empty(arg10),
            oracle           : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::new(),
            position_manager : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::new(arg10),
            balance_x        : 0x2::balance::zero<T0>(),
            balance_y        : 0x2::balance::zero<T1>(),
        };
        let v1 = &mut v0;
        set_static_fee_parameters_internal<T0, T1>(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        v0
    }

    public fun add_liquidity<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &mut 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPosition, arg2: vector<u32>, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u64>(&arg3), 2007);
        assert!(0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u64>(&arg4), 2007);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x1::vector::length<u32>(&arg2) > 0, 2002);
        let v1 = create_liquidity_configs_from_params(&arg2, &arg3, &arg4);
        let v2 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u64_to_u128(0x2::coin::value<T0>(&arg5)), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u64_to_u128(0x2::coin::value<T1>(&arg6)));
        0x2::coin::put<T0>(&mut arg0.balance_x, arg5);
        0x2::coin::put<T1>(&mut arg0.balance_y, arg6);
        let (v3, v4) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v2);
        assert!(arg0.reserve_x <= 340282366920938463463374607431768211455 - v3, 2022);
        assert!(arg0.reserve_y <= 340282366920938463463374607431768211455 - v4, 2022);
        arg0.reserve_x = arg0.reserve_x + v3;
        arg0.reserve_y = arg0.reserve_y + v4;
        let v5 = MintArrays{
            ids              : 0x1::vector::empty<u32>(),
            amounts          : 0x1::vector::empty<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts>(),
            liquidity_minted : 0x1::vector::empty<u256>(),
        };
        let v6 = &mut v5;
        let v7 = mint_bins<T0, T1>(arg0, &v1, v2, v6, arg1, arg7, arg8);
        let (v8, v9) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v7);
        if (v8 > 0 || v9 > 0) {
            assert!(arg0.reserve_x >= v8, 2023);
            assert!(arg0.reserve_y >= v9, 2023);
            arg0.reserve_x = arg0.reserve_x - v8;
            arg0.reserve_y = arg0.reserve_y - v9;
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance_x, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v8), arg8), v0);
            };
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.balance_y, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v9), arg8), v0);
            };
        };
        let v10 = AddLiquidityEvent{
            pair     : 0x2::object::id<LBPair<T0, T1>>(arg0),
            position : 0x2::object::id<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPosition>(arg1),
            ids      : v5.ids,
            amounts  : v5.amounts,
            tokens   : v5.liquidity_minted,
        };
        0x2::event::emit<AddLiquidityEvent>(v10);
    }

    public fun bin_step<T0, T1>(arg0: &LBPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun close_position<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPosition, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg0);
        assert!(v0 == 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::pair_id(&arg1), 19);
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::close_position(&mut arg0.position_manager, arg1);
        let v1 = ClosePositionEvent{
            pair     : v0,
            position : 0x2::object::id<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPosition>(&arg1),
            owner    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ClosePositionEvent>(v1);
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = arg0.protocol_fee_x;
        let v1 = arg0.protocol_fee_y;
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
        if (v2 > 0) {
            arg0.protocol_fee_x = arg0.protocol_fee_x - v2;
            assert!(arg0.reserve_x >= v2, 2023);
            arg0.reserve_x = arg0.reserve_x - v2;
        };
        if (v3 > 0) {
            arg0.protocol_fee_y = arg0.protocol_fee_y - v3;
            assert!(arg0.reserve_y >= v3, 2023);
            arg0.reserve_y = arg0.reserve_y - v3;
        };
        let v4 = CollectedProtocolFees{
            fee_recipient : 0x2::tx_context::sender(arg1),
            protocol_fees : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(v2, v3),
        };
        0x2::event::emit<CollectedProtocolFees>(v4);
        (0x2::coin::take<T0>(&mut arg0.balance_x, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v2), arg1), 0x2::coin::take<T1>(&mut arg0.balance_y, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v3), arg1))
    }

    fun create_liquidity_configs_from_params(arg0: &vector<u32>, arg1: &vector<u64>, arg2: &vector<u64>) : vector<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::liquidity_configurations::LiquidityConfig> {
        let v0 = 0x1::vector::length<u32>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 2007);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 2007);
        let v1 = 0x1::vector::empty<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::liquidity_configurations::LiquidityConfig>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::liquidity_configurations::LiquidityConfig>(&mut v1, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::liquidity_configurations::new_config(*0x1::vector::borrow<u64>(arg1, v2), *0x1::vector::borrow<u64>(arg2, v2), *0x1::vector::borrow<u32>(arg0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun force_decay<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::update_volatility_reference(&mut arg0.parameters);
        let v0 = ForcedDecay{
            sender               : 0x2::tx_context::sender(arg1),
            id_reference         : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_id_reference(&arg0.parameters),
            volatility_reference : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_volatility_reference(&arg0.parameters),
        };
        0x2::event::emit<ForcedDecay>(v0);
    }

    public fun get_active_id<T0, T1>(arg0: &LBPair<T0, T1>) : u32 {
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_active_id(&arg0.parameters)
    }

    public fun get_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : (u128, u128) {
        assert!(arg1 <= 16777215, 2020);
        if (0x2::table::contains<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, arg1)) {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_reserves(0x2::table::borrow<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, arg1))
        } else {
            (0, 0)
        }
    }

    public fun get_id_from_price<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u256) : u32 {
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::price_helper::get_id_from_price(arg1, arg0.bin_step);
        let v1 = IdFromPriceQueried{
            price : arg1,
            id    : v0,
        };
        0x2::event::emit<IdFromPriceQueried>(v1);
        v0
    }

    public fun get_oracle_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u8, u16, u16, u64, u64) {
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let (v1, v2, v3, v4, v5) = if (v0 == 0) {
            (0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::get_max_sample_lifetime(), 0, 0, 0, 0)
        } else {
            let (v6, v7) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::get_active_sample_and_size(&arg0.oracle, v0);
            let v8 = v6;
            let v9 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::get_sample_last_update(&v8);
            let v10 = if (v9 == 0) {
                0
            } else {
                v7
            };
            let v11 = if (v10 > 0) {
                let v12 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::get_sample(&arg0.oracle, 1 + v0 % v10);
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::get_sample_last_update(&v12)
            } else {
                0
            };
            (0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::get_max_sample_lifetime(), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::get_oracle_length(&v8), v10, v9, v11)
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
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_oracle_id(&arg0.parameters);
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
        let (v2, v3, v4, v5) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::get_sample_at(&arg0.oracle, v0, arg1);
        let v6 = v4;
        let v7 = v3;
        if (v2 < arg1) {
            let v8 = arg1 - v2;
            v7 = v3 + (0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_active_id(&arg0.parameters) as u64) * v8;
            v6 = v4 + (0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters) as u64) * v8;
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

    public fun get_price_from_id<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : u256 {
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::price_helper::get_price_from_id(arg1, arg0.bin_step);
        let v1 = PriceFromIdQueried{
            id    : arg1,
            price : v0,
        };
        0x2::event::emit<PriceFromIdQueried>(v1);
        v0
    }

    public fun get_protocol_fees<T0, T1>(arg0: &LBPair<T0, T1>) : (u128, u128) {
        (arg0.protocol_fee_x, arg0.protocol_fee_y)
    }

    public fun get_static_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u16, u16, u16, u16, u32, u16, u32) {
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_base_factor(&arg0.parameters);
        let v1 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_filter_period(&arg0.parameters);
        let v2 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_decay_period(&arg0.parameters);
        let v3 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_reduction_factor(&arg0.parameters);
        let v4 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_variable_fee_control(&arg0.parameters);
        let v5 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_protocol_share(&arg0.parameters);
        let v6 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_max_volatility_accumulator(&arg0.parameters);
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
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u64_to_u128(arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = arg0.parameters;
        let v4 = arg0.bin_step;
        let v5 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_active_id(&v3);
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::update_references(&mut v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = if (0x2::table::contains<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, v6)) {
                *0x2::table::borrow<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, v6)
            } else {
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_bin_reserves(0, 0)
            };
            let v9 = v8;
            let v10 = if (arg2) {
                let (_, v12) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_reserves(&v9);
                v12
            } else {
                let (v13, _) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_reserves(&v9);
                v13
            };
            if (v10 > 0) {
                let v15 = if (v10 > v0) {
                    v0
                } else {
                    v10
                };
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::update_volatility_accumulator(&mut v3, v6);
                let v16 = if (arg2) {
                    0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::shift_div_round_up((v15 as u256), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::scale_offset(), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::price_helper::get_price_from_id(v6, v4)))
                } else {
                    0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::safe128(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_shift_round_up((v15 as u256), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::price_helper::get_price_from_id(v6, v4), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::constants::scale_offset()))
                };
                let v17 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::fee_helper::get_fee_amount(v16, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_total_fee(&v3, v4));
                let v18 = v1 + v16;
                v1 = v18 + v17;
                v0 = v0 - v15;
                v2 = v2 + v17;
            };
            if (v0 == 0) {
                break
            };
            v6 = next_non_empty_bin<T0, T1>(arg0, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        (0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v1), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v0), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v2))
    }

    public fun get_swap_out<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = if (arg2) {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u64_to_u128(arg1), 0)
        } else {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u64_to_u128(arg1))
        };
        let v1 = v0;
        let v2 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0);
        let v3 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0);
        let v4 = arg0.parameters;
        let v5 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_active_id(&v4);
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::update_references(&mut v4, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = if (0x2::table::contains<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, v6)) {
                *0x2::table::borrow<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, v6)
            } else {
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_bin_reserves(0, 0)
            };
            let v9 = v8;
            if (!0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::is_empty(&v9, !arg2)) {
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::update_volatility_accumulator(&mut v4, v6);
                let (v10, v11, v12) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts(&v9, &v4, arg0.bin_step, arg2, v6, &v1);
                let v13 = v12;
                let v14 = v11;
                let v15 = v10;
                let (v16, v17) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v15);
                if (v16 > 0 || v17 > 0) {
                    let v18 = &v1;
                    v1 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::sub_amounts(v18, &v15);
                    let v19 = &v2;
                    v2 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::add_amounts(v19, &v14);
                    let v20 = &v3;
                    v3 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::add_amounts(v20, &v13);
                };
            };
            let (v21, v22) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v1);
            if (v21 == 0 && v22 == 0) {
                break
            };
            v6 = next_non_empty_bin<T0, T1>(arg0, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        let (v23, v24) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v1);
        let (v25, v26) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v2);
        let (v27, v28) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v3);
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
        (0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v29), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v30), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v31))
    }

    public fun get_variable_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u32, u32, u32, u64) {
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters);
        let v1 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_volatility_reference(&arg0.parameters);
        let v2 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_id_reference(&arg0.parameters);
        let v3 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_time_of_last_update(&arg0.parameters);
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
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let v1 = v0;
        if (v0 == 0) {
            let v2 = 1;
            v1 = v2;
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::set_oracle_id(&mut arg0.parameters, v2);
        };
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::increase_length(&mut arg0.oracle, v1, arg1);
        let v3 = OracleLengthIncreased{
            sender     : 0x2::tx_context::sender(arg2),
            new_length : arg1,
        };
        0x2::event::emit<OracleLengthIncreased>(v3);
    }

    fun mint_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &vector<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::liquidity_configurations::LiquidityConfig>, arg2: 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts, arg3: &mut MintArrays, arg4: &mut 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPosition, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts {
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_active_id(&arg0.parameters);
        let v3 = arg0.bin_step;
        let (v4, v5) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&arg2);
        while (v1 < 0x1::vector::length<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::liquidity_configurations::LiquidityConfig>(arg1)) {
            let v6 = 0x1::vector::borrow<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::liquidity_configurations::LiquidityConfig>(arg1, v1);
            let v7 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::liquidity_configurations::get_id(v6);
            let (v8, v9) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::liquidity_configurations::apply_distribution(v6, v4, v5);
            let v10 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(v8, v9);
            let (v11, v12, v13) = update_bin<T0, T1>(arg0, v3, v2, v7, &v10, arg5, 0x2::tx_context::sender(arg6));
            let v14 = v12;
            if (v11 > 0) {
                let v15 = &v0;
                v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::sub_amounts(v15, &v14);
                0x1::vector::push_back<u32>(&mut arg3.ids, v7);
                0x1::vector::push_back<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts>(&mut arg3.amounts, v13);
                0x1::vector::push_back<u256>(&mut arg3.liquidity_minted, v11);
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::increase_liquidity(&mut arg0.position_manager, arg4, v7, (v11 as u128));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun next_non_empty_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: bool, arg2: u32) : u32 {
        let v0 = if (arg1) {
            let v1 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::tree_math::find_first_right(&arg0.tree, arg2);
            if (v1 == 16777215) {
                0
            } else {
                v1
            }
        } else {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::tree_math::find_first_left(&arg0.tree, arg2)
        };
        let v2 = NextNonEmptyBinQueried{
            swap_for_y : arg1,
            id         : arg2,
            next_id    : v0,
        };
        0x2::event::emit<NextNonEmptyBinQueried>(v2);
        v0
    }

    public fun open_position<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPosition {
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg0);
        let v1 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::open_position<T0, T1>(&mut arg0.position_manager, v0, arg1);
        let v2 = OpenPositionEvent{
            pair     : v0,
            position : 0x2::object::id<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPosition>(&v1),
            owner    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<OpenPositionEvent>(v2);
        v1
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &mut 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPosition, arg2: vector<u32>, arg3: vector<u128>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x1::vector::length<u32>(&arg2) > 0, 2007);
        assert!(0x1::vector::length<u32>(&arg2) == 0x1::vector::length<u128>(&arg3), 2007);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg0) == 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::pair_id(arg1), 19);
        let v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg2)) {
            let v2 = *0x1::vector::borrow<u32>(&arg2, v1);
            let v3 = *0x1::vector::borrow<u128>(&arg3, v1);
            assert!(v3 > 0, 2013);
            assert!(v2 <= 16777215, 2020);
            let v4 = if (0x2::table::contains<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, v2)) {
                *0x2::table::borrow<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, v2)
            } else {
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_bin_reserves(0, 0)
            };
            let v5 = v4;
            let v6 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::total_supply(&arg0.position_manager, v2);
            let v7 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amount_out_of_bin(&v5, (v3 as u256), (v6 as u256));
            let (v8, v9) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v7);
            assert!(v8 > 0 || v9 > 0, 2014);
            let v10 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::amounts_to_reserves(&v7);
            if (v6 == v3) {
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::tree_math::remove(&mut arg0.tree, v2);
            };
            *0x2::table::borrow_mut<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&mut arg0.bins, v2) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::sub_reserves(&v5, &v10);
            let v11 = &v0;
            v0 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::add_amounts(v11, &v7);
            v1 = v1 + 1;
        };
        let (v12, v13) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v0);
        assert!(arg0.reserve_x >= v12, 2023);
        assert!(arg0.reserve_y >= v13, 2023);
        arg0.reserve_x = arg0.reserve_x - v12;
        arg0.reserve_y = arg0.reserve_y - v13;
        let v14 = RemoveLiquidityEvent{
            pair     : 0x2::object::id<LBPair<T0, T1>>(arg0),
            position : 0x2::object::id<0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::LBPosition>(arg1),
            ids      : arg2,
            amounts  : arg3,
            tokens   : v0,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v14);
        (0x2::coin::take<T0>(&mut arg0.balance_x, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v12), arg4), 0x2::coin::take<T1>(&mut arg0.balance_y, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::safe_math::u128_to_u64(v13), arg4))
    }

    public fun reserves<T0, T1>(arg0: &LBPair<T0, T1>) : (u128, u128) {
        let v0 = if (arg0.reserve_x > arg0.protocol_fee_x) {
            arg0.reserve_x - arg0.protocol_fee_x
        } else {
            0
        };
        let v1 = if (arg0.reserve_y > arg0.protocol_fee_y) {
            arg0.reserve_y - arg0.protocol_fee_y
        } else {
            0
        };
        (v0, v1)
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
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = arg0.bin_step;
        let v2 = arg0.parameters;
        0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::set_volatility_accumulator(&mut v2, arg7);
        assert!(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_base_fee(&v2, v1) + 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_variable_fee(&v2, v1) <= 100000000000000000, 2016);
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

    fun update_bin<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: u32, arg3: u32, arg4: &0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts, arg5: &0x2::clock::Clock, arg6: address) : (u256, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::Amounts) {
        let v0 = if (0x2::table::contains<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, arg3)) {
            *0x2::table::borrow<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, arg3)
        } else {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_bin_reserves(0, 0)
        };
        let v1 = v0;
        let v2 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::price_helper::get_price_from_id(arg3, arg1);
        let v3 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::lb_position::total_supply(&arg0.position_manager, arg3);
        let (v4, v5) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_shares_and_effective_amounts_in(&v1, arg4, v2, (v3 as u256));
        let v6 = v5;
        let v7 = v4;
        if (v4 == 0) {
            return (0, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0))
        };
        let v8 = v6;
        if (arg3 == arg2) {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::update_volatility_parameters(&mut arg0.parameters, arg3, 0x2::clock::timestamp_ms(arg5) / 1000);
            let v9 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_composition_fees(&v1, &arg0.parameters, arg1, &v6, (v3 as u256), v4);
            let (v10, v11) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v9);
            if (v10 > 0 || v11 > 0) {
                let v12 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::sub_amounts(&v6, &v9);
                let v13 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                let v14 = if (v13 > 0) {
                    0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::fee_helper::get_protocol_fee_amount(v10, (v13 as u128)), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::fee_helper::get_protocol_fee_amount(v11, (v13 as u128)))
                } else {
                    0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::new_amounts(0, 0)
                };
                let v15 = v14;
                let (v16, v17) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v15);
                if (v16 > 0 || v17 > 0) {
                    let v18 = &v8;
                    v8 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::sub_amounts(v18, &v15);
                    assert!(arg0.protocol_fee_x <= 340282366920938463463374607431768211455 - v16, 2024);
                    assert!(arg0.protocol_fee_y <= 340282366920938463463374607431768211455 - v17, 2024);
                    arg0.protocol_fee_x = arg0.protocol_fee_x + v16;
                    arg0.protocol_fee_y = arg0.protocol_fee_y + v17;
                };
                let v19 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::sub_amounts(&v9, &v15);
                let v20 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::amounts_to_reserves(&v19);
                let v21 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::add_reserves(&v1, &v20);
                v7 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::uint256x256_math::mul_div_round_down(0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_liquidity_from_amounts(&v12, v2), (v3 as u256), 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_liquidity_from_reserves(&v21, v2));
                0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, arg3, arg5);
                let v22 = CompositionFees{
                    sender        : arg6,
                    id            : arg3,
                    total_fees    : v9,
                    protocol_fees : v15,
                };
                0x2::event::emit<CompositionFees>(v22);
            };
        } else {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::verify_amounts(&v6, arg2, arg3);
        };
        assert!(v7 > 0, 2015);
        let (v23, v24) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::get_amounts_values(&v8);
        assert!(v23 > 0 || v24 > 0, 2015);
        if (v3 == 0) {
            0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::tree_math::add(&mut arg0.tree, arg3);
        };
        let v25 = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::amounts_to_reserves(&v8);
        if (!0x2::table::contains<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&arg0.bins, arg3)) {
            0x2::table::add<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&mut arg0.bins, arg3, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::add_reserves(&v1, &v25));
        } else {
            *0x2::table::borrow_mut<u32, 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::BinReserves>(&mut arg0.bins, arg3) = 0xc7eca5603249ff2d7bf94b75f18c227a48a2f4f6cff53bf751a140918a5fa0b7::bin_helper::add_reserves(&v1, &v25);
        };
        (v7, v6, v8)
    }

    // decompiled from Move bytecode v6
}

