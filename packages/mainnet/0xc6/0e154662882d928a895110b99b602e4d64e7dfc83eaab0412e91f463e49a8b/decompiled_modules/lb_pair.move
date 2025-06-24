module 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_pair {
    struct Swap has copy, drop {
        sender: address,
        to: address,
        id: u32,
        amounts_in: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
        amounts_out: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
        volatility_accumulator: u32,
        total_fees: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
        protocol_fees: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
    }

    struct Mint has copy, drop {
        sender: address,
        ids: vector<u64>,
        amounts: vector<u256>,
    }

    struct Burn has copy, drop {
        sender: address,
        ids: vector<u64>,
        amounts: vector<u256>,
    }

    struct CollectedProtocolFees has copy, drop {
        fee_recipient: address,
        protocol_fees: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
    }

    struct FlashLoan has copy, drop {
        sender: address,
        receiver: address,
        active_id: u32,
        amounts: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
        total_fees: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
        protocol_fees: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
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
        ids: vector<u64>,
        amounts: vector<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts>,
    }

    struct WithdrawnFromBins has copy, drop {
        sender: address,
        ids: vector<u64>,
        amounts: vector<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts>,
    }

    struct CompositionFees has copy, drop {
        sender: address,
        id: u32,
        total_fees: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
        protocol_fees: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts,
    }

    struct MintArrays has drop {
        ids: vector<u64>,
        amounts: vector<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts>,
        liquidity_minted: vector<u256>,
    }

    struct LBPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        token_x_type: vector<u8>,
        token_y_type: vector<u8>,
        bin_step: u16,
        parameters: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::PairParameters,
        reserve_x: u128,
        reserve_y: u128,
        protocol_fee_x: u128,
        protocol_fee_y: u128,
        bins: 0x2::table::Table<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>,
        tree: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::tree_math::TreeUint24,
        oracle: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::Oracle,
        lb_token_manager: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::LBTokenManager,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
    }

    public fun swap<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: bool, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::coin::value<T1>(&arg4);
        0x2::coin::put<T0>(&mut arg0.balance_x, arg3);
        0x2::coin::put<T1>(&mut arg0.balance_y, arg4);
        let v2 = if (arg1) {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u64_to_u128(v0), 0)
        } else {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u64_to_u128(v1))
        };
        let v3 = v2;
        let (v4, v5) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v3);
        assert!(v4 > 0 || v5 > 0, 2005);
        let v6 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u64_to_u128(v0);
        let v7 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u64_to_u128(v1);
        assert!(arg0.reserve_x <= 340282366920938463463374607431768211455 - v6, 2022);
        assert!(arg0.reserve_y <= 340282366920938463463374607431768211455 - v7, 2022);
        arg0.reserve_x = arg0.reserve_x + v6;
        arg0.reserve_y = arg0.reserve_y + v7;
        let v8 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, 0);
        let v9 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_active_id(&arg0.parameters);
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_references(&mut arg0.parameters, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v10 = v9;
        let v11 = 0;
        loop {
            assert!(v11 < 255, 2021);
            v11 = v11 + 1;
            let v12 = (v10 as u64);
            let v13 = if (0x2::table::contains<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v12)) {
                *0x2::table::borrow<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v12)
            } else {
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_bin_reserves(0, 0)
            };
            let v14 = v13;
            if (!0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::is_empty(&v14, !arg1)) {
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_volatility_accumulator(&mut arg0.parameters, v10);
                let (v15, v16, v17) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts(&v14, &arg0.parameters, arg0.bin_step, arg1, v10, &v3);
                let v18 = v17;
                let v19 = v16;
                let v20 = v15;
                let (v21, v22) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v20);
                if (v21 > 0 || v22 > 0) {
                    let v23 = &v3;
                    v3 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::sub_amounts(v23, &v20);
                    let v24 = &v8;
                    v8 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::add_amounts(v24, &v19);
                    let v25 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                    let (v26, v27) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v18);
                    let v28 = if (v25 > 0) {
                        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::fee_helper::get_protocol_fee_amount(v26, (v25 as u128)), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::fee_helper::get_protocol_fee_amount(v27, (v25 as u128)))
                    } else {
                        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, 0)
                    };
                    let v29 = v28;
                    let (v30, v31) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v29);
                    if (v30 > 0 || v31 > 0) {
                        assert!(arg0.protocol_fee_x <= 340282366920938463463374607431768211455 - v30, 2024);
                        assert!(arg0.protocol_fee_y <= 340282366920938463463374607431768211455 - v31, 2024);
                        arg0.protocol_fee_x = arg0.protocol_fee_x + v30;
                        arg0.protocol_fee_y = arg0.protocol_fee_y + v31;
                        let v32 = &v20;
                        v20 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::sub_amounts(v32, &v29);
                    };
                    let v33 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::amounts_to_reserves(&v20);
                    let v34 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::add_reserves(&v14, &v33);
                    let v35 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::amounts_to_reserves(&v19);
                    *0x2::table::borrow_mut<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&mut arg0.bins, v12) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::sub_reserves(&v34, &v35);
                    let v36 = Swap{
                        sender                 : 0x2::tx_context::sender(arg6),
                        to                     : arg2,
                        id                     : v10,
                        amounts_in             : v20,
                        amounts_out            : v19,
                        volatility_accumulator : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters),
                        total_fees             : v18,
                        protocol_fees          : v29,
                    };
                    0x2::event::emit<Swap>(v36);
                };
            };
            let (v37, v38) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v3);
            if (v37 == 0 && v38 == 0) {
                break
            };
            let v39 = get_next_non_empty_bin<T0, T1>(arg0, arg1, v10);
            if (v39 == 0 || v39 == v9) {
                abort 2011
            };
            v10 = v39;
        };
        let (v40, v41) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v8);
        assert!(v40 > 0 || v41 > 0, 2006);
        if (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, v10, arg5)) {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::set_active_id(&mut arg0.parameters, v10);
        };
        assert!(arg0.reserve_x >= v40, 2023);
        assert!(arg0.reserve_y >= v41, 2023);
        arg0.reserve_x = arg0.reserve_x - v40;
        arg0.reserve_y = arg0.reserve_y - v41;
        (0x2::coin::take<T0>(&mut arg0.balance_x, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u128_to_u64(v40), arg6), 0x2::coin::take<T1>(&mut arg0.balance_y, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u128_to_u64(v41), arg6))
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
        (v0, v1)
    }

    public fun burn<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &mut 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::LBTokenBucket, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, vector<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts>) {
        assert!(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::bucket_pool_id(arg1) == 0x2::object::uid_to_inner(&arg0.id), 2025);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::collect_bucket_tokens_for_burn(arg1, &arg0.lb_token_manager);
        let v3 = v2;
        let v4 = v1;
        assert!(0x1::vector::length<u64>(&v4) > 0, 2007);
        let v5 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, 0);
        let v6 = 0x1::vector::empty<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v4)) {
            let v8 = *0x1::vector::borrow<u64>(&v4, v7);
            let v9 = *0x1::vector::borrow<u256>(&v3, v7);
            assert!(v9 > 0, 2013);
            assert!(v8 <= (16777215 as u64), 2020);
            let v10 = if (0x2::table::contains<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v8)) {
                *0x2::table::borrow<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v8)
            } else {
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_bin_reserves(0, 0)
            };
            let v11 = v10;
            let v12 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::total_supply(&arg0.lb_token_manager, (v8 as u256));
            let v13 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amount_out_of_bin(&v11, v9, v12);
            let (v14, v15) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v13);
            assert!(v14 > 0 || v15 > 0, 2014);
            let v16 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::amounts_to_reserves(&v13);
            if (v12 == v9) {
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::tree_math::remove(&mut arg0.tree, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u64_to_u32(v8));
            };
            *0x2::table::borrow_mut<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&mut arg0.bins, v8) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::sub_reserves(&v11, &v16);
            let v17 = &v5;
            v5 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::add_amounts(v17, &v13);
            0x1::vector::push_back<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts>(&mut v6, v13);
            v7 = v7 + 1;
        };
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::burn(&mut arg0.lb_token_manager, arg1, v0);
        let (v18, v19) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v5);
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
        (0x2::coin::take<T0>(&mut arg0.balance_x, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u128_to_u64(v18), arg2), 0x2::coin::take<T1>(&mut arg0.balance_y, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u128_to_u64(v19), arg2), v6)
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
            protocol_fees : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(v2, v3),
        };
        0x2::event::emit<CollectedProtocolFees>(v4);
        (0x2::coin::take<T0>(&mut arg0.balance_x, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u128_to_u64(v2), arg1), 0x2::coin::take<T1>(&mut arg0.balance_y, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u128_to_u64(v3), arg1))
    }

    public fun create_lb_bucket<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::LBTokenBucket {
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::create_empty_bucket(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    fun create_liquidity_configs_from_params(arg0: &vector<u32>, arg1: &vector<u64>, arg2: &vector<u64>) : vector<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::liquidity_configurations::LiquidityConfig> {
        let v0 = 0x1::vector::length<u32>(arg0);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 2007);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 2007);
        let v1 = 0x1::vector::empty<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::liquidity_configurations::LiquidityConfig>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::liquidity_configurations::LiquidityConfig>(&mut v1, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::liquidity_configurations::new_config(*0x1::vector::borrow<u64>(arg1, v2), *0x1::vector::borrow<u64>(arg2, v2), *0x1::vector::borrow<u32>(arg0, v2)));
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
            parameters       : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::new(0),
            reserve_x        : 0,
            reserve_y        : 0,
            protocol_fee_x   : 0,
            protocol_fee_y   : 0,
            bins             : 0x2::table::new<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(arg3),
            tree             : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::tree_math::empty(arg3),
            oracle           : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::new(),
            lb_token_manager : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::new(0x2::object::uid_to_inner(&v0), arg3),
            balance_x        : 0x2::balance::zero<T0>(),
            balance_y        : 0x2::balance::zero<T1>(),
        }
    }

    public(friend) fun force_decay<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_volatility_reference(&mut arg0.parameters);
        let v0 = ForcedDecay{
            sender               : 0x2::tx_context::sender(arg1),
            id_reference         : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_id_reference(&arg0.parameters),
            volatility_reference : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_volatility_reference(&arg0.parameters),
        };
        0x2::event::emit<ForcedDecay>(v0);
    }

    public fun get_active_id<T0, T1>(arg0: &LBPair<T0, T1>) : u32 {
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_active_id(&arg0.parameters)
    }

    public fun get_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : (u128, u128) {
        assert!(arg1 <= 16777215, 2020);
        let v0 = (arg1 as u64);
        if (0x2::table::contains<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v0)) {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_reserves(0x2::table::borrow<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v0))
        } else {
            (0, 0)
        }
    }

    public fun get_bin_step<T0, T1>(arg0: &LBPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun get_id_from_price<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u256) : u32 {
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::price_helper::get_id_from_price(arg1, arg0.bin_step)
    }

    public fun get_next_non_empty_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: bool, arg2: u32) : u32 {
        if (arg1) {
            let v1 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::tree_math::find_first_right(&arg0.tree, arg2);
            if (v1 == 16777215) {
                0
            } else {
                v1
            }
        } else {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::tree_math::find_first_left(&arg0.tree, arg2)
        }
    }

    public fun get_oracle_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u8, u16, u16, u64, u64) {
        let v0 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        if (v0 == 0) {
            (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::get_max_sample_lifetime(), 0, 0, 0, 0)
        } else {
            let (v6, v7) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::get_active_sample_and_size(&arg0.oracle, v0);
            let v8 = v6;
            let v9 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::get_sample_last_update(&v8);
            let v10 = if (v9 == 0) {
                0
            } else {
                v7
            };
            let v11 = if (v10 > 0) {
                let v12 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::get_sample(&arg0.oracle, 1 + v0 % v10);
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::get_sample_last_update(&v12)
            } else {
                0
            };
            (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::get_max_sample_lifetime(), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::get_oracle_length(&v8), v10, v9, v11)
        }
    }

    public fun get_oracle_sample_at<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        if (v0 == 0 || arg1 > 0x2::clock::timestamp_ms(arg2) / 1000) {
            return (0, 0, 0)
        };
        let (v1, v2, v3, v4) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::get_sample_at(&arg0.oracle, v0, arg1);
        let v5 = v3;
        let v6 = v2;
        if (v1 < arg1) {
            let v7 = arg1 - v1;
            v6 = v2 + (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_active_id(&arg0.parameters) as u64) * v7;
            v5 = v3 + (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters) as u64) * v7;
        };
        (v6, v5, v4)
    }

    public fun get_price_from_id<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : u256 {
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::price_helper::get_price_from_id(arg1, arg0.bin_step)
    }

    public fun get_protocol_fees<T0, T1>(arg0: &LBPair<T0, T1>) : (u128, u128) {
        (arg0.protocol_fee_x, arg0.protocol_fee_y)
    }

    public fun get_static_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u16, u16, u16, u16, u32, u16, u32) {
        (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_base_factor(&arg0.parameters), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_filter_period(&arg0.parameters), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_decay_period(&arg0.parameters), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_reduction_factor(&arg0.parameters), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_variable_fee_control(&arg0.parameters), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_protocol_share(&arg0.parameters), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_max_volatility_accumulator(&arg0.parameters))
    }

    public fun get_swap_in<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u128, arg2: bool, arg3: &0x2::clock::Clock) : (u128, u128, u128) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = arg0.parameters;
        let v4 = arg0.bin_step;
        let v5 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_active_id(&v3);
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_references(&mut v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = (v6 as u64);
            let v9 = if (0x2::table::contains<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v8)) {
                *0x2::table::borrow<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v8)
            } else {
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_bin_reserves(0, 0)
            };
            let v10 = v9;
            let v11 = if (arg2) {
                let (_, v13) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_reserves(&v10);
                v13
            } else {
                let (v14, _) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_reserves(&v10);
                v14
            };
            if (v11 > 0) {
                let v16 = if (v11 > v0) {
                    v0
                } else {
                    v11
                };
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_volatility_accumulator(&mut v3, v6);
                let v17 = if (arg2) {
                    0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_cast::safe128(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::uint256x256_math::shift_div_round_up((v16 as u256), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::constants::scale_offset(), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::price_helper::get_price_from_id(v6, v4)))
                } else {
                    0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_cast::safe128(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::uint256x256_math::mul_shift_round_up((v16 as u256), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::price_helper::get_price_from_id(v6, v4), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::constants::scale_offset()))
                };
                let v18 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::fee_helper::get_fee_amount(v17, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_total_fee(&v3, v4));
                let v19 = v1 + v17;
                v1 = v19 + v18;
                v0 = v0 - v16;
                v2 = v2 + v18;
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

    public fun get_swap_out<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u128, arg2: bool, arg3: &0x2::clock::Clock) : (u128, u128, u128) {
        let v0 = if (arg2) {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(arg1, 0)
        } else {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, arg1)
        };
        let v1 = v0;
        let v2 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, 0);
        let v3 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, 0);
        let v4 = arg0.parameters;
        let v5 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_active_id(&v4);
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_references(&mut v4, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v6 = v5;
        let v7 = 0;
        loop {
            assert!(v7 < 255, 2021);
            v7 = v7 + 1;
            let v8 = (v6 as u64);
            let v9 = if (0x2::table::contains<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v8)) {
                *0x2::table::borrow<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v8)
            } else {
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_bin_reserves(0, 0)
            };
            let v10 = v9;
            if (!0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::is_empty(&v10, !arg2)) {
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_volatility_accumulator(&mut v4, v6);
                let (v11, v12, v13) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts(&v10, &v4, arg0.bin_step, arg2, v6, &v1);
                let v14 = v13;
                let v15 = v12;
                let v16 = v11;
                let (v17, v18) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v16);
                if (v17 > 0 || v18 > 0) {
                    let v19 = &v1;
                    v1 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::sub_amounts(v19, &v16);
                    let v20 = &v2;
                    v2 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::add_amounts(v20, &v15);
                    let v21 = &v3;
                    v3 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::add_amounts(v21, &v14);
                };
            };
            let (v22, v23) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v1);
            if (v22 == 0 && v23 == 0) {
                break
            };
            v6 = get_next_non_empty_bin<T0, T1>(arg0, arg2, v6);
            if (v6 == 0 || v6 == v5) {
                break
            };
        };
        let (v24, v25) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v1);
        let (v26, v27) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v2);
        let (v28, v29) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v3);
        let v30 = if (arg2) {
            v24
        } else {
            v25
        };
        let v31 = if (arg2) {
            v27
        } else {
            v26
        };
        let v32 = if (arg2) {
            v28
        } else {
            v29
        };
        (v30, v31, v32)
    }

    public fun get_token_x_type<T0, T1>(arg0: &LBPair<T0, T1>) : vector<u8> {
        arg0.token_x_type
    }

    public fun get_token_y_type<T0, T1>(arg0: &LBPair<T0, T1>) : vector<u8> {
        arg0.token_y_type
    }

    public fun get_variable_fee_parameters<T0, T1>(arg0: &LBPair<T0, T1>) : (u32, u32, u32, u64) {
        (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_volatility_accumulator(&arg0.parameters), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_volatility_reference(&arg0.parameters), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_id_reference(&arg0.parameters), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_time_of_last_update(&arg0.parameters))
    }

    public fun increase_oracle_length<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_oracle_id(&arg0.parameters);
        let v1 = v0;
        if (v0 == 0) {
            let v2 = 1;
            v1 = v2;
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::set_oracle_id(&mut arg0.parameters, v2);
        };
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::increase_length(&mut arg0.oracle, v1, arg1);
        let v3 = OracleLengthIncreased{
            sender     : 0x2::tx_context::sender(arg2),
            new_length : arg1,
        };
        0x2::event::emit<OracleLengthIncreased>(v3);
    }

    public(friend) fun initialize<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: u32, arg9: &0x2::tx_context::TxContext) {
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::set_active_id(&mut arg0.parameters, arg8);
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_id_reference(&mut arg0.parameters);
        set_static_fee_parameters_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
    }

    public fun mint<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: vector<u32>, arg2: vector<u64>, arg3: vector<u64>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::LBTokenBucket, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (vector<u64>, vector<u256>, vector<0x2::object::ID>) {
        assert!(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::bucket_pool_id(arg6) == 0x2::object::uid_to_inner(&arg0.id), 2025);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x1::vector::length<u32>(&arg1) > 0, 2002);
        let v1 = create_liquidity_configs_from_params(&arg1, &arg2, &arg3);
        let v2 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u64_to_u128(0x2::coin::value<T0>(&arg4)), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u64_to_u128(0x2::coin::value<T1>(&arg5)));
        0x2::coin::put<T0>(&mut arg0.balance_x, arg4);
        0x2::coin::put<T1>(&mut arg0.balance_y, arg5);
        let (v3, v4) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v2);
        assert!(arg0.reserve_x <= 340282366920938463463374607431768211455 - v3, 2022);
        assert!(arg0.reserve_y <= 340282366920938463463374607431768211455 - v4, 2022);
        arg0.reserve_x = arg0.reserve_x + v3;
        arg0.reserve_y = arg0.reserve_y + v4;
        let v5 = MintArrays{
            ids              : 0x1::vector::empty<u64>(),
            amounts          : 0x1::vector::empty<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts>(),
            liquidity_minted : 0x1::vector::empty<u256>(),
        };
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = &mut v5;
        let v8 = &mut v6;
        let v9 = mint_bins<T0, T1>(arg0, &v1, v2, v7, v8, arg6, arg7, arg8);
        let (v10, v11) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v9);
        if (v10 > 0 || v11 > 0) {
            assert!(arg0.reserve_x >= v10, 2023);
            assert!(arg0.reserve_y >= v11, 2023);
            arg0.reserve_x = arg0.reserve_x - v10;
            arg0.reserve_y = arg0.reserve_y - v11;
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance_x, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u128_to_u64(v10), arg8), v0);
            };
            if (v11 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.balance_y, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_u128_to_u64(v11), arg8), v0);
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

    fun mint_bins<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: &vector<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::liquidity_configurations::LiquidityConfig>, arg2: 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts, arg3: &mut MintArrays, arg4: &mut vector<0x2::object::ID>, arg5: &mut 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::LBTokenBucket, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg2;
        let v2 = 0;
        let v3 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_active_id(&arg0.parameters);
        let v4 = arg0.bin_step;
        let (v5, v6) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&arg2);
        while (v2 < 0x1::vector::length<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::liquidity_configurations::LiquidityConfig>(arg1)) {
            let v7 = 0x1::vector::borrow<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::liquidity_configurations::LiquidityConfig>(arg1, v2);
            let v8 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::liquidity_configurations::get_id(v7);
            let (v9, v10) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::liquidity_configurations::apply_distribution(v7, v5, v6);
            let v11 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(v9, v10);
            let (v12, v13, v14) = update_bin<T0, T1>(arg0, v4, v3, v8, &v11, arg6, v0);
            let v15 = v13;
            if (v12 > 0) {
                let v16 = &v1;
                v1 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::sub_amounts(v16, &v15);
                0x1::vector::push_back<u64>(&mut arg3.ids, (v8 as u64));
                0x1::vector::push_back<0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts>(&mut arg3.amounts, v14);
                0x1::vector::push_back<u256>(&mut arg3.liquidity_minted, v12);
                0x1::vector::push_back<0x2::object::ID>(arg4, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::mint(&mut arg0.lb_token_manager, arg5, v0, (v8 as u256), v12, arg7));
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
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = arg0.bin_step;
        let v2 = arg0.parameters;
        0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::set_volatility_accumulator(&mut v2, arg7);
        assert!(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_base_fee(&v2, v1) + 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_variable_fee(&v2, v1) <= 100000000000000000, 2016);
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

    fun update_bin<T0, T1>(arg0: &mut LBPair<T0, T1>, arg1: u16, arg2: u32, arg3: u32, arg4: &0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts, arg5: &0x2::clock::Clock, arg6: address) : (u256, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::Amounts) {
        let v0 = (arg3 as u64);
        let v1 = if (0x2::table::contains<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v0)) {
            *0x2::table::borrow<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v0)
        } else {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_bin_reserves(0, 0)
        };
        let v2 = v1;
        let v3 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::price_helper::get_price_from_id(arg3, arg1);
        let v4 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token::total_supply(&arg0.lb_token_manager, (arg3 as u256));
        let (v5, v6) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_shares_and_effective_amounts_in(&v2, arg4, v3, v4);
        let v7 = v6;
        let v8 = v5;
        if (v5 == 0) {
            return (0, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, 0), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, 0))
        };
        let v9 = v7;
        if (arg3 == arg2) {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::update_volatility_parameters(&mut arg0.parameters, arg3, 0x2::clock::timestamp_ms(arg5) / 1000);
            let v10 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_composition_fees(&v2, &arg0.parameters, arg1, &v7, v4, v5);
            let (v11, v12) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v10);
            if (v11 > 0 || v12 > 0) {
                let v13 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::sub_amounts(&v7, &v10);
                let v14 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::pair_parameter_helper::get_protocol_share(&arg0.parameters);
                let v15 = if (v14 > 0) {
                    0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::fee_helper::get_protocol_fee_amount(v11, (v14 as u128)), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::fee_helper::get_protocol_fee_amount(v12, (v14 as u128)))
                } else {
                    0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::new_amounts(0, 0)
                };
                let v16 = v15;
                let (v17, v18) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v16);
                if (v17 > 0 || v18 > 0) {
                    let v19 = &v9;
                    v9 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::sub_amounts(v19, &v16);
                    assert!(arg0.protocol_fee_x <= 340282366920938463463374607431768211455 - v17, 2024);
                    assert!(arg0.protocol_fee_y <= 340282366920938463463374607431768211455 - v18, 2024);
                    arg0.protocol_fee_x = arg0.protocol_fee_x + v17;
                    arg0.protocol_fee_y = arg0.protocol_fee_y + v18;
                };
                let v20 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::sub_amounts(&v10, &v16);
                let v21 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::amounts_to_reserves(&v20);
                let v22 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::add_reserves(&v2, &v21);
                v8 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::uint256x256_math::mul_div_round_down(0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_liquidity_from_amounts(&v13, v3), v4, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_liquidity_from_reserves(&v22, v3));
                0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::oracle_helper::update(&mut arg0.oracle, &mut arg0.parameters, arg3, arg5);
                let v23 = CompositionFees{
                    sender        : arg6,
                    id            : arg3,
                    total_fees    : v10,
                    protocol_fees : v16,
                };
                0x2::event::emit<CompositionFees>(v23);
            };
        } else {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::verify_amounts(&v7, arg2, arg3);
        };
        assert!(v8 > 0, 2015);
        let (v24, v25) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::get_amounts_values(&v9);
        assert!(v24 > 0 || v25 > 0, 2015);
        if (v4 == 0) {
            0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::tree_math::add(&mut arg0.tree, arg3);
        };
        let v26 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::amounts_to_reserves(&v9);
        if (!0x2::table::contains<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&arg0.bins, v0)) {
            0x2::table::add<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&mut arg0.bins, v0, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::add_reserves(&v2, &v26));
        } else {
            *0x2::table::borrow_mut<u64, 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::BinReserves>(&mut arg0.bins, v0) = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bin_helper::add_reserves(&v2, &v26);
        };
        (v8, v7, v9)
    }

    // decompiled from Move bytecode v6
}

