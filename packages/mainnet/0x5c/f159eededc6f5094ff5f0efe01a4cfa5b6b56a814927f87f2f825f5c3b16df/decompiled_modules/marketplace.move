module 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::marketplace {
    struct Marketplace has key {
        id: 0x2::object::UID,
        has_paused: bool,
        user_balances: 0x2::bag::Bag,
        markets: 0x2::bag::Bag,
        order_count: u64,
        deposit_cap: 0x1::option::Option<u64>,
    }

    struct QuoteMarket<phantom T0> has store {
        id: 0x2::object::UID,
        token_name: 0x1::string::String,
        orders: 0x2::bag::Bag,
    }

    struct Orders<phantom T0, phantom T1> has store {
        token_name: 0x1::string::String,
        bid_orders: vector<Order<T1>>,
        ask_orders: vector<Order<T0>>,
    }

    struct Order<phantom T0> has store {
        order_id: u64,
        created_epoch: u64,
        balance: 0x2::balance::Balance<T0>,
        unit_price: u64,
        owner: address,
    }

    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    fun add_ask_order<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        arg0.order_count = arg0.order_count + 1;
        let v1 = arg0.order_count;
        let v2 = Order<T0>{
            order_id      : v1,
            created_epoch : 0x2::tx_context::epoch(arg3),
            balance       : 0x2::coin::into_balance<T0>(arg1),
            unit_price    : arg2,
            owner         : v0,
        };
        let v3 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>();
        let v4 = 0x2::bag::borrow_mut<0x1::string::String, QuoteMarket<T1>>(&mut arg0.markets, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>());
        if (!0x2::bag::contains_with_type<0x1::string::String, Orders<T0, T1>>(&v4.orders, v3)) {
            let v5 = 0x1::vector::empty<Order<T0>>();
            0x1::vector::push_back<Order<T0>>(&mut v5, v2);
            let v6 = Orders<T0, T1>{
                token_name : v3,
                bid_orders : 0x1::vector::empty<Order<T1>>(),
                ask_orders : v5,
            };
            0x2::bag::add<0x1::string::String, Orders<T0, T1>>(&mut v4.orders, v3, v6);
        } else {
            0x1::vector::push_back<Order<T0>>(&mut 0x2::bag::borrow_mut<0x1::string::String, Orders<T0, T1>>(&mut v4.orders, v3).ask_orders, v2);
        };
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::new_order_event(0x2::object::id<Marketplace>(arg0), v1, false, v3, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>(), 0x2::coin::value<T0>(&arg1), arg2, v0);
    }

    fun add_bid_order<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        arg0.order_count = arg0.order_count + 1;
        let v1 = arg0.order_count;
        let v2 = Order<T0>{
            order_id      : v1,
            created_epoch : 0x2::tx_context::epoch(arg3),
            balance       : 0x2::coin::into_balance<T0>(arg1),
            unit_price    : arg2,
            owner         : v0,
        };
        let v3 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>();
        let v4 = 0x2::bag::borrow_mut<0x1::string::String, QuoteMarket<T0>>(&mut arg0.markets, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>());
        if (!0x2::bag::contains_with_type<0x1::string::String, Orders<T1, T0>>(&v4.orders, v3)) {
            let v5 = 0x1::vector::empty<Order<T0>>();
            0x1::vector::push_back<Order<T0>>(&mut v5, v2);
            let v6 = Orders<T1, T0>{
                token_name : v3,
                bid_orders : v5,
                ask_orders : 0x1::vector::empty<Order<T1>>(),
            };
            0x2::bag::add<0x1::string::String, Orders<T1, T0>>(&mut v4.orders, v3, v6);
        } else {
            0x1::vector::push_back<Order<T0>>(&mut 0x2::bag::borrow_mut<0x1::string::String, Orders<T1, T0>>(&mut v4.orders, v3).bid_orders, v2);
        };
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::new_order_event(0x2::object::id<Marketplace>(arg0), v1, true, v3, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>(), 0x2::coin::value<T0>(&arg1), arg2, v0);
    }

    public fun buy<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        matching_ask_orders<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun buy_and_listing<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        check_quote<T0>(arg0);
        let (v0, v1) = matching_ask_orders<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
        if (0x1::option::is_some<u64>(&arg0.deposit_cap)) {
            assert!(*0x1::option::borrow<u64>(&arg0.deposit_cap) >= 0x2::coin::value<T0>(&v3), 309);
            *0x1::option::borrow_mut<u64>(&mut arg0.deposit_cap) = *0x1::option::borrow<u64>(&arg0.deposit_cap) - 0x2::coin::value<T0>(&v3);
        };
        add_bid_order<T0, T1>(arg0, v3, arg2, arg3);
    }

    public entry fun buy_only<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        check_quote<T0>(arg0);
        let (v0, v1) = matching_ask_orders<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public entry fun cancel_order<T0, T1>(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_quote<T1>(arg0);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, QuoteMarket<T1>>(&mut arg0.markets, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>());
        assert!(0x2::bag::contains_with_type<0x1::string::String, Orders<T0, T1>>(&v0.orders, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>()), 307);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, Orders<T0, T1>>(&mut v0.orders, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>());
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<Order<T0>>(&v1.ask_orders)) {
            let v4 = 0x1::vector::borrow<Order<T0>>(&v1.ask_orders, v2);
            if (v4.order_id == arg1) {
                assert!(v4.owner == 0x2::tx_context::sender(arg2), 303);
                let Order {
                    order_id      : _,
                    created_epoch : _,
                    balance       : v7,
                    unit_price    : _,
                    owner         : _,
                } = 0x1::vector::swap_remove<Order<T0>>(&mut v1.ask_orders, v2);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg2), 0x2::tx_context::sender(arg2));
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 0x1::vector::length<Order<T1>>(&v1.bid_orders)) {
            let v10 = 0x1::vector::borrow<Order<T1>>(&v1.bid_orders, v2);
            if (v10.order_id == arg1) {
                assert!(v10.owner == 0x2::tx_context::sender(arg2), 303);
                let Order {
                    order_id      : _,
                    created_epoch : _,
                    balance       : v13,
                    unit_price    : _,
                    owner         : _,
                } = 0x1::vector::swap_remove<Order<T1>>(&mut v1.bid_orders, v2);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg2), 0x2::tx_context::sender(arg2));
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 307);
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::remove_order_event(0x2::object::id<Marketplace>(arg0), arg1, 0x2::tx_context::sender(arg2));
    }

    fun check_pause(arg0: &Marketplace) {
        assert!(!arg0.has_paused, 308);
    }

    public fun check_quote<T0>(arg0: &Marketplace) {
        assert!(0x2::bag::contains_with_type<0x1::string::String, QuoteMarket<T0>>(&arg0.markets, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>()), 306);
    }

    fun eligible_orders<T0>(arg0: &vector<Order<T0>>, arg1: u64, arg2: bool) : vector<u64> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 < 0x1::vector::length<Order<T0>>(arg0)) {
            if (!arg2) {
                if (arg1 >= 0x1::vector::borrow<Order<T0>>(arg0, v0).unit_price) {
                    0x1::vector::push_back<u64>(&mut v1, v0);
                };
            } else if (0x1::vector::borrow<Order<T0>>(arg0, v0).unit_price >= arg1) {
                0x1::vector::push_back<u64>(&mut v1, v0);
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Marketplace{
            id            : 0x2::object::new(arg0),
            has_paused    : false,
            user_balances : 0x2::bag::new(arg0),
            markets       : 0x2::bag::new(arg0),
            order_count   : 0,
            deposit_cap   : 0x1::option::none<u64>(),
        };
        0x2::transfer::share_object<Marketplace>(v1);
    }

    fun matching_ask_orders<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::object::id<Marketplace>(arg0);
        let v1 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>();
        let v2 = 0x2::bag::borrow_mut<0x1::string::String, QuoteMarket<T0>>(&mut arg0.markets, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>());
        if (!0x2::bag::contains_with_type<0x1::string::String, Orders<T1, T0>>(&v2.orders, v1)) {
            let v3 = Orders<T1, T0>{
                token_name : v1,
                bid_orders : 0x1::vector::empty<Order<T0>>(),
                ask_orders : 0x1::vector::empty<Order<T1>>(),
            };
            0x2::bag::add<0x1::string::String, Orders<T1, T0>>(&mut v2.orders, v1, v3);
        };
        let v4 = 0x2::bag::borrow_mut<0x1::string::String, Orders<T1, T0>>(&mut v2.orders, v1);
        let v5 = 0x2::coin::into_balance<T0>(arg1);
        let v6 = 0x2::balance::zero<T1>();
        let v7 = 0;
        let v8 = 0;
        if (0x1::vector::length<Order<T1>>(&v4.ask_orders) > 0) {
            let v9 = &mut v4.ask_orders;
            sort_orders<T1>(v9);
            let v10 = eligible_orders<T1>(&v4.ask_orders, arg2, false);
            let v11 = order_unit_prices<T1>(&v4.ask_orders);
            let v12 = order_balances<T1>(&v4.ask_orders);
            while (0x1::vector::length<u64>(&v10) > 0) {
                let v13 = 0x1::vector::remove<u64>(&mut v10, 0);
                let v14 = *0x1::vector::borrow<u64>(&v11, v13);
                let v15 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(*0x1::vector::borrow<u64>(&v12, v13), v14, 1000000000);
                if (0x2::balance::value<T0>(&v5) >= v15) {
                    let Order {
                        order_id      : v16,
                        created_epoch : _,
                        balance       : v18,
                        unit_price    : _,
                        owner         : v20,
                    } = 0x1::vector::swap_remove<Order<T1>>(&mut v4.ask_orders, v13);
                    let v21 = v18;
                    let v22 = if (0x2::balance::value<T0>(&v5) >= v15) {
                        v15
                    } else {
                        0x2::balance::value<T0>(&v5)
                    };
                    v7 = v7 + v22;
                    v8 = v8 + 0x2::balance::value<T1>(&v21);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v22), arg3), v20);
                    0x2::balance::join<T1>(&mut v6, v21);
                    0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::remove_order_event(v0, v16, v20);
                } else {
                    let v23 = 0x2::balance::value<T0>(&v5);
                    let v24 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(v23, 1000000000, v14);
                    let v25 = 0x1::vector::borrow_mut<Order<T1>>(&mut v4.ask_orders, v13);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v23), arg3), v25.owner);
                    let v26 = if (0x2::balance::value<T1>(&v25.balance) >= v24) {
                        v24
                    } else {
                        0x2::balance::value<T1>(&v25.balance)
                    };
                    v7 = v7 + v23;
                    v8 = v8 + v26;
                    0x2::balance::join<T1>(&mut v6, 0x2::balance::split<T1>(&mut v25.balance, v26));
                };
                if (0x2::balance::value<T0>(&v5) == 0) {
                    break
                };
            };
        };
        if (v8 > 0) {
            0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::trade_event(v0, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>(), 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>(), v7, v8, 0x2::tx_context::sender(arg3));
        };
        (0x2::coin::from_balance<T0>(v5, arg3), 0x2::coin::from_balance<T1>(v6, arg3))
    }

    fun matching_bid_orders<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::object::id<Marketplace>(arg0);
        let v1 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>();
        let v2 = 0x2::bag::borrow_mut<0x1::string::String, QuoteMarket<T1>>(&mut arg0.markets, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>());
        if (!0x2::bag::contains_with_type<0x1::string::String, Orders<T0, T1>>(&v2.orders, v1)) {
            let v3 = Orders<T0, T1>{
                token_name : v1,
                bid_orders : 0x1::vector::empty<Order<T1>>(),
                ask_orders : 0x1::vector::empty<Order<T0>>(),
            };
            0x2::bag::add<0x1::string::String, Orders<T0, T1>>(&mut v2.orders, v1, v3);
        };
        let v4 = 0x2::bag::borrow_mut<0x1::string::String, Orders<T0, T1>>(&mut v2.orders, v1);
        let v5 = 0x2::coin::into_balance<T0>(arg1);
        let v6 = 0x2::balance::zero<T1>();
        let v7 = 0;
        let v8 = 0;
        if (0x1::vector::length<Order<T1>>(&v4.bid_orders) > 0) {
            let v9 = &mut v4.bid_orders;
            sort_orders<T1>(v9);
            let v10 = eligible_orders<T1>(&v4.bid_orders, arg2, true);
            let v11 = order_unit_prices<T1>(&v4.bid_orders);
            let v12 = order_balances<T1>(&v4.bid_orders);
            while (0x1::vector::length<u64>(&v10) > 0) {
                let v13 = 0x1::vector::remove<u64>(&mut v10, 0);
                let v14 = *0x1::vector::borrow<u64>(&v12, v13);
                let v15 = *0x1::vector::borrow<u64>(&v11, v13);
                let v16 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(0x2::balance::value<T0>(&v5), v15, 1000000000);
                if (v16 >= v14) {
                    let Order {
                        order_id      : v17,
                        created_epoch : _,
                        balance       : v19,
                        unit_price    : _,
                        owner         : v21,
                    } = 0x1::vector::swap_remove<Order<T1>>(&mut v4.bid_orders, v13);
                    let v22 = v19;
                    let v23 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(v14, 1000000000, v15);
                    let v24 = if (0x2::balance::value<T0>(&v5) >= v23) {
                        v23
                    } else {
                        0x2::balance::value<T0>(&v5)
                    };
                    v7 = v7 + v24;
                    v8 = v8 + 0x2::balance::value<T1>(&v22);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v24), arg3), v21);
                    0x2::balance::join<T1>(&mut v6, v22);
                    0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::remove_order_event(v0, v17, v21);
                } else {
                    let v25 = 0x1::vector::borrow_mut<Order<T1>>(&mut v4.bid_orders, v13);
                    let v26 = 0x2::balance::value<T0>(&v5);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v26), arg3), v25.owner);
                    let v27 = if (0x2::balance::value<T1>(&v25.balance) >= v16) {
                        v16
                    } else {
                        0x2::balance::value<T1>(&v25.balance)
                    };
                    v7 = v7 + v26;
                    v8 = v8 + v27;
                    0x2::balance::join<T1>(&mut v6, 0x2::balance::split<T1>(&mut v25.balance, v27));
                };
                if (0x2::balance::value<T0>(&v5) == 0) {
                    break
                };
            };
        };
        if (v8 > 0) {
            0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::trade_event(v0, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>(), 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>(), v7, v8, 0x2::tx_context::sender(arg3));
        };
        (0x2::coin::from_balance<T0>(v5, arg3), 0x2::coin::from_balance<T1>(v6, arg3))
    }

    public fun order_balance<T0>(arg0: &vector<Order<T0>>, arg1: u64) : u64 {
        0x2::balance::value<T0>(&0x1::vector::borrow<Order<T0>>(arg0, arg1).balance)
    }

    fun order_balances<T0>(arg0: &vector<Order<T0>>) : vector<u64> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 < 0x1::vector::length<Order<T0>>(arg0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<T0>(&0x1::vector::borrow<Order<T0>>(arg0, v0).balance));
            v0 = v0 + 1;
        };
        v1
    }

    public fun order_unit_price<T0>(arg0: &vector<Order<T0>>, arg1: u64) : u64 {
        0x1::vector::borrow<Order<T0>>(arg0, arg1).unit_price
    }

    fun order_unit_prices<T0>(arg0: &vector<Order<T0>>) : vector<u64> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 < 0x1::vector::length<Order<T0>>(arg0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<Order<T0>>(arg0, v0).unit_price);
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun pause(arg0: &mut Marketplace, arg1: &mut ManagerCap) {
        arg0.has_paused = true;
    }

    public fun sell<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        matching_bid_orders<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun sell_and_listing<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        check_quote<T1>(arg0);
        let (v0, v1) = matching_bid_orders<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
        if (0x1::option::is_some<u64>(&arg0.deposit_cap)) {
            assert!(*0x1::option::borrow<u64>(&arg0.deposit_cap) >= 0x2::coin::value<T0>(&v3), 309);
            *0x1::option::borrow_mut<u64>(&mut arg0.deposit_cap) = *0x1::option::borrow<u64>(&arg0.deposit_cap) - 0x2::coin::value<T0>(&v3);
        };
        add_ask_order<T0, T1>(arg0, v3, arg2, arg3);
    }

    public entry fun sell_only<T0, T1>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        check_quote<T1>(arg0);
        let (v0, v1) = matching_bid_orders<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public entry fun set_deposit_cap(arg0: &mut Marketplace, arg1: &mut ManagerCap, arg2: u64) {
        if (arg2 == 0) {
            arg0.deposit_cap = 0x1::option::none<u64>();
        } else {
            arg0.deposit_cap = 0x1::option::some<u64>(arg2);
        };
    }

    public entry fun setup_quote<T0>(arg0: &mut Marketplace, arg1: &mut ManagerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, QuoteMarket<T0>>(&arg0.markets, v0), 301);
        let v1 = QuoteMarket<T0>{
            id         : 0x2::object::new(arg2),
            token_name : v0,
            orders     : 0x2::bag::new(arg2),
        };
        0x2::bag::add<0x1::string::String, QuoteMarket<T0>>(&mut arg0.markets, v0, v1);
    }

    fun sort_orders<T0>(arg0: &mut vector<Order<T0>>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<Order<T0>>(arg0)) {
            let v1 = v0;
            while (v1 > 0) {
                v1 = v1 - 1;
                if (0x1::vector::borrow<Order<T0>>(arg0, v1).unit_price > 0x1::vector::borrow<Order<T0>>(arg0, v0).unit_price) {
                    0x1::vector::swap<Order<T0>>(arg0, v1, v1 + 1);
                } else {
                    break
                };
            };
            v0 = v0 + 1;
        };
    }

    public entry fun unpause(arg0: &mut Marketplace, arg1: &mut ManagerCap) {
        arg0.has_paused = false;
    }

    public entry fun update_order<T0, T1>(arg0: &mut Marketplace, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_quote<T1>(arg0);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, QuoteMarket<T1>>(&mut arg0.markets, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T1>());
        assert!(0x2::bag::contains_with_type<0x1::string::String, Orders<T0, T1>>(&v0.orders, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>()), 307);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, Orders<T0, T1>>(&mut v0.orders, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib::token_to_name<T0>());
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<Order<T0>>(&v1.ask_orders)) {
            let v4 = 0x1::vector::borrow_mut<Order<T0>>(&mut v1.ask_orders, v2);
            if (v4.order_id == arg1) {
                assert!(v4.owner == 0x2::tx_context::sender(arg3), 303);
                v4.unit_price = arg2;
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 0x1::vector::length<Order<T1>>(&v1.bid_orders)) {
            let v5 = 0x1::vector::borrow_mut<Order<T1>>(&mut v1.bid_orders, v2);
            if (v5.order_id == arg1) {
                assert!(v5.owner == 0x2::tx_context::sender(arg3), 303);
                v5.unit_price = arg2;
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 307);
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::update_order_event(0x2::object::id<Marketplace>(arg0), arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

