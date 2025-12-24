module 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct PoolInner<phantom T0, phantom T1> has store {
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        pool_id: 0x2::object::ID,
        book: 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::Book,
        state: 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::State,
        vault: 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::Vault<T0, T1>,
        deep_price: 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::DeepPrice,
        registered_pool: bool,
    }

    struct PoolCreated<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        taker_fee: u64,
        maker_fee: u64,
        tick_size: u64,
        lot_size: u64,
        min_size: u64,
        whitelisted_pool: bool,
        treasury_address: address,
    }

    struct BookParamsUpdated<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        tick_size: u64,
        lot_size: u64,
        min_size: u64,
        timestamp: u64,
    }

    struct DeepBurned<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        deep_burned: u64,
    }

    struct ReferralRewards<phantom T0, phantom T1> has store {
        multiplier: u64,
        base: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        deep: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
    }

    struct ReferralClaimedEvent<phantom T0, phantom T1> has copy, drop, store {
        referral_id: 0x2::object::ID,
        owner: address,
        base_amount: u64,
        quote_amount: u64,
        deep_amount: u64,
    }

    struct ReferralClaimed has copy, drop, store {
        pool_id: 0x2::object::ID,
        referral_id: 0x2::object::ID,
        owner: address,
        base_amount: u64,
        quote_amount: u64,
        deep_amount: u64,
    }

    struct ReferralFeeEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        referral_id: 0x2::object::ID,
        base_fee: u64,
        quote_fee: u64,
        deep_fee: u64,
    }

    public fun id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        load_inner<T0, T1>(arg0).pool_id
    }

    public fun account<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager) : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::account::Account {
        *0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::account(&load_inner<T0, T1>(arg0).state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1))
    }

    public fun mint_referral<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 <= 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::referral_max_multiplier(), 16);
        assert!(arg1 % 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::referral_multiplier() == 0, 16);
        load_inner<T0, T1>(arg0);
        let v0 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::mint_referral(id<T0, T1>(arg0), arg2);
        let v1 = ReferralRewards<T0, T1>{
            multiplier : arg1,
            base       : 0x2::balance::zero<T0>(),
            quote      : 0x2::balance::zero<T1>(),
            deep       : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
        };
        0x2::dynamic_field::add<0x2::object::ID, ReferralRewards<T0, T1>>(&mut arg0.id, v0, v1);
        v0
    }

    public(friend) fun asks<T0, T1>(arg0: &PoolInner<T0, T1>) : &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::BigVector<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order> {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::asks(&arg0.book)
    }

    public(friend) fun bids<T0, T1>(arg0: &PoolInner<T0, T1>) : &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::BigVector<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order> {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::bids(&arg0.book)
    }

    public fun cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::cancel_order(&mut v0.book, arg3);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::balance_manager_id(&v1) == 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1), 9);
        let (v2, v3) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::process_cancel(&mut v0.state, &mut v1, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1), v0.pool_id, arg5);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v2, v3, arg1, arg2);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::emit_order_canceled(&v1, v0.pool_id, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4));
    }

    public fun check_limit_order_params<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : bool {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::check_limit_order_params(&load_inner<T0, T1>(arg0).book, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4))
    }

    public fun check_market_order_params<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : bool {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::check_market_order_params(&load_inner<T0, T1>(arg0).book, arg1)
    }

    public fun get_base_quantity_in<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = load_inner<T0, T1>(arg0);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&v0.state));
        let v2 = if (arg2) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::get_order_deep_price(&v0.deep_price, whitelisted<T0, T1>(arg0))
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::empty_deep_price(&v0.deep_price)
        };
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::get_base_quantity_in(&v0.book, arg1, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v1), v2, arg2, 0x2::clock::timestamp_ms(arg3))
    }

    public fun get_order<T0, T1>(arg0: &Pool<T0, T1>, arg1: u128) : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::get_order(&load_inner<T0, T1>(arg0).book, arg1)
    }

    public fun get_quantity_out<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = load_inner<T0, T1>(arg0);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&v0.state));
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::get_quantity_out(&v0.book, arg1, arg2, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v1), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::get_order_deep_price(&v0.deep_price, whitelisted<T0, T1>(arg0)), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::lot_size(&v0.book), true, 0x2::clock::timestamp_ms(arg3))
    }

    public fun get_quote_quantity_in<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = load_inner<T0, T1>(arg0);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&v0.state));
        let v2 = if (arg2) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::get_order_deep_price(&v0.deep_price, whitelisted<T0, T1>(arg0))
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::empty_deep_price(&v0.deep_price)
        };
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::get_quote_quantity_in(&v0.book, arg1, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v1), v2, arg2, 0x2::clock::timestamp_ms(arg3))
    }

    public fun mid_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::mid_price(&load_inner<T0, T1>(arg0).book, 0x2::clock::timestamp_ms(arg1))
    }

    public fun modify_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = get_order<T0, T1>(arg0, arg3);
        let v1 = load_inner_mut<T0, T1>(arg0);
        let (v2, v3) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::modify_order(&mut v1.book, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::balance_manager_id(v3) == 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1), 9);
        let (v4, v5) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::process_modify(&mut v1.state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1), v2, v3, v1.pool_id, arg6);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::settle_balance_manager<T0, T1>(&mut v1.vault, v4, v5, arg1, arg2);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::emit_order_modified(v3, v1.pool_id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::quantity(&v0), 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg5));
    }

    public fun get_order_deep_price<T0, T1>(arg0: &Pool<T0, T1>) : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::OrderDeepPrice {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::get_order_deep_price(&load_inner<T0, T1>(arg0).deep_price, whitelisted<T0, T1>(arg0))
    }

    public fun quorum<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::quorum(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&load_inner<T0, T1>(arg0).state))
    }

    public fun whitelisted<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::whitelisted(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&load_inner<T0, T1>(arg0).state))
    }

    public fun locked_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager) : (u64, u64, u64) {
        let v0 = get_account_order_details<T0, T1>(arg0, arg1);
        let v1 = load_inner<T0, T1>(arg0);
        if (!0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::account_exists(&v1.state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1))) {
            return (0, 0, 0)
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = &v0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(v5)) {
            let v7 = 0x1::vector::borrow<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(v5, v6);
            let v8 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::locked_balance(v7, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::history::historic_maker_fee(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::history(&v1.state), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::epoch(v7)));
            v2 = v2 + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::base(&v8);
            v3 = v3 + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::quote(&v8);
            v4 = v4 + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::deep(&v8);
            v6 = v6 + 1;
        };
        let v9 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::account::settled_balances(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::account(&v1.state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1)));
        (v2 + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::base(&v9), v3 + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::quote(&v9), v4 + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::deep(&v9))
    }

    public fun account_exists<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager) : bool {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::account_exists(&load_inner<T0, T1>(arg0).state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1))
    }

    public fun account_open_orders<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager) : 0x2::vec_set::VecSet<u128> {
        let v0 = load_inner<T0, T1>(arg0);
        if (!0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::account_exists(&v0.state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1))) {
            return 0x2::vec_set::empty<u128>()
        };
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::account::open_orders(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::account(&v0.state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1)))
    }

    public fun add_deep_price_point<T0, T1, T2, T3>(arg0: &mut Pool<T0, T1>, arg1: &Pool<T2, T3>, arg2: &0x2::clock::Clock) {
        assert!(whitelisted<T2, T3>(arg1) && registered_pool<T2, T3>(arg1), 7);
        let v0 = load_inner_mut<T0, T1>(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        let v2 = 0x1::type_name::with_defining_ids<T3>();
        let v3 = 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        let v4 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 == v3 || v2 == v3, 10);
        let v5 = v1 == v3;
        let v6 = if (v5) {
            v2
        } else {
            v1
        };
        let v7 = v6 == 0x1::type_name::with_defining_ids<T0>();
        assert!(v7 || v6 == 0x1::type_name::with_defining_ids<T1>(), 10);
        let v8 = if (v5) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(1000000000, mid_price<T2, T3>(arg1, arg2))
        } else {
            mid_price<T2, T3>(arg1, arg2)
        };
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::add_price_point(&mut v0.deep_price, v8, v4, v7);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::emit_deep_price_added(v8, v4, v7, load_inner<T2, T3>(arg1).pool_id, v0.pool_id);
    }

    public fun adjust_min_lot_size_admin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::DeepbookAdminCap, arg4: &0x2::clock::Clock) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        assert!(arg1 > 0, 4);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::lot_size(&v0.book) % arg1 == 0, 4);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::is_power_of_ten(arg1), 4);
        assert!(arg2 > 0, 5);
        assert!(arg2 % arg1 == 0, 5);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::is_power_of_ten(arg2), 5);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::set_lot_size(&mut v0.book, arg1);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::set_min_size(&mut v0.book, arg2);
        let v1 = BookParamsUpdated<T0, T1>{
            pool_id   : v0.pool_id,
            tick_size : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::tick_size(&v0.book),
            lot_size  : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::lot_size(&v0.book),
            min_size  : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::min_size(&v0.book),
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BookParamsUpdated<T0, T1>>(v1);
    }

    public fun adjust_tick_size_admin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::DeepbookAdminCap, arg3: &0x2::clock::Clock) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        assert!(arg1 > 0, 3);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::is_power_of_ten(arg1), 3);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::set_tick_size(&mut v0.book, arg1);
        let v1 = BookParamsUpdated<T0, T1>{
            pool_id   : v0.pool_id,
            tick_size : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::tick_size(&v0.book),
            lot_size  : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::lot_size(&v0.book),
            min_size  : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::min_size(&v0.book),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BookParamsUpdated<T0, T1>>(v1);
    }

    public fun borrow_flashloan_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::FlashLoan) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::borrow_flashloan_base<T0, T1>(&mut v0.vault, v0.pool_id, arg1, arg2)
    }

    public fun borrow_flashloan_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::FlashLoan) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::borrow_flashloan_quote<T0, T1>(&mut v0.vault, v0.pool_id, arg1, arg2)
    }

    public fun burn_deep<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::ProtectedTreasury, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let v1 = 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::withdraw_deep_to_burn<T0, T1>(&mut v0.vault, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::history::reset_balance_to_burn(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::history_mut(&mut v0.state))), arg2);
        let v2 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v1);
        0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::burn(arg1, v1);
        let v3 = DeepBurned<T0, T1>{
            pool_id     : v0.pool_id,
            deep_burned : v2,
        };
        0x2::event::emit<DeepBurned<T0, T1>>(v3);
        v2
    }

    public fun can_place_limit_order<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock) : bool {
        let v0 = load_inner<T0, T1>(arg0);
        if (!check_limit_order_params<T0, T1>(arg0, arg2, arg3, arg6, arg7)) {
            return false
        };
        let v1 = if (arg5) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::get_order_deep_price(&v0.deep_price, whitelisted<T0, T1>(arg0))
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::empty_deep_price(&v0.deep_price)
        };
        let v2 = v1;
        let v3 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(arg3, arg2);
        let v4 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&v0.state));
        let v5 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::fee_quantity(&v2, arg3, v3, arg4);
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        if (arg4) {
            v7 = v3;
            if (arg5) {
                v8 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::deep(&v5), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v4));
            } else {
                v7 = v3 + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::quote(&v5), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v4));
            };
        } else {
            v6 = arg3;
            if (arg5) {
                v8 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::deep(&v5), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v4));
            } else {
                v6 = arg3 + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::base(&v5), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v4));
            };
        };
        let v9 = if (!account_exists<T0, T1>(arg0, arg1)) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::empty()
        } else {
            let v10 = account<T0, T1>(arg0, arg1);
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::account::settled_balances(&v10)
        };
        let v11 = v9;
        if (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::balance<T0>(arg1) + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::base(&v11) >= v6) {
            if (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::balance<T1>(arg1) + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::quote(&v11) >= v7) {
                0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1) + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::deep(&v11) >= v8
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun can_place_market_order<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: u64, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock) : bool {
        if (!check_market_order_params<T0, T1>(arg0, arg2)) {
            return false
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = if (!account_exists<T0, T1>(arg0, arg1)) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::empty()
        } else {
            let v3 = account<T0, T1>(arg0, arg1);
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::account::settled_balances(&v3)
        };
        let v4 = v2;
        if (arg3) {
            let (v5, v6, v7) = get_quote_quantity_in<T0, T1>(arg0, arg2, arg4, arg5);
            if (v5 < arg2 || 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::balance<T1>(arg1) + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::quote(&v4) < v6) {
                return false
            };
            if (arg4) {
                v1 = v7;
            };
        } else {
            let v8 = if (arg4) {
                let (v9, v10, v11) = get_quantity_out<T0, T1>(arg0, arg2, 0, arg5);
                let _ = v10;
                let _ = v9;
                v11
            } else {
                let (v14, v15, v16) = get_quantity_out_input_fee<T0, T1>(arg0, arg2, 0, arg5);
                let _ = v15;
                let _ = v14;
                v16
            };
            let v17 = if (arg4) {
                arg2
            } else {
                let (v18, _, _) = pool_trade_params<T0, T1>(arg0);
                0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(arg2, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::float_scaling() + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(v18, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::fee_penalty_multiplier()))
            };
            v0 = v17;
            if (arg4) {
                v1 = v8;
            };
        };
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::balance<T0>(arg1) + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::base(&v4) >= v0 && 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1) + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::deep(&v4) >= v1
    }

    public fun cancel_all_orders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let v1 = vector[];
        if (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::account_exists(&v0.state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1))) {
            v1 = 0x2::vec_set::into_keys<u128>(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::account::open_orders(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::account(&v0.state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1))));
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&v1)) {
            cancel_order<T0, T1>(arg0, arg1, arg2, *0x1::vector::borrow<u128>(&v1, v2), arg3, arg4);
            v2 = v2 + 1;
        };
    }

    public fun cancel_orders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg3)) {
            cancel_order<T0, T1>(arg0, arg1, arg2, *0x1::vector::borrow<u128>(&arg3, v0), arg4, arg5);
            v0 = v0 + 1;
        };
    }

    public fun claim_pool_referral_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookPoolReferral, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        load_inner<T0, T1>(arg0);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::assert_referral_owner(arg1, arg2);
        let v0 = 0x2::object::id<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookPoolReferral>(arg1);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, ReferralRewards<T0, T1>>(&mut arg0.id, v0);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v1.base), arg2);
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut v1.quote), arg2);
        let v4 = 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v1.deep), arg2);
        let v5 = ReferralClaimed{
            pool_id      : id<T0, T1>(arg0),
            referral_id  : v0,
            owner        : 0x2::tx_context::sender(arg2),
            base_amount  : 0x2::coin::value<T0>(&v2),
            quote_amount : 0x2::coin::value<T1>(&v3),
            deep_amount  : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4),
        };
        0x2::event::emit<ReferralClaimed>(v5);
        (v2, v3, v4)
    }

    public fun claim_rebates<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let (v1, v2) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::process_claim_rebates<T0, T1>(&mut v0.state, v0.pool_id, arg1, arg3);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v1, v2, arg1, arg2);
    }

    public fun claim_referral_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookReferral, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        abort 13906838194432770047
    }

    public fun create_permissionless_pool<T0, T1>(arg0: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::Registry, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4) == 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::pool_creation_fee(), 1);
        let v0 = if (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::is_stablecoin(arg0, 0x1::type_name::with_defining_ids<T0>())) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::is_stablecoin(arg0, 0x1::type_name::with_defining_ids<T1>())
        } else {
            false
        };
        create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, v0, arg5)
    }

    public(friend) fun create_pool<T0, T1>(arg0: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::Registry, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 > 0, 3);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::is_power_of_ten(arg1), 3);
        assert!(arg2 >= 1000, 4);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::is_power_of_ten(arg2), 4);
        assert!(arg3 > 0, 5);
        assert!(arg3 % arg2 == 0, 5);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::is_power_of_ten(arg3), 5);
        let v0 = arg5 && arg6;
        assert!(!v0, 15);
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<T1>(), 2);
        let v1 = 0x2::object::new(arg7);
        let v2 = PoolInner<T0, T1>{
            allowed_versions : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::allowed_versions(arg0),
            pool_id          : 0x2::object::uid_to_inner(&v1),
            book             : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::empty(arg1, arg2, arg3, arg7),
            state            : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::empty(arg5, arg6, arg7),
            vault            : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::empty<T0, T1>(),
            deep_price       : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::empty(),
            registered_pool  : true,
        };
        let v3 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&v2.state));
        let v4 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::treasury_address(arg0);
        let v5 = Pool<T0, T1>{
            id    : v1,
            inner : 0x2::versioned::create<PoolInner<T0, T1>>(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::current_version(), v2, arg7),
        };
        let v6 = 0x2::object::id<Pool<T0, T1>>(&v5);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::register_pool<T0, T1>(arg0, v6);
        let v7 = PoolCreated<T0, T1>{
            pool_id          : v6,
            taker_fee        : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v3),
            maker_fee        : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::maker_fee(&v3),
            tick_size        : arg1,
            lot_size         : arg2,
            min_size         : arg3,
            whitelisted_pool : arg5,
            treasury_address : v4,
        };
        0x2::event::emit<PoolCreated<T0, T1>>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg4, v4);
        0x2::transfer::share_object<Pool<T0, T1>>(v5);
        v6
    }

    public fun create_pool_admin<T0, T1>(arg0: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::Registry, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::DeepbookAdminCap, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7);
        create_pool<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, arg5, arg7)
    }

    public fun enable_ewma_state<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::DeepbookAdminCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        load_inner_mut<T0, T1>(arg0);
        if (arg2) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::enable(update_ewma_state<T0, T1>(arg0, arg3, arg4));
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::disable(update_ewma_state<T0, T1>(arg0, arg3, arg4));
        };
    }

    public fun get_account_order_details<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager) : vector<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order> {
        get_orders<T0, T1>(arg0, 0x2::vec_set::into_keys<u128>(account_open_orders<T0, T1>(arg0, arg1)))
    }

    public fun get_base_quantity_out<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        get_quantity_out<T0, T1>(arg0, 0, arg1, arg2)
    }

    public fun get_base_quantity_out_input_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        get_quantity_out_input_fee<T0, T1>(arg0, 0, arg1, arg2)
    }

    public fun get_level2_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : (vector<u64>, vector<u64>) {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::get_level2_range_and_ticks(&load_inner<T0, T1>(arg0).book, arg1, arg2, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::max_u64(), arg3, 0x2::clock::timestamp_ms(arg4))
    }

    public fun get_level2_ticks_from_mid<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        let v0 = load_inner<T0, T1>(arg0);
        let (v1, v2) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::get_level2_range_and_ticks(&v0.book, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::min_price(), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::max_price(), arg1, true, 0x2::clock::timestamp_ms(arg2));
        let (v3, v4) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::get_level2_range_and_ticks(&v0.book, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::min_price(), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::max_price(), arg1, false, 0x2::clock::timestamp_ms(arg2));
        (v1, v2, v3, v4)
    }

    public fun get_order_deep_required<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = get_order_deep_price<T0, T1>(arg0);
        let v1 = load_inner<T0, T1>(arg0);
        let v2 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&v1.state));
        let v3 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&v1.state));
        let v4 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::fee_quantity(&v0, arg1, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(arg1, arg2), true);
        let v5 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balances::deep(&v4);
        (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v3), v5), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::maker_fee(&v2), v5))
    }

    public fun get_orders<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u128>) : vector<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order> {
        let v0 = 0x1::vector::empty<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg1)) {
            0x1::vector::push_back<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(&mut v0, get_order<T0, T1>(arg0, *0x1::vector::borrow<u128>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_pool_id_by_asset<T0, T1>(arg0: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::Registry) : 0x2::object::ID {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::get_pool_id<T0, T1>(arg0)
    }

    public fun get_pool_referral_balances<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookPoolReferral) : (u64, u64, u64) {
        load_inner<T0, T1>(arg0);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::balance_manager_referral_pool_id(arg1) == id<T0, T1>(arg0), 20);
        let v0 = 0x2::dynamic_field::borrow<0x2::object::ID, ReferralRewards<T0, T1>>(&arg0.id, 0x2::object::id<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookPoolReferral>(arg1));
        (0x2::balance::value<T0>(&v0.base), 0x2::balance::value<T1>(&v0.quote), 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v0.deep))
    }

    public fun get_quantity_out_input_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = load_inner<T0, T1>(arg0);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&v0.state));
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::get_quantity_out(&v0.book, arg1, arg2, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v1), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::empty_deep_price(&v0.deep_price), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::lot_size(&v0.book), false, 0x2::clock::timestamp_ms(arg3))
    }

    public fun get_quote_quantity_out<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        get_quantity_out<T0, T1>(arg0, arg1, 0, arg2)
    }

    public fun get_quote_quantity_out_input_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        get_quantity_out_input_fee<T0, T1>(arg0, arg1, 0, arg2)
    }

    public fun get_referral_balances<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookReferral) : (u64, u64, u64) {
        abort 13906841608931770367
    }

    public(friend) fun load_ewma_state<T0, T1>(arg0: &Pool<T0, T1>) : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::EWMAState {
        *0x2::dynamic_field::borrow<vector<u8>, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::EWMAState>(&arg0.id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::ewma_df_key())
    }

    public(friend) fun load_inner<T0, T1>(arg0: &Pool<T0, T1>) : &PoolInner<T0, T1> {
        let v0 = 0x2::versioned::load_value<PoolInner<T0, T1>>(&arg0.inner);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 11);
        v0
    }

    public(friend) fun load_inner_mut<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut PoolInner<T0, T1> {
        let v0 = 0x2::versioned::load_value_mut<PoolInner<T0, T1>>(&mut arg0.inner);
        let v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 11);
        v0
    }

    public fun place_limit_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::OrderInfo {
        place_order_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, false, arg12)
    }

    public fun place_market_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::OrderInfo {
        let v0 = if (arg6) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::max_price()
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::min_price()
        };
        place_order_int<T0, T1>(arg0, arg1, arg2, arg3, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::immediate_or_cancel(), arg4, v0, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8), arg8, true, arg9)
    }

    fun place_order_int<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: bool, arg13: &0x2::tx_context::TxContext) : 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::OrderInfo {
        let v0 = whitelisted<T0, T1>(arg0);
        update_ewma_state<T0, T1>(arg0, arg11, arg13);
        let v1 = load_ewma_state<T0, T1>(arg0);
        let v2 = load_inner_mut<T0, T1>(arg0);
        let v3 = if (arg9) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::get_order_deep_price(&v2.deep_price, v0)
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::deep_price::empty_deep_price(&v2.deep_price)
        };
        let v4 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::new(v2.pool_id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1), arg3, 0x2::tx_context::sender(arg13), arg4, arg5, arg6, arg7, arg8, arg9, 0x2::tx_context::epoch(arg13), arg10, v3, arg12, 0x2::clock::timestamp_ms(arg11));
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::create_order(&mut v2.book, &mut v4, 0x2::clock::timestamp_ms(arg11));
        let (v5, v6) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::process_create(&mut v2.state, &mut v4, &v1, v2.pool_id, arg13);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::settle_balance_manager<T0, T1>(&mut v2.vault, v5, v6, arg1, arg2);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::emit_order_info(&v4);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::emit_orders_filled(&v4, 0x2::clock::timestamp_ms(arg11));
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::emit_order_fully_filled_if_filled(&v4, 0x2::clock::timestamp_ms(arg11));
        process_referral_fees<T0, T1>(arg0, &v4, arg1, arg2);
        v4
    }

    public fun pool_book_params<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = load_inner<T0, T1>(arg0);
        (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::tick_size(&v0.book), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::lot_size(&v0.book), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::min_size(&v0.book))
    }

    public fun pool_referral_multiplier<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookPoolReferral) : u64 {
        load_inner<T0, T1>(arg0);
        assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::balance_manager_referral_pool_id(arg1) == id<T0, T1>(arg0), 20);
        0x2::dynamic_field::borrow<0x2::object::ID, ReferralRewards<T0, T1>>(&arg0.id, 0x2::object::id<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookPoolReferral>(arg1)).multiplier
    }

    public fun pool_trade_params<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&load_inner<T0, T1>(arg0).state));
        (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v0), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::maker_fee(&v0), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::stake_required(&v0))
    }

    public fun pool_trade_params_next<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::next_trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&load_inner<T0, T1>(arg0).state));
        (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v0), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::maker_fee(&v0), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::stake_required(&v0))
    }

    fun process_referral_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::OrderInfo, arg2: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg3: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof) {
        let v0 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::get_balance_manager_referral_id(arg2, id<T0, T1>(arg0));
        if (0x1::option::is_some<0x2::object::ID>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::object::ID>(v0);
            let v2 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, ReferralRewards<T0, T1>>(&mut arg0.id, v1);
            let v3 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::paid_fees(arg1), v2.multiplier);
            if (v3 == 0) {
                return
            };
            let v4 = 0;
            let v5 = 0;
            let v6 = 0;
            if (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::fee_is_deep(arg1)) {
                0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v2.deep, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::withdraw_with_proof<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg3, v3, false));
                v6 = v3;
            } else if (!0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::is_bid(arg1)) {
                0x2::balance::join<T0>(&mut v2.base, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::withdraw_with_proof<T0>(arg2, arg3, v3, false));
                v4 = v3;
            } else {
                0x2::balance::join<T1>(&mut v2.quote, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::withdraw_with_proof<T1>(arg2, arg3, v3, false));
                v5 = v3;
            };
            let v7 = ReferralFeeEvent{
                pool_id     : id<T0, T1>(arg0),
                referral_id : v1,
                base_fee    : v4,
                quote_fee   : v5,
                deep_fee    : v6,
            };
            0x2::event::emit<ReferralFeeEvent>(v7);
        };
    }

    public fun registered_pool<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        load_inner<T0, T1>(arg0).registered_pool
    }

    public fun return_flashloan_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::FlashLoan) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::return_flashloan_base<T0, T1>(&mut v0.vault, v0.pool_id, arg1, arg2);
    }

    public fun return_flashloan_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::FlashLoan) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::return_flashloan_quote<T0, T1>(&mut v0.vault, v0.pool_id, arg1, arg2);
    }

    public fun set_ewma_params<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::DeepbookAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::max_ewma_alpha(), 17);
        assert!(arg3 <= 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::max_z_score_threshold(), 18);
        assert!(arg4 <= 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::max_additional_taker_fee(), 19);
        load_inner_mut<T0, T1>(arg0);
        let v0 = update_ewma_state<T0, T1>(arg0, arg5, arg6);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::set_alpha(v0, arg2);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::set_z_score_threshold(v0, arg3);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::set_additional_taker_fee(v0, arg4);
    }

    public fun stable_pool<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::stable(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&load_inner<T0, T1>(arg0).state))
    }

    public fun stake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 13);
        let v0 = load_inner_mut<T0, T1>(arg0);
        let (v1, v2) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::process_stake(&mut v0.state, v0.pool_id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1), arg3, arg4);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v1, v2, arg1, arg2);
    }

    public fun submit_proposal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::validate_proof(arg1, arg2);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::process_proposal(&mut v0.state, v0.pool_id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1), arg3, arg4, arg5, arg6);
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::zero<T1>(arg5);
        swap_exact_quantity<T0, T1>(arg0, arg1, v0, arg2, arg3, arg4, arg5)
    }

    public fun swap_exact_base_for_quote_with_manager<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeCap, arg3: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DepositCap, arg4: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::WithdrawCap, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T1>(arg8);
        swap_exact_quantity_with_manager<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg8)
    }

    public fun swap_exact_quantity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = v0;
        let v2 = 0x2::coin::value<T1>(&arg2);
        let v3 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::governance::trade_params(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::governance(&load_inner<T0, T1>(arg0).state));
        assert!(v0 > 0 != v2 > 0, 6);
        let v4 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3) > 0;
        let v5 = v2 > 0;
        if (v5) {
            let v6 = if (v4) {
                let (v7, _, _) = get_quantity_out<T0, T1>(arg0, 0, v2, arg5);
                v7
            } else {
                let (v10, _, _) = get_quantity_out_input_fee<T0, T1>(arg0, 0, v2, arg5);
                v10
            };
            v1 = v6;
        } else if (!v4) {
            v1 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(v0, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::float_scaling() + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::trade_params::taker_fee(&v3), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::fee_penalty_multiplier()));
        };
        let v13 = v1 - v1 % 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::lot_size(&load_inner<T0, T1>(arg0).book);
        if (v13 < 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::min_size(&load_inner<T0, T1>(arg0).book)) {
            return (arg1, arg2, arg3)
        };
        let v14 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::new(arg6);
        let v15 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::generate_proof_as_owner(&mut v14, arg6);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::deposit<T0>(&mut v14, arg1, arg6);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::deposit<T1>(&mut v14, arg2, arg6);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v14, arg3, arg6);
        let v16 = &mut v14;
        place_market_order<T0, T1>(arg0, v16, &v15, 0, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::self_matching_allowed(), v13, v5, v4, arg5, arg6);
        let v17 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::withdraw_all<T0>(&mut v14, arg6);
        let v18 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::withdraw_all<T1>(&mut v14, arg6);
        if (v5) {
            assert!(0x2::coin::value<T0>(&v17) >= arg4, 12);
        } else {
            assert!(0x2::coin::value<T1>(&v18) >= arg4, 12);
        };
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::delete(v14);
        (v17, v18, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v14, arg6))
    }

    public fun swap_exact_quantity_with_manager<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeCap, arg3: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DepositCap, arg4: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::WithdrawCap, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::coin::value<T1>(&arg6);
        assert!(v0 > 0 != v1 > 0, 6);
        let v2 = v1 > 0;
        let v3 = if (v2) {
            let (v4, _, _) = get_quantity_out<T0, T1>(arg0, 0, v1, arg8);
            v4
        } else {
            v0 - v0 % 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::lot_size(&load_inner<T0, T1>(arg0).book)
        };
        if (v3 < 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::book::min_size(&load_inner<T0, T1>(arg0).book)) {
            return (arg5, arg6)
        };
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::deposit_with_cap<T0>(arg1, arg3, arg5, arg9);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::deposit_with_cap<T1>(arg1, arg3, arg6, arg9);
        let v7 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::generate_proof_as_trader(arg1, arg2, arg9);
        let v8 = place_market_order<T0, T1>(arg0, arg1, &v7, 0, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::self_matching_allowed(), v3, v2, true, arg8, arg9);
        let (v9, v10) = if (v2) {
            (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::executed_quantity(&v8), v1 - 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::cumulative_quote_quantity(&v8))
        } else {
            (0x2::coin::value<T0>(&arg5) - 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::executed_quantity(&v8), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_info::cumulative_quote_quantity(&v8))
        };
        let v11 = if (v9 > 0) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::withdraw_with_cap<T0>(arg1, arg4, v9, arg9)
        } else {
            0x2::coin::zero<T0>(arg9)
        };
        let v12 = v11;
        let v13 = if (v10 > 0) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::withdraw_with_cap<T1>(arg1, arg4, v10, arg9)
        } else {
            0x2::coin::zero<T1>(arg9)
        };
        let v14 = v13;
        if (v2) {
            assert!(0x2::coin::value<T0>(&v12) >= arg7, 12);
        } else {
            assert!(0x2::coin::value<T1>(&v14) >= arg7, 12);
        };
        (v12, v14)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::zero<T0>(arg5);
        swap_exact_quantity<T0, T1>(arg0, v0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun swap_exact_quote_for_base_with_manager<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeCap, arg3: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DepositCap, arg4: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::WithdrawCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T0>(arg8);
        swap_exact_quantity_with_manager<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg7, arg8)
    }

    public fun unregister_pool_admin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::Registry, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::DeepbookAdminCap) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        assert!(v0.registered_pool, 14);
        v0.registered_pool = false;
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::unregister_pool<T0, T1>(arg1);
    }

    public fun unstake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let (v1, v2) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::process_unstake(&mut v0.state, v0.pool_id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1), arg3);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v1, v2, arg1, arg2);
    }

    public fun update_allowed_versions<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::Registry, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::DeepbookAdminCap) {
        0x2::versioned::load_value_mut<PoolInner<T0, T1>>(&mut arg0.inner).allowed_versions = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::allowed_versions(arg1);
    }

    public fun update_deepbook_referral_multiplier<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookReferral, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        abort 13906838078468653055
    }

    fun update_ewma_state<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::EWMAState {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::ewma_df_key())) {
            0x2::dynamic_field::add<vector<u8>, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::EWMAState>(&mut arg0.id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::ewma_df_key(), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::init_ewma_state(arg2));
        };
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::EWMAState>(&mut arg0.id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::ewma_df_key());
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::ewma::update(v0, id<T0, T1>(arg0), arg1, arg2);
        v0
    }

    public fun update_pool_allowed_versions<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::Registry) {
        0x2::versioned::load_value_mut<PoolInner<T0, T1>>(&mut arg0.inner).allowed_versions = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::registry::allowed_versions(arg1);
    }

    public fun update_pool_referral_multiplier<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookPoolReferral, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        load_inner<T0, T1>(arg0);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::assert_referral_owner(arg1, arg3);
        assert!(arg2 <= 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::referral_max_multiplier(), 16);
        assert!(arg2 % 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::referral_multiplier() == 0, 16);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, ReferralRewards<T0, T1>>(&mut arg0.id, 0x2::object::id<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookPoolReferral>(arg1)).multiplier = arg2;
    }

    public fun update_referral_multiplier<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::DeepBookReferral, arg2: u64) {
        abort 1337
    }

    public fun vault_balances<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::balances<T0, T1>(&load_inner<T0, T1>(arg0).vault)
    }

    public fun vote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::validate_proof(arg1, arg2);
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::process_vote(&mut v0.state, v0.pool_id, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1), arg3, arg4);
    }

    public fun withdraw_settled_amounts<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager, arg2: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::TradeProof) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let (v1, v2) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::withdraw_settled_amounts(&mut v0.state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1));
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v1, v2, arg1, arg2);
    }

    public fun withdraw_settled_amounts_permissionless<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::BalanceManager) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let (v1, v2) = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::state::withdraw_settled_amounts(&mut v0.state, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::balance_manager::id(arg1));
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::vault::settle_balance_manager_permissionless<T0, T1>(&mut v0.vault, v1, v2, arg1);
    }

    // decompiled from Move bytecode v6
}

