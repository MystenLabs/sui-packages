module 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair {
    struct EventSetStaticFeeParameters has copy, drop, store {
        sender: address,
        base_factor: u16,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct EventCompositionFees has copy, drop, store {
        pair: 0x2::object::ID,
        token_x: 0x1::type_name::TypeName,
        token_y: 0x1::type_name::TypeName,
        sender: address,
        id: u32,
        fee_x: u64,
        fee_y: u64,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        gauge_fee_x: u64,
        gauge_fee_y: u64,
        fee_growth_x: u256,
        fee_growth_y: u256,
    }

    struct EventDepositedToBins has copy, drop, store {
        sender: address,
        lp: address,
        ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
        position_id: 0x2::object::ID,
        pair_reserve_x: u64,
        pair_reserve_y: u64,
        total_amount_in_x: u64,
        total_amount_in_y: u64,
    }

    struct EventWithdrawnFromBins has copy, drop, store {
        sender: address,
        lp: address,
        position_id: 0x2::object::ID,
        ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
        amounts_out_x: u64,
        amounts_out_y: u64,
        pair_reserve_x: u64,
        pair_reserve_y: u64,
    }

    struct EventBurnPosition has copy, drop, store {
        sender: address,
        lp: address,
        position_id: 0x2::object::ID,
        ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
        amounts_out_x: u64,
        amounts_out_y: u64,
        pair_reserve_x: u64,
        pair_reserve_y: u64,
    }

    struct EventSwap has copy, drop, store {
        sender: address,
        receiver: address,
        active_id: u32,
        swap_for_y: bool,
        amounts_in_with_fees: u64,
        amounts_out_of_bin: u64,
        volatility_accumulator: u32,
        pair_fee: u64,
        protocol_fee: u64,
        gauge_fee: u64,
        partner_fee: u64,
        pair_reserve_x: u64,
        pair_reserve_y: u64,
    }

    struct EventCollectedProtocolFees has copy, drop, store {
        sender: address,
        amount_x: u64,
        amount_y: u64,
    }

    struct EventCollectedFees has copy, drop, store {
        sender: address,
        pair_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        x: u64,
        y: u64,
    }

    struct EventCollectedReward has copy, drop, store {
        pair_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct EventForcedDecay has copy, drop, store {
        sender: address,
        id_reference: u32,
        volatility_reference: u32,
    }

    struct EventCreatePair has copy, drop, store {
        pair_id: 0x2::object::ID,
        factory_id: 0x2::object::ID,
        bin_step: u16,
        active_id: u32,
        params: DlmmPairParameter,
        token_x: 0x1::type_name::TypeName,
        token_y: 0x1::type_name::TypeName,
        lp_token_id: 0x2::object::ID,
    }

    struct DlmmPairParameter has copy, drop, store {
        base_factor: u16,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
        volatility_accumulator: u32,
        volatility_reference: u32,
        index_reference: u32,
        time_of_last_update: u64,
        oracle_index: u16,
        active_index: u32,
    }

    struct EventUpdateFactory has copy, drop, store {
        old_factory: 0x2::object::ID,
        new_factory: 0x2::object::ID,
    }

    struct DlmmPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        factory: 0x2::object::ID,
        global_config: 0x2::object::ID,
        lp_mint_cap: 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::MintCap,
        lp_token: 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::DlmmLpToken,
        pause: bool,
        x: 0x1::type_name::TypeName,
        y: 0x1::type_name::TypeName,
        bin_step: u16,
        liquidity: u256,
        params: DlmmPairParameter,
        bins_tree: 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin_tree::BinTree,
        bins: 0x2::table::Table<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>,
        bins_iter: 0x2::vec_set::VecSet<u32>,
        balances: 0x2::bag::Bag,
        reserve_x: u64,
        reserve_y: u64,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        rewarder_manager: 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::RewarderManager,
        unstaked_liquidity_fee_rate: u64,
        distribution_gauge_id: 0x1::option::Option<0x2::object::ID>,
        distribution_rate: u256,
        distribution_reserve: u64,
        distribution_period_finish: u64,
        distribution_rollover: u64,
        distribution_last_updated: u64,
        distribution_gauge_fee: Fee,
        position_manager: 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionManager,
    }

    struct Fee has drop, store {
        x: u64,
        y: u64,
    }

    struct SwapInternalResult has drop {
        amounts_out: u64,
        swap_for_y: bool,
        protocol_fee: u64,
        fee_to_bin: u64,
        partner_fee: u64,
        gauge_fee: u64,
        pair_reserve_x: u64,
        pair_reserve_y: u64,
    }

    struct SwapInternalStep has drop {
        bin_id: u32,
        distribution_portion: u64,
        staked_liquidity: u256,
        bin_liquidity: u256,
    }

    struct FeeHub has drop {
        total_fee: u64,
        partner_fee: u64,
        protocol_fee: u64,
        gauge_fee: u64,
        fee_growth: u256,
        fee_to_bin: u64,
    }

    struct BurnFromBinsResult has copy, drop {
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
        total_amounts_out_x: u64,
        total_amounts_out_y: u64,
    }

    struct MintResult has copy, drop, store {
        total_amounts_in_x: u64,
        total_amounts_in_y: u64,
        ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
        liquidity_minted: vector<u64>,
        fee_to_bin_x: u64,
        fee_to_bin_y: u64,
    }

    struct UpdateBinInternalResult has copy, drop {
        shares: u64,
        amounts_in_x: u64,
        amounts_in_y: u64,
        fee_to_bin_x: u64,
        fee_to_bin_y: u64,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        amounts_into_bin_x: u64,
        amounts_into_bin_y: u64,
        liquidity_delta: u256,
    }

    struct AddRewarderEvent has copy, drop, store {
        pair: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
    }

    struct UpdateRewarderEmissionEvent has copy, drop, store {
        pair: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        emissions_per_second_q128: u256,
    }

    struct CollectRewarderEvent has copy, drop, store {
        position: 0x2::object::ID,
        pair: 0x2::object::ID,
        amount: u64,
    }

    struct CalcFeesDistribution has copy, drop {
        growth_global: u256,
        fee_to_gauge: u64,
    }

    struct CollectGaugeFeeEvent has copy, drop, store {
        pair: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    public fun swap<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, SwapInternalResult) {
        swap_with_partner_fee_rate<T0, T1>(arg0, arg1, 0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun liquidity<T0, T1>(arg0: &DlmmPair<T0, T1>) : u256 {
        arg0.liquidity
    }

    public fun base_factor(arg0: &DlmmPairParameter) : u16 {
        arg0.base_factor
    }

    public fun decay_period(arg0: &DlmmPairParameter) : u16 {
        arg0.decay_period
    }

    public fun filter_period(arg0: &DlmmPairParameter) : u16 {
        arg0.filter_period
    }

    public fun max_volatility_accumulator(arg0: &DlmmPairParameter) : u32 {
        arg0.max_volatility_accumulator
    }

    public fun protocol_share(arg0: &DlmmPairParameter) : u16 {
        arg0.protocol_share
    }

    public fun reduction_factor(arg0: &DlmmPairParameter) : u16 {
        arg0.reduction_factor
    }

    public fun variable_fee_control(arg0: &DlmmPairParameter) : u32 {
        arg0.variable_fee_control
    }

    public fun burn<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position, arg2: vector<u32>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::staked(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(arg1))), 24);
        abort 9223376632469782527
    }

    public fun mint<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: vector<u32>, arg7: vector<u64>, arg8: vector<u64>, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (MintResult, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position) {
        assert!(arg9 != @0x0, 9223376396246581247);
        assert!(0x1::vector::length<u32>(&arg6) > 0, 8);
        assert!(0x1::vector::length<u32>(&arg6) == 0x1::vector::length<u64>(&arg7) && 0x1::vector::length<u32>(&arg6) == 0x1::vector::length<u64>(&arg8), 7);
        assert!(arg0.factory == 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory>(arg1), 25);
        settle_rewarders<T0, T1>(arg0, true, arg10);
        let (v0, v1) = mint_percents_to_amounts(arg6, arg7, arg8, arg4, arg5);
        let v2 = calc_unstaked_liquidity_fee_rate<T0, T1>(arg0, arg1);
        let (v3, v4) = mint_position_internal<T0, T1>(arg0, arg1, arg9, arg6, v0, v1, v2, arg10, arg11);
        let v5 = v4;
        let v6 = v3;
        arg0.reserve_x = arg0.reserve_x + v6.total_amounts_in_x;
        arg0.reserve_y = arg0.reserve_y + v6.total_amounts_in_y;
        let v7 = EventDepositedToBins{
            sender            : 0x2::tx_context::sender(arg11),
            lp                : arg9,
            ids               : v6.ids,
            amounts_x         : v6.amounts_x,
            amounts_y         : v6.amounts_y,
            position_id       : 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(&v5),
            pair_reserve_x    : arg0.reserve_x,
            pair_reserve_y    : arg0.reserve_y,
            total_amount_in_x : v6.total_amounts_in_x,
            total_amount_in_y : v6.total_amounts_in_y,
        };
        0x2::event::emit<EventDepositedToBins>(v7);
        if (0x2::coin::value<T0>(&arg2) - v6.total_amounts_in_x > 0) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6.total_amounts_in_x, arg11)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(arg2));
        };
        if (0x2::coin::value<T1>(&arg3) - v6.total_amounts_in_y > 0) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6.total_amounts_in_y, arg11)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(arg3));
        };
        (v6, v5)
    }

    public fun active_index(arg0: &DlmmPairParameter) : u32 {
        arg0.active_index
    }

    fun apply_unstaked_fees(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64((arg0 as u256) * (arg2 as u256) / (0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::unstaked_liquidity_fee_rate_denom() as u256));
        (arg0 - v0, arg1 + v0)
    }

    public fun bin_total_supply<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: u32) : u64 {
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::total_supply(&arg0.lp_token, arg1)
    }

    public fun borrow_bin<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: u32) : &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin {
        0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, arg1)
    }

    fun burn_from_bins_internal<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: address, arg2: &vector<u32>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : BurnFromBinsResult {
        let v0 = BurnFromBinsResult{
            amounts_x           : 0x1::vector::empty<u64>(),
            amounts_y           : 0x1::vector::empty<u64>(),
            total_amounts_out_x : 0,
            total_amounts_out_y : 0,
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg2)) {
            let v2 = *0x1::vector::borrow<u32>(arg2, v1);
            let v3 = 0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, v2);
            let v4 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::total_supply(&arg0.lp_token, v2);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v5 > 0, 14);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::burn(&mut arg0.lp_token, &arg0.lp_mint_cap, v2, arg1, v5, arg4);
            let (v6, v7) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::get_amount_out_of_bin(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v3), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v3), v5, v4);
            if (v6 == 0 && v7 == 0) {
                abort 15
            };
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::sub_reserves(v3, v6, v7);
            if (v4 == v5) {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin_tree::remove(&mut arg0.bins_tree, v2);
                0x2::vec_set::remove<u32>(&mut arg0.bins_iter, &v2);
            };
            let v8 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::liquidity(v3) - 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::liquidity(v3);
            let v9 = if (v8 > arg0.liquidity && v8 - arg0.liquidity >> 127 == 0) {
                true
            } else if (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v3) == 0 && 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v3) == 0) {
                true
            } else {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::total_supply(&arg0.lp_token, v2) == 0
            };
            if (v9) {
                arg0.liquidity = 0;
            } else {
                arg0.liquidity = arg0.liquidity - v8;
            };
            0x1::vector::push_back<u64>(&mut v0.amounts_x, v6);
            0x1::vector::push_back<u64>(&mut v0.amounts_y, v7);
            v0.total_amounts_out_x = v0.total_amounts_out_x + v6;
            v0.total_amounts_out_y = v0.total_amounts_out_y + v7;
            v1 = v1 + 1;
        };
        arg0.reserve_x = arg0.reserve_x - v0.total_amounts_out_x;
        arg0.reserve_y = arg0.reserve_y - v0.total_amounts_out_y;
        v0
    }

    public fun burn_position<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(&arg1);
        assert!(!0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::staked(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, v0)), 24);
        update_position_fees<T0, T1>(arg0, v0);
        let v1 = position_manager_mut<T0, T1>(arg0);
        let (v2, v3) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::extract_fees(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(v1, v0));
        assert!(v2 == 0 && v3 == 0, 26);
        settle_rewarders<T0, T1>(arg0, true, arg2);
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::shares(&arg1);
        let v6 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::ids(&arg1);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<u32>(v6)) {
            0x1::vector::push_back<u64>(&mut v7, *0x2::table::borrow<u32, u64>(v5, *0x1::vector::borrow<u32>(v6, v8)));
            v8 = v8 + 1;
        };
        let v9 = burn_from_bins_internal<T0, T1>(arg0, v4, v6, v7, arg3);
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::destroy(arg1);
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::remove_position_info(&mut arg0.position_manager, v0);
        let v10 = EventBurnPosition{
            sender         : 0x2::tx_context::sender(arg3),
            lp             : v4,
            position_id    : v0,
            ids            : *v6,
            amounts_x      : v9.amounts_x,
            amounts_y      : v9.amounts_y,
            amounts_out_x  : v9.total_amounts_out_x,
            amounts_out_y  : v9.total_amounts_out_y,
            pair_reserve_x : arg0.reserve_x,
            pair_reserve_y : arg0.reserve_y,
        };
        0x2::event::emit<EventBurnPosition>(v10);
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v9.total_amounts_out_x), 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), v9.total_amounts_out_y))
    }

    fun calc_fees_distribution(arg0: u64, arg1: u256, arg2: u256, arg3: u64) : CalcFeesDistribution {
        if (arg1 == arg2) {
            CalcFeesDistribution{growth_global: 0, fee_to_gauge: arg0}
        } else if (arg2 == 0) {
            let (v1, v2) = apply_unstaked_fees(arg0, 0, arg3);
            let v3 = (v1 as u256) * 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale() / (arg1 >> 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale_offset());
            if (v1 > 0) {
                assert!(v3 > 0, 9223380102803357695);
            };
            CalcFeesDistribution{growth_global: v3, fee_to_gauge: v2}
        } else {
            let (v4, v5) = split_fees(arg0, arg1, arg2, arg3);
            let v6 = (v4 as u256) * 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale() / (arg1 - arg2 >> 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale_offset());
            if (v4 > 0) {
                assert!(v6 > 0, 9223380154342965247);
            };
            CalcFeesDistribution{growth_global: v6, fee_to_gauge: v5}
        }
    }

    public fun calc_partner_fee_rate(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: &0x2::clock::Clock) : u64 {
        if (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::has_default_partner(arg1) && 0x2::object::id<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner>(arg0) == 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::default_partner(arg1)) {
            0
        } else {
            0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::current_ref_fee_rate(arg0, 0x2::clock::timestamp_ms(arg2) / 1000)
        }
    }

    public fun calc_unstaked_liquidity_fee_rate<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory) : u64 {
        if (arg0.unstaked_liquidity_fee_rate == 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::default_unstaked_liquidity_fee_rate()) {
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::unstaked_liquidity_fee_rate(arg1)
        } else {
            arg0.unstaked_liquidity_fee_rate
        }
    }

    fun check_gauge_cap<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: &0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::GaugeCap) {
        let v0 = if (0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::get_pool_id(arg1) == 0x2::object::id<DlmmPair<T0, T1>>(arg0)) {
            let v1 = &arg0.distribution_gauge_id;
            if (0x1::option::is_some<0x2::object::ID>(v1)) {
                let v2 = 0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::get_gauge_id(arg1);
                0x1::option::borrow<0x2::object::ID>(v1) == &v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9223379982544273407);
    }

    public fun collect_fees<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.pause, 22);
        let v0 = 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(arg1);
        update_position_fees<T0, T1>(arg0, v0);
        let v1 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(&mut arg0.position_manager, v0);
        if (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::staked(v1)) {
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v2, v3) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::extract_fees(v1);
        let v4 = if (v2 > 0) {
            0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v2)
        } else {
            0x2::balance::zero<T0>()
        };
        let v5 = v4;
        let v6 = if (v3 > 0) {
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), v3)
        } else {
            0x2::balance::zero<T1>()
        };
        let v7 = v6;
        let v8 = EventCollectedFees{
            sender      : 0x2::tx_context::sender(arg2),
            pair_id     : 0x2::object::id<DlmmPair<T0, T1>>(arg0),
            position_id : v0,
            x           : 0x2::balance::value<T0>(&v5),
            y           : 0x2::balance::value<T1>(&v7),
        };
        0x2::event::emit<EventCollectedFees>(v8);
        (v5, v7)
    }

    public fun collect_magma_distribution_gauge_fees<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::GaugeCap) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg1);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        if (arg0.distribution_gauge_fee.x > 0) {
            0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), arg0.distribution_gauge_fee.x));
            arg0.distribution_gauge_fee.x = 0;
        };
        if (arg0.distribution_gauge_fee.y > 0) {
            0x2::balance::join<T1>(&mut v1, 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), arg0.distribution_gauge_fee.y));
            arg0.distribution_gauge_fee.y = 0;
        };
        let v2 = CollectGaugeFeeEvent{
            pair     : 0x2::object::id<DlmmPair<T0, T1>>(arg0),
            amount_x : 0x2::balance::value<T0>(&v0),
            amount_y : 0x2::balance::value<T1>(&v1),
        };
        0x2::event::emit<CollectGaugeFeeEvent>(v2);
        (v0, v1)
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::ProtocolFeeCap, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::check_protocol_fee_cap(arg1, arg2);
        let v0 = if (arg0.protocol_fee_x > 0) {
            arg0.protocol_fee_x - 1
        } else {
            0
        };
        let v1 = if (arg0.protocol_fee_y > 0) {
            arg0.protocol_fee_y - 1
        } else {
            0
        };
        let v2 = if (v0 > 0) {
            arg0.protocol_fee_x = arg0.protocol_fee_x - v0;
            arg0.reserve_x = arg0.reserve_x - v0;
            0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v0)
        } else {
            0x2::balance::zero<T0>()
        };
        let v3 = v2;
        let v4 = if (v1 > 0) {
            arg0.protocol_fee_y = arg0.protocol_fee_y - v1;
            arg0.reserve_y = arg0.reserve_y - v1;
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), v1)
        } else {
            0x2::balance::zero<T1>()
        };
        let v5 = v4;
        let v6 = EventCollectedProtocolFees{
            sender   : 0x2::tx_context::sender(arg3),
            amount_x : 0x2::balance::value<T0>(&v3),
            amount_y : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<EventCollectedProtocolFees>(v6);
        (v3, v5)
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut DlmmPair<T0, T1>, arg1: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::RewarderGlobalVault, arg2: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        assert!(!arg0.pause, 22);
        settle_rewarders<T0, T1>(arg0, true, arg3);
        let v0 = 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(arg2);
        let v1 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::rewarder_index<T2>(&arg0.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v1), 30);
        let v2 = 0x1::type_name::get<T2>();
        let v3 = 0;
        let v4 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::ids(arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u32>(v4)) {
            let v6 = if (!0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::has_bin_id(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, v0), *0x1::vector::borrow<u32>(v4, v5))) {
                0
            } else if (!0x2::vec_map::contains<0x1::type_name::TypeName, u256>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v4, v5))), &v2)) {
                0
            } else {
                let v7 = *0x2::vec_map::get<0x1::type_name::TypeName, u256>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v4, v5))), &v2);
                let v8 = if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionReward>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_rewarder_growth(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, v0), *0x1::vector::borrow<u32>(v4, v5)), &v2)) {
                    v7 - 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_reward_growth(0x2::vec_map::get<0x1::type_name::TypeName, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionReward>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_rewarder_growth(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, v0), *0x1::vector::borrow<u32>(v4, v5)), &v2))
                } else {
                    v7 - 0
                };
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::reset_rewarder(&mut arg0.position_manager, v0, *0x1::vector::borrow<u32>(v4, v5), v2, v7) + 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64(v8 * (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_liquidity(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, v0), *0x1::vector::borrow<u32>(v4, v5)) >> 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale_offset()) >> 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale_offset())
            };
            v3 = v3 + v6;
            v5 = v5 + 1;
        };
        let v9 = EventCollectedReward{
            pair_id     : 0x2::object::id<DlmmPair<T0, T1>>(arg0),
            position_id : v0,
            reward_type : 0x1::type_name::get<T2>(),
            amount      : v3,
        };
        0x2::event::emit<EventCollectedReward>(v9);
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::withdraw_reward<T2>(arg1, v3)
    }

    public fun create_pair_by_preset<T0, T1>(arg0: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: u16, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : DlmmPair<T0, T1> {
        let v0 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::get_bin_step_preset(arg0, arg2);
        create_pair_internal<T0, T1>(arg0, arg1, arg2, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::base_factor(&v0), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::filter_period(&v0), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::decay_period(&v0), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::reduction_factor(&v0), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::variable_fee_control(&v0), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::protocol_share(&v0), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::max_volatility_accumulator(&v0), arg3, arg4)
    }

    public(friend) fun create_pair_internal<T0, T1>(arg0: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u32, arg8: u16, arg9: u32, arg10: u32, arg11: &mut 0x2::tx_context::TxContext) : DlmmPair<T0, T1> {
        let v0 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::pair_uniq<T0, T1>(arg2);
        assert!(!0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::pair_exist(arg0, v0), 16);
        let v1 = DlmmPairParameter{
            base_factor                : 0,
            filter_period              : 0,
            decay_period               : 0,
            reduction_factor           : 0,
            variable_fee_control       : 0,
            protocol_share             : 0,
            max_volatility_accumulator : 0,
            volatility_accumulator     : 0,
            volatility_reference       : 0,
            index_reference            : 0,
            time_of_last_update        : 0,
            oracle_index               : 0,
            active_index               : arg10,
        };
        let v2 = &mut v1;
        update_id_reference(v2);
        let v3 = &mut v1;
        set_static_fee_parameters(v3, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v4 = 0x2::object::new(arg11);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let (v6, v7) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::create(v5, v0, arg11);
        let v8 = v6;
        let v9 = Fee{
            x : 0,
            y : 0,
        };
        let v10 = DlmmPair<T0, T1>{
            id                          : v4,
            factory                     : 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory>(arg0),
            global_config               : 0x2::object::id<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig>(arg1),
            lp_mint_cap                 : v7,
            lp_token                    : v8,
            pause                       : false,
            x                           : 0x1::type_name::get<T0>(),
            y                           : 0x1::type_name::get<T1>(),
            bin_step                    : arg2,
            liquidity                   : 0,
            params                      : v1,
            bins_tree                   : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin_tree::create_bin_tree(),
            bins                        : 0x2::table::new<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(arg11),
            bins_iter                   : 0x2::vec_set::empty<u32>(),
            balances                    : 0x2::bag::new(arg11),
            reserve_x                   : 0,
            reserve_y                   : 0,
            protocol_fee_x              : 0,
            protocol_fee_y              : 0,
            rewarder_manager            : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::new(),
            unstaked_liquidity_fee_rate : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::default_unstaked_liquidity_fee_rate(),
            distribution_gauge_id       : 0x1::option::none<0x2::object::ID>(),
            distribution_rate           : 0,
            distribution_reserve        : 0,
            distribution_period_finish  : 0,
            distribution_rollover       : 0,
            distribution_last_updated   : 0,
            distribution_gauge_fee      : v9,
            position_manager            : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::new_partition_manager(arg11),
        };
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v10.balances, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v10.balances, 0x1::type_name::get<T1>(), 0x2::balance::zero<T1>());
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::add_pair(arg0, v0, v5);
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::add_available_bin_step(arg0, v10.x, v10.y, arg2, arg11);
        let v11 = EventCreatePair{
            pair_id     : v5,
            factory_id  : 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory>(arg0),
            bin_step    : arg2,
            active_id   : arg10,
            params      : v1,
            token_x     : 0x1::type_name::get<T0>(),
            token_y     : 0x1::type_name::get<T1>(),
            lp_token_id : 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::DlmmLpToken>(&v8),
        };
        0x2::event::emit<EventCreatePair>(v11);
        v10
    }

    public fun earned_fees<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1);
        if (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::staked(v0)) {
            return (0, 0)
        };
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = *0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_ids(v0);
        while (v3 < 0x1::vector::length<u32>(&v4)) {
            let (v5, v6) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::get_position_info_bin_fees(v0, *0x1::vector::borrow<u32>(&v4, v3), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_x(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v3))), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_y(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v3))));
            v1 = v1 + v5;
            v2 = v2 + v6;
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun earned_reward<T0, T1, T2>(arg0: &DlmmPair<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::rewarder_index<T2>(&arg0.rewarder_manager);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0
        };
        let v1 = 0x1::type_name::get<T2>();
        let (v2, _) = get_active_liquidity<T0, T1>(arg0);
        let v4 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::get_growths_update_to_date(&arg0.rewarder_manager, v2, arg2);
        let v5 = 0;
        let v6 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_ids(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1));
        let v7 = 0;
        while (v7 < 0x1::vector::length<u32>(v6)) {
            let v8 = if (!0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::has_bin_id(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7))) {
                0
            } else if (!0x2::vec_map::contains<0x1::type_name::TypeName, u256>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v6, v7))), &v1)) {
                0
            } else {
                let v9 = if (*0x1::vector::borrow<u32>(v6, v7) == arg0.params.active_index) {
                    if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionReward>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_rewarder_growth(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1)) {
                        *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&v4, &v1) - 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_reward_growth(0x2::vec_map::get<0x1::type_name::TypeName, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionReward>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_rewarder_growth(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1))
                    } else {
                        *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&v4, &v1) - 0
                    }
                } else if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionReward>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_rewarder_growth(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1)) {
                    *0x2::vec_map::get<0x1::type_name::TypeName, u256>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v6, v7))), &v1) - 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_reward_growth(0x2::vec_map::get<0x1::type_name::TypeName, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionReward>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_rewarder_growth(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1))
                } else {
                    *0x2::vec_map::get<0x1::type_name::TypeName, u256>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v6, v7))), &v1) - 0
                };
                let v10 = if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionReward>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_rewarder_growth(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1)) {
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_reward_amount_owned(0x2::vec_map::get<0x1::type_name::TypeName, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionReward>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_rewarder_growth(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1))
                } else {
                    0
                };
                v10 + 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64(v9 * (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_liquidity(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)) >> 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale_offset()) >> 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale_offset())
            };
            v5 = v5 + v8;
            v7 = v7 + 1;
        };
        v5
    }

    fun fee_hub(arg0: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin, arg1: &DlmmPairParameter, arg2: u64, arg3: u64, arg4: u64) : FeeHub {
        let v0 = arg2;
        let v1 = if (arg3 > 0) {
            arg2 * arg3 / 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::protocol_fee_rate_denom()
        } else {
            0
        };
        if (v1 > 0) {
            v0 = arg2 - v1;
        };
        let v2 = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64((v0 as u256) * (protocol_share(arg1) as u256) / (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::basis_point_max() as u256));
        if (v2 > 0) {
            v0 = v0 - v2;
        };
        let CalcFeesDistribution {
            growth_global : v3,
            fee_to_gauge  : v4,
        } = calc_fees_distribution(v0, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::liquidity(arg0), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::staked_liquidity(arg0), arg4);
        if (v4 > 0) {
            v0 = v0 - v4;
        };
        FeeHub{
            total_fee    : arg2,
            partner_fee  : v1,
            protocol_fee : v2,
            gauge_fee    : v4,
            fee_growth   : v3,
            fee_to_bin   : v0,
        }
    }

    public fun fetch_bins<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: u64, arg2: u64) : vector<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin> {
        let v0 = 0x2::vec_set::keys<u32>(&arg0.bins_iter);
        let v1 = 0x1::vector::empty<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>();
        while (arg1 < arg1 + arg2) {
            0x1::vector::push_back<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut v1, *0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v0, arg1)));
            if (arg1 == 0x1::vector::length<u32>(v0)) {
                break
            };
            arg1 = arg1 + 1;
        };
        v1
    }

    public fun force_decay<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.factory == 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory>(arg1), 18);
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::check_admin(arg1, arg2);
        let v0 = &mut arg0.params;
        update_id_reference(v0);
        let v1 = &mut arg0.params;
        update_volatility_reference(v1);
        let v2 = EventForcedDecay{
            sender               : 0x2::tx_context::sender(arg3),
            id_reference         : arg0.params.index_reference,
            volatility_reference : arg0.params.volatility_reference,
        };
        0x2::event::emit<EventForcedDecay>(v2);
    }

    public fun get_active_liquidity<T0, T1>(arg0: &DlmmPair<T0, T1>) : (u256, bool) {
        let v0 = arg0.params.active_index;
        if (0x2::table::contains<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, v0)) {
            (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::liquidity(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, v0)), true)
        } else {
            (0, false)
        }
    }

    public fun get_base_fee(arg0: &DlmmPairParameter, arg1: u16) : u64 {
        (arg0.base_factor as u64) * (arg1 as u64) * 10
    }

    public fun get_bin_step<T0, T1>(arg0: &DlmmPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun get_delta_id(arg0: &DlmmPairParameter, arg1: u32) : u32 {
        let v0 = arg0.active_index;
        if (v0 > arg1) {
            v0 - arg1
        } else {
            arg1 - v0
        }
    }

    public fun get_magma_distribution_gauge_id<T0, T1>(arg0: &DlmmPair<T0, T1>) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.distribution_gauge_id), 9223380596724596735);
        *0x1::option::borrow<0x2::object::ID>(&arg0.distribution_gauge_id)
    }

    public fun get_magma_distribution_growth_global<T0, T1>(arg0: &DlmmPair<T0, T1>) : u256 {
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::distribution_growth(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, arg0.params.active_index))
    }

    public fun get_magma_distribution_last_updated<T0, T1>(arg0: &DlmmPair<T0, T1>) : u64 {
        arg0.distribution_last_updated
    }

    public fun get_magma_distribution_reserve<T0, T1>(arg0: &DlmmPair<T0, T1>) : u64 {
        arg0.distribution_reserve
    }

    public fun get_magma_distribution_rollover<T0, T1>(arg0: &DlmmPair<T0, T1>) : u64 {
        arg0.distribution_rollover
    }

    public fun get_magma_distribution_staked_liquidity<T0, T1>(arg0: &DlmmPair<T0, T1>) : u256 {
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::staked_liquidity(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, arg0.params.active_index))
    }

    public fun get_next_non_empty_bin<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: bool, arg2: u32) : u32 {
        let (v0, v1) = get_next_non_empty_bin_internal<T0, T1>(arg0, arg1, arg2);
        assert!(v1, 4);
        v0
    }

    fun get_next_non_empty_bin_internal<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: bool, arg2: u32) : (u32, bool) {
        if (arg1) {
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin_tree::find_first_right(&arg0.bins_tree, arg2)
        } else {
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin_tree::find_first_left(&arg0.bins_tree, arg2)
        }
    }

    public fun get_swap_in<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = arg0.params;
        let v1 = arg1;
        let v2 = v0.active_index;
        let v3 = &mut v0;
        update_references(v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v4 = 0;
        let v5 = 0;
        loop {
            let v6 = if (arg2) {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, v2))
            } else {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, v2))
            };
            if (v6 > 0) {
                let v7 = if (v6 > v1) {
                    v1
                } else {
                    v6
                };
                let v8 = &mut v0;
                update_volatility_accumulator(v8, v2);
                let v9 = if (arg2) {
                    ((v7 as u256) << 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale_offset()) / 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_price::get_price_from_storage_id(v2, arg0.bin_step)
                } else {
                    (v7 as u256) * 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_price::get_price_from_storage_id(v2, arg0.bin_step) >> 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale_offset()
                };
                let v10 = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64(v9);
                let v11 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_fee::get_fee_amount_from(v10, get_total_fee(&v0, arg0.bin_step));
                let v12 = v4 + v10;
                v4 = v12 + v11;
                v1 = v1 - v7;
                v5 = v5 + v11;
            };
            if (v1 == 0) {
                break
            };
            let (v13, v14) = get_next_non_empty_bin_internal<T0, T1>(arg0, arg2, v2);
            if (!v14) {
                break
            };
            v2 = v13;
        };
        (v4, v1, v5)
    }

    public fun get_swap_out<T0, T1>(arg0: &DlmmPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = arg0.params;
        let v2 = active_index(&v1);
        let v3 = &mut v1;
        update_references(v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v4 = 0;
        let v5 = 0;
        loop {
            let v6 = 0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, v2);
            let v7 = if (arg2) {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v6)
            } else {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v6)
            };
            if (v7 > 0) {
                let v8 = &mut v1;
                update_volatility_accumulator(v8, v2);
                let (v9, v10, v11, v12, v13, v14) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::get_amounts(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v6), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v6), arg0.bin_step, get_total_fee(&v1, arg0.bin_step), arg2, v2, v0);
                if (v9 > 0 && arg2) {
                    v0 = v0 - v9;
                    v5 = v5 + v12;
                    v4 = v4 + v13;
                } else if (v10 > 0 && !arg2) {
                    v0 = v0 - v10;
                    v5 = v5 + v11;
                    v4 = v4 + v14;
                };
            };
            if (v0 == 0) {
                break
            };
            let (v15, v16) = get_next_non_empty_bin_internal<T0, T1>(arg0, arg2, v2);
            if (!v16) {
                break
            };
            v2 = v15;
        };
        (v0, v5, v4)
    }

    public fun get_total_fee(arg0: &DlmmPairParameter, arg1: u16) : u64 {
        get_base_fee(arg0, arg1) + get_variable_fee(arg0, arg1)
    }

    public fun get_variable_fee(arg0: &DlmmPairParameter, arg1: u16) : u64 {
        if (arg0.variable_fee_control != 0) {
            let v1 = (arg0.volatility_accumulator as u256) * (arg1 as u256);
            (((v1 * v1 * (arg0.variable_fee_control as u256) + 99) / 100 / 1000000000) as u64)
        } else {
            0
        }
    }

    public fun index_reference(arg0: &DlmmPairParameter) : u32 {
        arg0.index_reference
    }

    public fun init_magma_distribution_gauge<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::GaugeCap) {
        assert!(0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::get_pool_id(arg1) == 0x2::object::id<DlmmPair<T0, T1>>(arg0), 9223380626789367807);
        0x1::option::fill<0x2::object::ID>(&mut arg0.distribution_gauge_id, 0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::get_gauge_id(arg1));
    }

    public fun initialize_rewarder<T0, T1, T2>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.pause, 22);
        0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::check_rewarder_manager_role(arg1, 0x2::tx_context::sender(arg3));
        settle_rewarders<T0, T1>(arg0, true, arg2);
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::add_rewarder<T2>(&mut arg0.rewarder_manager);
        if (0x2::table::contains<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, arg0.params.active_index)) {
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::download_rewarders(0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, arg0.params.active_index), &arg0.rewarder_manager);
        };
        let v0 = AddRewarderEvent{
            pair          : 0x2::object::id<DlmmPair<T0, T1>>(arg0),
            rewarder_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<AddRewarderEvent>(v0);
    }

    public fun mint_by_amounts<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (MintResult, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position) {
        assert!(arg7 != @0x0, 9223376121368674303);
        assert!(0x1::vector::length<u32>(&arg4) > 0, 8);
        assert!(0x1::vector::length<u32>(&arg4) == 0x1::vector::length<u64>(&arg5) && 0x1::vector::length<u32>(&arg4) == 0x1::vector::length<u64>(&arg6), 7);
        assert!(arg0.factory == 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory>(arg1), 25);
        settle_rewarders<T0, T1>(arg0, true, arg8);
        let v0 = calc_unstaked_liquidity_fee_rate<T0, T1>(arg0, arg1);
        let (v1, v2) = mint_position_internal<T0, T1>(arg0, arg1, arg7, arg4, arg5, arg6, v0, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        arg0.reserve_x = arg0.reserve_x + v4.total_amounts_in_x;
        arg0.reserve_y = arg0.reserve_y + v4.total_amounts_in_y;
        let v5 = EventDepositedToBins{
            sender            : 0x2::tx_context::sender(arg9),
            lp                : arg7,
            ids               : v4.ids,
            amounts_x         : v4.amounts_x,
            amounts_y         : v4.amounts_y,
            position_id       : 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(&v3),
            pair_reserve_x    : arg0.reserve_x,
            pair_reserve_y    : arg0.reserve_y,
            total_amount_in_x : v4.total_amounts_in_x,
            total_amount_in_y : v4.total_amounts_in_y,
        };
        0x2::event::emit<EventDepositedToBins>(v5);
        if (0x2::coin::value<T0>(&arg2) - v4.total_amounts_in_x > 0) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v4.total_amounts_in_x, arg9)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(arg2));
        };
        if (0x2::coin::value<T1>(&arg3) - v4.total_amounts_in_y > 0) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v4.total_amounts_in_y, arg9)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(arg3));
        };
        (v4, v3)
    }

    fun mint_percents_to_amounts(arg0: vector<u32>, arg1: vector<u64>, arg2: vector<u64>, arg3: u64, arg4: u64) : (vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg0)) {
            let v3 = if (*0x1::vector::borrow<u64>(&arg1, v2) > 0) {
                0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64((arg3 as u256) * (*0x1::vector::borrow<u64>(&arg1, v2) as u256) / 100000000)
            } else {
                0
            };
            let v4 = if (*0x1::vector::borrow<u64>(&arg2, v2) > 0) {
                0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64((arg4 as u256) * (*0x1::vector::borrow<u64>(&arg2, v2) as u256) / 100000000)
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun mint_position_internal<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: address, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (MintResult, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position) {
        assert!(0x1::vector::length<u32>(&arg3) <= 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::max_bins_in_position(arg1), 27);
        let v0 = active_index(&arg0.params);
        let v1 = MintResult{
            total_amounts_in_x : 0,
            total_amounts_in_y : 0,
            ids                : 0x1::vector::empty<u32>(),
            amounts_x          : 0x1::vector::empty<u64>(),
            amounts_y          : 0x1::vector::empty<u64>(),
            liquidity_minted   : 0x1::vector::empty<u64>(),
            fee_to_bin_x       : 0,
            fee_to_bin_y       : 0,
        };
        let v2 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::create(0x2::object::id<DlmmPair<T0, T1>>(arg0), arg3, 0x1::vector::empty<u64>(), arg8);
        let v3 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::new_position_info(0x2::object::id<DlmmPair<T0, T1>>(arg0), 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(&v2), arg3, arg8);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u32>(&arg3)) {
            let v5 = mint_update_bin_internal<T0, T1>(arg0, v0, *0x1::vector::borrow<u32>(&arg3, v4), *0x1::vector::borrow<u64>(&arg4, v4), *0x1::vector::borrow<u64>(&arg5, v4), arg6, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::composition_enabled(arg1), arg7, arg8);
            let UpdateBinInternalResult {
                shares             : v6,
                amounts_in_x       : v7,
                amounts_in_y       : v8,
                fee_to_bin_x       : v9,
                fee_to_bin_y       : v10,
                protocol_fee_x     : v11,
                protocol_fee_y     : v12,
                amounts_into_bin_x : v13,
                amounts_into_bin_y : v14,
                liquidity_delta    : v15,
            } = v5;
            if (v11 > 0) {
                arg0.protocol_fee_x = arg0.protocol_fee_x + v11;
            };
            if (v12 > 0) {
                arg0.protocol_fee_y = arg0.protocol_fee_y + v12;
            };
            arg0.liquidity = arg0.liquidity + v15;
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::mint(&mut arg0.lp_token, &arg0.lp_mint_cap, *0x1::vector::borrow<u32>(&arg3, v4), arg2, v6, arg8);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::increase_shares(&mut v2, *0x1::vector::borrow<u32>(&arg3, v4), v6);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::set_fee_growth(&mut v3, *0x1::vector::borrow<u32>(&arg3, v4), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_x(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&arg3, v4))), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_y(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&arg3, v4))));
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::add_bin_liquidity(&mut v3, *0x1::vector::borrow<u32>(&arg3, v4), v15);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::add_bin_shares(&mut v3, *0x1::vector::borrow<u32>(&arg3, v4), v6);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_load_rewarder_growth_from_bin(&mut v3, *0x1::vector::borrow<u32>(&arg3, v4), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&arg3, v4))));
            0x1::vector::push_back<u32>(&mut v1.ids, *0x1::vector::borrow<u32>(&arg3, v4));
            0x1::vector::push_back<u64>(&mut v1.amounts_x, v13);
            0x1::vector::push_back<u64>(&mut v1.amounts_y, v14);
            0x1::vector::push_back<u64>(&mut v1.liquidity_minted, v6);
            v1.total_amounts_in_x = v1.total_amounts_in_x + v7;
            v1.total_amounts_in_y = v1.total_amounts_in_y + v8;
            v1.fee_to_bin_x = v1.fee_to_bin_x + v9;
            v1.fee_to_bin_y = v1.fee_to_bin_y + v10;
            v4 = v4 + 1;
        };
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::add_position_info(&mut arg0.position_manager, 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(&v2), v3);
        (v1, v2)
    }

    fun mint_update_bin_internal<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : UpdateBinInternalResult {
        let v0 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_price::get_price_from_storage_id(arg2, arg0.bin_step);
        if (!0x2::table::contains<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, arg2)) {
            0x2::table::add<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, arg2, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::new(arg2, v0, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::borrow_rewarders(&arg0.rewarder_manager)));
        };
        let v1 = 0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, arg2);
        let v2 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::total_supply(&arg0.lp_token, arg2);
        let v3 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v1);
        let v4 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v1);
        let v5 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::get_liquidity(v3, v4, v0);
        let (v6, v7, v8) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::get_shares_and_effective_amounts_in(v3, v4, arg3, arg4, v0, v2);
        let v9 = v6;
        let v10 = v7;
        let v11 = v8;
        let v12 = 0;
        let v13 = 0;
        let v14 = 0;
        let v15 = 0;
        if (arg2 == arg1) {
            let v16 = &mut arg0.params;
            update_volatility_parameters(v16, arg2, 0x2::clock::timestamp_ms(arg7) / 1000);
            let (v17, v18) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::get_composition_fees(v3, v4, v7, v8, v2, v6, get_total_fee(&arg0.params, arg0.bin_step));
            if (!arg6) {
                assert!(v17 == 0 && v18 == 0, 9223378573795000319);
            };
            if (v17 != 0 || v18 != 0) {
                let v19 = if (v17 > 0) {
                    v17 * (arg0.params.protocol_share as u64) / (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::basis_point_max() as u64)
                } else {
                    0
                };
                let v20 = if (v18 > 0) {
                    v18 * (arg0.params.protocol_share as u64) / (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::basis_point_max() as u64)
                } else {
                    0
                };
                if (v17 > 0) {
                    v10 = v7 - v17;
                };
                if (v18 > 0) {
                    v11 = v8 - v18;
                };
                v14 = v19;
                v15 = v20;
                let v21 = v17 - v19;
                let v22 = v21;
                let v23 = v18 - v20;
                let v24 = v23;
                let v25 = if (v21 > 0) {
                    calc_fees_distribution(v21, v5, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::staked_liquidity(v1), arg5)
                } else {
                    calc_fees_distribution(v23, v5, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::staked_liquidity(v1), arg5)
                };
                let v26 = v25;
                if (v21 > 0) {
                    v22 = v21 - v26.fee_to_gauge;
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::grow_fee_x(v1, v26.growth_global);
                };
                if (v23 > 0) {
                    v24 = v23 - v26.fee_to_gauge;
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::grow_fee_y(v1, v26.growth_global);
                };
                v9 = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::get_liquidity(v10, v11, v0) * (v2 as u256) / v5);
                let v27 = if (v22 > 0) {
                    v26.growth_global
                } else {
                    0
                };
                let v28 = if (v24 > 0) {
                    v26.growth_global
                } else {
                    0
                };
                let v29 = if (v22 > 0) {
                    v26.fee_to_gauge
                } else {
                    0
                };
                let v30 = if (v24 > 0) {
                    v26.fee_to_gauge
                } else {
                    0
                };
                let v31 = EventCompositionFees{
                    pair           : 0x2::object::id<DlmmPair<T0, T1>>(arg0),
                    token_x        : 0x1::type_name::get<T0>(),
                    token_y        : 0x1::type_name::get<T1>(),
                    sender         : 0x2::tx_context::sender(arg8),
                    id             : arg2,
                    fee_x          : v22,
                    fee_y          : v24,
                    protocol_fee_x : v19,
                    protocol_fee_y : v20,
                    gauge_fee_x    : v29,
                    gauge_fee_y    : v30,
                    fee_growth_x   : v27,
                    fee_growth_y   : v28,
                };
                0x2::event::emit<EventCompositionFees>(v31);
                v12 = v22;
                v13 = v24;
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::download_rewarders(v1, &arg0.rewarder_manager);
            };
        } else {
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::verify_amounts(v7, v8, arg1, arg2);
        };
        if (v9 == 0 || v10 == 0 && v11 == 0) {
            abort 6
        };
        if (v2 == 0) {
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin_tree::add(&mut arg0.bins_tree, arg2);
            0x2::vec_set::insert<u32>(&mut arg0.bins_iter, arg2);
        };
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::add_reserves(v1, v10, v11);
        UpdateBinInternalResult{
            shares             : v9,
            amounts_in_x       : v7,
            amounts_in_y       : v8,
            fee_to_bin_x       : v12,
            fee_to_bin_y       : v13,
            protocol_fee_x     : v14,
            protocol_fee_y     : v15,
            amounts_into_bin_x : v10,
            amounts_into_bin_y : v11,
            liquidity_delta    : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::liquidity(v1) - v5,
        }
    }

    public fun oracle_index(arg0: &DlmmPairParameter) : u16 {
        arg0.oracle_index
    }

    public fun params<T0, T1>(arg0: &DlmmPair<T0, T1>) : &DlmmPairParameter {
        &arg0.params
    }

    public fun position_manager<T0, T1>(arg0: &DlmmPair<T0, T1>) : &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionManager {
        &arg0.position_manager
    }

    public fun position_manager_mut<T0, T1>(arg0: &mut DlmmPair<T0, T1>) : &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::PositionManager {
        &mut arg0.position_manager
    }

    public fun raise_position_by_amounts<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: vector<u64>, arg6: vector<u64>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = raise_position_by_amounts_internal<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9);
        assert!(0x2::balance::value<T0>(&arg3) >= v0.total_amounts_in_x, 12);
        assert!(0x2::balance::value<T1>(&arg4) >= v0.total_amounts_in_y, 13);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::balance::split<T0>(&mut arg3, v0.total_amounts_in_x));
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::balance::split<T1>(&mut arg4, v0.total_amounts_in_y));
        (arg3, arg4)
    }

    fun raise_position_by_amounts_internal<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position, arg3: vector<u64>, arg4: vector<u64>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : MintResult {
        let v0 = 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(arg2);
        assert!(!0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::staked(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, v0)), 24);
        update_position_fees<T0, T1>(arg0, v0);
        let v1 = position_manager_mut<T0, T1>(arg0);
        let (v2, v3) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::extract_fees(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(v1, v0));
        assert!(v2 == 0 && v3 == 0, 26);
        let v4 = *0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::ids(arg2);
        assert!(0x1::vector::length<u32>(&v4) == 0x1::vector::length<u64>(&arg3) && 0x1::vector::length<u32>(&v4) == 0x1::vector::length<u64>(&arg4), 9223377366909190143);
        let v5 = 0;
        0x1::vector::reverse<u64>(&mut arg3);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg3)) {
            v5 = v5 + 0x1::vector::pop_back<u64>(&mut arg3);
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg3);
        let v7 = 0;
        0x1::vector::reverse<u64>(&mut arg4);
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&arg4)) {
            v7 = v7 + 0x1::vector::pop_back<u64>(&mut arg4);
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg4);
        assert!(v5 > 0 || v7 > 0, 28);
        let v9 = active_index(&arg0.params);
        let v10 = calc_unstaked_liquidity_fee_rate<T0, T1>(arg0, arg1);
        let v11 = MintResult{
            total_amounts_in_x : 0,
            total_amounts_in_y : 0,
            ids                : 0x1::vector::empty<u32>(),
            amounts_x          : 0x1::vector::empty<u64>(),
            amounts_y          : 0x1::vector::empty<u64>(),
            liquidity_minted   : 0x1::vector::empty<u64>(),
            fee_to_bin_x       : 0,
            fee_to_bin_y       : 0,
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<u32>(&v4)) {
            let v13 = mint_update_bin_internal<T0, T1>(arg0, v9, *0x1::vector::borrow<u32>(&v4, v12), *0x1::vector::borrow<u64>(&arg3, v12), *0x1::vector::borrow<u64>(&arg4, v12), v10, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::composition_enabled(arg1), arg6, arg7);
            let UpdateBinInternalResult {
                shares             : v14,
                amounts_in_x       : v15,
                amounts_in_y       : v16,
                fee_to_bin_x       : v17,
                fee_to_bin_y       : v18,
                protocol_fee_x     : v19,
                protocol_fee_y     : v20,
                amounts_into_bin_x : v21,
                amounts_into_bin_y : v22,
                liquidity_delta    : v23,
            } = v13;
            if (v19 > 0) {
                arg0.protocol_fee_x = arg0.protocol_fee_x + v19;
            };
            if (v20 > 0) {
                arg0.protocol_fee_y = arg0.protocol_fee_y + v20;
            };
            arg0.liquidity = arg0.liquidity + v23;
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_lp_token::mint(&mut arg0.lp_token, &arg0.lp_mint_cap, *0x1::vector::borrow<u32>(&v4, v12), arg5, v14, arg7);
            let v24 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(&mut arg0.position_manager, v0);
            if ((v17 > 0 || v18 > 0) && 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_liquidity(v24, *0x1::vector::borrow<u32>(&v4, v12)) > 0) {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::update_fees(v24, *0x1::vector::borrow<u32>(&v4, v12), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_x(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v12))), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_y(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v12))));
            } else {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::set_fee_growth(v24, *0x1::vector::borrow<u32>(&v4, v12), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_x(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v12))), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_y(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v12))));
            };
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::increase_shares(arg2, *0x1::vector::borrow<u32>(&v4, v12), v14);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::add_bin_liquidity(v24, *0x1::vector::borrow<u32>(&v4, v12), v23);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::add_bin_shares(v24, *0x1::vector::borrow<u32>(&v4, v12), v14);
            0x1::vector::push_back<u32>(&mut v11.ids, *0x1::vector::borrow<u32>(&v4, v12));
            0x1::vector::push_back<u64>(&mut v11.amounts_x, v21);
            0x1::vector::push_back<u64>(&mut v11.amounts_y, v22);
            0x1::vector::push_back<u64>(&mut v11.liquidity_minted, v14);
            v11.total_amounts_in_x = v11.total_amounts_in_x + v15;
            v11.total_amounts_in_y = v11.total_amounts_in_y + v16;
            v11.fee_to_bin_x = v11.fee_to_bin_x + v17;
            v11.fee_to_bin_y = v11.fee_to_bin_y + v18;
            v12 = v12 + 1;
        };
        arg0.reserve_x = arg0.reserve_x + v11.total_amounts_in_x;
        arg0.reserve_y = arg0.reserve_y + v11.total_amounts_in_y;
        v11
    }

    public fun rewarder_manager<T0, T1>(arg0: &DlmmPair<T0, T1>) : &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::RewarderManager {
        &arg0.rewarder_manager
    }

    public(friend) fun set_active_id(arg0: &mut DlmmPairParameter, arg1: u32) {
        arg0.active_index = arg1;
    }

    public(friend) fun set_oracle_id(arg0: &mut DlmmPairParameter, arg1: u16) {
        arg0.oracle_index = arg1;
    }

    public(friend) fun set_static_fee_parameters(arg0: &mut DlmmPairParameter, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32) {
        let v0 = if (arg2 > arg3) {
            true
        } else if (arg3 >> 12 > 0) {
            true
        } else if (arg4 > 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::basis_point_max()) {
            true
        } else if (arg6 > 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::max_protocol_share()) {
            true
        } else {
            arg7 >> 20 > 0
        };
        if (v0) {
            abort 3
        };
        arg0.base_factor = arg1;
        arg0.filter_period = arg2;
        arg0.decay_period = arg3;
        arg0.reduction_factor = arg4;
        arg0.variable_fee_control = arg5;
        arg0.protocol_share = arg6;
        arg0.max_volatility_accumulator = arg7;
    }

    public fun set_static_fee_parameters_external<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::AdminCap, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u32, arg8: u16, arg9: u32, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.factory == 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory>(arg1), 18);
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::check_admin(arg1, arg2);
        set_static_fee_parameters_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun set_static_fee_parameters_internal<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 0) {
            if (arg2 == 0) {
                if (arg3 == 0) {
                    if (arg4 == 0) {
                        if (arg5 == 0) {
                            if (arg6 == 0) {
                                arg7 == 0
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
        if (v0) {
            abort 3
        };
        let v1 = &mut arg0.params;
        set_static_fee_parameters(v1, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        arg0.params.volatility_accumulator = arg7;
        if (get_total_fee(&arg0.params, arg0.bin_step) > 100000000) {
            abort 5
        };
        let v2 = EventSetStaticFeeParameters{
            sender                     : 0x2::tx_context::sender(arg8),
            base_factor                : arg1,
            filter_period              : arg2,
            decay_period               : arg3,
            reduction_factor           : arg4,
            variable_fee_control       : arg5,
            protocol_share             : arg6,
            max_volatility_accumulator : arg7,
        };
        0x2::event::emit<EventSetStaticFeeParameters>(v2);
    }

    public(friend) fun set_volatility_accumulator(arg0: &mut DlmmPairParameter, arg1: u32) {
        assert!(arg1 >> 20 == 0, 2);
        arg0.volatility_accumulator = arg1;
    }

    public(friend) fun set_volatility_reference(arg0: &mut DlmmPairParameter, arg1: u32) {
        assert!(arg1 >> 20 == 0, 1);
        arg0.volatility_reference = arg1;
    }

    public fun settle_rewarders<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock) {
        let (v0, v1) = get_active_liquidity<T0, T1>(arg0);
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::settle(&mut arg0.rewarder_manager, v0, 0x2::clock::timestamp_ms(arg2) / 1000);
        if (!arg1) {
            return
        };
        if (v1) {
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::download_rewarders(0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, active_index(&arg0.params)), &arg0.rewarder_manager);
        };
    }

    public fun shrink_position<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::object::id<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(arg1);
        assert!(!0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::staked(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, v0)), 24);
        assert!(arg2 > 0 && arg2 < (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::basis_point_max() as u64), 29);
        update_position_fees<T0, T1>(arg0, v0);
        let v1 = position_manager_mut<T0, T1>(arg0);
        let (v2, v3) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::extract_fees(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(v1, v0));
        assert!(v2 == 0 && v3 == 0, 26);
        let v4 = *0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::ids(arg1);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<u32>(&v4)) {
            0x1::vector::push_back<u64>(&mut v5, 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64((*0x2::table::borrow<u32, u64>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::shares(arg1), *0x1::vector::borrow<u32>(&v4, v6)) as u256) * (arg2 as u256) / (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::basis_point_max() as u256)));
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::decrease_shares(arg1, *0x1::vector::borrow<u32>(&v4, v6), *0x1::vector::borrow<u64>(&v5, v6));
            v6 = v6 + 1;
        };
        let v7 = 0x2::tx_context::sender(arg4);
        let v8 = burn_from_bins_internal<T0, T1>(arg0, v7, &v4, v5, arg4);
        v6 = 0;
        let v9 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(&mut arg0.position_manager, v0);
        while (v6 < 0x1::vector::length<u32>(&v4)) {
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::sub_bin_liquidity(v9, *0x1::vector::borrow<u32>(&v4, v6), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::get_liquidity(*0x1::vector::borrow<u64>(&v8.amounts_x, v6), *0x1::vector::borrow<u64>(&v8.amounts_y, v6), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::price(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v6)))));
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::sub_bin_shares(v9, *0x1::vector::borrow<u32>(&v4, v6), *0x1::vector::borrow<u64>(&v5, v6));
            v6 = v6 + 1;
        };
        let v10 = EventWithdrawnFromBins{
            sender         : 0x2::tx_context::sender(arg4),
            lp             : 0x2::tx_context::sender(arg4),
            position_id    : v0,
            ids            : v4,
            amounts_x      : v8.amounts_x,
            amounts_y      : v8.amounts_y,
            amounts_out_x  : v8.total_amounts_out_x,
            amounts_out_y  : v8.total_amounts_out_y,
            pair_reserve_x : arg0.reserve_x,
            pair_reserve_y : arg0.reserve_y,
        };
        0x2::event::emit<EventWithdrawnFromBins>(v10);
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v8.total_amounts_out_x), 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), v8.total_amounts_out_y))
    }

    fun split_fees(arg0: u64, arg1: u256, arg2: u256, arg3: u64) : (u64, u64) {
        let v0 = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64((arg0 as u256) * arg2 / arg1);
        let (v1, v2) = apply_unstaked_fees(arg0 - v0, v0, arg3);
        ((v1 as u64), (v2 as u64))
    }

    public fun stake_in_magma_distribution<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::GaugeCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg1);
        let v0 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::liquidity(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg2));
        assert!(v0 > 0, 9223380394861133823);
        let v1 = *0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_ids(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg2));
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&v1)) {
            if (arg0.params.active_index == *0x1::vector::borrow<u32>(&v1, v2)) {
                update_magma_distribution_growth_global_internal<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v1, v2), arg3);
            };
            let v3 = 0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, *0x1::vector::borrow<u32>(&v1, v2));
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::stake_liquidity(v3, v0);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::set_distribution_growth(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(&mut arg0.position_manager, arg2), *0x1::vector::borrow<u32>(&v1, v2), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::distribution_growth(v3));
            v2 = v2 + 1;
        };
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::stake(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(&mut arg0.position_manager, arg2));
    }

    fun swap_internal<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: u64, arg2: bool, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : SwapInternalResult {
        let v0 = SwapInternalResult{
            amounts_out    : 0,
            swap_for_y     : arg2,
            protocol_fee   : 0,
            fee_to_bin     : 0,
            partner_fee    : 0,
            gauge_fee      : 0,
            pair_reserve_x : arg0.reserve_x,
            pair_reserve_y : arg0.reserve_y,
        };
        let v1 = arg0.params;
        let v2 = v1.active_index;
        let v3 = &mut v1;
        update_references(v3, 0x2::clock::timestamp_ms(arg6) / 1000);
        let v4 = 0x1::vector::empty<SwapInternalStep>();
        let v5 = 0;
        let v6 = false;
        loop {
            let v7 = 0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, v2);
            let v8 = if (arg2) {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v7)
            } else {
                0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v7)
            };
            if (v8 > 0) {
                let v9 = &mut v1;
                update_volatility_accumulator(v9, v2);
                let (v10, v11, v12, v13, v14, v15) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::get_amounts(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v7), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v7), arg0.bin_step, get_total_fee(&v1, arg0.bin_step), arg2, v2, arg1);
                if (v10 > 0 && arg2) {
                    if (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::staked_liquidity(v7) > 0) {
                        v5 = v5 + v10;
                        let v16 = SwapInternalStep{
                            bin_id               : v2,
                            distribution_portion : v10,
                            staked_liquidity     : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::staked_liquidity(v7),
                            bin_liquidity        : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::liquidity(v7),
                        };
                        0x1::vector::push_back<SwapInternalStep>(&mut v4, v16);
                    };
                    arg1 = arg1 - v10;
                    v0.amounts_out = v0.amounts_out + v13;
                    let v17 = v10 - v14;
                    let v18 = fee_hub(v7, &v1, v14, arg4, arg5);
                    v0.partner_fee = v0.partner_fee + v18.partner_fee;
                    v0.protocol_fee = v0.protocol_fee + v18.protocol_fee;
                    v0.gauge_fee = v0.gauge_fee + v18.gauge_fee;
                    v0.fee_to_bin = v0.fee_to_bin + v18.fee_to_bin;
                    if (v18.fee_growth > 0) {
                        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::grow_fee_x(v7, v18.fee_growth);
                    };
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::add_reserves(v7, v17, 0);
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::sub_reserves(v7, 0, v13);
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::accumulate_fees(v7, v18.fee_to_bin, v0.swap_for_y);
                    v0.pair_reserve_x = v0.pair_reserve_x + v17;
                    v0.pair_reserve_y = v0.pair_reserve_y - v13;
                    let v19 = EventSwap{
                        sender                 : 0x2::tx_context::sender(arg7),
                        receiver               : arg3,
                        active_id              : v2,
                        swap_for_y             : arg2,
                        amounts_in_with_fees   : v17,
                        amounts_out_of_bin     : v13,
                        volatility_accumulator : volatility_accumulator(&v1),
                        pair_fee               : v18.fee_to_bin,
                        protocol_fee           : v18.protocol_fee,
                        gauge_fee              : v18.gauge_fee,
                        partner_fee            : v18.partner_fee,
                        pair_reserve_x         : v0.pair_reserve_x,
                        pair_reserve_y         : v0.pair_reserve_y,
                    };
                    0x2::event::emit<EventSwap>(v19);
                } else if (v11 > 0 && !arg2) {
                    if (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::staked_liquidity(v7) > 0) {
                        v5 = v5 + v11;
                        let v20 = SwapInternalStep{
                            bin_id               : v2,
                            distribution_portion : v11,
                            staked_liquidity     : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::staked_liquidity(v7),
                            bin_liquidity        : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::liquidity(v7),
                        };
                        0x1::vector::push_back<SwapInternalStep>(&mut v4, v20);
                    };
                    arg1 = arg1 - v11;
                    v0.amounts_out = v0.amounts_out + v12;
                    let v21 = v11 - v15;
                    let v22 = fee_hub(v7, &v1, v15, arg4, arg5);
                    v0.partner_fee = v0.partner_fee + v22.partner_fee;
                    v0.protocol_fee = v0.protocol_fee + v22.protocol_fee;
                    v0.gauge_fee = v0.gauge_fee + v22.gauge_fee;
                    v0.fee_to_bin = v0.fee_to_bin + v22.fee_to_bin;
                    if (v22.fee_growth > 0) {
                        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::grow_fee_y(v7, v22.fee_growth);
                    };
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::add_reserves(v7, 0, v21);
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::sub_reserves(v7, v12, 0);
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::accumulate_fees(v7, v22.fee_to_bin, v0.swap_for_y);
                    v0.pair_reserve_x = v0.pair_reserve_x - v12;
                    v0.pair_reserve_y = v0.pair_reserve_y + v21;
                    let v23 = EventSwap{
                        sender                 : 0x2::tx_context::sender(arg7),
                        receiver               : arg3,
                        active_id              : v2,
                        swap_for_y             : arg2,
                        amounts_in_with_fees   : v21,
                        amounts_out_of_bin     : v12,
                        volatility_accumulator : volatility_accumulator(&v1),
                        pair_fee               : v22.fee_to_bin,
                        protocol_fee           : v22.protocol_fee,
                        gauge_fee              : v22.gauge_fee,
                        partner_fee            : v22.partner_fee,
                        pair_reserve_x         : v0.pair_reserve_x,
                        pair_reserve_y         : v0.pair_reserve_y,
                    };
                    0x2::event::emit<EventSwap>(v23);
                };
            };
            if (arg1 == 0) {
                break
            };
            let (v24, v25) = get_next_non_empty_bin_internal<T0, T1>(arg0, arg2, v2);
            assert!(v25, 10);
            v2 = v24;
            v6 = true;
        };
        assert!(v0.amounts_out > 0, 11);
        if (v6) {
            update_distribution_in_cross_bins_by_swap<T0, T1>(arg0, v5, &v4, 0x2::clock::timestamp_ms(arg6) / 1000);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::download_rewarders(0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, arg0.params.active_index), &arg0.rewarder_manager);
            let v26 = 0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, v2);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::upload_rewarders(v26, &mut arg0.rewarder_manager);
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::download_rewarders(v26, &arg0.rewarder_manager);
        };
        arg0.reserve_x = v0.pair_reserve_x;
        arg0.reserve_y = v0.pair_reserve_y;
        if (arg2) {
            arg0.protocol_fee_x = arg0.protocol_fee_x + v0.protocol_fee;
            arg0.distribution_gauge_fee.x = arg0.distribution_gauge_fee.x + v0.gauge_fee;
        } else {
            arg0.protocol_fee_y = arg0.protocol_fee_y + v0.protocol_fee;
            arg0.distribution_gauge_fee.y = arg0.distribution_gauge_fee.y + v0.gauge_fee;
        };
        let v27 = &mut v1;
        set_active_id(v27, v2);
        arg0.params = v1;
        v0
    }

    public fun swap_with_partner<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, SwapInternalResult) {
        swap_with_partner_fee_rate<T0, T1>(arg0, arg1, 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::current_ref_fee_rate(arg2, 0x2::clock::timestamp_ms(arg9) / 1000), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public(friend) fun swap_with_partner_fee_rate<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, SwapInternalResult) {
        assert!(arg5 > 0, 9);
        if (arg7) {
            assert!(0x2::coin::value<T0>(&arg3) >= arg5, 12);
        } else {
            assert!(0x2::coin::value<T1>(&arg4) >= arg5, 13);
        };
        settle_rewarders<T0, T1>(arg0, true, arg9);
        let v0 = if (arg0.unstaked_liquidity_fee_rate == 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::default_unstaked_fee_rate()) {
            0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::unstaked_liquidity_fee_rate(arg1)
        } else {
            arg0.unstaked_liquidity_fee_rate
        };
        let v1 = swap_internal<T0, T1>(arg0, arg5, arg7, arg8, arg2, v0, arg9, arg10);
        assert!(v1.amounts_out >= arg6, 23);
        if (arg7) {
            0x2::coin::destroy_zero<T1>(arg4);
            let v4 = if (0x2::coin::value<T0>(&arg3) > arg5) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, arg5, arg10)));
                0x2::coin::into_balance<T0>(arg3)
            } else {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(arg3));
                0x2::balance::zero<T0>()
            };
            (v4, 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), v1.amounts_out), v1)
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
            let v5 = if (0x2::coin::value<T1>(&arg4) > arg5) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, arg5, arg10)));
                0x2::coin::into_balance<T1>(arg4)
            } else {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(arg4));
                0x2::balance::zero<T1>()
            };
            (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v1.amounts_out), v5, v1)
        }
    }

    public fun sync_magma_distribution_reward<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::GaugeCap, arg2: u256, arg3: u64, arg4: u64) {
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg1);
        arg0.distribution_rate = arg2;
        arg0.distribution_reserve = arg3;
        arg0.distribution_period_finish = arg4;
        arg0.distribution_rollover = 0;
    }

    public fun time_of_last_update(arg0: &DlmmPairParameter) : u64 {
        arg0.time_of_last_update
    }

    public fun unstake_from_magma_distribution<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::GaugeCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg1);
        let v0 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::liquidity(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg2));
        assert!(v0 > 0, 9223380480760479743);
        let v1 = *0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_ids(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(&arg0.position_manager, arg2));
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&v1)) {
            if (arg0.params.active_index == *0x1::vector::borrow<u32>(&v1, v2)) {
                update_magma_distribution_growth_global_internal<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v1, v2), arg3);
            };
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::unstake_liquidity(0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, *0x1::vector::borrow<u32>(&v1, v2)), v0);
            v2 = v2 + 1;
        };
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::unstake(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(&mut arg0.position_manager, arg2));
    }

    fun update_distribution_in_cross_bins_by_swap<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: u64, arg2: &vector<SwapInternalStep>, arg3: u64) {
        let v0 = arg3 - arg0.distribution_last_updated;
        if (v0 == 0) {
            return
        };
        if (arg0.distribution_reserve > 0) {
            let v1 = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64(arg0.distribution_rate * (v0 as u256) / 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale());
            let v2 = v1;
            if (v1 > arg0.distribution_reserve) {
                v2 = arg0.distribution_reserve;
            };
            arg0.distribution_reserve = arg0.distribution_reserve - v2;
            if (0x1::vector::length<SwapInternalStep>(arg2) == 0) {
                arg0.distribution_rollover = arg0.distribution_rollover + v2;
            } else {
                let v3 = 0;
                while (v3 < 0x1::vector::length<SwapInternalStep>(arg2)) {
                    let v4 = 0x1::vector::borrow<SwapInternalStep>(arg2, v3);
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::grow_distribution(0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, v4.bin_id), (0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64((v2 as u256) * (v4.distribution_portion as u256) / (arg1 as u256)) as u256) * 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale() / v4.staked_liquidity);
                    v3 = v3 + 1;
                };
            };
        };
        arg0.distribution_last_updated = arg3;
    }

    public fun update_factory_id<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        assert!(arg0.factory != arg2, 17);
        arg0.factory = arg2;
        let v0 = EventUpdateFactory{
            old_factory : arg0.factory,
            new_factory : arg2,
        };
        0x2::event::emit<EventUpdateFactory>(v0);
    }

    public(friend) fun update_id_reference(arg0: &mut DlmmPairParameter) {
        arg0.index_reference = arg0.active_index;
    }

    public fun update_magma_distribution_growth_global<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: &0x25267b1f1cd2e57ab260a8adab81e7904ebbf6856d128292e39d57d3faaf26db::gauge_cap::GaugeCap, arg2: &0x2::clock::Clock) {
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg1);
        let v0 = arg0.params.active_index;
        update_magma_distribution_growth_global_internal<T0, T1>(arg0, v0, arg2);
    }

    fun update_magma_distribution_growth_global_internal<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: u32, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = v0 - arg0.distribution_last_updated;
        let v2 = 0x2::table::borrow_mut<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&mut arg0.bins, arg1);
        let v3 = 0;
        if (v1 != 0) {
            if (arg0.distribution_reserve > 0) {
                let v4 = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64(arg0.distribution_rate * (v1 as u256) / 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale());
                let v5 = v4;
                if (v4 > arg0.distribution_reserve) {
                    v5 = arg0.distribution_reserve;
                };
                arg0.distribution_reserve = arg0.distribution_reserve - v5;
                let v6 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::staked_liquidity(v2);
                if (v6 > 0) {
                    0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::grow_distribution(v2, (v5 as u256) * 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::scale() / v6);
                } else {
                    arg0.distribution_rollover = arg0.distribution_rollover + v5;
                };
                v3 = v5;
            };
            arg0.distribution_last_updated = v0;
        };
        v3
    }

    public(friend) fun update_position_fees<T0, T1>(arg0: &mut DlmmPair<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info_mut(&mut arg0.position_manager, arg1);
        let v1 = 0;
        let v2 = *0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_ids(v0);
        while (v1 < 0x1::vector::length<u32>(&v2)) {
            0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::update_fees(v0, *0x1::vector::borrow<u32>(&v2, v1), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_x(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v2, v1))), 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::fee_growth_y(0x2::table::borrow<u32, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v2, v1))));
            v1 = v1 + 1;
        };
    }

    public(friend) fun update_references(arg0: &mut DlmmPairParameter, arg1: u64) {
        let v0 = arg1 - arg0.time_of_last_update;
        if (v0 >= (arg0.filter_period as u64)) {
            update_id_reference(arg0);
            if (v0 < (arg0.decay_period as u64)) {
                update_volatility_reference(arg0);
            } else {
                arg0.volatility_reference = 0;
            };
        };
        update_time_of_last_update(arg0, arg1);
    }

    public fun update_rewarder_emission<T0, T1, T2>(arg0: &mut DlmmPair<T0, T1>, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::RewarderGlobalVault, arg3: u256, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.pause, 22);
        0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::check_rewarder_manager_role(arg1, 0x2::tx_context::sender(arg5));
        settle_rewarders<T0, T1>(arg0, true, arg4);
        let (v0, _) = get_active_liquidity<T0, T1>(arg0);
        0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_rewarder::update_emission<T2>(&mut arg0.rewarder_manager, arg2, v0, arg3, 0x2::clock::timestamp_ms(arg4) / 1000);
        let v2 = UpdateRewarderEmissionEvent{
            pair                      : 0x2::object::id<DlmmPair<T0, T1>>(arg0),
            rewarder_type             : 0x1::type_name::get<T2>(),
            emissions_per_second_q128 : arg3,
        };
        0x2::event::emit<UpdateRewarderEmissionEvent>(v2);
    }

    public(friend) fun update_time_of_last_update(arg0: &mut DlmmPairParameter, arg1: u64) {
        arg0.time_of_last_update = arg1;
    }

    public(friend) fun update_volatility_accumulator(arg0: &mut DlmmPairParameter, arg1: u32) {
        let v0 = arg0.index_reference;
        let v1 = if (arg1 > v0) {
            arg1 - v0
        } else {
            v0 - arg1
        };
        let v2 = arg0.volatility_reference + v1 * (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::basis_point_max() as u32);
        let v3 = arg0.max_volatility_accumulator;
        let v4 = if (v2 > v3) {
            v3
        } else {
            v2
        };
        arg0.volatility_accumulator = v4;
    }

    public(friend) fun update_volatility_parameters(arg0: &mut DlmmPairParameter, arg1: u32, arg2: u64) {
        update_references(arg0, arg2);
        update_volatility_accumulator(arg0, arg1);
    }

    public(friend) fun update_volatility_reference(arg0: &mut DlmmPairParameter) {
        arg0.volatility_reference = (0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::full_math_u64::mul_div_floor((arg0.volatility_accumulator as u64), ((arg0.reduction_factor as u32) as u64), (0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_constants::basis_point_max() as u64)) as u32);
    }

    public fun volatility_accumulator(arg0: &DlmmPairParameter) : u32 {
        arg0.volatility_accumulator
    }

    public fun volatility_reference(arg0: &DlmmPairParameter) : u32 {
        arg0.volatility_reference
    }

    // decompiled from Move bytecode v6
}

