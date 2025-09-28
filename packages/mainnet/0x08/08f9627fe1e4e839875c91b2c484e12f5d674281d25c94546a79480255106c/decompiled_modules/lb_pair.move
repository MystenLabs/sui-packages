module 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_pair {
    struct Amount has copy, drop {
        x: u64,
        y: u64,
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
        parameters: 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::PairParameters,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        bin_manager: 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::BinManager,
        position_manager: 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPositionManager,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        reward_manager: 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::RewarderManager,
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
        amount_x: u64,
        amount_y: u64,
    }

    struct RewarderAddedEvent has copy, drop {
        pair: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
    }

    struct RewardsCollectedEvent has copy, drop {
        pair: 0x2::object::ID,
        position: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
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

    public fun swap<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
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
        let v4 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_active_id(&arg1.parameters);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::update_references(&mut arg1.parameters, 0x2::clock::timestamp_ms(arg6) / 1000);
        let v5 = make_swap_event<T0, T1>(0x2::tx_context::sender(arg7), arg1, arg2);
        let v6 = false;
        let v7 = v4;
        loop {
            if (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::contains(&arg1.bin_manager, v7)) {
                let v8 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_mut(&mut arg1.bin_manager, v7);
                if (v7 == v4) {
                    0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::settle_active_bin_reward_growths(v8, &mut arg1.reward_manager, arg6);
                    v6 = true;
                };
                if (!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::is_empty(v8, !arg2)) {
                    0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::update_volatility_accumulator(&mut arg1.parameters, v7);
                    let (v9, v10, v11, v12, v13, v14) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_amounts(v8, &arg1.parameters, arg1.bin_step, arg2, v0.x, v0.y);
                    if (v9 > 0 || v10 > 0) {
                        let v15 = &mut v0;
                        sub_amount(v15, v9, v10);
                        let v16 = &mut v3;
                        add_amount(v16, v11, v12);
                        let v17 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_protocol_share(&arg1.parameters);
                        let v18 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::fee_helper::get_protocol_fee_amount(v13, v17);
                        let v19 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::fee_helper::get_protocol_fee_amount(v14, v17);
                        if (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::add_fee_growth(v8, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v13, v18), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v14, v19))) {
                            arg1.protocol_fee_x = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_x, v18);
                            arg1.protocol_fee_y = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_y, v19);
                            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::update_reserves_fees(v8, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v9, v13), v11, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v10, v14), v12);
                        } else {
                            arg1.protocol_fee_x = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_x, v13);
                            arg1.protocol_fee_y = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_y, v14);
                            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::update_reserves_fees(v8, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v9, v13), v11, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v10, v14), v12);
                        };
                        let v20 = &mut v5;
                        push_swap_event(v20, v7, v9, v10, v11, v12, v13, v14, v18, v19, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_volatility_accumulator(&arg1.parameters));
                    };
                };
            };
            if (v0.x == 0 && v0.y == 0) {
                break
            };
            let v21 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_next_non_empty_bin(&arg1.bin_manager, arg2, v7);
            if (v21 == 0 || v21 == v4) {
                abort 2011
            };
            v7 = v21;
        };
        if (!v6) {
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::settle_reward(&mut arg1.reward_manager, arg6);
        };
        let v22 = if (arg2) {
            v3.y
        } else {
            v3.x
        };
        assert!(v22 > 0 && v22 >= arg3, 2037);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::set_active_id(&mut arg1.parameters, v7);
        0x2::event::emit<SwapEvent>(v5);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v3.x, arg7), 0x2::coin::take<T1>(&mut arg1.balance_y, v3.y, arg7))
    }

    public(friend) fun new<T0, T1>(arg0: u32, arg1: u16, arg2: u32, arg3: u16, arg4: u16, arg5: u16, arg6: u32, arg7: u16, arg8: u32, arg9: &mut 0x2::tx_context::TxContext) : LBPair<T0, T1> {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::validate_bin_step(arg1);
        let v0 = LBPair<T0, T1>{
            id               : 0x2::object::new(arg9),
            is_pause         : false,
            bin_step         : arg1,
            parameters       : 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::new(arg0),
            protocol_fee_x   : 0,
            protocol_fee_y   : 0,
            bin_manager      : 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::new(arg9),
            position_manager : 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::new(arg9),
            balance_x        : 0x2::balance::zero<T0>(),
            balance_y        : 0x2::balance::zero<T1>(),
            reward_manager   : 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::new(),
        };
        let v1 = &mut v0;
        set_static_fee_parameters_internal<T0, T1>(v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        v0
    }

    public fun get_bin<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u32) : (u64, u64) {
        assert!(arg1 <= 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::tree_math::max_id(), 2020);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_reserves(&arg0.bin_manager, arg1)
    }

    public fun get_range_id<T0, T1>(arg0: &LBPair<T0, T1>) : (u32, u32) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_range_id(&arg0.bin_manager)
    }

    fun add_amount(arg0: &mut Amount, arg1: u64, arg2: u64) {
        arg0.x = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg0.x, arg1);
        arg0.y = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg0.y, arg2);
    }

    public fun add_liquidity<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        assert!(v0 == 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::pair_id(arg2), 2030);
        assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_lock_until(arg2) <= 0x2::clock::timestamp_ms(arg10), 2038);
        let v1 = 0x1::vector::length<u32>(&arg3);
        validate_bin_length(v1);
        assert!(v1 == 0x1::vector::length<u64>(&arg4) && v1 == 0x1::vector::length<u64>(&arg5), 2007);
        let v2 = 0x2::tx_context::sender(arg11);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0x2::coin::value<T1>(&arg7);
        0x2::coin::put<T0>(&mut arg1.balance_x, arg6);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0x1::vector::empty<u128>();
        let v10 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_active_id(&arg1.parameters);
        let v11 = arg1.bin_step;
        let v12 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::precision();
        let v13 = 0x1::vector::empty<u32>();
        let v14 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::borrow_bins_table_mut(&mut arg1.bin_manager);
        let v15 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bins_mut(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_info_mut(&mut arg1.position_manager, arg2));
        let v16 = 0;
        let v17 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::max_u32();
        let v18 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::create_empty_pack();
        let v19 = &mut v18;
        let v20 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::create_empty_pack();
        let v21 = &mut v20;
        let v22 = 0;
        while (v22 < v1) {
            let v23 = *0x1::vector::borrow<u32>(&arg3, v22);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::price_helper::validate_bin_id(v23);
            let v24 = *0x1::vector::borrow<u64>(&arg4, v22);
            let v25 = *0x1::vector::borrow<u64>(&arg5, v22);
            assert!(v24 <= v12 && v25 <= v12, 2035);
            let (v26, v27) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::resolve_bin_group_index(v23);
            if (v26 != v17) {
                if (!0x2::table::contains<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v14, v26)) {
                    0x2::table::add<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v14, v26, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::create_empty_pack());
                };
                v19 = 0x2::table::borrow_mut<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v14, v26);
                v17 = v26;
                if (!0x2::table::contains<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::PackedBins>(v15, v26)) {
                    0x2::table::add<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::PackedBins>(v15, v26, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::create_empty_pack());
                };
                v21 = 0x2::table::borrow_mut<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::PackedBins>(v15, v26);
            };
            if (!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::bin_exists_in_pack(v19, v27)) {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::create_bin_in_pack(v19, v23, v27, v11);
                0x1::vector::push_back<u32>(&mut v13, v23);
            };
            let v28 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_mut_from_pack(v19, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_index_in_pack(v19, v27));
            if (!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::is_bin_active_in_bitmap(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v21), v27)) {
                v16 = v16 + 1;
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::create_bin_in_pack(v21, v23, v27);
            };
            let v29 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bin_mut_from_pack(v21, (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::count_active_bins_before_position(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v21), v27) as u64));
            let v30 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_price(v28);
            let v31 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_total_supply(v28);
            let (v32, v33, v34) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_shares_and_effective_amounts_in(v28, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::mul_div_u64(v3, v24, v12), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::mul_div_u64(v4, v25, v12), v30);
            let v35 = v32;
            assert!(v32 > 0, 2015);
            let v36 = v34;
            let v37 = v33;
            let v38 = if (v23 == v10) {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::update_volatility_parameters(&mut arg1.parameters, v23, 0x2::clock::timestamp_ms(arg10) / 1000);
                let (v39, v40) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_composition_fees(v28, &arg1.parameters, v11, v33, v34, v31, v32);
                if (v39 > 0 || v40 > 0) {
                    let v41 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_protocol_share(&arg1.parameters);
                    let v42 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::fee_helper::get_protocol_fee_amount(v39, v41);
                    let v43 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::fee_helper::get_protocol_fee_amount(v40, v41);
                    if (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::add_fee_growth(v28, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v39, v42), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v40, v43))) {
                        arg1.protocol_fee_x = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_x, v42);
                        arg1.protocol_fee_y = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_y, v43);
                    } else {
                        arg1.protocol_fee_x = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_x, v39);
                        arg1.protocol_fee_y = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_y, v40);
                    };
                    let v44 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v33, v39);
                    v37 = v44;
                    let v45 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v34, v40);
                    v36 = v45;
                    let (v46, v47) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_reserves(v28);
                    v35 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::mul_div_round_down_u128(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::liquidity(v44, v45, v30), v31, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::liquidity(v46, v47, v30));
                    let v48 = CompositionFeesEvent{
                        pair   : v0,
                        bin_id : v23,
                        fee_x  : v39,
                        fee_y  : v40,
                    };
                    0x2::event::emit<CompositionFeesEvent>(v48);
                };
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::settle_active_bin_reward_growths(v28, &mut arg1.reward_manager, arg10)
            } else {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::verify_lp_amounts(v33, v34, v10, v23);
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_reward_growths(v28)
            };
            assert!((v37 > 0 || v36 > 0) && v35 > 0, 2015);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::settle_position_fees(arg2, v29, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_fee_growth_x(v28), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_fee_growth_y(v28));
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::settle_position_rewards(arg2, v29, v38);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::add_reserves_and_supply(v28, v37, v36, v35);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::increase_bin_liquidity(v29, v35);
            v6 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v6, v33);
            v5 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v5, v34);
            0x1::vector::push_back<u64>(&mut v8, v37);
            0x1::vector::push_back<u64>(&mut v7, v36);
            0x1::vector::push_back<u128>(&mut v9, v35);
            v22 = v22 + 1;
        };
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::increase_position_total_bins(arg2, v16);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::batch_add_bins_to_tree(&mut arg1.bin_manager, &v13);
        assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v3, v6) >= arg8 && 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v4, v5) >= arg9, 2037);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance_x, v6, arg11), v2);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v5, arg11), v2);
        };
        let v49 = AddLiquidityEvent{
            pair      : v0,
            position  : 0x2::object::id<0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition>(arg2),
            ids       : arg3,
            amounts_x : v8,
            amounts_y : v7,
            tokens    : v9,
        };
        0x2::event::emit<AddLiquidityEvent>(v49);
    }

    public fun add_rewarder<T0, T1, T2>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::check_reward_role(arg0, 0x2::tx_context::sender(arg2));
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::add_rewarder<T2>(&mut arg1.reward_manager);
        let v0 = RewarderAddedEvent{
            pair          : 0x2::object::id<LBPair<T0, T1>>(arg1),
            rewarder_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<RewarderAddedEvent>(v0);
    }

    public fun close_position<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg3: &mut 0x2::tx_context::TxContext) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        assert!(v0 == 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::pair_id(&arg2), 2030);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::close_position(&mut arg1.position_manager, arg2);
        let v1 = ClosePositionEvent{
            pair     : v0,
            position : 0x2::object::id<0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition>(&arg2),
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClosePositionEvent>(v1);
    }

    public fun collect_position_fees<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg3: vector<u32>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::pair_id(arg2), 2030);
        let v0 = 0x1::vector::length<u32>(&arg3);
        validate_bin_length(v0);
        let v1 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::borrow_bins_table_mut(&mut arg1.bin_manager);
        let v2 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bins_mut(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_info_mut(&mut arg1.position_manager, arg2));
        let v3 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::max_u32();
        let v4 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::create_empty_pack();
        let v5 = &mut v4;
        let v6 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::create_empty_pack();
        let v7 = &mut v6;
        let v8 = 0;
        while (v8 < v0) {
            let v9 = *0x1::vector::borrow<u32>(&arg3, v8);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::price_helper::validate_bin_id(v9);
            let (v10, v11) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::resolve_bin_group_index(v9);
            if (v10 != v3) {
                assert!(0x2::table::contains<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v1, v10), 2039);
                v5 = 0x2::table::borrow_mut<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v1, v10);
                v7 = 0x2::table::borrow_mut<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::PackedBins>(v2, v10);
                v3 = v10;
            };
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::bin_exists_in_pack(v5, v11), 2039);
            let v12 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_mut_from_pack(v5, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_index_in_pack(v5, v11));
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::is_bin_active_in_bitmap(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v7), v11), 2039);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::settle_position_fees(arg2, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bin_mut_from_pack(v7, (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::count_active_bins_before_position(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v7), v11) as u64)), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_fee_growth_x(v12), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_fee_growth_y(v12));
            v8 = v8 + 1;
        };
        let (v13, v14) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::collect_saved_fees(arg2);
        let v15 = FeesCollectedEvent{
            pair     : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position : 0x2::object::id<0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition>(arg2),
            bin_ids  : arg3,
            amount_x : v13,
            amount_y : v14,
        };
        0x2::event::emit<FeesCollectedEvent>(v15);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v13, arg4), 0x2::coin::take<T1>(&mut arg1.balance_y, v14, arg4))
    }

    public fun collect_position_rewards<T0, T1, T2>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: vector<u32>, arg3: &mut 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg4: &mut 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::pair_id(arg3), 2030);
        let v0 = 0x1::vector::length<u32>(&arg2);
        assert!(v0 <= 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::max_bins(), 2041);
        let v1 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::borrow_bins_table_mut(&mut arg1.bin_manager);
        let v2 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bins_mut(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_info_mut(&mut arg1.position_manager, arg3));
        let v3 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::max_u32();
        let v4 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::create_empty_pack();
        let v5 = &mut v4;
        let v6 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::create_empty_pack();
        let v7 = &mut v6;
        let v8 = 0;
        while (v8 < v0) {
            let v9 = *0x1::vector::borrow<u32>(&arg2, v8);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::price_helper::validate_bin_id(v9);
            let (v10, v11) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::resolve_bin_group_index(v9);
            if (v10 != v3) {
                assert!(0x2::table::contains<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v1, v10), 2039);
                v5 = 0x2::table::borrow_mut<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v1, v10);
                v7 = 0x2::table::borrow_mut<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::PackedBins>(v2, v10);
                v3 = v10;
            };
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::bin_exists_in_pack(v5, v11), 2039);
            let v12 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_mut_from_pack(v5, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_index_in_pack(v5, v11));
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::is_bin_active_in_bitmap(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v7), v11), 2039);
            let v13 = if (v9 == 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_active_id(&arg1.parameters)) {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::settle_active_bin_reward_growths(v12, &mut arg1.reward_manager, arg5)
            } else {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_reward_growths(v12)
            };
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::settle_position_rewards(arg3, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bin_mut_from_pack(v7, (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::count_active_bins_before_position(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v7), v11) as u64)), v13);
            v8 = v8 + 1;
        };
        let v14 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::rewarder_index<T2>(&arg1.reward_manager);
        assert!(0x1::option::is_some<u64>(&v14), 2044);
        let v15 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::collect_saved_rewards(arg3, *0x1::option::borrow<u64>(&v14));
        let v16 = if (v15 == 0) {
            0x2::coin::zero<T2>(arg6)
        } else {
            0x2::coin::from_balance<T2>(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::withdraw_reward<T2>(arg4, v15), arg6)
        };
        let v17 = RewardsCollectedEvent{
            pair        : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position    : 0x2::object::id<0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition>(arg3),
            reward_type : 0x1::type_name::get<T2>(),
            amount      : v15,
        };
        0x2::event::emit<RewardsCollectedEvent>(v17);
        v16
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::get_fund_receiver(arg0);
        let v1 = arg1.protocol_fee_x;
        let v2 = arg1.protocol_fee_y;
        let v3 = if (v1 > 1) {
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v1, 1)
        } else {
            0
        };
        let v4 = if (v2 > 1) {
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v2, 1)
        } else {
            0
        };
        assert!(v3 > 0 || v4 > 0, 2014);
        if (v3 > 0) {
            arg1.protocol_fee_x = arg1.protocol_fee_x - v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance_x, v3, arg2), v0);
        };
        if (v4 > 0) {
            arg1.protocol_fee_y = arg1.protocol_fee_y - v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.balance_y, v4, arg2), v0);
        };
        let v5 = CollectedProtocolFeesEvent{
            fee_recipient   : 0x2::tx_context::sender(arg2),
            protocol_fees_x : v3,
            protocol_fees_y : v4,
        };
        0x2::event::emit<CollectedProtocolFeesEvent>(v5);
    }

    public fun flash_loan<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        let v0 = if (!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0)) {
            if (!arg1.is_pause) {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::flash_loan_enable(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2033);
        assert!(arg3 > 0, 2034);
        let v1 = if (arg2) {
            0x2::balance::value<T0>(&arg1.balance_x)
        } else {
            0x2::balance::value<T1>(&arg1.balance_y)
        };
        assert!(arg3 <= 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::mul_div_u64(v1, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::flash_loan_max_amount(arg0), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::precision()), 2005);
        let v2 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::div_round_up_u64(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::mul_u64(arg3, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::flash_loan_fee_rate(arg0)), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::precision());
        if (arg2) {
            arg1.protocol_fee_x = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_x, v2);
        } else {
            arg1.protocol_fee_y = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(arg1.protocol_fee_y, v2);
        };
        let v3 = FlashLoanReceipt{
            pair_id    : 0x2::object::id<LBPair<T0, T1>>(arg1),
            loan_x     : arg2,
            amount     : arg3,
            fee_amount : v2,
        };
        let v4 = FlashLoanEvent{
            pair       : 0x2::object::id<LBPair<T0, T1>>(arg1),
            loan_x     : arg2,
            amount     : arg3,
            fee_amount : v2,
        };
        0x2::event::emit<FlashLoanEvent>(v4);
        let (v5, v6) = if (arg2) {
            (0x2::balance::split<T0>(&mut arg1.balance_x, arg3), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg1.balance_y, arg3))
        };
        arg1.is_pause = true;
        (v5, v6, v3)
    }

    public fun force_decay<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::update_id_reference(&mut arg1.parameters);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::update_volatility_reference(&mut arg1.parameters);
        let v0 = ForcedDecayEvent{
            sender               : 0x2::tx_context::sender(arg2),
            id_reference         : 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_id_reference(&arg1.parameters),
            volatility_reference : 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_volatility_reference(&arg1.parameters),
        };
        0x2::event::emit<ForcedDecayEvent>(v0);
    }

    public fun get_active_id<T0, T1>(arg0: &LBPair<T0, T1>) : u32 {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_active_id(&arg0.parameters)
    }

    public fun get_bin_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::BinManager {
        &arg0.bin_manager
    }

    public fun get_bin_step<T0, T1>(arg0: &LBPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun get_id_from_price<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u128) : u32 {
        let v0 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::price_helper::get_id_from_price(arg1, arg0.bin_step);
        let v1 = IdFromPriceQueriedEvent{
            price : arg1,
            id    : v0,
        };
        0x2::event::emit<IdFromPriceQueriedEvent>(v1);
        v0
    }

    public fun get_pending_fees<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg2: vector<u32>) : (u64, u64) {
        let v0 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::borrow_bins_table(&arg0.bin_manager);
        let v1 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bins(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_info(&arg0.position_manager, arg1));
        let v2 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::max_u32();
        let v3 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::create_empty_pack();
        let v4 = &v3;
        let v5 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::create_empty_pack();
        let v6 = &v5;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u32>(&arg2)) {
            let v10 = *0x1::vector::borrow<u32>(&arg2, v9);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::price_helper::validate_bin_id(v10);
            let (v11, v12) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::resolve_bin_group_index(v10);
            if (v11 != v2) {
                assert!(0x2::table::contains<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v0, v11), 2039);
                v4 = 0x2::table::borrow<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v0, v11);
                v6 = 0x2::table::borrow<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::PackedBins>(v1, v11);
                v2 = v11;
            };
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::bin_exists_in_pack(v4, v12), 2039);
            let v13 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_from_pack(v4, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_index_in_pack(v4, v12));
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::is_bin_active_in_bitmap(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v6), v12), 2039);
            let (v14, v15) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_pending_fees(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bin_from_pack(v6, (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::count_active_bins_before_position(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v6), v12) as u64)), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_fee_growth_x(v13), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_fee_growth_y(v13));
            v7 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u128(v7, v14);
            v8 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u128(v8, v15);
            v9 = v9 + 1;
        };
        let (v16, v17) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_saved_fees(arg1);
        (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::u128_to_u64(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u128(v7, v16) >> 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::scale_offset()), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::u128_to_u64(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u128(v8, v17) >> 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::scale_offset()))
    }

    public fun get_pending_rewards<T0, T1, T2>(arg0: &LBPair<T0, T1>, arg1: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg2: vector<u32>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::borrow_bins_table(&arg0.bin_manager);
        let v1 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bins(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_info(&arg0.position_manager, arg1));
        let v2 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::max_u32();
        let v3 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::create_empty_pack();
        let v4 = &v3;
        let v5 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::create_empty_pack();
        let v6 = &v5;
        let v7 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::rewarder_index<T2>(&arg0.reward_manager);
        if (!0x1::option::is_some<u64>(&v7)) {
            return 0
        };
        let v8 = *0x1::option::borrow<u64>(&v7);
        let v9 = 0;
        let v10 = 0;
        while (v10 < 0x1::vector::length<u32>(&arg2)) {
            let v11 = *0x1::vector::borrow<u32>(&arg2, v10);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::price_helper::validate_bin_id(v11);
            let (v12, v13) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::resolve_bin_group_index(v11);
            if (v12 != v2) {
                assert!(0x2::table::contains<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v0, v12), 2039);
                v4 = 0x2::table::borrow<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v0, v12);
                v6 = 0x2::table::borrow<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::PackedBins>(v1, v12);
                v2 = v12;
            };
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::bin_exists_in_pack(v4, v13), 2039);
            let v14 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_from_pack(v4, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_index_in_pack(v4, v13));
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::is_bin_active_in_bitmap(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v6), v13), 2039);
            let v15 = if (v11 == 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_active_id(&arg0.parameters)) {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::simulate_settle_position_rewards(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bin_from_pack(v6, (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::count_active_bins_before_position(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v6), v13) as u64)), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::simulate_settle_active_bin_reward_growths(v14, &arg0.reward_manager, arg3))
            } else {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::simulate_settle_position_rewards(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bin_from_pack(v6, (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::count_active_bins_before_position(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v6), v13) as u64)), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_reward_growths(v14))
            };
            let v16 = v15;
            if (v8 < 0x1::vector::length<u128>(&v16)) {
                v9 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u128(v9, *0x1::vector::borrow<u128>(&v16, v8));
            };
            v10 = v10 + 1;
        };
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::u128_to_u64(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u128(v9, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_saved_rewards(arg1, v8)) >> 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::scale_offset())
    }

    fun get_position_bin_reserves<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg2: u32) : (u64, u64) {
        let v0 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::position_token_amount(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_bin(&arg0.position_manager, arg1, arg2));
        if (v0 == 0) {
            return (0, 0)
        };
        if (!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::contains(&arg0.bin_manager, arg2)) {
            return (0, 0)
        };
        let (v1, v2, v3) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_reserves_supply(&arg0.bin_manager, arg2);
        if (v3 == 0) {
            return (0, 0)
        };
        (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::mul_div_u128_to_u64(v0, (v1 as u128), v3), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::mul_div_u128_to_u64(v0, (v2 as u128), v3))
    }

    public fun get_position_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPositionManager {
        &arg0.position_manager
    }

    public fun get_position_reserves_for_bins<T0, T1>(arg0: &LBPair<T0, T1>, arg1: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg2: vector<u32>) : (vector<u64>, vector<u64>) {
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
        let v0 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::price_helper::get_price_from_id(arg1, arg0.bin_step);
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

    public fun get_reward_emission<T0, T1, T2>(arg0: &LBPair<T0, T1>, arg1: &0x2::clock::Clock) : u128 {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::get_reward_emission<T2>(&arg0.reward_manager, arg1)
    }

    public fun get_reward_manager<T0, T1>(arg0: &LBPair<T0, T1>) : &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::RewarderManager {
        &arg0.reward_manager
    }

    public fun get_swap_in<T0, T1>(arg0: &LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = arg0.parameters;
        let v4 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_active_id(&v3);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::update_references(&mut v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        loop {
            if (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::contains(&arg0.bin_manager, v4)) {
                let (v5, v6) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_reserves(&arg0.bin_manager, v4);
                let v7 = if (arg2) {
                    v6
                } else {
                    v5
                };
                if (v7 > 0) {
                    let v8 = if (v7 > v0) {
                        v0
                    } else {
                        v7
                    };
                    0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::update_volatility_accumulator(&mut v3, v4);
                    let v9 = if (arg2) {
                        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::shift_div_round_up(v8, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::scale_offset(), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_price(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin(&arg0.bin_manager, v4)))
                    } else {
                        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::mul_shift_round_up(v8, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_price(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin(&arg0.bin_manager, v4)), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::q64x64::scale_offset())
                    };
                    let v10 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::fee_helper::get_fee_amount_exclusive(v9, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_total_fee_rate(&v3, arg0.bin_step));
                    v1 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(v1, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(v9, v10));
                    v0 = v0 - v8;
                    v2 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(v2, v10);
                };
            };
            if (v0 == 0) {
                break
            };
            v4 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_next_non_empty_bin(&arg0.bin_manager, arg2, v4);
            if (v4 == 0 || v4 == v4) {
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
        let v9 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_active_id(&v8);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::update_references(&mut v8, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v10 = v9;
        loop {
            if (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::contains(&arg0.bin_manager, v10)) {
                let v11 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin(&arg0.bin_manager, v10);
                if (!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::is_empty(v11, !arg2)) {
                    0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::update_volatility_accumulator(&mut v8, v10);
                    let (v12, v13, v14, v15, v16, v17) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_amounts(v11, &v8, arg0.bin_step, arg2, v3, v2);
                    if (v12 > 0 || v13 > 0) {
                        v3 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v3, v12);
                        v2 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(v2, v13);
                        v5 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(v5, v14);
                        v4 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(v4, v15);
                        v7 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(v7, v16);
                        v6 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(v6, v17);
                    };
                };
            };
            if (v3 == 0 && v2 == 0) {
                break
            };
            v10 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_next_non_empty_bin(&arg0.bin_manager, arg2, v10);
            if (v10 == 0 || v10 == v9) {
                break
            };
        };
        let v18 = if (arg2) {
            v3
        } else {
            v2
        };
        let v19 = if (arg2) {
            v4
        } else {
            v5
        };
        let v20 = if (arg2) {
            v7
        } else {
            v6
        };
        (v18, v19, v20)
    }

    public fun lock_position<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::pair_id(arg2), 2030);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = if (arg3 > 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_lock_until(arg2)) {
            if (arg3 > v0) {
                arg3 - v0 < 5315360000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2031);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::lock_position(arg2, arg3);
        let v2 = LockPositionEvent{
            pair       : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position   : 0x2::object::id<0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition>(arg2),
            lock_until : arg3,
            owner      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LockPositionEvent>(v2);
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

    public fun open_position<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        let v0 = 0x2::object::id<LBPair<T0, T1>>(arg1);
        let v1 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::open_position<T0, T1>(&mut arg1.position_manager, v0, arg2);
        let v2 = OpenPositionEvent{
            pair     : v0,
            position : 0x2::object::id<0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition>(&v1),
            owner    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<OpenPositionEvent>(v2);
        v1
    }

    public fun pause_pair<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg1.is_pause != arg2, 2032);
        arg1.is_pause = arg2;
        let v0 = PairPausedEvent{
            pair   : 0x2::object::id<LBPair<T0, T1>>(arg1),
            paused : arg2,
        };
        0x2::event::emit<PairPausedEvent>(v0);
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

    public fun remove_liquidity<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &mut 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition, arg3: vector<u32>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_lock_until(arg2) <= 0x2::clock::timestamp_ms(arg6), 2038);
        let v0 = 0x1::vector::length<u32>(&arg3);
        validate_bin_length(v0);
        assert!(0x2::object::id<LBPair<T0, T1>>(arg1) == 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::pair_id(arg2), 2030);
        let v1 = make_amount();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u128>();
        let v5 = 0x1::vector::empty<u32>();
        let v6 = 0x1::vector::empty<u32>();
        let v7 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::borrow_bins_table_mut(&mut arg1.bin_manager);
        let v8 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bins_mut(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_info_mut(&mut arg1.position_manager, arg2));
        let v9 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::max_u32();
        let v10 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::create_empty_pack();
        let v11 = &mut v10;
        let v12 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::create_empty_pack();
        let v13 = &mut v12;
        let v14 = 0;
        while (v14 < v0) {
            let v15 = *0x1::vector::borrow<u32>(&arg3, v14);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::price_helper::validate_bin_id(v15);
            let (v16, v17) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::resolve_bin_group_index(v15);
            if (v16 != v9) {
                assert!(0x2::table::contains<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v7, v16), 2039);
                v11 = 0x2::table::borrow_mut<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::PackedBins>(v7, v16);
                v13 = 0x2::table::borrow_mut<u32, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::PackedBins>(v8, v16);
                v9 = v16;
            };
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::bin_exists_in_pack(v11, v17), 2039);
            let v18 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_mut_from_pack(v11, 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_index_in_pack(v11, v17));
            assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::is_bin_active_in_bitmap(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v13), v17), 2039);
            let v19 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::borrow_position_bin_mut_from_pack(v13, (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::count_active_bins_before_position(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::get_active_bins_bitmap(v13), v17) as u64));
            let v20 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::position_token_amount(v19);
            let (v21, v22, v23) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::fee_growth_and_supply(v18);
            let (v24, v25) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_amount_out_of_bin(v18, v20, v23);
            assert!(v24 > 0 || v25 > 0, 2014);
            let v26 = &mut v1;
            add_amount(v26, v24, v25);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::settle_position_fees(arg2, v19, v21, v22);
            let v27 = if (v15 == 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_active_id(&arg1.parameters)) {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::settle_active_bin_reward_growths(v18, &mut arg1.reward_manager, arg6)
            } else {
                0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_reward_growths(v18)
            };
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::settle_position_rewards(arg2, v19, v27);
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::subtract_bin(v18, v24, v25, v20);
            0x1::vector::push_back<u32>(&mut v6, v15);
            if (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::bin_empty(v18)) {
                0x1::vector::push_back<u32>(&mut v5, v15);
            };
            0x1::vector::push_back<u64>(&mut v2, v24);
            0x1::vector::push_back<u64>(&mut v3, v25);
            0x1::vector::push_back<u128>(&mut v4, v20);
            v14 = v14 + 1;
        };
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::remove_bins(&mut arg1.bin_manager, v5);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::remove_bins(&mut arg1.position_manager, arg2, v6);
        assert!(v1.x >= arg4 && v1.y >= arg5, 2037);
        let (v28, v29) = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::collect_saved_fees(arg2);
        let v30 = &mut v1;
        add_amount(v30, v28, v29);
        let v31 = RemoveLiquidityEvent{
            pair             : 0x2::object::id<LBPair<T0, T1>>(arg1),
            position         : 0x2::object::id<0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::lb_position::LBPosition>(arg2),
            ids              : arg3,
            tokens_x         : v1.x,
            tokens_y         : v1.y,
            token_bins_x     : v2,
            token_bins_y     : v3,
            liquidity_burned : v4,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v31);
        (0x2::coin::take<T0>(&mut arg1.balance_x, v1.x, arg7), 0x2::coin::take<T1>(&mut arg1.balance_y, v1.y, arg7))
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
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

    public fun set_static_fee_parameters<T0, T1>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: u32, arg3: u16, arg4: u16, arg5: u16, arg6: u32, arg7: u16, arg8: u32, arg9: &0x2::tx_context::TxContext) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg9));
        set_static_fee_parameters_internal<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
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
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::set_static_fee_parameters(&mut arg0.parameters, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = arg0.bin_step;
        let v2 = arg0.parameters;
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::set_volatility_accumulator(&mut v2, arg7);
        assert!(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::add_u64(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_base_fee(&v2, v1), 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_variable_fee(&v2, v1)) <= 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::max_fee_rate(), 2016);
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
        arg0.x = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(arg0.x, arg1);
        arg0.y = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::safe_math::sub_u64(arg0.y, arg2);
    }

    public fun update_emission<T0, T1, T2>(arg0: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::GlobalConfig, arg1: &mut LBPair<T0, T1>, arg2: &0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::checked_package_version(arg0);
        assert!(!0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::global_paused(arg0) && !arg1.is_pause, 2033);
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::config::check_reward_role(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::pair_parameter_helper::get_active_id(&arg1.parameters);
        if (0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::contains(&arg1.bin_manager, v0)) {
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::settle_active_bin_reward_growths(0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::bin_manager::get_bin_mut(&mut arg1.bin_manager, v0), &mut arg1.reward_manager, arg4);
        } else {
            0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::settle_reward(&mut arg1.reward_manager, arg4);
        };
        0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::rewarder::update_reward_emission<T2>(arg2, &mut arg1.reward_manager, 0x2::object::id<LBPair<T0, T1>>(arg1), arg3);
    }

    fun validate_bin_length(arg0: u64) {
        assert!(arg0 > 0, 2042);
        assert!(arg0 <= 0x808f9627fe1e4e839875c91b2c484e12f5d674281d25c94546a79480255106c::constants::max_bins(), 2041);
    }

    // decompiled from Move bytecode v6
}

