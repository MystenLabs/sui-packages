module 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_pair {
    struct EventSetStaticFeeParameters has copy, drop, store {
        sender: address,
        pair_id: 0x2::object::ID,
        base_factor: u32,
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
        pair_id: 0x2::object::ID,
        ids: vector<u32>,
        amounts_x: vector<u64>,
        amounts_y: vector<u64>,
        position_id: 0x2::object::ID,
        pair_reserve_x: u64,
        pair_reserve_y: u64,
        total_amount_in_x: u64,
        total_amount_in_y: u64,
    }

    struct EventRaisePosition has copy, drop, store {
        sender: address,
        pair_id: 0x2::object::ID,
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
        pair_id: 0x2::object::ID,
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
        pair_id: 0x2::object::ID,
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
        pair_id: 0x2::object::ID,
        sender: address,
        receiver: address,
        active_id: vector<u32>,
        swap_for_y: bool,
        amounts_in_with_fees: vector<u64>,
        amounts_out_of_bin: vector<u64>,
        volatility_accumulator: vector<u32>,
        pair_fee: vector<u64>,
        protocol_fee: vector<u64>,
        gauge_fee: vector<u64>,
        partner_fee: vector<u64>,
        pair_reserve_x: u64,
        pair_reserve_y: u64,
    }

    struct EventCollectedProtocolFees has copy, drop, store {
        pair_id: 0x2::object::ID,
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
        pair_id: 0x2::object::ID,
        sender: address,
        id_reference: u32,
        volatility_reference: u32,
    }

    struct EventNewProtocolVariableFee has copy, drop, store {
        pair_id: 0x2::object::ID,
        sender: address,
        old_share: u16,
        share: u16,
    }

    struct EventCreatePair has copy, drop, store {
        pair_id: 0x2::object::ID,
        factory_id: 0x2::object::ID,
        bin_step: u16,
        active_id: u32,
        params: AlmmPairParameter,
        token_x: 0x1::type_name::TypeName,
        token_y: 0x1::type_name::TypeName,
        lp_token_id: 0x2::object::ID,
    }

    struct EventPairPause has copy, drop, store {
        pair_id: 0x2::object::ID,
        pause: bool,
    }

    struct AlmmPairParameter has copy, drop, store {
        base_factor: u32,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        protocol_variable_share: u16,
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

    struct AlmmPair<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        factory: 0x2::object::ID,
        global_config: 0x2::object::ID,
        lp_mint_cap: 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::MintCap,
        lp_token: 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::AlmmLpToken,
        pause: bool,
        x: 0x1::type_name::TypeName,
        y: 0x1::type_name::TypeName,
        bin_step: u16,
        liquidity: u256,
        params: AlmmPairParameter,
        bins_tree: 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin_tree::BinTree,
        bins: 0x2::table::Table<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>,
        bins_iter: 0x2::vec_set::VecSet<u32>,
        balances: 0x2::bag::Bag,
        reserve_x: u64,
        reserve_y: u64,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        rewarder_manager: 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::RewarderManager,
        unstaked_liquidity_fee_rate: u64,
        distribution_gauge_id: 0x1::option::Option<0x2::object::ID>,
        distribution_rate: u256,
        distribution_reserve: u64,
        distribution_period_finish: u64,
        distribution_rollover: u64,
        distribution_last_updated: u64,
        distribution_gauge_fee: Fee,
        position_manager: 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionManager,
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

    struct EventAddRewarder has copy, drop, store {
        pair: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
    }

    struct EventUpdateRewarderEmission has copy, drop, store {
        pair: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        emissions_per_second_q128: u256,
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

    public fun swap<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, SwapInternalResult) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        swap_with_partner_fee_rate<T0, T1>(arg0, arg1, arg2, 0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun liquidity<T0, T1>(arg0: &AlmmPair<T0, T1>) : u256 {
        arg0.liquidity
    }

    public fun base_factor(arg0: &AlmmPairParameter) : u32 {
        arg0.base_factor
    }

    public fun decay_period(arg0: &AlmmPairParameter) : u16 {
        arg0.decay_period
    }

    public fun filter_period(arg0: &AlmmPairParameter) : u16 {
        arg0.filter_period
    }

    public fun max_volatility_accumulator(arg0: &AlmmPairParameter) : u32 {
        arg0.max_volatility_accumulator
    }

    public fun protocol_share(arg0: &AlmmPairParameter) : u16 {
        arg0.protocol_share
    }

    public fun reduction_factor(arg0: &AlmmPairParameter) : u16 {
        arg0.reduction_factor
    }

    public fun variable_fee_control(arg0: &AlmmPairParameter) : u32 {
        arg0.variable_fee_control
    }

    public fun mint<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: vector<u32>, arg7: vector<u64>, arg8: vector<u64>, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (MintResult, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        assert!(arg9 != @0x0, 13906839938189492223);
        assert!(0x1::vector::length<u32>(&arg6) > 0, 8);
        assert!(0x1::vector::length<u32>(&arg6) == 0x1::vector::length<u64>(&arg7) && 0x1::vector::length<u32>(&arg6) == 0x1::vector::length<u64>(&arg8), 7);
        assert!(arg0.factory == 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg1), 25);
        assert!(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::max_bins_in_position(arg1) >= 0x1::vector::length<u32>(&arg6), 27);
        settle_rewarders<T0, T1>(arg0, arg1, true, arg10);
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
            pair_id           : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            ids               : v6.ids,
            amounts_x         : v6.amounts_x,
            amounts_y         : v6.amounts_y,
            position_id       : 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(&v5),
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

    public fun active_index(arg0: &AlmmPairParameter) : u32 {
        arg0.active_index
    }

    public fun amounts_out(arg0: &SwapInternalResult) : u64 {
        arg0.amounts_out
    }

    fun apply_unstaked_fees(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg0 as u256) * (arg2 as u256) / (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::unstaked_liquidity_fee_rate_denom() as u256));
        (arg0 - v0, arg1 + v0)
    }

    public fun bin_total_supply<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: u32) : u64 {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::total_supply(&arg0.lp_token, arg1)
    }

    public fun borrow_bin<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: u32) : &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin {
        0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, arg1)
    }

    fun burn_from_bins_internal<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: address, arg2: &vector<u32>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : BurnFromBinsResult {
        let v0 = BurnFromBinsResult{
            amounts_x           : 0x1::vector::empty<u64>(),
            amounts_y           : 0x1::vector::empty<u64>(),
            total_amounts_out_x : 0,
            total_amounts_out_y : 0,
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg2)) {
            let v2 = *0x1::vector::borrow<u32>(arg2, v1);
            let v3 = 0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, v2);
            let v4 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::total_supply(&arg0.lp_token, v2);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v5 > 0, 14);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::burn(&mut arg0.lp_token, &arg0.lp_mint_cap, v2, arg1, v5, arg4);
            let (v6, v7) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::get_amount_out_of_bin(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_x(v3), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_y(v3), v5, v4);
            if (v6 == 0 && v7 == 0) {
                abort 15
            };
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::sub_reserves(v3, v6, v7);
            if (v4 == v5) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin_tree::remove(&mut arg0.bins_tree, v2);
                0x2::vec_set::remove<u32>(&mut arg0.bins_iter, &v2);
            };
            let v8 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::liquidity(v3) - 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::liquidity(v3);
            if (v8 > arg0.liquidity) {
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

    public fun burn_position<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        let v0 = 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(&arg2);
        assert!(!0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::staked(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, v0)), 24);
        update_position_fees<T0, T1>(arg0, v0);
        let v1 = position_manager_mut<T0, T1>(arg0);
        let (v2, v3) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::extract_fees(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(v1, v0));
        assert!(v2 == 0 && v3 == 0, 26);
        settle_rewarders<T0, T1>(arg0, arg1, true, arg3);
        update_position_active_rewards<T0, T1>(arg0, v0);
        update_position_inactive_rewards<T0, T1>(arg0, v0);
        assert!(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_rewards_remains_zero(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, v0)), 32);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::shares(&arg2);
        let v6 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::ids(&arg2);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<u32>(v6)) {
            0x1::vector::push_back<u64>(&mut v7, *0x2::table::borrow<u32, u64>(v5, *0x1::vector::borrow<u32>(v6, v8)));
            v8 = v8 + 1;
        };
        let v9 = burn_from_bins_internal<T0, T1>(arg0, 0x2::object::id_to_address(&v0), v6, v7, arg4);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::destroy(arg2);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::remove_position_info(&mut arg0.position_manager, v0);
        let v10 = EventBurnPosition{
            sender         : 0x2::tx_context::sender(arg4),
            lp             : v4,
            pair_id        : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
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
        let v0 = arg1 >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset();
        let v1 = arg2 >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset();
        if (v0 == v1) {
            CalcFeesDistribution{growth_global: 0, fee_to_gauge: arg0}
        } else if (v1 == 0) {
            let (v3, v4) = apply_unstaked_fees(arg0, 0, arg3);
            let v5 = (v3 as u256) * 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale() / v0;
            if (v3 > 0) {
                assert!(v5 > 0, 13906844052768161791);
            };
            CalcFeesDistribution{growth_global: v5, fee_to_gauge: v4}
        } else {
            let (v6, v7) = split_fees(arg0, v0, v1, arg3);
            let v8 = (v6 as u256) * 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale() / (v0 - v1);
            if (v6 > 0) {
                assert!(v8 > 0, 13906844104307769343);
            };
            CalcFeesDistribution{growth_global: v8, fee_to_gauge: v7}
        }
    }

    public fun calc_partner_fee_rate(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x2::clock::Clock) : u64 {
        if (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::has_default_partner(arg1) && 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner>(arg0) == 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::default_partner(arg1)) {
            0
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::current_ref_fee_rate(arg0, 0x2::clock::timestamp_ms(arg2) / 1000)
        }
    }

    public fun calc_unstaked_liquidity_fee_rate<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory) : u64 {
        if (arg0.unstaked_liquidity_fee_rate == 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::default_unstaked_liquidity_fee_rate()) {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::unstaked_liquidity_fee_rate(arg1)
        } else {
            arg0.unstaked_liquidity_fee_rate
        }
    }

    fun check_gauge_cap<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::GaugeCap) {
        let v0 = if (0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::get_pool_id(arg1) == 0x2::object::id<AlmmPair<T0, T1>>(arg0)) {
            let v1 = &arg0.distribution_gauge_id;
            if (0x1::option::is_some<0x2::object::ID>(v1)) {
                let v2 = 0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::get_gauge_id(arg1);
                0x1::option::borrow<0x2::object::ID>(v1) == &v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906843915329208319);
    }

    public fun collect_fees<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        let v0 = 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(arg2);
        settle_rewarders<T0, T1>(arg0, arg1, true, arg3);
        update_position_fees<T0, T1>(arg0, v0);
        let v1 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(&mut arg0.position_manager, v0);
        if (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::staked(v1)) {
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v2, v3) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::extract_fees(v1);
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
            sender      : 0x2::tx_context::sender(arg4),
            pair_id     : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            position_id : v0,
            x           : 0x2::balance::value<T0>(&v5),
            y           : 0x2::balance::value<T1>(&v7),
        };
        0x2::event::emit<EventCollectedFees>(v8);
        (v5, v7)
    }

    public fun collect_magma_distribution_gauge_fees<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::GaugeCap) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg2);
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
            pair     : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            amount_x : 0x2::balance::value<T0>(&v0),
            amount_y : 0x2::balance::value<T1>(&v1),
        };
        0x2::event::emit<CollectGaugeFeeEvent>(v2);
        (v0, v1)
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::ProtocolFeeCap, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::check_protocol_fee_cap(arg1, arg2);
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
            pair_id  : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            sender   : 0x2::tx_context::sender(arg3),
            amount_x : 0x2::balance::value<T0>(&v3),
            amount_y : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<EventCollectedProtocolFees>(v6);
        (v3, v5)
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::RewarderGlobalVault, arg3: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        settle_rewarders<T0, T1>(arg0, arg1, true, arg4);
        let v0 = 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(arg3);
        let v1 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::rewarder_index<T2>(&arg0.rewarder_manager);
        assert!(0x1::option::is_some<u64>(&v1), 30);
        let v2 = 0x1::type_name::get<T2>();
        let v3 = 0;
        let v4 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::ids(arg3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u32>(v4)) {
            let v6 = if (!0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::has_bin_id(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, v0), *0x1::vector::borrow<u32>(v4, v5))) {
                0
            } else if (!0x2::vec_map::contains<0x1::type_name::TypeName, u256>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v4, v5))), &v2)) {
                0
            } else {
                let v7 = *0x2::vec_map::get<0x1::type_name::TypeName, u256>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v4, v5))), &v2);
                let v8 = if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionReward>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_rewarder_growth(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, v0), *0x1::vector::borrow<u32>(v4, v5)), &v2)) {
                    v7 - 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_reward_growth(0x2::vec_map::get<0x1::type_name::TypeName, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionReward>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_rewarder_growth(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, v0), *0x1::vector::borrow<u32>(v4, v5)), &v2))
                } else {
                    v7 - 0
                };
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::reset_rewarder(&mut arg0.position_manager, v0, *0x1::vector::borrow<u32>(v4, v5), v2, v7) + 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v8 * (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_liquidity(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, v0), *0x1::vector::borrow<u32>(v4, v5)) >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset())
            };
            v3 = v3 + v6;
            v5 = v5 + 1;
        };
        let v9 = EventCollectedReward{
            pair_id     : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            position_id : v0,
            reward_type : 0x1::type_name::get<T2>(),
            amount      : v3,
        };
        0x2::event::emit<EventCollectedReward>(v9);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::withdraw_reward<T2>(arg2, v3)
    }

    public fun create_pair_by_preset<T0, T1>(arg0: &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: u64, arg3: u16, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : AlmmPair<T0, T1> {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg0);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg0);
        let v0 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::get_bin_step_preset(arg0, arg2, arg3);
        create_pair_internal<T0, T1>(arg0, arg1, arg2, arg3, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::base_factor(&v0), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::filter_period(&v0), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::decay_period(&v0), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::reduction_factor(&v0), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::variable_fee_control(&v0), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::protocol_share(&v0), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::max_volatility_accumulator(&v0), arg4, arg5, arg6)
    }

    public(friend) fun create_pair_internal<T0, T1>(arg0: &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: u64, arg3: u16, arg4: u32, arg5: u16, arg6: u16, arg7: u16, arg8: u32, arg9: u16, arg10: u32, arg11: u32, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : AlmmPair<T0, T1> {
        let v0 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::pair_uniq<T0, T1>(arg3);
        assert!(!0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::pair_exist(arg0, v0), 16);
        let v1 = AlmmPairParameter{
            base_factor                : 0,
            filter_period              : 0,
            decay_period               : 0,
            reduction_factor           : 0,
            variable_fee_control       : 0,
            protocol_share             : 0,
            protocol_variable_share    : 0,
            max_volatility_accumulator : 0,
            volatility_accumulator     : 0,
            volatility_reference       : 0,
            index_reference            : 0,
            time_of_last_update        : 0,
            oracle_index               : 0,
            active_index               : arg11,
        };
        let v2 = &mut v1;
        update_id_reference(v2);
        let v3 = &mut v1;
        set_static_fee_parameters(v3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v4 = 0x2::object::new(arg13);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let (v6, v7) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::create(v5, v0, arg13);
        let v8 = v6;
        let v9 = Fee{
            x : 0,
            y : 0,
        };
        let v10 = AlmmPair<T0, T1>{
            id                          : v4,
            factory                     : 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg0),
            global_config               : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig>(arg1),
            lp_mint_cap                 : v7,
            lp_token                    : v8,
            pause                       : false,
            x                           : 0x1::type_name::get<T0>(),
            y                           : 0x1::type_name::get<T1>(),
            bin_step                    : arg3,
            liquidity                   : 0,
            params                      : v1,
            bins_tree                   : 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin_tree::create_bin_tree(),
            bins                        : 0x2::table::new<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(arg13),
            bins_iter                   : 0x2::vec_set::empty<u32>(),
            balances                    : 0x2::bag::new(arg13),
            reserve_x                   : 0,
            reserve_y                   : 0,
            protocol_fee_x              : 0,
            protocol_fee_y              : 0,
            rewarder_manager            : 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::new(),
            unstaked_liquidity_fee_rate : 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::default_unstaked_liquidity_fee_rate(),
            distribution_gauge_id       : 0x1::option::none<0x2::object::ID>(),
            distribution_rate           : 0,
            distribution_reserve        : 0,
            distribution_period_finish  : 0,
            distribution_rollover       : 0,
            distribution_last_updated   : 0x2::clock::timestamp_ms(arg12) / 1000,
            distribution_gauge_fee      : v9,
            position_manager            : 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::new_position_manager(arg13),
        };
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v10.balances, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v10.balances, 0x1::type_name::get<T1>(), 0x2::balance::zero<T1>());
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::add_pair(arg0, v0, v5);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::add_available_bin_step(arg0, v10.x, v10.y, arg2, arg3, arg13);
        let v11 = EventCreatePair{
            pair_id     : v5,
            factory_id  : 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg0),
            bin_step    : arg3,
            active_id   : arg11,
            params      : v1,
            token_x     : 0x1::type_name::get<T0>(),
            token_y     : 0x1::type_name::get<T1>(),
            lp_token_id : 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::AlmmLpToken>(&v8),
        };
        0x2::event::emit<EventCreatePair>(v11);
        v10
    }

    public fun earned_fees<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1);
        if (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::staked(v0)) {
            return (0, 0)
        };
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = *0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_ids(v0);
        while (v3 < 0x1::vector::length<u32>(&v4)) {
            let (v5, v6) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::get_position_info_bin_fees(v0, *0x1::vector::borrow<u32>(&v4, v3), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_x(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v3))), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_y(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v3))));
            v1 = v1 + v5;
            v2 = v2 + v6;
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun earned_reward<T0, T1, T2>(arg0: &AlmmPair<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::rewarder_index<T2>(&arg0.rewarder_manager);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0
        };
        let v1 = 0x1::type_name::get<T2>();
        let (v2, _) = get_active_liquidity<T0, T1>(arg0);
        let v4 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::get_growths_update_to_date(&arg0.rewarder_manager, v2, arg2);
        let v5 = 0;
        let v6 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_ids(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1));
        let v7 = 0;
        while (v7 < 0x1::vector::length<u32>(v6)) {
            let v8 = if (!0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::has_bin_id(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7))) {
                0
            } else if (!0x2::vec_map::contains<0x1::type_name::TypeName, u256>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v6, v7))), &v1)) {
                0
            } else {
                let v9 = if (*0x1::vector::borrow<u32>(v6, v7) == arg0.params.active_index) {
                    if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionReward>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_rewarder_growth(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1)) {
                        *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&v4, &v1) - 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_reward_growth(0x2::vec_map::get<0x1::type_name::TypeName, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionReward>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_rewarder_growth(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1))
                    } else {
                        *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&v4, &v1) - 0
                    }
                } else if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionReward>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_rewarder_growth(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1)) {
                    *0x2::vec_map::get<0x1::type_name::TypeName, u256>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v6, v7))), &v1) - 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_reward_growth(0x2::vec_map::get<0x1::type_name::TypeName, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionReward>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_rewarder_growth(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1))
                } else {
                    *0x2::vec_map::get<0x1::type_name::TypeName, u256>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v6, v7))), &v1) - 0
                };
                let v10 = if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionReward>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_rewarder_growth(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1)) {
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_reward_amount_owned(0x2::vec_map::get<0x1::type_name::TypeName, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionReward>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_rewarder_growth(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)), &v1))
                } else {
                    0
                };
                v10 + 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v9 * (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_liquidity(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg1), *0x1::vector::borrow<u32>(v6, v7)) >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset())
            };
            v5 = v5 + v8;
            v7 = v7 + 1;
        };
        v5
    }

    fun fee_hub(arg0: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin, arg1: &AlmmPairParameter, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : FeeHub {
        let v0 = arg2;
        let v1 = if (arg3 > 0) {
            arg2 * arg3 / 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::protocol_fee_rate_denom()
        } else {
            0
        };
        if (v1 > 0) {
            v0 = arg2 - v1;
        };
        let v2 = v0 * arg5 / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u64);
        let v3 = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((v2 as u256) * (arg1.protocol_share as u256) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u256)) + 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(((v0 - v2) as u256) * (arg1.protocol_variable_share as u256) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u256));
        if (v3 > 0) {
            v0 = v0 - v3;
        };
        let CalcFeesDistribution {
            growth_global : v4,
            fee_to_gauge  : v5,
        } = calc_fees_distribution(v0, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::liquidity(arg0), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::staked_liquidity(arg0), arg4);
        if (v5 > 0) {
            v0 = v0 - v5;
        };
        FeeHub{
            total_fee    : arg2,
            partner_fee  : v1,
            protocol_fee : v3,
            gauge_fee    : v5,
            fee_growth   : v4,
            fee_to_bin   : v0,
        }
    }

    public fun fetch_bins<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: u64, arg2: u64) : vector<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin> {
        let v0 = 0x2::vec_set::keys<u32>(&arg0.bins_iter);
        let v1 = 0x1::vector::empty<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>();
        while (arg1 < arg1 + arg2) {
            if (arg1 >= 0x1::vector::length<u32>(v0)) {
                break
            };
            0x1::vector::push_back<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut v1, *0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(v0, arg1)));
            arg1 = arg1 + 1;
        };
        v1
    }

    public fun force_decay<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        assert!(arg0.factory == 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg1), 18);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::check_admin(arg1, arg2);
        let v0 = &mut arg0.params;
        update_id_reference(v0);
        let v1 = &mut arg0.params;
        update_volatility_reference(v1);
        let v2 = EventForcedDecay{
            pair_id              : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            sender               : 0x2::tx_context::sender(arg3),
            id_reference         : arg0.params.index_reference,
            volatility_reference : arg0.params.volatility_reference,
        };
        0x2::event::emit<EventForcedDecay>(v2);
    }

    public fun get_active_liquidity<T0, T1>(arg0: &AlmmPair<T0, T1>) : (u256, bool) {
        let v0 = arg0.params.active_index;
        if (0x2::table::contains<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, v0)) {
            (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::liquidity(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, v0)), true)
        } else {
            (0, false)
        }
    }

    public fun get_base_fee(arg0: &AlmmPairParameter, arg1: u16) : u64 {
        ((arg0.base_factor as u64) * (arg1 as u64) + 9) / 10
    }

    public fun get_bin_step<T0, T1>(arg0: &AlmmPair<T0, T1>) : u16 {
        arg0.bin_step
    }

    public fun get_delta_id(arg0: &AlmmPairParameter, arg1: u32) : u32 {
        let v0 = arg0.active_index;
        if (v0 > arg1) {
            v0 - arg1
        } else {
            arg1 - v0
        }
    }

    public fun get_magma_distribution_gauge_id<T0, T1>(arg0: &AlmmPair<T0, T1>) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.distribution_gauge_id), 13906844555279335423);
        *0x1::option::borrow<0x2::object::ID>(&arg0.distribution_gauge_id)
    }

    public fun get_magma_distribution_growth_global<T0, T1>(arg0: &AlmmPair<T0, T1>) : u256 {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::distribution_growth(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, arg0.params.active_index))
    }

    public fun get_magma_distribution_last_updated<T0, T1>(arg0: &AlmmPair<T0, T1>) : u64 {
        arg0.distribution_last_updated
    }

    public fun get_magma_distribution_reserve<T0, T1>(arg0: &AlmmPair<T0, T1>) : u64 {
        arg0.distribution_reserve
    }

    public fun get_magma_distribution_rollover<T0, T1>(arg0: &AlmmPair<T0, T1>) : u64 {
        arg0.distribution_rollover
    }

    public fun get_magma_distribution_staked_liquidity<T0, T1>(arg0: &AlmmPair<T0, T1>) : u256 {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::staked_liquidity(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, arg0.params.active_index))
    }

    public fun get_next_non_empty_bin<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: bool, arg2: u32) : u32 {
        let (v0, v1) = get_next_non_empty_bin_internal<T0, T1>(arg0, arg1, arg2);
        assert!(v1, 4);
        v0
    }

    fun get_next_non_empty_bin_internal<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: bool, arg2: u32) : (u32, bool) {
        if (arg1) {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin_tree::find_first_right(&arg0.bins_tree, arg2)
        } else {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin_tree::find_first_left(&arg0.bins_tree, arg2)
        }
    }

    public fun get_swap_in<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = arg0.params;
        let v1 = arg1;
        let v2 = v0.active_index;
        let v3 = &mut v0;
        update_references(v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v4 = 0;
        let v5 = 0;
        loop {
            let v6 = if (arg2) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_y(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, v2))
            } else {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_x(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, v2))
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
                    ((v7 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(v2, arg0.bin_step)
                } else {
                    (v7 as u256) * 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(v2, arg0.bin_step) >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()
                };
                let v10 = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(v9);
                let v11 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_fee::get_fee_amount_by_net_input(v10, get_total_fee(&v0, arg0.bin_step));
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

    public fun get_swap_out<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = arg0.params;
        let v2 = active_index(&v1);
        let v3 = &mut v1;
        update_references(v3, 0x2::clock::timestamp_ms(arg3) / 1000);
        let v4 = 0;
        let v5 = 0;
        loop {
            let v6 = 0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, v2);
            let v7 = if (arg2) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_y(v6)
            } else {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_x(v6)
            };
            if (v7 > 0) {
                let v8 = &mut v1;
                update_volatility_accumulator(v8, v2);
                let (v9, v10, v11, v12, v13, v14) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::get_amounts(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_x(v6), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_y(v6), arg0.bin_step, get_total_fee(&v1, arg0.bin_step), arg2, v2, v0);
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

    public fun get_total_fee(arg0: &AlmmPairParameter, arg1: u16) : u64 {
        get_base_fee(arg0, arg1) + get_variable_fee(arg0, arg1)
    }

    public fun get_variable_fee(arg0: &AlmmPairParameter, arg1: u16) : u64 {
        if (arg0.variable_fee_control != 0) {
            let v1 = (arg0.volatility_accumulator as u256) * (arg1 as u256);
            (((v1 * v1 * (arg0.variable_fee_control as u256) + 9999999999999999) / 10000000000000000) as u64)
        } else {
            0
        }
    }

    public fun has_bin<T0, T1>(arg0: &AlmmPair<T0, T1>, arg1: u32) : bool {
        0x2::table::contains<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, arg1)
    }

    public fun index_reference(arg0: &AlmmPairParameter) : u32 {
        arg0.index_reference
    }

    public fun init_magma_distribution_gauge<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::GaugeCap) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        assert!(0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::get_pool_id(arg2) == 0x2::object::id<AlmmPair<T0, T1>>(arg0), 13906844598229008383);
        0x1::option::fill<0x2::object::ID>(&mut arg0.distribution_gauge_id, 0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::get_gauge_id(arg2));
    }

    public fun initialize_rewarder<T0, T1, T2>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::check_rewarder_manager_role(arg2, 0x2::tx_context::sender(arg4));
        settle_rewarders<T0, T1>(arg0, arg1, true, arg3);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::add_rewarder<T2>(&mut arg0.rewarder_manager);
        if (0x2::table::contains<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, arg0.params.active_index)) {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::download_rewarders(0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, arg0.params.active_index), &arg0.rewarder_manager);
        };
        let v0 = EventAddRewarder{
            pair          : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            rewarder_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<EventAddRewarder>(v0);
    }

    public fun mint_by_amounts<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (MintResult, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        assert!(arg7 != @0x0, 13906839641836748799);
        assert!(0x1::vector::length<u32>(&arg4) > 0, 8);
        assert!(0x1::vector::length<u32>(&arg4) == 0x1::vector::length<u64>(&arg5) && 0x1::vector::length<u32>(&arg4) == 0x1::vector::length<u64>(&arg6), 7);
        assert!(arg0.factory == 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg1), 25);
        assert!(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::max_bins_in_position(arg1) >= 0x1::vector::length<u32>(&arg4), 27);
        settle_rewarders<T0, T1>(arg0, arg1, true, arg8);
        let v0 = calc_unstaked_liquidity_fee_rate<T0, T1>(arg0, arg1);
        let (v1, v2) = mint_position_internal<T0, T1>(arg0, arg1, arg7, arg4, arg5, arg6, v0, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        arg0.reserve_x = arg0.reserve_x + v4.total_amounts_in_x;
        arg0.reserve_y = arg0.reserve_y + v4.total_amounts_in_y;
        let v5 = EventDepositedToBins{
            sender            : 0x2::tx_context::sender(arg9),
            lp                : arg7,
            pair_id           : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            ids               : v4.ids,
            amounts_x         : v4.amounts_x,
            amounts_y         : v4.amounts_y,
            position_id       : 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(&v3),
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
                0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg3 as u256) * (*0x1::vector::borrow<u64>(&arg1, v2) as u256) / 100000000)
            } else {
                0
            };
            let v4 = if (*0x1::vector::borrow<u64>(&arg2, v2) > 0) {
                0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg4 as u256) * (*0x1::vector::borrow<u64>(&arg2, v2) as u256) / 100000000)
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun mint_position_internal<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: address, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (MintResult, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position) {
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
        let v2 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::create(0x2::object::id<AlmmPair<T0, T1>>(arg0), arg3, arg8);
        let v3 = 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(&v2);
        let v4 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::new_position_info(0x2::object::id<AlmmPair<T0, T1>>(arg0), 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(&v2), arg3, arg8);
        let v5 = 0;
        let v6 = 0x1::vector::empty<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::EventTransfer>();
        while (v5 < 0x1::vector::length<u32>(&arg3)) {
            let v7 = mint_update_bin_internal<T0, T1>(arg0, v0, *0x1::vector::borrow<u32>(&arg3, v5), *0x1::vector::borrow<u64>(&arg4, v5), *0x1::vector::borrow<u64>(&arg5, v5), arg6, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::composition_enabled(arg1), arg7, arg8);
            let UpdateBinInternalResult {
                shares             : v8,
                amounts_in_x       : v9,
                amounts_in_y       : v10,
                fee_to_bin_x       : v11,
                fee_to_bin_y       : v12,
                protocol_fee_x     : v13,
                protocol_fee_y     : v14,
                amounts_into_bin_x : v15,
                amounts_into_bin_y : v16,
                liquidity_delta    : v17,
            } = v7;
            if (v13 > 0) {
                arg0.protocol_fee_x = arg0.protocol_fee_x + v13;
            };
            if (v14 > 0) {
                arg0.protocol_fee_y = arg0.protocol_fee_y + v14;
            };
            arg0.liquidity = arg0.liquidity + v17;
            let (_, v19) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::mint(&mut arg0.lp_token, &arg0.lp_mint_cap, *0x1::vector::borrow<u32>(&arg3, v5), 0x2::object::id_to_address(&v3), v8, arg8);
            0x1::vector::push_back<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::EventTransfer>(&mut v6, v19);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::increase_shares(&mut v2, *0x1::vector::borrow<u32>(&arg3, v5), v8);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::set_fee_growth(&mut v4, *0x1::vector::borrow<u32>(&arg3, v5), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_x(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&arg3, v5))), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_y(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&arg3, v5))));
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::add_bin_liquidity(&mut v4, *0x1::vector::borrow<u32>(&arg3, v5), v17);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::add_bin_shares(&mut v4, *0x1::vector::borrow<u32>(&arg3, v5), v8);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_load_rewarder_growth_from_bin(&mut v4, *0x1::vector::borrow<u32>(&arg3, v5), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&arg3, v5))));
            0x1::vector::push_back<u32>(&mut v1.ids, *0x1::vector::borrow<u32>(&arg3, v5));
            0x1::vector::push_back<u64>(&mut v1.amounts_x, v15);
            0x1::vector::push_back<u64>(&mut v1.amounts_y, v16);
            0x1::vector::push_back<u64>(&mut v1.liquidity_minted, v8);
            v1.total_amounts_in_x = v1.total_amounts_in_x + v9;
            v1.total_amounts_in_y = v1.total_amounts_in_y + v10;
            v1.fee_to_bin_x = v1.fee_to_bin_x + v11;
            v1.fee_to_bin_y = v1.fee_to_bin_y + v12;
            v5 = v5 + 1;
        };
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::emit_mint_events_bundle(&arg0.lp_token, 0x2::object::id<AlmmPair<T0, T1>>(arg0), v6);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::add_position_info(&mut arg0.position_manager, 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(&v2), v4);
        (v1, v2)
    }

    fun mint_update_bin_internal<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : UpdateBinInternalResult {
        let v0 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price::get_price_from_storage_id(arg2, arg0.bin_step);
        if (!0x2::table::contains<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, arg2)) {
            0x2::table::add<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, arg2, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::new(arg2, v0, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::borrow_rewarders(&arg0.rewarder_manager)));
        };
        let v1 = 0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, arg2);
        let v2 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::total_supply(&arg0.lp_token, arg2);
        let v3 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_x(v1);
        let v4 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_y(v1);
        let v5 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::get_liquidity(v3, v4, v0);
        let (v6, v7, v8) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::get_shares_and_effective_amounts_in(v3, v4, arg3, arg4, v0, v2);
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
            let (v17, v18) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::get_composition_fees(v3, v4, v7, v8, v2, v6, get_total_fee(&arg0.params, arg0.bin_step));
            if (!arg6) {
                assert!(v17 == 0 && v18 == 0, 13906842369140981759);
            };
            if (v17 != 0 || v18 != 0) {
                let v19 = if (v17 > 0) {
                    (((v17 as u128) * (arg0.params.protocol_share as u128) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u128)) as u64)
                } else {
                    0
                };
                let v20 = if (v18 > 0) {
                    (((v18 as u128) * (arg0.params.protocol_share as u128) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u128)) as u64)
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
                    calc_fees_distribution(v21, v5, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::staked_liquidity(v1), arg5)
                } else {
                    calc_fees_distribution(v23, v5, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::staked_liquidity(v1), arg5)
                };
                let v26 = v25;
                if (v21 > 0) {
                    v22 = v21 - v26.fee_to_gauge;
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::grow_fee_x(v1, v26.growth_global);
                };
                if (v23 > 0) {
                    v24 = v23 - v26.fee_to_gauge;
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::grow_fee_y(v1, v26.growth_global);
                };
                v9 = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::get_liquidity(v10, v11, v0) * (v2 as u256) / v5);
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
                    pair           : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
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
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::download_rewarders(v1, &arg0.rewarder_manager);
            };
        } else {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::verify_amounts(v7, v8, arg1, arg2);
        };
        if (v9 == 0 || v10 == 0 && v11 == 0) {
            abort 6
        };
        if (v2 == 0) {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin_tree::add(&mut arg0.bins_tree, arg2);
            0x2::vec_set::insert<u32>(&mut arg0.bins_iter, arg2);
        };
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::add_reserves(v1, v10, v11);
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
            liquidity_delta    : 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::liquidity(v1) - v5,
        }
    }

    public fun oracle_index(arg0: &AlmmPairParameter) : u16 {
        arg0.oracle_index
    }

    public fun params<T0, T1>(arg0: &AlmmPair<T0, T1>) : &AlmmPairParameter {
        &arg0.params
    }

    public fun position_manager<T0, T1>(arg0: &AlmmPair<T0, T1>) : &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionManager {
        &arg0.position_manager
    }

    public fun position_manager_mut<T0, T1>(arg0: &mut AlmmPair<T0, T1>) : &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::PositionManager {
        &mut arg0.position_manager
    }

    public fun protocol_fee_x<T0, T1>(arg0: &AlmmPair<T0, T1>) : u64 {
        arg0.protocol_fee_x
    }

    public fun protocol_fee_y<T0, T1>(arg0: &AlmmPair<T0, T1>) : u64 {
        arg0.protocol_fee_y
    }

    public fun protocol_variable_share(arg0: &AlmmPairParameter) : u16 {
        arg0.protocol_variable_share
    }

    public fun raise_position_by_amounts<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: vector<u64>, arg6: vector<u64>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        settle_rewarders<T0, T1>(arg0, arg1, true, arg8);
        let v0 = raise_position_by_amounts_internal<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9);
        assert!(0x2::balance::value<T0>(&arg3) >= v0.total_amounts_in_x, 12);
        assert!(0x2::balance::value<T1>(&arg4) >= v0.total_amounts_in_y, 13);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::balance::split<T0>(&mut arg3, v0.total_amounts_in_x));
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::balance::split<T1>(&mut arg4, v0.total_amounts_in_y));
        let v1 = EventRaisePosition{
            sender            : 0x2::tx_context::sender(arg9),
            pair_id           : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            ids               : v0.ids,
            amounts_x         : v0.amounts_x,
            amounts_y         : v0.amounts_y,
            position_id       : 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(arg2),
            pair_reserve_x    : arg0.reserve_x,
            pair_reserve_y    : arg0.reserve_y,
            total_amount_in_x : v0.total_amounts_in_x,
            total_amount_in_y : v0.total_amounts_in_y,
        };
        0x2::event::emit<EventRaisePosition>(v1);
        (arg3, arg4)
    }

    fun raise_position_by_amounts_internal<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position, arg3: vector<u64>, arg4: vector<u64>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : MintResult {
        let v0 = 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(arg2);
        assert!(!0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::staked(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, v0)), 24);
        update_position_fees<T0, T1>(arg0, v0);
        update_position_active_rewards<T0, T1>(arg0, v0);
        update_position_inactive_rewards<T0, T1>(arg0, v0);
        let v1 = position_manager_mut<T0, T1>(arg0);
        let (v2, v3) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::extract_fees(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(v1, v0));
        assert!(v2 == 0 && v3 == 0, 26);
        let v4 = *0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::ids(arg2);
        assert!(0x1::vector::length<u32>(&v4) == 0x1::vector::length<u64>(&arg3) && 0x1::vector::length<u32>(&v4) == 0x1::vector::length<u64>(&arg4), 13906841037701119999);
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
        let v12 = 0x1::vector::empty<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::EventTransfer>();
        let v13 = 0;
        while (v13 < 0x1::vector::length<u32>(&v4)) {
            let v14 = mint_update_bin_internal<T0, T1>(arg0, v9, *0x1::vector::borrow<u32>(&v4, v13), *0x1::vector::borrow<u64>(&arg3, v13), *0x1::vector::borrow<u64>(&arg4, v13), v10, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::composition_enabled(arg1), arg6, arg7);
            let UpdateBinInternalResult {
                shares             : v15,
                amounts_in_x       : v16,
                amounts_in_y       : v17,
                fee_to_bin_x       : v18,
                fee_to_bin_y       : v19,
                protocol_fee_x     : v20,
                protocol_fee_y     : v21,
                amounts_into_bin_x : v22,
                amounts_into_bin_y : v23,
                liquidity_delta    : v24,
            } = v14;
            if (v20 > 0) {
                arg0.protocol_fee_x = arg0.protocol_fee_x + v20;
            };
            if (v21 > 0) {
                arg0.protocol_fee_y = arg0.protocol_fee_y + v21;
            };
            arg0.liquidity = arg0.liquidity + v24;
            let (_, v26) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::mint(&mut arg0.lp_token, &arg0.lp_mint_cap, *0x1::vector::borrow<u32>(&v4, v13), 0x2::object::id_to_address(&v0), v15, arg7);
            0x1::vector::push_back<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::EventTransfer>(&mut v12, v26);
            let v27 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(&mut arg0.position_manager, v0);
            if ((v18 > 0 || v19 > 0) && 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_liquidity(v27, *0x1::vector::borrow<u32>(&v4, v13)) > 0) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::update_fees(v27, *0x1::vector::borrow<u32>(&v4, v13), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_x(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v13))), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_y(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v13))));
            } else {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::set_fee_growth(v27, *0x1::vector::borrow<u32>(&v4, v13), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_x(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v13))), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_y(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v13))));
            };
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::increase_shares(arg2, *0x1::vector::borrow<u32>(&v4, v13), v15);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::add_bin_liquidity(v27, *0x1::vector::borrow<u32>(&v4, v13), v24);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::add_bin_shares(v27, *0x1::vector::borrow<u32>(&v4, v13), v15);
            0x1::vector::push_back<u32>(&mut v11.ids, *0x1::vector::borrow<u32>(&v4, v13));
            0x1::vector::push_back<u64>(&mut v11.amounts_x, v22);
            0x1::vector::push_back<u64>(&mut v11.amounts_y, v23);
            0x1::vector::push_back<u64>(&mut v11.liquidity_minted, v15);
            v11.total_amounts_in_x = v11.total_amounts_in_x + v16;
            v11.total_amounts_in_y = v11.total_amounts_in_y + v17;
            v11.fee_to_bin_x = v11.fee_to_bin_x + v18;
            v11.fee_to_bin_y = v11.fee_to_bin_y + v19;
            v13 = v13 + 1;
        };
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token::emit_mint_events_bundle(&arg0.lp_token, 0x2::object::id<AlmmPair<T0, T1>>(arg0), v12);
        arg0.reserve_x = arg0.reserve_x + v11.total_amounts_in_x;
        arg0.reserve_y = arg0.reserve_y + v11.total_amounts_in_y;
        v11
    }

    public fun rewarder_manager<T0, T1>(arg0: &AlmmPair<T0, T1>) : &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::RewarderManager {
        &arg0.rewarder_manager
    }

    public(friend) fun set_active_id(arg0: &mut AlmmPairParameter, arg1: u32) {
        arg0.active_index = arg1;
    }

    public(friend) fun set_oracle_id(arg0: &mut AlmmPairParameter, arg1: u16) {
        arg0.oracle_index = arg1;
    }

    public fun set_pause<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::AdminCap, arg3: bool) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::check_admin(arg1, arg2);
        assert!(arg0.pause != arg3, 13906835823610822655);
        arg0.pause = arg3;
        let v0 = EventPairPause{
            pair_id : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            pause   : arg3,
        };
        0x2::event::emit<EventPairPause>(v0);
    }

    public fun set_protocol_variable_share<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::AdminCap, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        assert!(arg0.factory == 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg1), 18);
        assert!(arg3 <= 10000, 13906843614681497599);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::check_admin(arg1, arg2);
        arg0.params.protocol_variable_share = arg3;
        let v0 = EventNewProtocolVariableFee{
            pair_id   : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            sender    : 0x2::tx_context::sender(arg4),
            old_share : arg0.params.protocol_variable_share,
            share     : arg3,
        };
        0x2::event::emit<EventNewProtocolVariableFee>(v0);
    }

    public(friend) fun set_static_fee_parameters(arg0: &mut AlmmPairParameter, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32) {
        let v0 = if (arg2 > arg3) {
            true
        } else if (arg3 >> 12 > 0) {
            true
        } else if (arg4 > 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max()) {
            true
        } else if (arg6 > 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::max_protocol_share()) {
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
        arg0.protocol_variable_share = arg6;
        arg0.max_volatility_accumulator = arg7;
    }

    public fun set_static_fee_parameters_external<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::AdminCap, arg3: u32, arg4: u16, arg5: u16, arg6: u16, arg7: u32, arg8: u16, arg9: u32, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.factory == 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg1), 18);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::check_admin(arg1, arg2);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        set_static_fee_parameters_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun set_static_fee_parameters_internal<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: u32, arg2: u16, arg3: u16, arg4: u16, arg5: u32, arg6: u16, arg7: u32, arg8: &mut 0x2::tx_context::TxContext) {
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
        arg0.params.volatility_accumulator = arg0.params.volatility_accumulator;
        let v2 = EventSetStaticFeeParameters{
            sender                     : 0x2::tx_context::sender(arg8),
            pair_id                    : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
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

    public(friend) fun set_volatility_accumulator(arg0: &mut AlmmPairParameter, arg1: u32) {
        assert!(arg1 >> 20 == 0, 2);
        arg0.volatility_accumulator = arg1;
    }

    public(friend) fun set_volatility_reference(arg0: &mut AlmmPairParameter, arg1: u32) {
        assert!(arg1 >> 20 == 0, 1);
        arg0.volatility_reference = arg1;
    }

    public fun settle_rewarders<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: bool, arg3: &0x2::clock::Clock) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        let (v0, v1) = get_active_liquidity<T0, T1>(arg0);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::settle(&mut arg0.rewarder_manager, v0, 0x2::clock::timestamp_ms(arg3) / 1000);
        if (!arg2) {
            return
        };
        if (v1) {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::download_rewarders(0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, active_index(&arg0.params)), &arg0.rewarder_manager);
        };
    }

    public fun shrink_position<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &mut 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        settle_rewarders<T0, T1>(arg0, arg1, true, arg4);
        let v0 = 0x2::object::id<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::Position>(arg2);
        assert!(!0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::staked(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, v0)), 24);
        assert!(arg3 > 0 && arg3 < (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u64), 29);
        update_position_fees<T0, T1>(arg0, v0);
        update_position_active_rewards<T0, T1>(arg0, v0);
        update_position_inactive_rewards<T0, T1>(arg0, v0);
        let v1 = position_manager_mut<T0, T1>(arg0);
        let (v2, v3) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::extract_fees(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(v1, v0));
        assert!(v2 == 0 && v3 == 0, 26);
        let v4 = *0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::ids(arg2);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<u32>(&v4)) {
            0x1::vector::push_back<u64>(&mut v5, 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((*0x2::table::borrow<u32, u64>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::shares(arg2), *0x1::vector::borrow<u32>(&v4, v6)) as u256) * (arg3 as u256) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u256)));
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position::decrease_shares(arg2, *0x1::vector::borrow<u32>(&v4, v6), *0x1::vector::borrow<u64>(&v5, v6));
            v6 = v6 + 1;
        };
        let v7 = burn_from_bins_internal<T0, T1>(arg0, 0x2::object::id_to_address(&v0), &v4, v5, arg5);
        v6 = 0;
        let v8 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(&mut arg0.position_manager, v0);
        while (v6 < 0x1::vector::length<u32>(&v4)) {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::sub_bin_liquidity(v8, *0x1::vector::borrow<u32>(&v4, v6), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::get_liquidity(*0x1::vector::borrow<u64>(&v7.amounts_x, v6), *0x1::vector::borrow<u64>(&v7.amounts_y, v6), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::price(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v4, v6)))));
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::sub_bin_shares(v8, *0x1::vector::borrow<u32>(&v4, v6), *0x1::vector::borrow<u64>(&v5, v6));
            v6 = v6 + 1;
        };
        let v9 = EventWithdrawnFromBins{
            sender         : 0x2::tx_context::sender(arg5),
            lp             : 0x2::tx_context::sender(arg5),
            pair_id        : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            position_id    : v0,
            ids            : v4,
            amounts_x      : v7.amounts_x,
            amounts_y      : v7.amounts_y,
            amounts_out_x  : v7.total_amounts_out_x,
            amounts_out_y  : v7.total_amounts_out_y,
            pair_reserve_x : arg0.reserve_x,
            pair_reserve_y : arg0.reserve_y,
        };
        0x2::event::emit<EventWithdrawnFromBins>(v9);
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v7.total_amounts_out_x), 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), v7.total_amounts_out_y))
    }

    fun split_fees(arg0: u64, arg1: u256, arg2: u256, arg3: u64) : (u64, u64) {
        let v0 = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg0 as u256) * arg2 / arg1);
        let (v1, v2) = apply_unstaked_fees(arg0 - v0, v0, arg3);
        ((v1 as u64), (v2 as u64))
    }

    public fun stake_in_magma_distribution<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::GaugeCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg2);
        assert!(!0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::staked(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg3)), 24);
        assert!(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::liquidity(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg3)) > 0, 31);
        let v0 = *0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_ids(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg3));
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&v0)) {
            if (arg0.params.active_index == *0x1::vector::borrow<u32>(&v0, v1)) {
                update_magma_distribution_growth_global_internal<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v0, v1), arg4);
            };
            let v2 = 0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, *0x1::vector::borrow<u32>(&v0, v1));
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::stake_liquidity(v2, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_liquidity(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg3), *0x1::vector::borrow<u32>(&v0, v1)));
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::set_distribution_growth(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(&mut arg0.position_manager, arg3), *0x1::vector::borrow<u32>(&v0, v1), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::distribution_growth(v2));
            v1 = v1 + 1;
        };
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::stake(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(&mut arg0.position_manager, arg3));
    }

    fun swap_internal<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: u64, arg2: bool, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : SwapInternalResult {
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
        let v4 = EventSwap{
            pair_id                : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            sender                 : 0x2::tx_context::sender(arg7),
            receiver               : arg3,
            active_id              : 0x1::vector::empty<u32>(),
            swap_for_y             : arg2,
            amounts_in_with_fees   : 0x1::vector::empty<u64>(),
            amounts_out_of_bin     : 0x1::vector::empty<u64>(),
            volatility_accumulator : 0x1::vector::empty<u32>(),
            pair_fee               : 0x1::vector::empty<u64>(),
            protocol_fee           : 0x1::vector::empty<u64>(),
            gauge_fee              : 0x1::vector::empty<u64>(),
            partner_fee            : 0x1::vector::empty<u64>(),
            pair_reserve_x         : 0,
            pair_reserve_y         : 0,
        };
        let v5 = 0x1::vector::empty<SwapInternalStep>();
        let v6 = 0;
        let v7 = 0x1::vector::empty<u32>();
        0x2::object::id<AlmmPair<T0, T1>>(arg0);
        loop {
            let v8 = 0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, v2);
            let v9 = if (arg2) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_y(v8)
            } else {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_x(v8)
            };
            if (v9 > 0) {
                let v10 = &mut v1;
                update_volatility_accumulator(v10, v2);
                let v11 = get_base_fee(&v1, arg0.bin_step);
                let v12 = get_variable_fee(&v1, arg0.bin_step);
                let (v13, v14, v15, v16, v17, v18) = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::get_amounts(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_x(v8), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::reserve_y(v8), arg0.bin_step, v11 + v12, arg2, v2, arg1);
                if (v13 > 0 && arg2) {
                    if (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::staked_liquidity(v8) > 0) {
                        v6 = v6 + v13;
                        let v19 = SwapInternalStep{
                            bin_id               : v2,
                            distribution_portion : v13,
                            staked_liquidity     : 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::staked_liquidity(v8),
                            bin_liquidity        : 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::liquidity(v8),
                        };
                        0x1::vector::push_back<SwapInternalStep>(&mut v5, v19);
                    };
                    arg1 = arg1 - v13;
                    v0.amounts_out = v0.amounts_out + v16;
                    let v20 = v13 - v17;
                    let v21 = fee_hub(v8, &v1, v17, arg4, arg5, v11 * (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u64) / (v11 + v12));
                    v0.partner_fee = v0.partner_fee + v21.partner_fee;
                    v0.protocol_fee = v0.protocol_fee + v21.protocol_fee;
                    v0.gauge_fee = v0.gauge_fee + v21.gauge_fee;
                    v0.fee_to_bin = v0.fee_to_bin + v21.fee_to_bin;
                    if (v21.fee_growth > 0) {
                        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::grow_fee_x(v8, v21.fee_growth);
                    };
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::add_reserves(v8, v20, 0);
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::sub_reserves(v8, 0, v16);
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::accumulate_fees(v8, v21.fee_to_bin, v0.swap_for_y);
                    v0.pair_reserve_x = v0.pair_reserve_x + v20;
                    v0.pair_reserve_y = v0.pair_reserve_y - v16;
                    0x1::vector::push_back<u32>(&mut v4.active_id, v2);
                    0x1::vector::push_back<u64>(&mut v4.amounts_in_with_fees, v20);
                    0x1::vector::push_back<u64>(&mut v4.amounts_out_of_bin, v16);
                    0x1::vector::push_back<u32>(&mut v4.volatility_accumulator, volatility_accumulator(&v1));
                    0x1::vector::push_back<u64>(&mut v4.pair_fee, v21.fee_to_bin);
                    0x1::vector::push_back<u64>(&mut v4.protocol_fee, v21.protocol_fee);
                    0x1::vector::push_back<u64>(&mut v4.gauge_fee, v21.gauge_fee);
                    0x1::vector::push_back<u64>(&mut v4.partner_fee, v21.partner_fee);
                    v4.pair_reserve_x = v0.pair_reserve_x;
                    v4.pair_reserve_y = v0.pair_reserve_y;
                } else if (v14 > 0 && !arg2) {
                    if (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::staked_liquidity(v8) > 0) {
                        v6 = v6 + v14;
                        let v22 = SwapInternalStep{
                            bin_id               : v2,
                            distribution_portion : v14,
                            staked_liquidity     : 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::staked_liquidity(v8),
                            bin_liquidity        : 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::liquidity(v8),
                        };
                        0x1::vector::push_back<SwapInternalStep>(&mut v5, v22);
                    };
                    arg1 = arg1 - v14;
                    v0.amounts_out = v0.amounts_out + v15;
                    let v23 = v14 - v18;
                    let v24 = fee_hub(v8, &v1, v18, arg4, arg5, v11 * (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u64) / (v11 + v12));
                    v0.partner_fee = v0.partner_fee + v24.partner_fee;
                    v0.protocol_fee = v0.protocol_fee + v24.protocol_fee;
                    v0.gauge_fee = v0.gauge_fee + v24.gauge_fee;
                    v0.fee_to_bin = v0.fee_to_bin + v24.fee_to_bin;
                    if (v24.fee_growth > 0) {
                        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::grow_fee_y(v8, v24.fee_growth);
                    };
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::add_reserves(v8, 0, v23);
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::sub_reserves(v8, v15, 0);
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::accumulate_fees(v8, v24.fee_to_bin, v0.swap_for_y);
                    v0.pair_reserve_x = v0.pair_reserve_x - v15;
                    v0.pair_reserve_y = v0.pair_reserve_y + v23;
                    0x1::vector::push_back<u32>(&mut v4.active_id, v2);
                    0x1::vector::push_back<u64>(&mut v4.amounts_in_with_fees, v23);
                    0x1::vector::push_back<u64>(&mut v4.amounts_out_of_bin, v15);
                    0x1::vector::push_back<u32>(&mut v4.volatility_accumulator, volatility_accumulator(&v1));
                    0x1::vector::push_back<u64>(&mut v4.pair_fee, v24.fee_to_bin);
                    0x1::vector::push_back<u64>(&mut v4.protocol_fee, v24.protocol_fee);
                    0x1::vector::push_back<u64>(&mut v4.gauge_fee, v24.gauge_fee);
                    0x1::vector::push_back<u64>(&mut v4.partner_fee, v24.partner_fee);
                    v4.pair_reserve_x = v0.pair_reserve_x;
                    v4.pair_reserve_y = v0.pair_reserve_y;
                };
            };
            if (arg1 == 0) {
                break
            };
            let (v25, v26) = get_next_non_empty_bin_internal<T0, T1>(arg0, arg2, v2);
            assert!(v26, 10);
            0x1::vector::push_back<u32>(&mut v7, v2);
            v2 = v25;
        };
        assert!(v0.amounts_out > 0, 11);
        if (0x1::vector::length<u32>(&v7) > 0) {
            update_distribution_in_cross_bins_by_swap<T0, T1>(arg0, v6, &v5, 0x2::clock::timestamp_ms(arg6) / 1000);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::download_rewarders(0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, arg0.params.active_index), &arg0.rewarder_manager);
            let v27 = 0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, v2);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::upload_rewarders(v27, &mut arg0.rewarder_manager);
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::download_rewarders(v27, &arg0.rewarder_manager);
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
        let v28 = &mut v1;
        set_active_id(v28, v2);
        arg0.params = v1;
        0x2::event::emit<EventSwap>(v4);
        v0
    }

    public fun swap_with_partner<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, SwapInternalResult) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        swap_with_partner_fee_rate<T0, T1>(arg0, arg1, arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::current_ref_fee_rate(arg3, 0x2::clock::timestamp_ms(arg10) / 1000), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public(friend) fun swap_with_partner_fee_rate<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, SwapInternalResult) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        assert!(arg6 > 0, 9);
        if (arg8) {
            assert!(0x2::coin::value<T0>(&arg4) >= arg6, 12);
        } else {
            assert!(0x2::coin::value<T1>(&arg5) >= arg6, 13);
        };
        settle_rewarders<T0, T1>(arg0, arg1, true, arg10);
        let v0 = if (arg0.unstaked_liquidity_fee_rate == 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::default_unstaked_fee_rate()) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::unstaked_liquidity_fee_rate(arg2)
        } else {
            arg0.unstaked_liquidity_fee_rate
        };
        let v1 = swap_internal<T0, T1>(arg0, arg6, arg8, arg9, arg3, v0, arg10, arg11);
        assert!(v1.amounts_out >= arg7, 23);
        if (arg8) {
            0x2::coin::destroy_zero<T1>(arg5);
            let v4 = if (0x2::coin::value<T0>(&arg4) > arg6) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, arg6, arg11)));
                0x2::coin::into_balance<T0>(arg4)
            } else {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(arg4));
                0x2::balance::zero<T0>()
            };
            (v4, 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), v1.amounts_out), v1)
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
            let v5 = if (0x2::coin::value<T1>(&arg5) > arg6) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, arg6, arg11)));
                0x2::coin::into_balance<T1>(arg5)
            } else {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(arg5));
                0x2::balance::zero<T1>()
            };
            (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v1.amounts_out), v5, v1)
        }
    }

    public fun sync_magma_distribution_reward<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::GaugeCap, arg3: u256, arg4: u64, arg5: u64) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg2);
        arg0.distribution_rate = arg3;
        arg0.distribution_reserve = arg4;
        arg0.distribution_period_finish = arg5;
        arg0.distribution_rollover = 0;
    }

    public fun time_of_last_update(arg0: &AlmmPairParameter) : u64 {
        arg0.time_of_last_update
    }

    public fun unstake_from_magma_distribution<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::GaugeCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg2);
        let v0 = *0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_ids(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg3));
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&v0)) {
            if (arg0.params.active_index == *0x1::vector::borrow<u32>(&v0, v1)) {
                update_magma_distribution_growth_global_internal<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v0, v1), arg4);
            };
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::unstake_liquidity(0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, *0x1::vector::borrow<u32>(&v0, v1)), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_liquidity(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info(&arg0.position_manager, arg3), *0x1::vector::borrow<u32>(&v0, v1)));
            v1 = v1 + 1;
        };
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::unstake(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(&mut arg0.position_manager, arg3));
    }

    public fun update_display<T0, T1>(arg0: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg1), 13906845671970832383);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg0);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"bin_step"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_a"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_b"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{bin_step}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{x}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{y}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://app.magmafinance.io/liquidity/almmdeposit?poolAddress={id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Magma ALMM Pair"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://magmafinance.io"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"MAGMA"));
        let v2 = 0x2::display::new_with_fields<AlmmPair<T0, T1>>(arg1, v0, v1, arg2);
        0x2::display::update_version<AlmmPair<T0, T1>>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<AlmmPair<T0, T1>>>(v2, 0x2::tx_context::sender(arg2));
    }

    fun update_distribution_in_cross_bins_by_swap<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: u64, arg2: &vector<SwapInternalStep>, arg3: u64) {
        let v0 = arg3 - arg0.distribution_last_updated;
        if (v0 == 0) {
            return
        };
        if (arg0.distribution_reserve > 0) {
            let v1 = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(arg0.distribution_rate * (v0 as u256) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale());
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
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::grow_distribution(0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, v4.bin_id), ((0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((v2 as u256) * (v4.distribution_portion as u256) / (arg1 as u256)) as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (v4.staked_liquidity >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()), arg3);
                    v3 = v3 + 1;
                };
            };
        };
        arg0.distribution_last_updated = arg3;
    }

    public fun update_factory_id<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        assert!(0x2::package::from_module<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory>(arg1), 13906835540142981119);
        assert!(arg0.factory != arg2, 17);
        arg0.factory = arg2;
        let v0 = EventUpdateFactory{
            old_factory : arg0.factory,
            new_factory : arg2,
        };
        0x2::event::emit<EventUpdateFactory>(v0);
    }

    public(friend) fun update_id_reference(arg0: &mut AlmmPairParameter) {
        arg0.index_reference = arg0.active_index;
    }

    public fun update_magma_distribution_growth_global<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::GaugeCap, arg3: &0x2::clock::Clock) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::abort_if_paused(arg1);
        assert!(!arg0.pause, 22);
        check_gauge_cap<T0, T1>(arg0, arg2);
        let v0 = arg0.params.active_index;
        update_magma_distribution_growth_global_internal<T0, T1>(arg0, v0, arg3);
    }

    fun update_magma_distribution_growth_global_internal<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: u32, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = v0 - arg0.distribution_last_updated;
        let v2 = 0x2::table::borrow_mut<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&mut arg0.bins, arg1);
        let v3 = 0;
        if (v1 != 0) {
            if (arg0.distribution_reserve > 0) {
                let v4 = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(arg0.distribution_rate * (v1 as u256) / 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale());
                let v5 = v4;
                if (v4 > arg0.distribution_reserve) {
                    v5 = arg0.distribution_reserve;
                };
                arg0.distribution_reserve = arg0.distribution_reserve - v5;
                let v6 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::staked_liquidity(v2);
                if (v6 > 0) {
                    0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::grow_distribution(v2, ((v5 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (v6 >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()), v0);
                } else {
                    arg0.distribution_rollover = arg0.distribution_rollover + v5;
                };
                v3 = v5;
            };
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::set_distribution_last_updated(v2, v0);
            arg0.distribution_last_updated = v0;
        };
        v3
    }

    public(friend) fun update_position_active_rewards<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::rewarders(&arg0.rewarder_manager);
        let v1 = 0;
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
        while (v1 < 0x1::vector::length<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::Rewarder>(&v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v2, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::reward_coin(0x1::vector::borrow<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::Rewarder>(&v0, v1)), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::growth_global(0x1::vector::borrow<0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::Rewarder>(&v0, v1)));
            v1 = v1 + 1;
        };
        let v3 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(&mut arg0.position_manager, arg1);
        let v4 = active_index(&arg0.params);
        if (0x1::vector::contains<u32>(0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_ids(v3), &v4)) {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::update_rewarder(v3, v4, v2);
        };
    }

    public(friend) fun update_position_fees<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(&mut arg0.position_manager, arg1);
        let v1 = 0;
        let v2 = *0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_ids(v0);
        while (v1 < 0x1::vector::length<u32>(&v2)) {
            0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::update_fees(v0, *0x1::vector::borrow<u32>(&v2, v1), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_x(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v2, v1))), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::fee_growth_y(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v2, v1))));
            v1 = v1 + 1;
        };
    }

    fun update_position_inactive_rewards<T0, T1>(arg0: &mut AlmmPair<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::position_info_mut(&mut arg0.position_manager, arg1);
        let v1 = *0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::bin_ids(v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&v1)) {
            if (*0x1::vector::borrow<u32>(&v1, v2) != active_index(&arg0.params)) {
                0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_position_info::update_rewarder(v0, *0x1::vector::borrow<u32>(&v1, v2), *0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::borrow_rewarders(0x2::table::borrow<u32, 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_bin::Bin>(&arg0.bins, *0x1::vector::borrow<u32>(&v1, v2))));
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun update_references(arg0: &mut AlmmPairParameter, arg1: u64) {
        assert!(arg1 >= arg0.time_of_last_update, 13906843210954571775);
        let v0 = arg1 - arg0.time_of_last_update;
        if (v0 >= (arg0.filter_period as u64)) {
            update_id_reference(arg0);
            if (v0 < (arg0.decay_period as u64)) {
                update_volatility_reference(arg0);
            } else {
                arg0.volatility_reference = 0;
            };
            update_time_of_last_update(arg0, arg1);
        };
    }

    public fun update_rewarder_emission<T0, T1, T2>(arg0: &mut AlmmPair<T0, T1>, arg1: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::RewarderGlobalVault, arg4: u256, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_factory::version_only(arg1);
        assert!(!arg0.pause, 22);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::check_rewarder_manager_role(arg2, 0x2::tx_context::sender(arg7));
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6) / 1000, 13906843859494633471);
        settle_rewarders<T0, T1>(arg0, arg1, true, arg6);
        let (v0, _) = get_active_liquidity<T0, T1>(arg0);
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_rewarder::update_emission<T2>(&mut arg0.rewarder_manager, arg3, v0, arg4, arg5, 0x2::clock::timestamp_ms(arg6) / 1000);
        let v2 = EventUpdateRewarderEmission{
            pair                      : 0x2::object::id<AlmmPair<T0, T1>>(arg0),
            rewarder_type             : 0x1::type_name::get<T2>(),
            emissions_per_second_q128 : arg4,
        };
        0x2::event::emit<EventUpdateRewarderEmission>(v2);
    }

    public(friend) fun update_time_of_last_update(arg0: &mut AlmmPairParameter, arg1: u64) {
        arg0.time_of_last_update = arg1;
    }

    public(friend) fun update_volatility_accumulator(arg0: &mut AlmmPairParameter, arg1: u32) {
        let v0 = arg0.index_reference;
        let v1 = if (arg1 > v0) {
            arg1 - v0
        } else {
            v0 - arg1
        };
        let v2 = arg0.volatility_reference + v1 * (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u32);
        let v3 = arg0.max_volatility_accumulator;
        let v4 = if (v2 > v3) {
            v3
        } else {
            v2
        };
        arg0.volatility_accumulator = v4;
    }

    public(friend) fun update_volatility_parameters(arg0: &mut AlmmPairParameter, arg1: u32, arg2: u64) {
        update_references(arg0, arg2);
        update_volatility_accumulator(arg0, arg1);
    }

    public(friend) fun update_volatility_reference(arg0: &mut AlmmPairParameter) {
        arg0.volatility_reference = (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u64::mul_div_floor((arg0.volatility_accumulator as u64), ((arg0.reduction_factor as u32) as u64), (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u64)) as u32);
    }

    public fun volatility_accumulator(arg0: &AlmmPairParameter) : u32 {
        arg0.volatility_accumulator
    }

    public fun volatility_reference(arg0: &AlmmPairParameter) : u32 {
        arg0.volatility_reference
    }

    // decompiled from Move bytecode v6
}

