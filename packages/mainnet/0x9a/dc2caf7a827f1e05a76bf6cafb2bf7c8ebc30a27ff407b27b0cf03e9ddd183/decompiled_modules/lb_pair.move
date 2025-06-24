module 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair {
    struct Swap has copy, drop {
        sender: address,
        to: address,
        id: u32,
        amounts_in: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
        amounts_out: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
        volatility_accumulator: u32,
        total_fees: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
        protocol_fees: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
    }

    struct Mint has copy, drop {
        sender: address,
        ids: vector<u32>,
        amounts: vector<u256>,
    }

    struct Burn has copy, drop {
        sender: address,
        ids: vector<u32>,
        amounts: vector<u256>,
    }

    struct CollectedProtocolFees has copy, drop {
        fee_recipient: address,
        protocol_fees: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
    }

    struct FlashLoan has copy, drop {
        sender: address,
        receiver: address,
        active_id: u32,
        amounts: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
        total_fees: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
        protocol_fees: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
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

    struct DepositedToBins has copy, drop {
        sender: address,
        ids: vector<u32>,
        amounts: vector<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts>,
    }

    struct WithdrawnFromBins has copy, drop {
        sender: address,
        ids: vector<u32>,
        amounts: vector<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts>,
    }

    struct CompositionFees has copy, drop {
        sender: address,
        id: u32,
        total_fees: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
        protocol_fees: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts,
    }

    struct ReservesQueried has copy, drop {
        reserve_x: u128,
        reserve_y: u128,
    }

    struct ActiveIdQueried has copy, drop {
        active_id: u32,
    }

    struct BinQueried has copy, drop {
        id: u32,
        reserve_x: u128,
        reserve_y: u128,
    }

    struct NextNonEmptyBinQueried has copy, drop {
        swap_for_y: bool,
        id: u32,
        next_id: u32,
    }

    struct ProtocolFeesQueried has copy, drop {
        fee_x: u128,
        fee_y: u128,
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

    struct BinStepQueried has copy, drop {
        bin_step: u16,
    }

    struct TokenTypesQueried has copy, drop {
        token_x: vector<u8>,
        token_y: vector<u8>,
    }

    struct PriceFromIdQueried has copy, drop {
        id: u32,
        price: u256,
    }

    struct IdFromPriceQueried has copy, drop {
        price: u256,
        id: u32,
    }

    struct MintArrays has drop {
        ids: vector<u32>,
        amounts: vector<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts>,
        liquidity_minted: vector<u256>,
    }

    struct LBPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        token_x_type: vector<u8>,
        token_y_type: vector<u8>,
        bin_step: u16,
        parameters: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::PairParameters,
        reserve_x: u128,
        reserve_y: u128,
        protocol_fee_x: u128,
        protocol_fee_y: u128,
        bins: 0x2::table::Table<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>,
        tree: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::tree_math::TreeUint24,
        oracle: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::Oracle,
        lb_token_manager: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::LBTokenManager,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
    }

    public fun swap<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: bool, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::coin::value<T1>(&arg4);
        0x2::coin::put<T0>(&mut arg0.balance_x, arg3);
        0x2::coin::put<T1>(&mut arg0.balance_y, arg4);
        let v2 = if (arg1) {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u64_to_u128(v0), 0)
        } else {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u64_to_u128(v1))
        };
        let v3 = v2;
        let (v4, v5) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v3);
        assert!(v4 > 0 || v5 > 0, 2005);
        let v6 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u64_to_u128(v0);
        let v7 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u64_to_u128(v1);
        assert!(arg0.reserve_x <= 340282366920938463463374607431768211455 - v6, 2022);
        assert!(arg0.reserve_y <= 340282366920938463463374607431768211455 - v7, 2022);
        arg0.reserve_x = arg0.reserve_x + v6;
        arg0.reserve_y = arg0.reserve_y + v7;
        let v8 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0);
        let v9 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_active_id(&arg0.parameters);
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_references(&mut arg0.parameters, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v10 = v9;
        let v11 = 0;
        loop {
            assert!(v11 < 255, 2021);
            v11 = v11 + 1;
            let v12 = if (0x2::table::contains<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, v10)) {
                *0x2::table::borrow<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, v10)
            } else {
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_bin_reserves(0, 0)
            };
            let v13 = v12;
            if (!0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::is_empty(&v13, !arg1)) {
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_volatility_accumulator(&mut arg0.parameters, v10);
                let (v14, v15, v16) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts(&v13, &arg0.parameters, arg0.bin_step, arg1, v10, &v3);
                let v17 = v16;
                let v18 = v15;
                let v19 = v14;
                let (v20, v21) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v19);
                if (v20 > 0 || v21 > 0) {
                    let v22 = &v3;
                    v3 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::sub_amounts(v22, &v19);
                    let v23 = &v8;
                    v8 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::add_amounts(v23, &v18);
                    let v24 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                    let (v25, v26) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v17);
                    let v27 = if (v24 > 0) {
                        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::fee_helper::get_protocol_fee_amount(v25, (v24 as u128)), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::fee_helper::get_protocol_fee_amount(v26, (v24 as u128)))
                    } else {
                        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0)
                    };
                    let v28 = v27;
                    let (v29, v30) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v28);
                    if (v29 > 0 || v30 > 0) {
                        assert!(arg0.protocol_fee_x <= 340282366920938463463374607431768211455 - v29, 2024);
                        assert!(arg0.protocol_fee_y <= 340282366920938463463374607431768211455 - v30, 2024);
                        arg0.protocol_fee_x = arg0.protocol_fee_x + v29;
                        arg0.protocol_fee_y = arg0.protocol_fee_y + v30;
                        let v31 = &v19;
                        v19 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::sub_amounts(v31, &v28);
                    };
                    let v32 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::amounts_to_reserves(&v19);
                    let v33 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::add_reserves(&v13, &v32);
                    let v34 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::amounts_to_reserves(&v18);
                    *0x2::table::borrow_mut<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&mut arg0.bins, v10) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::sub_reserves(&v33, &v34);
                    let v35 = Swap{
                        sender                 : 0x2::tx_context::sender(arg6),
                        to                     : arg2,
                        id                     : v10,
                        amounts_in             : v19,
                        amounts_out            : v18,
                        volatility_accumulator : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters),
                        total_fees             : v17,
                        protocol_fees          : v28,
                    };
                    0x2::event::emit<Swap>(v35);
                };
            };
            let (v36, v37) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v3);
            if (v36 == 0 && v37 == 0) {
                break
            };
            let v38 = get_next_non_empty_bin<T0, T1>(arg0, arg1, v10);
            if (v38 == 0 || v38 == v9) {
                abort 2011
            };
            v10 = v38;
        };
        let (v39, v40) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v8);
        assert!(v39 > 0 || v40 > 0, 2006);
        if (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, v10, arg5)) {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::set_active_id(&mut arg0.parameters, v10);
        };
        assert!(arg0.reserve_x >= v39, 2023);
        assert!(arg0.reserve_y >= v40, 2023);
        arg0.reserve_x = arg0.reserve_x - v39;
        arg0.reserve_y = arg0.reserve_y - v40;
        (0x2::coin::take<T0>(&mut arg0.balance_x, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v39), arg6), 0x2::coin::take<T1>(&mut arg0.balance_y, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v40), arg6))
    }

    public fun get_reserves<T0, T1>(arg0: &LBPair<T0, T1>) : (u128, u128) {
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
        let v2 = ReservesQueried{
            reserve_x : v0,
            reserve_y : v1,
        };
        0x2::event::emit<ReservesQueried>(v2);
        (v0, v1)
    }

    public fun burn<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::LBTokenBucket, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, vector<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts>) {
        assert!(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::bucket_pool_id(arg1) == 0x2::object::uid_to_inner(&arg0.id), 2025);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::collect_bucket_tokens_for_burn(arg1, &arg0.lb_token_manager);
        let v3 = v2;
        let v4 = v1;
        assert!(0x1::vector::length<u32>(&v4) > 0, 2007);
        let v5 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0);
        let v6 = 0x1::vector::empty<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u32>(&v4)) {
            let v8 = *0x1::vector::borrow<u32>(&v4, v7);
            let v9 = *0x1::vector::borrow<u256>(&v3, v7);
            assert!(v9 > 0, 2013);
            assert!(v8 <= 16777215, 2020);
            let v10 = if (0x2::table::contains<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, v8)) {
                *0x2::table::borrow<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, v8)
            } else {
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_bin_reserves(0, 0)
            };
            let v11 = v10;
            let v12 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::total_supply(&arg0.lb_token_manager, v8);
            let v13 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amount_out_of_bin(&v11, v9, v12);
            let (v14, v15) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v13);
            assert!(v14 > 0 || v15 > 0, 2014);
            let v16 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::amounts_to_reserves(&v13);
            if (v12 == v9) {
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::tree_math::remove(&mut arg0.tree, v8);
            };
            *0x2::table::borrow_mut<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&mut arg0.bins, v8) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::sub_reserves(&v11, &v16);
            let v17 = &v5;
            v5 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::add_amounts(v17, &v13);
            0x1::vector::push_back<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts>(&mut v6, v13);
            v7 = v7 + 1;
        };
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::burn(&mut arg0.lb_token_manager, arg1, v0);
        let (v18, v19) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v5);
        assert!(arg0.reserve_x >= v18, 2023);
        assert!(arg0.reserve_y >= v19, 2023);
        arg0.reserve_x = arg0.reserve_x - v18;
        arg0.reserve_y = arg0.reserve_y - v19;
        let v20 = Burn{
            sender  : v0,
            ids     : v4,
            amounts : v3,
        };
        0x2::event::emit<Burn>(v20);
        let v21 = WithdrawnFromBins{
            sender  : v0,
            ids     : v4,
            amounts : v6,
        };
        0x2::event::emit<WithdrawnFromBins>(v21);
        (0x2::coin::take<T0>(&mut arg0.balance_x, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v18), arg2), 0x2::coin::take<T1>(&mut arg0.balance_y, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v19), arg2), v6)
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
            protocol_fees : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(v2, v3),
        };
        0x2::event::emit<CollectedProtocolFees>(v4);
        (0x2::coin::take<T0>(&mut arg0.balance_x, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v2), arg1), 0x2::coin::take<T1>(&mut arg0.balance_y, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v3), arg1))
    }

    public fun create_lb_bucket<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::LBTokenBucket {
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::create_empty_bucket(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    fun create_liquidity_configs_from_params(arg0: &vector<u32>, arg1: &vector<u64>, arg2: &vector<u64>) : vector<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations::LiquidityConfig> {
        let v0 = 0x1::vector::length<u32>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 2007);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 2007);
        let v1 = 0x1::vector::empty<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations::LiquidityConfig>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations::LiquidityConfig>(&mut v1, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations::new_config(*0x1::vector::borrow<u64>(arg1, v2), *0x1::vector::borrow<u64>(arg2, v2), *0x1::vector::borrow<u32>(arg0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun create_pair<T0, T1>(arg0: vector<u8>, arg1: vector<u8>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : LBPair<T0, T1> {
        let v0 = 0x2::object::new(arg3);
        LBPair<T0, T1>{
            id               : v0,
            token_x_type     : arg0,
            token_y_type     : arg1,
            bin_step         : arg2,
            parameters       : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::new(0),
            reserve_x        : 0,
            reserve_y        : 0,
            protocol_fee_x   : 0,
            protocol_fee_y   : 0,
            bins             : 0x2::table::new<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(arg3),
            tree             : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::tree_math::empty(arg3),
            oracle           : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::new(),
            lb_token_manager : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::new(0x2::object::uid_to_inner(&v0), arg3),
            balance_x        : 0x2::balance::zero<T0>(),
            balance_y        : 0x2::balance::zero<T1>(),
        }
    }

    public(friend) fun force_decay<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_volatility_reference(&mut arg0.parameters);
        let v0 = ForcedDecay{
            sender               : 0x2::tx_context::sender(arg1),
            id_reference         : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_id_reference(&arg0.parameters),
            volatility_reference : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_volatility_reference(&arg0.parameters),
        };
        0x2::event::emit<ForcedDecay>(v0);
    }

    public fun get_active_id<T0, T1>(arg0: &LBPair<T0, T1>) : u32 {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_active_id(&arg0.parameters);
        let v1 = ActiveIdQueried{active_id: v0};
        0x2::event::emit<ActiveIdQueried>(v1);
        v0
    }

    public fun get_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : (u128, u128) {
        assert!(arg1 <= 16777215, 2020);
        let (v0, v1) = if (0x2::table::contains<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, arg1)) {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_reserves(0x2::table::borrow<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, arg1))
        } else {
            (0, 0)
        };
        let v2 = BinQueried{
            id        : arg1,
            reserve_x : v0,
            reserve_y : v1,
        };
        0x2::event::emit<BinQueried>(v2);
        (v0, v1)
    }

    public fun get_bin_step<T0, T1>(arg0: &LBPair<T0, T1>) : u16 {
        let v0 = arg0.bin_step;
        let v1 = BinStepQueried{bin_step: v0};
        0x2::event::emit<BinStepQueried>(v1);
        v0
    }

    public fun get_id_from_price<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u256) : u32 {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::price_helper::get_id_from_price(arg1, arg0.bin_step);
        let v1 = IdFromPriceQueried{
            price : arg1,
            id    : v0,
        };
        0x2::event::emit<IdFromPriceQueried>(v1);
        v0
    }

    public fun get_next_non_empty_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: bool, arg2: u32) : u32 {
        let v0 = if (arg1) {
            let v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::tree_math::find_first_right(&arg0.tree, arg2);
            if (v1 == 16777215) {
                0
            } else {
                v1
            }
        } else {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::tree_math::find_first_left(&arg0.tree, arg2)
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
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let (v1, v2, v3, v4, v5) = if (v0 == 0) {
            (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::get_max_sample_lifetime(), 0, 0, 0, 0)
        } else {
            let (v6, v7) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::get_active_sample_and_size(&arg0.oracle, v0);
            let v8 = v6;
            let v9 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::get_sample_last_update(&v8);
            let v10 = if (v9 == 0) {
                0
            } else {
                v7
            };
            let v11 = if (v10 > 0) {
                let v12 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::get_sample(&arg0.oracle, 1 + v0 % v10);
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::get_sample_last_update(&v12)
            } else {
                0
            };
            (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::get_max_sample_lifetime(), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::get_oracle_length(&v8), v10, v9, v11)
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
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_oracle_id(&arg0.parameters);
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
        let (v2, v3, v4, v5) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::get_sample_at(&arg0.oracle, v0, arg1);
        let v6 = v4;
        let v7 = v3;
        if (v2 < arg1) {
            let v8 = arg1 - v2;
            v7 = v3 + (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_active_id(&arg0.parameters) as u64) * v8;
            v6 = v4 + (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters) as u64) * v8;
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
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::price_helper::get_price_from_id(arg1, arg0.bin_step);
        let v1 = PriceFromIdQueried{
            id    : arg1,
            price : v0,
        };
        0x2::event::emit<PriceFromIdQueried>(v1);
        v0
    }

    public fun get_protocol_fees<T0, T1>(arg0: &LBPair<T0, T1>) : (u128, u128) {
        let v0 = arg0.protocol_fee_x;
        let v1 = arg0.protocol_fee_y;
        let v2 = ProtocolFeesQueried{
            fee_x : v0,
            fee_y : v1,
        };
        0x2::event::emit<ProtocolFeesQueried>(v2);
        (v0, v1)
    }

    public fun get_static_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u16, u16, u16, u16, u32, u16, u32) {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_base_factor(&arg0.parameters);
        let v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_filter_period(&arg0.parameters);
        let v2 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_decay_period(&arg0.parameters);
        let v3 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_reduction_factor(&arg0.parameters);
        let v4 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_variable_fee_control(&arg0.parameters);
        let v5 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_protocol_share(&arg0.parameters);
        let v6 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_max_volatility_accumulator(&arg0.parameters);
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
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u64_to_u128(arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = arg0.parameters;
        let v4 = arg0.bin_step;
        let v5 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_active_id(&v3);
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_references(&mut v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = if (0x2::table::contains<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, v6)) {
                *0x2::table::borrow<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, v6)
            } else {
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_bin_reserves(0, 0)
            };
            let v9 = v8;
            let v10 = if (arg2) {
                let (_, v12) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_reserves(&v9);
                v12
            } else {
                let (v13, _) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_reserves(&v9);
                v13
            };
            if (v10 > 0) {
                let v15 = if (v10 > v0) {
                    v0
                } else {
                    v10
                };
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_volatility_accumulator(&mut v3, v6);
                let v16 = if (arg2) {
                    0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::safe128(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint256x256_math::shift_div_round_up((v15 as u256), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::constants::scale_offset(), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::price_helper::get_price_from_id(v6, v4)))
                } else {
                    0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::safe128(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint256x256_math::mul_shift_round_up((v15 as u256), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::price_helper::get_price_from_id(v6, v4), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::constants::scale_offset()))
                };
                let v17 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::fee_helper::get_fee_amount(v16, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_total_fee(&v3, v4));
                let v18 = v1 + v16;
                v1 = v18 + v17;
                v0 = v0 - v15;
                v2 = v2 + v17;
            };
            if (v0 == 0) {
                break
            };
            v6 = get_next_non_empty_bin<T0, T1>(arg0, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v1), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v0), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v2))
    }

    public fun get_swap_out<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = if (arg2) {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u64_to_u128(arg1), 0)
        } else {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u64_to_u128(arg1))
        };
        let v1 = v0;
        let v2 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0);
        let v3 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0);
        let v4 = arg0.parameters;
        let v5 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_active_id(&v4);
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_references(&mut v4, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = if (0x2::table::contains<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, v6)) {
                *0x2::table::borrow<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, v6)
            } else {
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_bin_reserves(0, 0)
            };
            let v9 = v8;
            if (!0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::is_empty(&v9, !arg2)) {
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_volatility_accumulator(&mut v4, v6);
                let (v10, v11, v12) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts(&v9, &v4, arg0.bin_step, arg2, v6, &v1);
                let v13 = v12;
                let v14 = v11;
                let v15 = v10;
                let (v16, v17) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v15);
                if (v16 > 0 || v17 > 0) {
                    let v18 = &v1;
                    v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::sub_amounts(v18, &v15);
                    let v19 = &v2;
                    v2 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::add_amounts(v19, &v14);
                    let v20 = &v3;
                    v3 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::add_amounts(v20, &v13);
                };
            };
            let (v21, v22) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v1);
            if (v21 == 0 && v22 == 0) {
                break
            };
            v6 = get_next_non_empty_bin<T0, T1>(arg0, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        let (v23, v24) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v1);
        let (v25, v26) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v2);
        let (v27, v28) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v3);
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
        (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v29), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v30), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v31))
    }

    public fun get_token_x_type<T0, T1>(arg0: &LBPair<T0, T1>) : vector<u8> {
        let v0 = arg0.token_x_type;
        let v1 = TokenTypesQueried{
            token_x : v0,
            token_y : arg0.token_y_type,
        };
        0x2::event::emit<TokenTypesQueried>(v1);
        v0
    }

    public fun get_token_y_type<T0, T1>(arg0: &LBPair<T0, T1>) : vector<u8> {
        let v0 = arg0.token_y_type;
        let v1 = TokenTypesQueried{
            token_x : arg0.token_x_type,
            token_y : v0,
        };
        0x2::event::emit<TokenTypesQueried>(v1);
        v0
    }

    public fun get_variable_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u32, u32, u32, u64) {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters);
        let v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_volatility_reference(&arg0.parameters);
        let v2 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_id_reference(&arg0.parameters);
        let v3 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_time_of_last_update(&arg0.parameters);
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
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let v1 = v0;
        if (v0 == 0) {
            let v2 = 1;
            v1 = v2;
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::set_oracle_id(&mut arg0.parameters, v2);
        };
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::increase_length(&mut arg0.oracle, v1, arg1);
        let v3 = OracleLengthIncreased{
            sender     : 0x2::tx_context::sender(arg2),
            new_length : arg1,
        };
        0x2::event::emit<OracleLengthIncreased>(v3);
    }

    public(friend) fun initialize<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: u32, arg9: &0x2::tx_context::TxContext) {
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::set_active_id(&mut arg0.parameters, arg8);
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        set_static_fee_parameters_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
    }

    public fun mint<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: vector<u32>, arg2: vector<u64>, arg3: vector<u64>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::LBTokenBucket, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (vector<u32>, vector<u256>, vector<0x2::object::ID>) {
        assert!(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::bucket_pool_id(arg6) == 0x2::object::uid_to_inner(&arg0.id), 2025);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x1::vector::length<u32>(&arg1) > 0, 2002);
        let v1 = create_liquidity_configs_from_params(&arg1, &arg2, &arg3);
        let v2 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u64_to_u128(0x2::coin::value<T0>(&arg4)), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u64_to_u128(0x2::coin::value<T1>(&arg5)));
        0x2::coin::put<T0>(&mut arg0.balance_x, arg4);
        0x2::coin::put<T1>(&mut arg0.balance_y, arg5);
        let (v3, v4) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v2);
        assert!(arg0.reserve_x <= 340282366920938463463374607431768211455 - v3, 2022);
        assert!(arg0.reserve_y <= 340282366920938463463374607431768211455 - v4, 2022);
        arg0.reserve_x = arg0.reserve_x + v3;
        arg0.reserve_y = arg0.reserve_y + v4;
        let v5 = MintArrays{
            ids              : 0x1::vector::empty<u32>(),
            amounts          : 0x1::vector::empty<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts>(),
            liquidity_minted : 0x1::vector::empty<u256>(),
        };
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = &mut v5;
        let v8 = &mut v6;
        let v9 = mint_bins<T0, T1>(arg0, &v1, v2, v7, v8, arg6, arg7, arg8);
        let (v10, v11) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v9);
        if (v10 > 0 || v11 > 0) {
            assert!(arg0.reserve_x >= v10, 2023);
            assert!(arg0.reserve_y >= v11, 2023);
            arg0.reserve_x = arg0.reserve_x - v10;
            arg0.reserve_y = arg0.reserve_y - v11;
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance_x, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v10), arg8), v0);
            };
            if (v11 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.balance_y, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::u128_to_u64(v11), arg8), v0);
            };
        };
        let v12 = Mint{
            sender  : v0,
            ids     : v5.ids,
            amounts : v5.liquidity_minted,
        };
        0x2::event::emit<Mint>(v12);
        let v13 = DepositedToBins{
            sender  : v0,
            ids     : v5.ids,
            amounts : v5.amounts,
        };
        0x2::event::emit<DepositedToBins>(v13);
        (v5.ids, v5.liquidity_minted, v6)
    }

    fun mint_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &vector<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations::LiquidityConfig>, arg2: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts, arg3: &mut MintArrays, arg4: &mut vector<0x2::object::ID>, arg5: &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::LBTokenBucket, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg2;
        let v2 = 0;
        let v3 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_active_id(&arg0.parameters);
        let v4 = arg0.bin_step;
        let (v5, v6) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&arg2);
        while (v2 < 0x1::vector::length<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations::LiquidityConfig>(arg1)) {
            let v7 = 0x1::vector::borrow<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations::LiquidityConfig>(arg1, v2);
            let v8 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations::get_id(v7);
            let (v9, v10) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations::apply_distribution(v7, v5, v6);
            let v11 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(v9, v10);
            let (v12, v13, v14) = update_bin<T0, T1>(arg0, v4, v3, v8, &v11, arg6, v0);
            let v15 = v13;
            if (v12 > 0) {
                let v16 = &v1;
                v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::sub_amounts(v16, &v15);
                0x1::vector::push_back<u32>(&mut arg3.ids, v8);
                0x1::vector::push_back<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts>(&mut arg3.amounts, v14);
                0x1::vector::push_back<u256>(&mut arg3.liquidity_minted, v12);
                0x1::vector::push_back<0x2::object::ID>(arg4, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::mint(&mut arg0.lb_token_manager, arg5, v0, v8, v12, arg7));
            };
            v2 = v2 + 1;
        };
        v1
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
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = arg0.bin_step;
        let v2 = arg0.parameters;
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::set_volatility_accumulator(&mut v2, arg7);
        assert!(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_base_fee(&v2, v1) + 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_variable_fee(&v2, v1) <= 100000000000000000, 2016);
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

    fun update_bin<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: u32, arg3: u32, arg4: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts, arg5: &0x2::clock::Clock, arg6: address) : (u256, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::Amounts) {
        let v0 = if (0x2::table::contains<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, arg3)) {
            *0x2::table::borrow<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, arg3)
        } else {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_bin_reserves(0, 0)
        };
        let v1 = v0;
        let v2 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::price_helper::get_price_from_id(arg3, arg1);
        let v3 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::total_supply(&arg0.lb_token_manager, arg3);
        let (v4, v5) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_shares_and_effective_amounts_in(&v1, arg4, v2, v3);
        let v6 = v5;
        let v7 = v4;
        if (v4 == 0) {
            return (0, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0))
        };
        let v8 = v6;
        if (arg3 == arg2) {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::update_volatility_parameters(&mut arg0.parameters, arg3, 0x2::clock::timestamp_ms(arg5) / 1000);
            let v9 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_composition_fees(&v1, &arg0.parameters, arg1, &v6, v3, v4);
            let (v10, v11) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v9);
            if (v10 > 0 || v11 > 0) {
                let v12 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::sub_amounts(&v6, &v9);
                let v13 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                let v14 = if (v13 > 0) {
                    0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::fee_helper::get_protocol_fee_amount(v10, (v13 as u128)), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::fee_helper::get_protocol_fee_amount(v11, (v13 as u128)))
                } else {
                    0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::new_amounts(0, 0)
                };
                let v15 = v14;
                let (v16, v17) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v15);
                if (v16 > 0 || v17 > 0) {
                    let v18 = &v8;
                    v8 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::sub_amounts(v18, &v15);
                    assert!(arg0.protocol_fee_x <= 340282366920938463463374607431768211455 - v16, 2024);
                    assert!(arg0.protocol_fee_y <= 340282366920938463463374607431768211455 - v17, 2024);
                    arg0.protocol_fee_x = arg0.protocol_fee_x + v16;
                    arg0.protocol_fee_y = arg0.protocol_fee_y + v17;
                };
                let v19 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::sub_amounts(&v9, &v15);
                let v20 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::amounts_to_reserves(&v19);
                let v21 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::add_reserves(&v1, &v20);
                v7 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint256x256_math::mul_div_round_down(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_liquidity_from_amounts(&v12, v2), v3, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_liquidity_from_reserves(&v21, v2));
                0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, arg3, arg5);
                let v22 = CompositionFees{
                    sender        : arg6,
                    id            : arg3,
                    total_fees    : v9,
                    protocol_fees : v15,
                };
                0x2::event::emit<CompositionFees>(v22);
            };
        } else {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::verify_amounts(&v6, arg2, arg3);
        };
        assert!(v7 > 0, 2015);
        let (v23, v24) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::get_amounts_values(&v8);
        assert!(v23 > 0 || v24 > 0, 2015);
        if (v3 == 0) {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::tree_math::add(&mut arg0.tree, arg3);
        };
        let v25 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::amounts_to_reserves(&v8);
        if (!0x2::table::contains<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&arg0.bins, arg3)) {
            0x2::table::add<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&mut arg0.bins, arg3, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::add_reserves(&v1, &v25));
        } else {
            *0x2::table::borrow_mut<u32, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::BinReserves>(&mut arg0.bins, arg3) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::bin_helper::add_reserves(&v1, &v25);
        };
        (v7, v6, v8)
    }

    // decompiled from Move bytecode v6
}

