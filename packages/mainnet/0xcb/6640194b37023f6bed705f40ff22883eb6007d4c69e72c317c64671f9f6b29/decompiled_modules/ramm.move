module 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm {
    struct LP<phantom T0> has drop, store {
        dummy_field: bool,
    }

    struct RAMMAdminCap has key {
        id: 0x2::object::UID,
    }

    struct RAMMNewAssetCap has key {
        id: 0x2::object::UID,
    }

    struct RAMM has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        new_asset_cap_id: 0x2::object::ID,
        is_initialized: bool,
        collected_protocol_fees: 0x2::bag::Bag,
        fee_collector: address,
        asset_count: u8,
        deposits_enabled: 0x2::vec_map::VecMap<u8, bool>,
        factors_for_balances: 0x2::vec_map::VecMap<u8, u256>,
        minimum_trade_amounts: 0x2::vec_map::VecMap<u8, u64>,
        types_to_indexes: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
        aggregator_addrs: 0x2::vec_map::VecMap<u8, address>,
        previous_prices: 0x2::vec_map::VecMap<u8, u256>,
        previous_price_timestamps: 0x2::vec_map::VecMap<u8, u64>,
        volatility_indices: 0x2::vec_map::VecMap<u8, u256>,
        volatility_timestamps: 0x2::vec_map::VecMap<u8, u64>,
        balances: 0x2::vec_map::VecMap<u8, u256>,
        typed_balances: 0x2::bag::Bag,
        lp_tokens_issued: 0x2::vec_map::VecMap<u8, u256>,
        typed_lp_tokens_issued: 0x2::bag::Bag,
    }

    struct TradeOutput has drop {
        amount: u256,
        protocol_fee: u256,
        trade_outcome: u8,
    }

    struct WithdrawalOutput has drop {
        amounts: 0x2::vec_map::VecMap<u8, u256>,
        fees: 0x2::vec_map::VecMap<u8, u256>,
        value: u256,
        remaining: u256,
    }

    public(friend) fun value(arg0: &WithdrawalOutput) : u256 {
        arg0.value
    }

    public(friend) fun adjust(arg0: u256) : u256 {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::adjust(arg0, 12, 25)
    }

    fun check_imbalance_ratios(arg0: &RAMM, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: u8, arg3: u8, arg4: u256, arg5: u256, arg6: u256, arg7: &0x2::vec_map::VecMap<u8, u256>) : bool {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::check_imbalance_ratios(&arg0.balances, &arg0.lp_tokens_issued, arg1, arg2, arg3, arg4, arg5, arg6, &arg0.factors_for_balances, 1000, arg7, 12, 25, 1000000000000, 250000000000)
    }

    fun compute_B_and_L(arg0: &RAMM, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: &0x2::vec_map::VecMap<u8, u256>) : (u256, u256) {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::compute_B_and_L(&arg0.balances, &arg0.lp_tokens_issued, arg1, &arg0.factors_for_balances, 1000, arg2, 12, 25)
    }

    public(friend) fun compute_volatility_fee(arg0: &RAMM, arg1: u8, arg2: u256, arg3: u64) : u256 {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::compute_volatility_fee(get_prev_prc(arg0, arg1), get_prev_prc_tmstmp(arg0, arg1), arg2, arg3, *0x2::vec_map::get<u8, u256>(&arg0.volatility_indices, &arg1), *0x2::vec_map::get<u8, u64>(&arg0.volatility_timestamps, &arg1), 12, 25, 1000000000000, 50000000000, 1000000000, 300)
    }

    public fun div(arg0: u256, arg1: u256) : u256 {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::div(arg0, arg1, 12, 25)
    }

    public fun imbalance_ratios(arg0: &RAMM, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: &0x2::vec_map::VecMap<u8, u256>) : 0x2::vec_map::VecMap<u8, u256> {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::imbalance_ratios(&arg0.balances, &arg0.lp_tokens_issued, arg1, &arg0.factors_for_balances, 1000, arg2, 12, 25)
    }

    public fun mul(arg0: u256, arg1: u256) : u256 {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::mul(arg0, arg1, 12, 25)
    }

    public fun mul3(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::mul3(arg0, arg1, arg2, 12, 25)
    }

    public fun pow_d(arg0: u256, arg1: u256) : u256 {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::pow_d(arg0, arg1, 1000000000000, 12, 25)
    }

    public fun pow_n(arg0: u256, arg1: u256) : u256 {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::pow_n(arg0, arg1, 1000000000000, 12, 25)
    }

    public fun power(arg0: u256, arg1: u256) : u256 {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::power(arg0, arg1, 1000000000000, 12, 25)
    }

    fun scaled_fee_and_leverage(arg0: &RAMM, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: u8, arg3: u8, arg4: &0x2::vec_map::VecMap<u8, u256>) : (u256, u256) {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::scaled_fee_and_leverage(&arg0.balances, &arg0.lp_tokens_issued, arg1, arg2, arg3, &arg0.factors_for_balances, 1000, arg4, 1000000000, 100000000000000, 12, 25)
    }

    public(friend) fun update_volatility_data(arg0: &mut RAMM, arg1: u8, arg2: u256, arg3: u64, arg4: u256, arg5: u64, arg6: u256) {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::update_volatility_data(arg2, arg3, arg4, arg5, 0x2::vec_map::get_mut<u8, u256>(&mut arg0.volatility_indices, &arg1), 0x2::vec_map::get_mut<u8, u64>(&mut arg0.volatility_timestamps, &arg1), arg6, 1000000000000, 300);
    }

    fun weights(arg0: &RAMM, arg1: &0x2::vec_map::VecMap<u8, u256>, arg2: &0x2::vec_map::VecMap<u8, u256>) : 0x2::vec_map::VecMap<u8, u256> {
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::weights(&arg0.balances, arg1, &arg0.factors_for_balances, arg2, 12, 25)
    }

    public fun add_asset_to_ramm<T0>(arg0: &mut RAMM, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg2: u64, arg3: u8, arg4: &RAMMAdminCap, arg5: &RAMMNewAssetCap) {
        assert!(arg0.admin_cap_id == 0x2::object::id<RAMMAdminCap>(arg4), 2);
        assert!(arg0.new_asset_cap_id == 0x2::object::id<RAMMNewAssetCap>(arg5), 6);
        assert!(!arg0.is_initialized, 10);
        let v0 = arg0.asset_count;
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.collected_protocol_fees, v0, 0x2::balance::zero<T0>());
        arg0.asset_count = arg0.asset_count + 1;
        0x2::vec_map::insert<u8, bool>(&mut arg0.deposits_enabled, v0, false);
        0x2::vec_map::insert<u8, u256>(&mut arg0.factors_for_balances, v0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::pow(10, 12 - arg3));
        0x2::vec_map::insert<u8, u64>(&mut arg0.minimum_trade_amounts, v0, arg2);
        0x2::vec_map::insert<0x1::type_name::TypeName, u8>(&mut arg0.types_to_indexes, 0x1::type_name::get<T0>(), v0);
        0x2::vec_map::insert<u8, address>(&mut arg0.aggregator_addrs, v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(arg1));
        0x2::vec_map::insert<u8, u256>(&mut arg0.previous_prices, v0, 0);
        0x2::vec_map::insert<u8, u64>(&mut arg0.previous_price_timestamps, v0, 0);
        0x2::vec_map::insert<u8, u256>(&mut arg0.volatility_indices, v0, 0);
        0x2::vec_map::insert<u8, u64>(&mut arg0.volatility_timestamps, v0, 0);
        0x2::vec_map::insert<u8, u256>(&mut arg0.balances, v0, 0);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut arg0.typed_balances, v0, 0x2::balance::zero<T0>());
        0x2::vec_map::insert<u8, u256>(&mut arg0.lp_tokens_issued, v0, 0);
        let v1 = LP<T0>{dummy_field: false};
        0x2::bag::add<u8, 0x2::balance::Supply<LP<T0>>>(&mut arg0.typed_lp_tokens_issued, v0, 0x2::balance::create_supply<LP<T0>>(v1));
        let v2 = (arg0.asset_count as u64);
        assert!(v2 == 0x2::bag::length(&arg0.collected_protocol_fees), 4);
        assert!(v2 == 0x2::vec_map::size<u8, bool>(&arg0.deposits_enabled), 4);
        assert!(v2 == 0x2::vec_map::size<u8, u256>(&arg0.factors_for_balances), 4);
        assert!(v2 == 0x2::vec_map::size<0x1::type_name::TypeName, u8>(&arg0.types_to_indexes), 4);
        assert!(v2 == 0x2::vec_map::size<u8, address>(&arg0.aggregator_addrs), 4);
        assert!(v2 == 0x2::vec_map::size<u8, u256>(&arg0.previous_prices), 4);
        assert!(v2 == 0x2::vec_map::size<u8, u64>(&arg0.previous_price_timestamps), 4);
        assert!(v2 == 0x2::vec_map::size<u8, u256>(&arg0.volatility_indices), 4);
        assert!(v2 == 0x2::vec_map::size<u8, u64>(&arg0.volatility_timestamps), 4);
        assert!(v2 == 0x2::vec_map::size<u8, u256>(&arg0.balances), 4);
        assert!(v2 == 0x2::bag::length(&arg0.typed_balances), 4);
        assert!(v2 == 0x2::vec_map::size<u8, u256>(&arg0.lp_tokens_issued), 4);
        assert!(v2 == 0x2::bag::length(&arg0.typed_lp_tokens_issued), 4);
    }

    public(friend) fun amount(arg0: &TradeOutput) : u256 {
        arg0.amount
    }

    public(friend) fun amounts(arg0: &WithdrawalOutput) : 0x2::vec_map::VecMap<u8, u256> {
        arg0.amounts
    }

    public(friend) fun burn_lp_tokens<T0>(arg0: &mut RAMM, arg1: 0x2::balance::Balance<LP<T0>>) : u64 {
        0x2::balance::decrease_supply<LP<T0>>(get_lptoken_supply<T0>(arg0), arg1)
    }

    public(friend) fun can_deposit_asset(arg0: &RAMM, arg1: u8) : bool {
        *0x2::vec_map::get<u8, bool>(&arg0.deposits_enabled, &arg1)
    }

    fun check_feed_address(arg0: &RAMM, arg1: u8, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) : bool {
        *0x2::vec_map::get<u8, address>(&arg0.aggregator_addrs, &arg1) == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(arg2)
    }

    public(friend) fun check_feed_and_get_price_data(arg0: &RAMM, arg1: u64, arg2: u8, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &mut 0x2::vec_map::VecMap<u8, u256>, arg5: &mut 0x2::vec_map::VecMap<u8, u256>, arg6: &mut 0x2::vec_map::VecMap<u8, u64>) {
        assert!(check_feed_address(arg0, arg2, arg3), 1);
        let (v0, v1, v2) = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::oracles::get_price_from_oracle(arg3, arg1, 3600000, 12);
        0x2::vec_map::insert<u8, u256>(arg4, arg2, v0);
        0x2::vec_map::insert<u8, u64>(arg6, arg2, v2);
        0x2::vec_map::insert<u8, u256>(arg5, arg2, v1);
    }

    fun check_imbalance_ratios_status(arg0: bool) : u8 {
        if (arg0) {
            success()
        } else {
            failed_pool_imbalance()
        }
    }

    public(friend) fun check_ramm_invariants_2<T0, T1>(arg0: &RAMM) {
        assert!(get_asset_count(arg0) == 2, 7);
        assert!(get_balance<T0>(arg0) == get_typed_balance<T0>(arg0), 7);
        assert!(get_balance<T1>(arg0) == get_typed_balance<T1>(arg0), 7);
        assert!(get_lptokens_issued<T0>(arg0) == get_typed_lptokens_issued<T0>(arg0), 7);
        assert!(get_lptokens_issued<T1>(arg0) == get_typed_lptokens_issued<T1>(arg0), 7);
    }

    public(friend) fun check_ramm_invariants_3<T0, T1, T2>(arg0: &RAMM) {
        assert!(get_asset_count(arg0) == 3, 7);
        assert!(get_balance<T0>(arg0) == get_typed_balance<T0>(arg0), 7);
        assert!(get_balance<T1>(arg0) == get_typed_balance<T1>(arg0), 7);
        assert!(get_balance<T2>(arg0) == get_typed_balance<T2>(arg0), 7);
        assert!(get_lptokens_issued<T0>(arg0) == get_typed_lptokens_issued<T0>(arg0), 7);
        assert!(get_lptokens_issued<T1>(arg0) == get_typed_lptokens_issued<T1>(arg0), 7);
        assert!(get_lptokens_issued<T2>(arg0) == get_typed_lptokens_issued<T2>(arg0), 7);
    }

    public(friend) fun check_trade_amount_in<T0>(arg0: &RAMM, arg1: u256) {
        assert!(arg1 <= mul(div(50000000000, 1000000000000 - 50000000000), get_typed_balance<T0>(arg0)), 8);
    }

    public(friend) fun check_trade_amount_out<T0>(arg0: &RAMM, arg1: u256) {
        assert!(arg1 <= mul(get_typed_balance<T0>(arg0), 50000000000), 9);
    }

    public(friend) fun decr_lptokens_issued<T0>(arg0: &mut RAMM, arg1: u64) {
        let v0 = get_asset_index<T0>(arg0);
        let v1 = 0x2::vec_map::get_mut<u8, u256>(&mut arg0.lp_tokens_issued, &v0);
        *v1 = *v1 - (arg1 as u256);
    }

    public fun disable_deposits<T0>(arg0: &mut RAMM, arg1: &RAMMAdminCap) {
        assert!(arg0.admin_cap_id == 0x2::object::id<RAMMAdminCap>(arg1), 2);
        assert!(is_initialized(arg0), 5);
        let v0 = get_asset_index<T0>(arg0);
        set_deposit_status(arg0, v0, false);
    }

    public fun enable_deposits<T0>(arg0: &mut RAMM, arg1: &RAMMAdminCap) {
        assert!(arg0.admin_cap_id == 0x2::object::id<RAMMAdminCap>(arg1), 2);
        assert!(is_initialized(arg0), 5);
        let v0 = get_asset_index<T0>(arg0);
        set_deposit_status(arg0, v0, true);
    }

    public(friend) fun failed_insufficient_out_token_balance() : u8 {
        2
    }

    public(friend) fun failed_low_out_token_imb_ratio() : u8 {
        3
    }

    public(friend) fun failed_pool_imbalance() : u8 {
        1
    }

    public(friend) fun fees(arg0: &WithdrawalOutput) : 0x2::vec_map::VecMap<u8, u256> {
        arg0.fees
    }

    public fun get_admin_cap_id(arg0: &RAMM) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    fun get_aggr_addr(arg0: &RAMM, arg1: u8) : address {
        *0x2::vec_map::get<u8, address>(&arg0.aggregator_addrs, &arg1)
    }

    public fun get_aggregator_address<T0>(arg0: &RAMM) : address {
        get_aggr_addr(arg0, get_asset_index<T0>(arg0))
    }

    public fun get_asset_count(arg0: &RAMM) : u8 {
        arg0.asset_count
    }

    public(friend) fun get_asset_index<T0>(arg0: &RAMM) : u8 {
        let v0 = 0x1::type_name::get<T0>();
        *0x2::vec_map::get<0x1::type_name::TypeName, u8>(&arg0.types_to_indexes, &v0)
    }

    public(friend) fun get_bal(arg0: &RAMM, arg1: u8) : u256 {
        *0x2::vec_map::get<u8, u256>(&arg0.balances, &arg1)
    }

    public fun get_balance<T0>(arg0: &RAMM) : u256 {
        get_bal(arg0, get_asset_index<T0>(arg0))
    }

    public fun get_collected_protocol_fees<T0>(arg0: &RAMM) : u64 {
        get_fees<T0>(arg0, get_asset_index<T0>(arg0))
    }

    public fun get_deposit_status<T0>(arg0: &RAMM) : bool {
        can_deposit_asset(arg0, get_asset_index<T0>(arg0))
    }

    public(friend) fun get_fact_for_bal(arg0: &RAMM, arg1: u8) : u256 {
        *0x2::vec_map::get<u8, u256>(&arg0.factors_for_balances, &arg1)
    }

    public fun get_factor_for_balance<T0>(arg0: &RAMM) : u256 {
        get_fact_for_bal(arg0, get_asset_index<T0>(arg0))
    }

    public fun get_fee_collector(arg0: &RAMM) : address {
        arg0.fee_collector
    }

    fun get_fees<T0>(arg0: &RAMM, arg1: u8) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<u8, 0x2::balance::Balance<T0>>(&arg0.collected_protocol_fees, arg1))
    }

    public(friend) fun get_fees_for_asset<T0>(arg0: &mut RAMM, arg1: u8) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::bag::borrow_mut<u8, 0x2::balance::Balance<T0>>(&mut arg0.collected_protocol_fees, arg1);
        0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0))
    }

    public(friend) fun get_id(arg0: &RAMM) : 0x2::object::ID {
        0x2::object::id<RAMM>(arg0)
    }

    fun get_lptok_issued(arg0: &RAMM, arg1: u8) : u256 {
        *0x2::vec_map::get<u8, u256>(&arg0.lp_tokens_issued, &arg1)
    }

    fun get_lptoken_supply<T0>(arg0: &mut RAMM) : &mut 0x2::balance::Supply<LP<T0>> {
        0x2::bag::borrow_mut<u8, 0x2::balance::Supply<LP<T0>>>(&mut arg0.typed_lp_tokens_issued, get_asset_index<T0>(arg0))
    }

    public fun get_lptokens_issued<T0>(arg0: &RAMM) : u256 {
        get_lptok_issued(arg0, get_asset_index<T0>(arg0))
    }

    public(friend) fun get_min_trade_amount(arg0: &RAMM, arg1: u8) : u64 {
        *0x2::vec_map::get<u8, u64>(&arg0.minimum_trade_amounts, &arg1)
    }

    public fun get_minimum_trade_amount<T0>(arg0: &RAMM) : u64 {
        get_min_trade_amount(arg0, get_asset_index<T0>(arg0))
    }

    fun get_mut_bal(arg0: &mut RAMM, arg1: u8) : &mut u256 {
        0x2::vec_map::get_mut<u8, u256>(&mut arg0.balances, &arg1)
    }

    fun get_mut_typed_bal<T0>(arg0: &mut RAMM, arg1: u8) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<u8, 0x2::balance::Balance<T0>>(&mut arg0.typed_balances, arg1)
    }

    public fun get_new_asset_cap_id(arg0: &RAMM) : 0x2::object::ID {
        arg0.new_asset_cap_id
    }

    public fun get_pool_state(arg0: &RAMM, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0x1::vector::empty<u256>();
        while (v0 < arg0.asset_count) {
            0x1::vector::push_back<u256>(&mut v1, get_bal(arg0, v0));
            0x1::vector::push_back<u256>(&mut v2, get_lptok_issued(arg0, v0));
            v0 = v0 + 1;
        };
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::pool_state_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg1), 0x2::vec_map::keys<0x1::type_name::TypeName, u8>(&arg0.types_to_indexes), v1, v2);
    }

    public(friend) fun get_prev_prc(arg0: &RAMM, arg1: u8) : u256 {
        *0x2::vec_map::get<u8, u256>(&arg0.previous_prices, &arg1)
    }

    public(friend) fun get_prev_prc_tmstmp(arg0: &RAMM, arg1: u8) : u64 {
        *0x2::vec_map::get<u8, u64>(&arg0.previous_price_timestamps, &arg1)
    }

    public fun get_previous_price<T0>(arg0: &RAMM) : u256 {
        get_prev_prc(arg0, get_asset_index<T0>(arg0))
    }

    public fun get_previous_price_timestamp<T0>(arg0: &RAMM) : u64 {
        get_prev_prc_tmstmp(arg0, get_asset_index<T0>(arg0))
    }

    public fun get_type_index<T0>(arg0: &RAMM) : u8 {
        let v0 = 0x1::type_name::get<T0>();
        *0x2::vec_map::get<0x1::type_name::TypeName, u8>(&arg0.types_to_indexes, &v0)
    }

    fun get_typed_bal<T0>(arg0: &RAMM, arg1: u8) : u256 {
        (0x2::balance::value<T0>(0x2::bag::borrow<u8, 0x2::balance::Balance<T0>>(&arg0.typed_balances, arg1)) as u256)
    }

    public fun get_typed_balance<T0>(arg0: &RAMM) : u256 {
        get_typed_bal<T0>(arg0, get_asset_index<T0>(arg0))
    }

    fun get_typed_lptok_issued<T0>(arg0: &RAMM, arg1: u8) : u256 {
        (0x2::balance::supply_value<LP<T0>>(0x2::bag::borrow<u8, 0x2::balance::Supply<LP<T0>>>(&arg0.typed_lp_tokens_issued, arg1)) as u256)
    }

    public fun get_typed_lptokens_issued<T0>(arg0: &RAMM) : u256 {
        get_typed_lptok_issued<T0>(arg0, get_asset_index<T0>(arg0))
    }

    fun get_vol_ix(arg0: &RAMM, arg1: u8) : u256 {
        *0x2::vec_map::get<u8, u256>(&arg0.volatility_indices, &arg1)
    }

    fun get_vol_tmstmp(arg0: &RAMM, arg1: u8) : u64 {
        *0x2::vec_map::get<u8, u64>(&arg0.volatility_timestamps, &arg1)
    }

    public fun get_volatility_index<T0>(arg0: &RAMM) : u256 {
        get_vol_ix(arg0, get_asset_index<T0>(arg0))
    }

    public fun get_volatility_timestamp<T0>(arg0: &RAMM) : u64 {
        get_vol_tmstmp(arg0, get_asset_index<T0>(arg0))
    }

    public(friend) fun incr_lptokens_issued<T0>(arg0: &mut RAMM, arg1: u64) {
        let v0 = get_asset_index<T0>(arg0);
        let v1 = 0x2::vec_map::get_mut<u8, u256>(&mut arg0.lp_tokens_issued, &v0);
        *v1 = *v1 + (arg1 as u256);
    }

    public fun initialize_ramm(arg0: &mut RAMM, arg1: &RAMMAdminCap, arg2: RAMMNewAssetCap) {
        assert!(arg0.admin_cap_id == 0x2::object::id<RAMMAdminCap>(arg1), 2);
        assert!(arg0.new_asset_cap_id == 0x2::object::id<RAMMNewAssetCap>(&arg2), 6);
        assert!(arg0.asset_count > 0, 3);
        assert!(!arg0.is_initialized, 10);
        let v0 = 0x2::vec_map::size<0x1::type_name::TypeName, u8>(&arg0.types_to_indexes);
        assert!(v0 > 0 && arg0.asset_count == (v0 as u8) && v0 == 0x2::bag::length(&arg0.collected_protocol_fees) && v0 == 0x2::vec_map::size<u8, bool>(&arg0.deposits_enabled) && v0 == 0x2::vec_map::size<u8, u256>(&arg0.factors_for_balances) && v0 == 0x2::vec_map::size<u8, u64>(&arg0.minimum_trade_amounts) && v0 == 0x2::vec_map::size<u8, address>(&arg0.aggregator_addrs) && v0 == 0x2::vec_map::size<u8, u256>(&arg0.previous_prices) && v0 == 0x2::vec_map::size<u8, u64>(&arg0.previous_price_timestamps) && v0 == 0x2::vec_map::size<u8, u256>(&arg0.volatility_indices) && v0 == 0x2::vec_map::size<u8, u64>(&arg0.volatility_timestamps) && v0 == 0x2::vec_map::size<u8, u256>(&arg0.balances) && v0 == 0x2::bag::length(&arg0.typed_balances) && v0 == 0x2::vec_map::size<u8, u256>(&arg0.lp_tokens_issued) && v0 == 0x2::bag::length(&arg0.typed_lp_tokens_issued), 0);
        let v1 = 0;
        while (v1 < arg0.asset_count) {
            set_deposit_status(arg0, v1, true);
            v1 = v1 + 1;
        };
        let RAMMNewAssetCap { id: v2 } = arg2;
        0x2::object::delete(v2);
        arg0.is_initialized = true;
    }

    public fun is_initialized(arg0: &RAMM) : bool {
        arg0.is_initialized
    }

    public(friend) fun is_successful(arg0: &TradeOutput) : bool {
        arg0.trade_outcome == success()
    }

    public(friend) fun join_bal(arg0: &mut RAMM, arg1: u8, arg2: u256) {
        let v0 = get_mut_bal(arg0, arg1);
        *v0 = *v0 + arg2;
    }

    public(friend) fun join_protocol_fees<T0>(arg0: &mut RAMM, arg1: u8, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(0x2::bag::borrow_mut<u8, 0x2::balance::Balance<T0>>(&mut arg0.collected_protocol_fees, arg1), arg2);
    }

    public(friend) fun join_typed_bal<T0>(arg0: &mut RAMM, arg1: u8, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(get_mut_typed_bal<T0>(arg0, arg1), arg2);
    }

    public(friend) fun liq_dep<T0>(arg0: &RAMM, arg1: u8, arg2: u64, arg3: 0x2::vec_map::VecMap<u8, u256>, arg4: 0x2::vec_map::VecMap<u8, u256>) : u64 {
        let v0 = get_fact_for_bal(arg0, arg1);
        if (get_typed_lptok_issued<T0>(arg0, arg1) == 0 || get_typed_lptok_issued<T0>(arg0, arg1) != 0 && get_typed_bal<T0>(arg0, arg1) == 0) {
            let (v1, v2) = compute_B_and_L(arg0, &arg3, &arg4);
            if (v1 == 0) {
                return arg2
            };
            return ((div(mul((arg2 as u256) * v0, v2), v1) / 1000) as u64)
        };
        if (get_typed_lptok_issued<T0>(arg0, arg1) != 0 && get_typed_bal<T0>(arg0, arg1) != 0) {
            let v3 = imbalance_ratios(arg0, &arg3, &arg4);
            return ((div(mul3((arg2 as u256) * v0, *0x2::vec_map::get<u8, u256>(&v3, &arg1), get_typed_lptok_issued<T0>(arg0, arg1) * 1000), get_typed_bal<T0>(arg0, arg1) * v0) / 1000) as u64)
        };
        0
    }

    public(friend) fun liq_withdraw_helper<T0>(arg0: &mut RAMM, arg1: u8, arg2: u256, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        split_bal(arg0, arg1, arg2);
        split_bal(arg0, arg1, arg3);
        let v0 = split_typed_bal<T0>(arg0, arg1, (arg2 as u64));
        let v1 = split_typed_bal<T0>(arg0, arg1, (arg3 as u64));
        join_protocol_fees<T0>(arg0, arg1, v1);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public(friend) fun liq_wthdrw<T0>(arg0: &RAMM, arg1: u8, arg2: u64, arg3: 0x2::vec_map::VecMap<u8, u256>, arg4: 0x2::vec_map::VecMap<u8, u256>, arg5: 0x2::vec_map::VecMap<u8, u256>) : WithdrawalOutput {
        let v0 = (arg2 as u256);
        let v1 = 0x2::vec_map::empty<u8, u256>();
        let v2 = 0;
        while (v2 < get_asset_count(arg0)) {
            0x2::vec_map::insert<u8, u256>(&mut v1, v2, 0);
            v2 = v2 + 1;
        };
        let v3 = 0;
        let v4 = &mut v3;
        let v5 = get_fact_for_bal(arg0, arg1);
        let v6 = get_typed_bal<T0>(arg0, arg1) * v5;
        let v7 = imbalance_ratios(arg0, &arg3, &arg4);
        let v8 = 0;
        let v9 = &mut v8;
        let (v10, v11) = compute_B_and_L(arg0, &arg3, &arg4);
        if (get_bal(arg0, arg1) == 0) {
            *v9 = div(mul(v0 * 1000, v10), v11) / v5;
            *v4 = *v9;
        };
        if (get_bal(arg0, arg1) != 0) {
            let v12 = *0x2::vec_map::get<u8, u256>(&v7, &arg1);
            let v13 = get_typed_lptok_issued<T0>(arg0, arg1) * v5;
            if (v0 < get_typed_lptok_issued<T0>(arg0, arg1)) {
                *v9 = div(mul(v0 * 1000, v6), mul(v13, v12)) / v5;
                let v14 = 0;
                let v15 = &mut v14;
                if (1000000000000 - 250000000000 < v12) {
                    *v15 = get_bal(arg0, arg1) - div(mul3(v10, (get_lptok_issued(arg0, arg1) - v0) * 1000, 1000000000000 - 250000000000), v11) / v5;
                } else {
                    *v15 = div(mul(v0 * 1000, v6), v13) / v5;
                };
                let v16 = 0x2::vec_map::get_mut<u8, u256>(&mut v1, &arg1);
                let v17 = 0x2::vec_map::get_mut<u8, u256>(&mut v1, &arg1);
                if (*v9 <= *v15) {
                    *v16 = *v16 + *v9;
                    split_withdrawal_fee(v16, v17, *0x2::vec_map::get<u8, u256>(&arg5, &arg1));
                    return WithdrawalOutput{
                        amounts   : v1,
                        fees      : v1,
                        value     : *v9,
                        remaining : 0,
                    }
                };
                if (*v9 > *v15) {
                    *v16 = *v16 + *v15;
                    split_withdrawal_fee(v16, v17, *0x2::vec_map::get<u8, u256>(&arg5, &arg1));
                    *v4 = *v9 - *v15;
                    *0x2::vec_map::get_mut<u8, u256>(&mut v7, &arg1) = 0;
                };
            } else {
                *v9 = div(v6, v12) / v5;
                let v18 = 0x2::vec_map::get_mut<u8, u256>(&mut v1, &arg1);
                let v19 = 0x2::vec_map::get_mut<u8, u256>(&mut v1, &arg1);
                if (*v9 <= get_bal(arg0, arg1)) {
                    *v18 = *v18 + *v9;
                    split_withdrawal_fee(v18, v19, *0x2::vec_map::get<u8, u256>(&arg5, &arg1));
                    return WithdrawalOutput{
                        amounts   : v1,
                        fees      : v1,
                        value     : *v9,
                        remaining : 0,
                    }
                };
                if (*v9 > get_bal(arg0, arg1)) {
                    *v18 = *v18 + get_bal(arg0, arg1);
                    split_withdrawal_fee(v18, v19, *0x2::vec_map::get<u8, u256>(&arg5, &arg1));
                    *v4 = *v9 - get_bal(arg0, arg1);
                    *0x2::vec_map::get_mut<u8, u256>(&mut v7, &arg1) = 0;
                };
            };
        };
        *0x2::vec_map::get_mut<u8, u256>(&mut v7, &arg1) = 0;
        let v20 = 0;
        while (v20 < get_asset_count(arg0)) {
            let v21 = 0;
            let v22 = &mut v21;
            let v23 = &mut arg1;
            let v24 = 0;
            while (v24 < get_asset_count(arg0)) {
                if (*v22 < *0x2::vec_map::get<u8, u256>(&v7, &v24)) {
                    *v23 = v24;
                    *v22 = *0x2::vec_map::get<u8, u256>(&v7, &v24);
                };
                let v25 = *v23;
                *0x2::vec_map::get_mut<u8, u256>(&mut v7, &v25) = 0;
                if (*v4 != 0 && *v22 != 0) {
                    let v26 = get_fact_for_bal(arg0, v25);
                    let v27 = div(mul(*v4 * v5, *0x2::vec_map::get<u8, u256>(&arg3, &arg1) * *0x2::vec_map::get<u8, u256>(&arg4, &arg1)), *0x2::vec_map::get<u8, u256>(&arg3, &v25) * *0x2::vec_map::get<u8, u256>(&arg4, &v25)) / v26;
                    let v28 = get_bal(arg0, v25) - div(mul3(v10, get_lptok_issued(arg0, v25) * 1000, 1000000000000 - 250000000000), v11) / v26;
                    let v29 = 0x2::vec_map::get_mut<u8, u256>(&mut v1, &v25);
                    let v30 = 0x2::vec_map::get_mut<u8, u256>(&mut v1, &v25);
                    let v31 = *0x2::vec_map::get<u8, u256>(&arg5, &v25);
                    if (v27 <= v28) {
                        *v29 = *v29 + v27;
                        split_withdrawal_fee(v29, v30, v31);
                        *v4 = 0;
                    };
                    if (v27 > v28) {
                        *v29 = *v29 + v28;
                        split_withdrawal_fee(v29, v30, v31);
                        *v4 = *v4 - div(mul(v28 * v26, *0x2::vec_map::get<u8, u256>(&arg3, &v25) * *0x2::vec_map::get<u8, u256>(&arg4, &v25)), *0x2::vec_map::get<u8, u256>(&arg3, &arg1) * *0x2::vec_map::get<u8, u256>(&arg4, &arg1)) / v5;
                    };
                };
                v24 = v24 + 1;
            };
            v20 = v20 + 1;
        };
        WithdrawalOutput{
            amounts   : v1,
            fees      : v1,
            value     : *v9,
            remaining : *v4,
        }
    }

    public(friend) fun lptok_in_circulation<T0>(arg0: &RAMM, arg1: u8) : u64 {
        0x2::balance::supply_value<LP<T0>>(0x2::bag::borrow<u8, 0x2::balance::Supply<LP<T0>>>(&arg0.typed_lp_tokens_issued, arg1))
    }

    public(friend) fun mint_lp_tokens<T0>(arg0: &mut RAMM, arg1: u64) : 0x2::balance::Balance<LP<T0>> {
        0x2::balance::increase_supply<LP<T0>>(get_lptoken_supply<T0>(arg0), arg1)
    }

    public fun new_ramm(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = RAMMAdminCap{id: v0};
        let v2 = 0x2::object::new(arg1);
        let v3 = RAMMNewAssetCap{id: v2};
        let v4 = RAMM{
            id                        : 0x2::object::new(arg1),
            admin_cap_id              : 0x2::object::uid_to_inner(&v0),
            new_asset_cap_id          : 0x2::object::uid_to_inner(&v2),
            is_initialized            : false,
            collected_protocol_fees   : 0x2::bag::new(arg1),
            fee_collector             : arg0,
            asset_count               : 0,
            deposits_enabled          : 0x2::vec_map::empty<u8, bool>(),
            factors_for_balances      : 0x2::vec_map::empty<u8, u256>(),
            minimum_trade_amounts     : 0x2::vec_map::empty<u8, u64>(),
            types_to_indexes          : 0x2::vec_map::empty<0x1::type_name::TypeName, u8>(),
            aggregator_addrs          : 0x2::vec_map::empty<u8, address>(),
            previous_prices           : 0x2::vec_map::empty<u8, u256>(),
            previous_price_timestamps : 0x2::vec_map::empty<u8, u64>(),
            volatility_indices        : 0x2::vec_map::empty<u8, u256>(),
            volatility_timestamps     : 0x2::vec_map::empty<u8, u64>(),
            balances                  : 0x2::vec_map::empty<u8, u256>(),
            typed_balances            : 0x2::bag::new(arg1),
            lp_tokens_issued          : 0x2::vec_map::empty<u8, u256>(),
            typed_lp_tokens_issued    : 0x2::bag::new(arg1),
        };
        0x2::transfer::transfer<RAMMAdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<RAMMNewAssetCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<RAMM>(v4);
    }

    public(friend) fun protocol_fee(arg0: &TradeOutput) : u256 {
        arg0.protocol_fee
    }

    public(friend) fun remaining(arg0: &WithdrawalOutput) : u256 {
        arg0.remaining
    }

    fun set_aggr_addr(arg0: &mut RAMM, arg1: u8, arg2: address) {
        *0x2::vec_map::get_mut<u8, address>(&mut arg0.aggregator_addrs, &arg1) = arg2;
    }

    public fun set_aggregator_address<T0>(arg0: &mut RAMM, arg1: &RAMMAdminCap, arg2: address) {
        assert!(arg0.admin_cap_id == 0x2::object::id<RAMMAdminCap>(arg1), 2);
        let v0 = get_asset_index<T0>(arg0);
        set_aggr_addr(arg0, v0, arg2);
    }

    fun set_deposit_status(arg0: &mut RAMM, arg1: u8, arg2: bool) {
        *0x2::vec_map::get_mut<u8, bool>(&mut arg0.deposits_enabled, &arg1) = arg2;
    }

    public fun set_fee_collector(arg0: &mut RAMM, arg1: &RAMMAdminCap, arg2: address) {
        assert!(arg0.admin_cap_id == 0x2::object::id<RAMMAdminCap>(arg1), 2);
        arg0.fee_collector = arg2;
    }

    public fun set_minimum_trade_amount<T0>(arg0: &mut RAMM, arg1: &RAMMAdminCap, arg2: u64) {
        assert!(arg0.admin_cap_id == 0x2::object::id<RAMMAdminCap>(arg1), 2);
        let v0 = get_asset_index<T0>(arg0);
        *0x2::vec_map::get_mut<u8, u64>(&mut arg0.minimum_trade_amounts, &v0) = arg2;
    }

    fun set_prev_prc(arg0: &mut RAMM, arg1: u8, arg2: u256) {
        *0x2::vec_map::get_mut<u8, u256>(&mut arg0.previous_prices, &arg1) = arg2;
    }

    fun set_prev_prc_tmstmp(arg0: &mut RAMM, arg1: u8, arg2: u64) {
        *0x2::vec_map::get_mut<u8, u64>(&mut arg0.previous_price_timestamps, &arg1) = arg2;
    }

    public(friend) fun set_previous_price<T0>(arg0: &mut RAMM, arg1: u256) {
        let v0 = get_asset_index<T0>(arg0);
        set_prev_prc(arg0, v0, arg1);
    }

    public(friend) fun set_previous_price_timestamp<T0>(arg0: &mut RAMM, arg1: u64) {
        let v0 = get_asset_index<T0>(arg0);
        set_prev_prc_tmstmp(arg0, v0, arg1);
    }

    public(friend) fun split_bal(arg0: &mut RAMM, arg1: u8, arg2: u256) {
        let v0 = get_mut_bal(arg0, arg1);
        *v0 = *v0 - arg2;
    }

    public(friend) fun split_typed_bal<T0>(arg0: &mut RAMM, arg1: u8, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(get_mut_typed_bal<T0>(arg0, arg1), arg2)
    }

    fun split_withdrawal_fee(arg0: &mut u256, arg1: &mut u256, arg2: u256) {
        *arg1 = mul(*arg0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::clamp(4000000000 + arg2, 1000000000000));
        *arg0 = *arg0 - *arg1;
    }

    public(friend) fun success() : u8 {
        0
    }

    public(friend) fun trade_i<T0, T1>(arg0: &RAMM, arg1: u8, arg2: u8, arg3: u256, arg4: 0x2::vec_map::VecMap<u8, u256>, arg5: 0x2::vec_map::VecMap<u8, u256>, arg6: u256) : TradeOutput {
        let v0 = get_fact_for_bal(arg0, arg1);
        let v1 = get_fact_for_bal(arg0, arg2);
        if (get_typed_bal<T0>(arg0, arg1) == 0) {
            let v2 = div(mul3(1000000000000 - 1000000000, arg3 * v0, *0x2::vec_map::get<u8, u256>(&arg4, &arg1) * *0x2::vec_map::get<u8, u256>(&arg5, &arg1)), *0x2::vec_map::get<u8, u256>(&arg4, &arg1) * *0x2::vec_map::get<u8, u256>(&arg5, &arg2)) / v1;
            let v3 = mul3(300000000000, 1000000000 + arg6, arg3 * v0) / v0;
            return TradeOutput{
                amount        : v2,
                protocol_fee  : v3,
                trade_outcome : check_imbalance_ratios_status(check_imbalance_ratios(arg0, &arg4, arg1, arg2, arg3, v2, v3, &arg5)),
            }
        };
        let v4 = weights(arg0, &arg4, &arg5);
        let v5 = 0;
        let v6 = &mut v5;
        *v6 = 100000000000000;
        let v7 = 0;
        let v8 = &mut v7;
        *v8 = 1000000000;
        if (get_typed_lptok_issued<T1>(arg0, arg2) != 0 && get_typed_bal<T0>(arg0, arg1) != 0) {
            let v9 = imbalance_ratios(arg0, &arg4, &arg5);
            if (*0x2::vec_map::get<u8, u256>(&v9, &arg2) < 1000000000000 - 250000000000) {
                return TradeOutput{
                    amount        : 0,
                    protocol_fee  : 0,
                    trade_outcome : failed_low_out_token_imb_ratio(),
                }
            };
            let (v10, v11) = scaled_fee_and_leverage(arg0, &arg4, arg1, arg2, &arg5);
            *v8 = v10;
            *v6 = v11;
        };
        let v12 = mul(get_typed_bal<T0>(arg0, arg1) * v0, *v6);
        *v8 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::clamp(*v8 + arg6, 1000000000000);
        let v13 = mul(mul(get_typed_bal<T1>(arg0, arg2) * v1, *v6), 1000000000000 - power(div(v12, v12 + mul(1000000000000 - *v8, arg3 * v0)), div(*0x2::vec_map::get<u8, u256>(&v4, &arg1), *0x2::vec_map::get<u8, u256>(&v4, &arg2)))) / v1;
        let v14 = mul3(300000000000, *v8, arg3 * v0) / v0;
        if (v13 > get_typed_bal<T1>(arg0, arg2) || v13 == get_typed_bal<T1>(arg0, arg2) && get_typed_lptok_issued<T1>(arg0, arg2) != 0) {
            return TradeOutput{
                amount        : 0,
                protocol_fee  : 0,
                trade_outcome : failed_insufficient_out_token_balance(),
            }
        };
        TradeOutput{
            amount        : v13,
            protocol_fee  : v14,
            trade_outcome : check_imbalance_ratios_status(check_imbalance_ratios(arg0, &arg4, arg1, arg2, arg3, v13, v14, &arg5)),
        }
    }

    public(friend) fun trade_o<T0, T1>(arg0: &RAMM, arg1: u8, arg2: u8, arg3: u64, arg4: 0x2::vec_map::VecMap<u8, u256>, arg5: 0x2::vec_map::VecMap<u8, u256>, arg6: u256) : TradeOutput {
        let v0 = get_fact_for_bal(arg0, arg1);
        let v1 = get_fact_for_bal(arg0, arg2);
        let v2 = (arg3 as u256);
        if (get_typed_bal<T0>(arg0, arg1) == 0) {
            let v3 = div(mul(v2 * v1, *0x2::vec_map::get<u8, u256>(&arg4, &arg2) * *0x2::vec_map::get<u8, u256>(&arg5, &arg2)), mul(*0x2::vec_map::get<u8, u256>(&arg4, &arg1) * *0x2::vec_map::get<u8, u256>(&arg5, &arg1), 1000000000000 - 1000000000)) / v0;
            let v4 = mul3(300000000000, 1000000000 + arg6, v3 * v0) / v0;
            return TradeOutput{
                amount        : v3,
                protocol_fee  : v4,
                trade_outcome : check_imbalance_ratios_status(check_imbalance_ratios(arg0, &arg4, arg1, arg2, v3, v2, v4, &arg5)),
            }
        };
        let v5 = weights(arg0, &arg4, &arg5);
        let v6 = 0;
        let v7 = &mut v6;
        *v7 = 100000000000000;
        let v8 = 0;
        let v9 = &mut v8;
        *v9 = 1000000000;
        if (get_typed_lptok_issued<T1>(arg0, arg2) != 0 && get_typed_bal<T0>(arg0, arg1) != 0) {
            let v10 = imbalance_ratios(arg0, &arg4, &arg5);
            if (*0x2::vec_map::get<u8, u256>(&v10, &arg2) < 1000000000000 - 250000000000) {
                return TradeOutput{
                    amount        : 0,
                    protocol_fee  : 0,
                    trade_outcome : failed_low_out_token_imb_ratio(),
                }
            };
            let (v11, v12) = scaled_fee_and_leverage(arg0, &arg4, arg1, arg2, &arg5);
            *v9 = v11;
            *v7 = v12;
        };
        let v13 = mul(get_typed_bal<T1>(arg0, arg2) * v1, *v7);
        *v9 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::math::clamp(*v9 + arg6, 1000000000000);
        let v14 = div(mul(mul(get_typed_bal<T0>(arg0, arg1) * v0, *v7), power(div(v13, v13 - v2 * v1), div(*0x2::vec_map::get<u8, u256>(&v5, &arg2), *0x2::vec_map::get<u8, u256>(&v5, &arg1))) - 1000000000000), 1000000000000 - *v9) / v0;
        let v15 = mul3(300000000000, *v9, v14 * v0) / v0;
        TradeOutput{
            amount        : v14,
            protocol_fee  : v15,
            trade_outcome : check_imbalance_ratios_status(check_imbalance_ratios(arg0, &arg4, arg1, arg2, v14, v2, v15, &arg5)),
        }
    }

    public(friend) fun trade_outcome(arg0: &TradeOutput) : u8 {
        arg0.trade_outcome
    }

    public fun transfer_admin_cap(arg0: RAMMAdminCap, arg1: address) {
        0x2::transfer::transfer<RAMMAdminCap>(arg0, arg1);
    }

    public(friend) fun update_pricing_data<T0>(arg0: &mut RAMM, arg1: u256, arg2: u64) {
        let v0 = get_asset_index<T0>(arg0);
        set_prev_prc(arg0, v0, arg1);
        set_prev_prc_tmstmp(arg0, v0, arg2);
    }

    // decompiled from Move bytecode v6
}

