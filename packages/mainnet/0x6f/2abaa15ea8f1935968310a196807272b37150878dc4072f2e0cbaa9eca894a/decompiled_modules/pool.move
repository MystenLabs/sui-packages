module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct PoolInner<phantom T0, phantom T1> has store {
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        pool_id: 0x2::object::ID,
        book: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::Book,
        state: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::State,
        vault: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::Vault<T0, T1>,
        deep_price: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::DeepPrice,
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

    public fun account<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account {
        *0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::account(&load_inner<T0, T1>(arg0).state, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1))
    }

    public(friend) fun asks<T0, T1>(arg0: &PoolInner<T0, T1>) : &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::BigVector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order> {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::asks(&arg0.book)
    }

    public(friend) fun bids<T0, T1>(arg0: &PoolInner<T0, T1>) : &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::BigVector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order> {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::bids(&arg0.book)
    }

    public fun cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::cancel_order(&mut v0.book, arg3);
        assert!(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::balance_manager_id(&v1) == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), 9);
        let (v2, v3) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::process_cancel(&mut v0.state, &mut v1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), arg5);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v2, v3, arg1, arg2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::emit_order_canceled(&v1, v0.pool_id, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4));
    }

    public fun get_order<T0, T1>(arg0: &Pool<T0, T1>, arg1: u128) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::get_order(&load_inner<T0, T1>(arg0).book, arg1)
    }

    public fun get_quantity_out<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = load_inner<T0, T1>(arg0);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::governance(&v0.state));
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::maker_fee(&v1);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::get_quantity_out(&v0.book, arg1, arg2, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::taker_fee(&v1), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::get_order_deep_price(&v0.deep_price, whitelisted<T0, T1>(arg0)), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::lot_size(&v0.book), 0x2::clock::timestamp_ms(arg3))
    }

    public fun mid_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::mid_price(&load_inner<T0, T1>(arg0).book, 0x2::clock::timestamp_ms(arg1))
    }

    public fun modify_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = get_order<T0, T1>(arg0, arg3);
        let v1 = load_inner_mut<T0, T1>(arg0);
        let (v2, v3) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::modify_order(&mut v1.book, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
        assert!(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::balance_manager_id(v3) == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), 9);
        let (v4, v5) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::process_modify(&mut v1.state, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), v2, v3, arg6);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::settle_balance_manager<T0, T1>(&mut v1.vault, v4, v5, arg1, arg2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::emit_order_modified(v3, v1.pool_id, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::quantity(&v0), 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg5));
    }

    public fun get_order_deep_price<T0, T1>(arg0: &Pool<T0, T1>) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::OrderDeepPrice {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::get_order_deep_price(&load_inner<T0, T1>(arg0).deep_price, whitelisted<T0, T1>(arg0))
    }

    fun set_whitelist<T0, T1>(arg0: &mut PoolInner<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::set_whitelist(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::governance_mut(&mut arg0.state, arg1), true);
    }

    public fun whitelisted<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::whitelisted(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::governance(&load_inner<T0, T1>(arg0).state))
    }

    public fun locked_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager) : (u64, u64, u64) {
        let v0 = get_account_order_details<T0, T1>(arg0, arg1);
        let v1 = load_inner<T0, T1>(arg0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = &v0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v5)) {
            let v7 = 0x1::vector::borrow<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v5, v6);
            let (v8, v9, v10) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::locked_balance(v7, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::historic_maker_fee(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::history(&v1.state), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::epoch(v7)));
            v2 = v2 + v8;
            v3 = v3 + v9;
            v4 = v4 + v10;
            v6 = v6 + 1;
        };
        let v11 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::settled_balances(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::account(&v1.state, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1)));
        (v2 + 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::base(&v11), v3 + 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::quote(&v11), v4 + 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::deep(&v11))
    }

    public fun account_open_orders<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager) : 0x2::vec_set::VecSet<u128> {
        let v0 = load_inner<T0, T1>(arg0);
        if (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::account_exists(&v0.state, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1))) {
            return 0x2::vec_set::empty<u128>()
        };
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::open_orders(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::account(&v0.state, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1)))
    }

    public fun add_deep_price_point<T0, T1, T2, T3>(arg0: &mut Pool<T0, T1>, arg1: &Pool<T2, T3>, arg2: &0x2::clock::Clock) {
        assert!(whitelisted<T2, T3>(arg1) && registered_pool<T2, T3>(arg1), 7);
        let v0 = load_inner_mut<T0, T1>(arg0);
        let v1 = 0x1::type_name::get<T2>();
        let v2 = 0x1::type_name::get<T3>();
        let v3 = 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        let v4 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 == v3 || v2 == v3, 10);
        let v5 = v1 == v3;
        let v6 = if (v5) {
            v2
        } else {
            v1
        };
        let v7 = v6 == 0x1::type_name::get<T0>();
        assert!(v7 || v6 == 0x1::type_name::get<T1>(), 10);
        let v8 = if (v5) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::div(1000000000, mid_price<T2, T3>(arg1, arg2))
        } else {
            mid_price<T2, T3>(arg1, arg2)
        };
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::add_price_point(&mut v0.deep_price, v8, v4, v7);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::emit_deep_price_added(v8, v4, v7, load_inner<T2, T3>(arg1).pool_id, v0.pool_id);
    }

    public fun borrow_flashloan_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::FlashLoan) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::borrow_flashloan_base<T0, T1>(&mut v0.vault, v0.pool_id, arg1, arg2)
    }

    public fun borrow_flashloan_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::FlashLoan) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::borrow_flashloan_quote<T0, T1>(&mut v0.vault, v0.pool_id, arg1, arg2)
    }

    public fun burn_deep<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::ProtectedTreasury, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::reset_balance_to_burn(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::history_mut(&mut v0.state));
        assert!(v1 > 0, 11);
        let v2 = 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::withdraw_deep_to_burn<T0, T1>(&mut v0.vault, v1), arg2);
        0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::burn(arg1, v2);
        0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v2)
    }

    public fun cancel_all_orders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let v1 = vector[];
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::account_exists(&v0.state, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1))) {
            v1 = 0x2::vec_set::into_keys<u128>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::open_orders(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::account(&v0.state, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1))));
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&v1)) {
            cancel_order<T0, T1>(arg0, arg1, arg2, *0x1::vector::borrow<u128>(&v1, v2), arg3, arg4);
            v2 = v2 + 1;
        };
    }

    public fun cancel_orders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg3)) {
            cancel_order<T0, T1>(arg0, arg1, arg2, *0x1::vector::borrow<u128>(&arg3, v0), arg4, arg5);
            v0 = v0 + 1;
        };
    }

    public fun claim_rebates<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let (v1, v2) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::process_claim_rebates(&mut v0.state, v0.pool_id, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), arg3);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v1, v2, arg1, arg2);
    }

    public(friend) fun create_pool<T0, T1>(arg0: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::Registry, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4) == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::pool_creation_fee(), 1);
        assert!(arg1 > 0, 3);
        assert!(arg2 > 0, 4);
        assert!(arg3 > 0, 5);
        assert!(arg3 % arg2 == 0, 5);
        let v0 = arg5 && arg6;
        assert!(!v0, 16);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 2);
        let v1 = 0x2::object::new(arg7);
        let v2 = PoolInner<T0, T1>{
            allowed_versions : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::allowed_versions(arg0),
            pool_id          : 0x2::object::uid_to_inner(&v1),
            book             : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::empty(arg1, arg2, arg3, arg7),
            state            : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::empty(arg6, arg7),
            vault            : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::empty<T0, T1>(),
            deep_price       : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::empty(),
            registered_pool  : true,
        };
        if (arg5) {
            let v3 = &mut v2;
            set_whitelist<T0, T1>(v3, arg7);
        };
        let v4 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::governance(&v2.state));
        let v5 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::treasury_address(arg0);
        let v6 = Pool<T0, T1>{
            id    : v1,
            inner : 0x2::versioned::create<PoolInner<T0, T1>>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::current_version(), v2, arg7),
        };
        let v7 = 0x2::object::id<Pool<T0, T1>>(&v6);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::register_pool<T0, T1>(arg0, v7);
        let v8 = PoolCreated<T0, T1>{
            pool_id          : v7,
            taker_fee        : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::taker_fee(&v4),
            maker_fee        : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::maker_fee(&v4),
            tick_size        : arg1,
            lot_size         : arg2,
            min_size         : arg3,
            whitelisted_pool : arg5,
            treasury_address : v5,
        };
        0x2::event::emit<PoolCreated<T0, T1>>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg4, v5);
        0x2::transfer::share_object<Pool<T0, T1>>(v6);
        v7
    }

    public fun create_pool_admin<T0, T1>(arg0: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::Registry, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::DeepbookAdminCap, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7);
        create_pool<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, arg5, arg7)
    }

    public fun get_account_order_details<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager) : vector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order> {
        get_orders<T0, T1>(arg0, 0x2::vec_set::into_keys<u128>(account_open_orders<T0, T1>(arg0, arg1)))
    }

    public fun get_base_quantity_out<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        get_quantity_out<T0, T1>(arg0, 0, arg1, arg2)
    }

    public fun get_level2_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : (vector<u64>, vector<u64>) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::get_level2_range_and_ticks(&load_inner<T0, T1>(arg0).book, arg1, arg2, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_u64(), arg3, 0x2::clock::timestamp_ms(arg4))
    }

    public fun get_level2_ticks_from_mid<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        let v0 = load_inner<T0, T1>(arg0);
        let (v1, v2) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::get_level2_range_and_ticks(&v0.book, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::min_price(), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_price(), arg1, true, 0x2::clock::timestamp_ms(arg2));
        let (v3, v4) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::get_level2_range_and_ticks(&v0.book, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::min_price(), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_price(), arg1, false, 0x2::clock::timestamp_ms(arg2));
        (v1, v2, v3, v4)
    }

    public fun get_order_deep_required<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = get_order_deep_price<T0, T1>(arg0);
        let v1 = load_inner<T0, T1>(arg0);
        let v2 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::governance(&v1.state));
        let v3 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::governance(&v1.state));
        let v4 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::deep_quantity(&v0, arg1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(arg1, arg2));
        (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::taker_fee(&v3), v4), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::maker_fee(&v2), v4))
    }

    public fun get_orders<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u128>) : vector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order> {
        let v0 = 0x1::vector::empty<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg1)) {
            0x1::vector::push_back<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&mut v0, get_order<T0, T1>(arg0, *0x1::vector::borrow<u128>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_pool_id_by_asset<T0, T1>(arg0: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::Registry) : 0x2::object::ID {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::get_pool_id<T0, T1>(arg0)
    }

    public fun get_quote_quantity_out<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        get_quantity_out<T0, T1>(arg0, arg1, 0, arg2)
    }

    public(friend) fun load_inner<T0, T1>(arg0: &Pool<T0, T1>) : &PoolInner<T0, T1> {
        let v0 = 0x2::versioned::load_value<PoolInner<T0, T1>>(&arg0.inner);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 12);
        v0
    }

    public(friend) fun load_inner_mut<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut PoolInner<T0, T1> {
        let v0 = 0x2::versioned::load_value_mut<PoolInner<T0, T1>>(&mut arg0.inner);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 12);
        v0
    }

    public fun place_limit_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::OrderInfo {
        place_order_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, false, arg12)
    }

    public fun place_market_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::OrderInfo {
        let v0 = if (arg6) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_price()
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::min_price()
        };
        place_order_int<T0, T1>(arg0, arg1, arg2, arg3, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::immediate_or_cancel(), arg4, v0, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8), arg8, true, arg9)
    }

    fun place_order_int<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: bool, arg13: &0x2::tx_context::TxContext) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::OrderInfo {
        let v0 = whitelisted<T0, T1>(arg0);
        assert!(arg9 || v0, 8);
        let v1 = load_inner_mut<T0, T1>(arg0);
        let v2 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::new(v1.pool_id, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), arg3, 0x2::tx_context::sender(arg13), arg4, arg5, arg6, arg7, arg8, arg9, 0x2::tx_context::epoch(arg13), arg10, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::get_order_deep_price(&v1.deep_price, v0), arg12, 0x2::clock::timestamp_ms(arg11));
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::create_order(&mut v1.book, &mut v2, 0x2::clock::timestamp_ms(arg11));
        let (v3, v4) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::process_create(&mut v1.state, &mut v2, arg13);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::settle_balance_manager<T0, T1>(&mut v1.vault, v3, v4, arg1, arg2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::emit_order_info(&v2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::emit_orders_filled(&v2, 0x2::clock::timestamp_ms(arg11));
        v2
    }

    public fun pool_book_params<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = load_inner<T0, T1>(arg0);
        (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::tick_size(&v0.book), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::lot_size(&v0.book), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::min_size(&v0.book))
    }

    public fun pool_trade_params<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = load_inner<T0, T1>(arg0);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::governance(&v0.state));
        let v2 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::governance(&v0.state));
        let v3 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::governance(&v0.state));
        (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::taker_fee(&v1), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::maker_fee(&v2), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::stake_required(&v3))
    }

    public fun registered_pool<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        load_inner<T0, T1>(arg0).registered_pool
    }

    public fun return_flashloan_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::FlashLoan) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::return_flashloan_base<T0, T1>(&mut v0.vault, v0.pool_id, arg1, arg2);
    }

    public fun return_flashloan_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::FlashLoan) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::return_flashloan_quote<T0, T1>(&mut v0.vault, v0.pool_id, arg1, arg2);
    }

    public fun stake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 14);
        let v0 = load_inner_mut<T0, T1>(arg0);
        let (v1, v2) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::process_stake(&mut v0.state, v0.pool_id, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), arg3, arg4);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v1, v2, arg1, arg2);
    }

    public fun submit_proposal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::validate_proof(arg1, arg2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::process_proposal(&mut v0.state, v0.pool_id, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), arg3, arg4, arg5, arg6);
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::zero<T1>(arg5);
        swap_exact_quantity<T0, T1>(arg0, arg1, v0, arg2, arg3, arg4, arg5)
    }

    public fun swap_exact_quantity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = v0;
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 != v2 > 0, 6);
        let v3 = v2 > 0;
        if (v3) {
            let (v4, _, _) = get_quantity_out<T0, T1>(arg0, 0, v2, arg5);
            v1 = v4;
        };
        let v7 = v1 - v1 % 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::lot_size(&load_inner<T0, T1>(arg0).book);
        if (v7 < 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book::min_size(&load_inner<T0, T1>(arg0).book)) {
            return (arg1, arg2, arg3)
        };
        let v8 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::new(arg6);
        let v9 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::generate_proof_as_owner(&mut v8, arg6);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::deposit<T0>(&mut v8, arg1, arg6);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::deposit<T1>(&mut v8, arg2, arg6);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v8, arg3, arg6);
        let v10 = &mut v8;
        place_market_order<T0, T1>(arg0, v10, &v9, 0, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::self_matching_allowed(), v7, v3, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3) > 0, arg5, arg6);
        let v11 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::withdraw_all<T0>(&mut v8, arg6);
        let v12 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::withdraw_all<T1>(&mut v8, arg6);
        if (v3) {
            assert!(0x2::coin::value<T0>(&v11) >= arg4, 13);
        } else {
            assert!(0x2::coin::value<T1>(&v12) >= arg4, 13);
        };
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::delete(v8);
        (v11, v12, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v8, arg6))
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::zero<T0>(arg5);
        swap_exact_quantity<T0, T1>(arg0, v0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun unregister_pool_admin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::Registry, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::DeepbookAdminCap) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        assert!(v0.registered_pool, 15);
        v0.registered_pool = false;
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::unregister_pool<T0, T1>(arg1);
    }

    public fun unstake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let (v1, v2) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::process_unstake(&mut v0.state, v0.pool_id, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), arg3);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v1, v2, arg1, arg2);
    }

    public fun update_allowed_versions<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::Registry, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::DeepbookAdminCap) {
        0x2::versioned::load_value_mut<PoolInner<T0, T1>>(&mut arg0.inner).allowed_versions = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::registry::allowed_versions(arg1);
    }

    public fun vault_balances<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::balances<T0, T1>(&load_inner<T0, T1>(arg0).vault)
    }

    public fun vote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::validate_proof(arg1, arg2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::process_vote(&mut v0.state, v0.pool_id, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1), arg3, arg4);
    }

    public fun withdraw_settled_amounts<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::BalanceManager, arg2: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::TradeProof) {
        let v0 = load_inner_mut<T0, T1>(arg0);
        let (v1, v2) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state::withdraw_settled_amounts(&mut v0.state, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balance_manager::id(arg1));
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::vault::settle_balance_manager<T0, T1>(&mut v0.vault, v1, v2, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

