module 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::suimarket {
    struct EventCreated has copy, drop, store {
        event_id: 0x2::object::ID,
        client_event_id: u64,
        base_asset: 0x1::type_name::TypeName,
        token_per_share: u64,
        end_date: u64,
    }

    struct EventMarketCreated has copy, drop, store {
        event_market_id: 0x2::object::ID,
        client_event_market_id: u64,
    }

    struct OrderPlaced has copy, drop, store {
        event_market_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        is_yes: bool,
        owner: address,
        original_quantity: u64,
        quantity_placed: u64,
        price: u64,
    }

    struct OrderFilled has copy, drop, store {
        event_market_id: 0x2::object::ID,
        order_id: u64,
        taker_address: address,
        maker_address: address,
        quantity_filled: u64,
        quantity_remain: u64,
        price: u64,
        is_yes: bool,
        is_opposite: bool,
    }

    struct OrderCanceled has copy, drop, store {
        event_market_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        is_yes: bool,
        owner: address,
        original_quantity: u64,
        quantity_canceled: u64,
        price: u64,
    }

    struct ShareBalanceChanged has copy, drop, store {
        event_market_id: 0x2::object::ID,
        owner: address,
        yes_balance: u64,
        no_balance: u64,
        balance_id: u64,
    }

    struct SuiMarket has store, key {
        id: 0x2::object::UID,
        admin: address,
        resolver: address,
        version: u64,
        withdraw_fee: u64,
        market_fee: u64,
        next_bid_yes_order_id: u64,
        next_bid_no_order_id: u64,
        next_ask_yes_order_id: u64,
        next_ask_no_order_id: u64,
        next_balance_id: u64,
    }

    struct Order has drop, store {
        order_id: u64,
        owner: address,
        price: u64,
        original_quantity: u64,
        quantity: u64,
        is_bid: bool,
        is_yes: bool,
    }

    struct TickLevel has store {
        price: u64,
        open_orders: 0x2::linked_table::LinkedTable<u64, Order>,
    }

    struct Event<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        resolver: address,
        name: 0x1::string::String,
        end_date: u64,
        event_market_win: 0x1::option::Option<0x2::object::ID>,
        total_base_coin: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T0>,
        is_yes: 0x1::option::Option<bool>,
        token_per_share: u64,
    }

    struct EventMarket<phantom T0> has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        yes_bids: 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::CritbitTree<TickLevel>,
        yes_asks: 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::CritbitTree<TickLevel>,
        no_bids: 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::CritbitTree<TickLevel>,
        no_asks: 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::CritbitTree<TickLevel>,
        usr_open_orders: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, u64>>,
        is_yes: 0x1::option::Option<bool>,
    }

    struct ShareBalance has drop, store {
        balance_id: u64,
        owner: address,
        yes_balance: u64,
        no_balance: u64,
    }

    public entry fun cancel_order<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: &mut EventMarket<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.version == 1, 10);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg2.usr_open_orders, v0), 8);
        let v1 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg2.usr_open_orders, v0);
        assert!(0x2::linked_table::contains<u64, u64>(v1, arg3), 12);
        let (v2, v3) = order_is_bid_yes(arg3);
        let v4 = if (v2) {
            if (v3) {
                &arg2.yes_bids
            } else {
                &arg2.no_bids
            }
        } else if (v3) {
            &arg2.yes_asks
        } else {
            &arg2.no_asks
        };
        let (v5, v6) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::find_leaf<TickLevel>(v4, *0x2::linked_table::borrow<u64, u64>(v1, arg3));
        assert!(v5, 13);
        let v7 = if (v2) {
            if (v3) {
                &mut arg2.yes_bids
            } else {
                &mut arg2.no_bids
            }
        } else if (v3) {
            &mut arg2.yes_asks
        } else {
            &mut arg2.no_asks
        };
        let v8 = remove_order(v7, v1, v6, arg3, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.total_base_coin, v8.quantity * v8.price * arg1.token_per_share / 1000, arg4), v0);
        let v9 = OrderCanceled{
            event_market_id   : *0x2::object::uid_as_inner(&arg2.id),
            order_id          : arg3,
            is_bid            : v2,
            is_yes            : v3,
            owner             : v0,
            original_quantity : v8.original_quantity,
            quantity_canceled : v8.quantity,
            price             : v8.price,
        };
        0x2::event::emit<OrderCanceled>(v9);
    }

    public entry fun create_event<T0>(arg0: &mut SuiMarket, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        let v0 = Event<T0>{
            id               : 0x2::object::new(arg5),
            admin            : arg0.admin,
            resolver         : arg0.resolver,
            name             : arg1,
            end_date         : arg2,
            event_market_win : 0x1::option::none<0x2::object::ID>(),
            total_base_coin  : 0x2::balance::zero<T0>(),
            fee              : 0x2::balance::zero<T0>(),
            is_yes           : 0x1::option::none<bool>(),
            token_per_share  : arg3,
        };
        let v1 = EventCreated{
            event_id        : 0x2::object::id<Event<T0>>(&v0),
            client_event_id : arg4,
            base_asset      : 0x1::type_name::get<T0>(),
            token_per_share : arg3,
            end_date        : arg2,
        };
        0x2::event::emit<EventCreated>(v1);
        0x2::transfer::share_object<Event<T0>>(v0);
    }

    public entry fun create_event_market<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        let v0 = EventMarket<T0>{
            id              : 0x2::object::new(arg4),
            event_id        : 0x2::object::id<Event<T0>>(arg1),
            name            : arg2,
            yes_bids        : 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::new<TickLevel>(arg4),
            yes_asks        : 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::new<TickLevel>(arg4),
            no_bids         : 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::new<TickLevel>(arg4),
            no_asks         : 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::new<TickLevel>(arg4),
            usr_open_orders : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, u64>>(arg4),
            is_yes          : 0x1::option::none<bool>(),
        };
        let v1 = EventMarketCreated{
            event_market_id        : 0x2::object::id<EventMarket<T0>>(&v0),
            client_event_market_id : arg3,
        };
        0x2::event::emit<EventMarketCreated>(v1);
        0x2::transfer::share_object<EventMarket<T0>>(v0);
    }

    fun decrease_user_balance(arg0: &mut SuiMarket, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64, arg4: bool) {
        if (!0x2::dynamic_field::exists_<address>(arg1, arg2)) {
            let v0 = ShareBalance{
                balance_id  : arg0.next_balance_id,
                owner       : arg2,
                yes_balance : 0,
                no_balance  : 0,
            };
            0x2::dynamic_field::add<address, ShareBalance>(arg1, arg2, v0);
            arg0.next_balance_id = arg0.next_balance_id + 1;
        };
        let v1 = 0x2::dynamic_field::borrow_mut<address, ShareBalance>(arg1, arg2);
        if (arg4) {
            v1.yes_balance = v1.yes_balance - arg3;
        } else {
            v1.no_balance = v1.no_balance - arg3;
        };
        let v2 = ShareBalanceChanged{
            event_market_id : *0x2::object::uid_as_inner(arg1),
            owner           : arg2,
            yes_balance     : v1.yes_balance,
            no_balance      : v1.no_balance,
            balance_id      : v1.balance_id,
        };
        0x2::event::emit<ShareBalanceChanged>(v2);
    }

    fun destroy_empty_level(arg0: TickLevel) {
        let TickLevel {
            price       : _,
            open_orders : v1,
        } = arg0;
        0x2::linked_table::destroy_empty<u64, Order>(v1);
    }

    public entry fun end_event<T0>(arg0: &mut Event<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.resolver, 0);
        arg0.event_market_win = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.is_yes = 0x1::option::some<bool>(arg2);
    }

    public entry fun end_event_market<T0>(arg0: &Event<T0>, arg1: &mut EventMarket<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.resolver, 0);
        assert!(arg1.event_id == 0x2::object::id<Event<T0>>(arg0), 0);
        arg1.is_yes = 0x1::option::some<bool>(arg2);
    }

    fun increase_user_balance(arg0: &mut SuiMarket, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64, arg4: bool) {
        if (!0x2::dynamic_field::exists_<address>(arg1, arg2)) {
            let v0 = ShareBalance{
                balance_id  : arg0.next_balance_id,
                owner       : arg2,
                yes_balance : 0,
                no_balance  : 0,
            };
            0x2::dynamic_field::add<address, ShareBalance>(arg1, arg2, v0);
            arg0.next_balance_id = arg0.next_balance_id + 1;
        };
        let v1 = 0x2::dynamic_field::borrow_mut<address, ShareBalance>(arg1, arg2);
        if (arg4) {
            v1.yes_balance = v1.yes_balance + arg3;
        } else {
            v1.no_balance = v1.no_balance + arg3;
        };
        let v2 = ShareBalanceChanged{
            event_market_id : *0x2::object::uid_as_inner(arg1),
            owner           : arg2,
            yes_balance     : v1.yes_balance,
            no_balance      : v1.no_balance,
            balance_id      : v1.balance_id,
        };
        0x2::event::emit<ShareBalanceChanged>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiMarket{
            id                    : 0x2::object::new(arg0),
            admin                 : @0xa4b98171021e70f50bb6265c1991560500b9889379a6df0232e837bc33930ff9,
            resolver              : @0xa4b98171021e70f50bb6265c1991560500b9889379a6df0232e837bc33930ff9,
            version               : 1,
            withdraw_fee          : 100,
            market_fee            : 50,
            next_bid_yes_order_id : 1,
            next_bid_no_order_id  : 2305843009213693952,
            next_ask_yes_order_id : 4611686018427387904,
            next_ask_no_order_id  : 6917529027641081856,
            next_balance_id       : 0,
        };
        0x2::transfer::share_object<SuiMarket>(v0);
    }

    fun inject_limit_order<T0>(arg0: &mut SuiMarket, arg1: &mut EventMarket<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, v2) = if (arg5) {
            if (arg6) {
                arg0.next_bid_yes_order_id = arg0.next_bid_yes_order_id + 1;
                (&mut arg1.yes_bids, arg0.next_bid_yes_order_id)
            } else {
                arg0.next_bid_no_order_id = arg0.next_bid_no_order_id + 1;
                (&mut arg1.no_bids, arg0.next_bid_no_order_id)
            }
        } else if (arg6) {
            arg0.next_ask_yes_order_id = arg0.next_ask_yes_order_id + 1;
            (&mut arg1.yes_asks, arg0.next_ask_yes_order_id)
        } else {
            arg0.next_ask_no_order_id = arg0.next_ask_no_order_id + 1;
            (&mut arg1.no_asks, arg0.next_ask_no_order_id)
        };
        let v3 = Order{
            order_id          : v2,
            owner             : v0,
            price             : arg2,
            original_quantity : arg3,
            quantity          : arg4,
            is_bid            : arg5,
            is_yes            : arg6,
        };
        let (v4, v5) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::find_leaf<TickLevel>(v1, arg2);
        let v6 = v5;
        if (!v4) {
            let v7 = TickLevel{
                price       : arg2,
                open_orders : 0x2::linked_table::new<u64, Order>(arg7),
            };
            v6 = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::insert_leaf<TickLevel>(v1, arg2, v7);
        };
        0x2::linked_table::push_back<u64, Order>(&mut 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::borrow_mut_leaf_by_index<TickLevel>(v1, v6).open_orders, v2, v3);
        let v8 = OrderPlaced{
            event_market_id   : *0x2::object::uid_as_inner(&arg1.id),
            order_id          : v2,
            is_bid            : arg5,
            is_yes            : arg6,
            owner             : v0,
            original_quantity : arg3,
            quantity_placed   : arg4,
            price             : arg2,
        };
        0x2::event::emit<OrderPlaced>(v8);
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg1.usr_open_orders, v0)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg1.usr_open_orders, v0, 0x2::linked_table::new<u64, u64>(arg7));
        };
        0x2::linked_table::push_back<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg1.usr_open_orders, v0), v2, arg2);
        v2
    }

    fun match_ask<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: &mut EventMarket<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0;
        let v2 = v1;
        let v3 = arg4;
        let v4 = if (arg5) {
            &mut arg2.yes_bids
        } else {
            &mut arg2.no_bids
        };
        if (0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::is_empty<TickLevel>(v4)) {
            return (arg4, v1)
        };
        let (v5, v6) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::max_leaf<TickLevel>(v4);
        let v7 = v6;
        let v8 = v5;
        while (!0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::is_empty<TickLevel>(v4) && v8 >= arg3) {
            let v9 = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::borrow_mut_leaf_by_index<TickLevel>(v4, v7);
            let v10 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v9.open_orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v9.open_orders)) {
                let v11 = 0x2::linked_table::borrow<u64, Order>(&v9.open_orders, v10);
                let v12 = v11.quantity;
                let v13 = if (v3 >= v12) {
                    v12
                } else {
                    v3
                };
                let v14 = &mut arg2.id;
                decrease_user_balance(arg0, v14, v0, v13, arg5);
                let v15 = &mut arg2.id;
                increase_user_balance(arg0, v15, v11.owner, v13, arg5);
                v2 = v2 + v13 * v11.price * arg1.token_per_share / 1000;
                let v16 = v12 - v13;
                let v17 = OrderFilled{
                    event_market_id : *0x2::object::uid_as_inner(&arg2.id),
                    order_id        : v11.order_id,
                    taker_address   : v0,
                    maker_address   : v11.owner,
                    quantity_filled : v13,
                    quantity_remain : v16,
                    price           : v11.price,
                    is_yes          : arg5,
                    is_opposite     : false,
                };
                0x2::event::emit<OrderFilled>(v17);
                let v18 = v3 - v13;
                v3 = v18;
                if (v16 == 0) {
                    let v19 = 0x2::linked_table::next<u64, Order>(&v9.open_orders, v10);
                    if (!0x1::option::is_none<u64>(v19)) {
                        v10 = *0x1::option::borrow<u64>(v19);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg2.usr_open_orders, v11.owner), v10);
                    0x2::linked_table::remove<u64, Order>(&mut v9.open_orders, v10);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v9.open_orders, v10).quantity = v16;
                };
                if (v18 == 0) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v9.open_orders)) {
                let (v20, _) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::next_leaf<TickLevel>(v4, v8);
                v8 = v20;
                destroy_empty_level(0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::remove_leaf_by_index<TickLevel>(v4, v7));
                let (_, v23) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::find_leaf<TickLevel>(v4, v20);
                v7 = v23;
            };
            if (v3 == 0) {
                break
            };
        };
        let v24 = 0x2::coin::take<T0>(&mut arg1.total_base_coin, v2, arg6);
        0x2::balance::join<T0>(&mut arg1.fee, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v24, v2 * arg0.market_fee / 10000, arg6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v24, v0);
        (v3, v2)
    }

    fun match_bid<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: &mut EventMarket<T0>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg4;
        let (v2, v3) = if (arg6) {
            let v3 = &mut arg2.yes_asks;
            let v2 = &mut arg2.no_bids;
            (v2, v3)
        } else {
            let v3 = &mut arg2.no_asks;
            let v2 = &mut arg2.yes_bids;
            (v2, v3)
        };
        if (0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::is_empty<TickLevel>(v3) && 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::is_empty<TickLevel>(v2)) {
            return (arg4, arg5)
        };
        let v4 = 1000;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        if (!0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::is_empty<TickLevel>(v3)) {
            let (v8, v9) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::min_leaf<TickLevel>(v3);
            v5 = v9;
            v4 = v8;
        };
        if (!0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::is_empty<TickLevel>(v2)) {
            let (v10, v11) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::max_leaf<TickLevel>(v2);
            v7 = v11;
            v6 = v10;
        };
        while (!0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::is_empty<TickLevel>(v3) && v4 <= arg3 || !0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::is_empty<TickLevel>(v2) && 1000 - v6 <= arg3) {
            if (v4 <= 1000 - v6) {
                let v12 = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::borrow_mut_leaf_by_index<TickLevel>(v3, v5);
                let v13 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v12.open_orders));
                while (!0x2::linked_table::is_empty<u64, Order>(&v12.open_orders)) {
                    let v14 = 0x2::linked_table::borrow<u64, Order>(&v12.open_orders, v13);
                    let v15 = v14.quantity;
                    let v16 = if (v1 >= v15) {
                        v15
                    } else {
                        v1
                    };
                    let v17 = &mut arg2.id;
                    increase_user_balance(arg0, v17, v0, v16, arg6);
                    let v18 = v16 * v14.price * arg1.token_per_share / 1000;
                    assert!(0x2::coin::value<T0>(&arg5) >= v18, 3);
                    let v19 = 0x2::coin::split<T0>(&mut arg5, v18, arg7);
                    0x2::balance::join<T0>(&mut arg1.fee, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v19, v18 * arg0.market_fee / 10000, arg7)));
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, v14.owner);
                    let v20 = v15 - v16;
                    let v21 = OrderFilled{
                        event_market_id : *0x2::object::uid_as_inner(&arg2.id),
                        order_id        : v14.order_id,
                        taker_address   : v0,
                        maker_address   : v14.owner,
                        quantity_filled : v16,
                        quantity_remain : v20,
                        price           : v14.price,
                        is_yes          : arg6,
                        is_opposite     : false,
                    };
                    0x2::event::emit<OrderFilled>(v21);
                    let v22 = v1 - v16;
                    v1 = v22;
                    if (v20 == 0) {
                        let v23 = 0x2::linked_table::next<u64, Order>(&v12.open_orders, v13);
                        if (!0x1::option::is_none<u64>(v23)) {
                            v13 = *0x1::option::borrow<u64>(v23);
                        };
                        0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg2.usr_open_orders, v14.owner), v13);
                        0x2::linked_table::remove<u64, Order>(&mut v12.open_orders, v13);
                    } else {
                        0x2::linked_table::borrow_mut<u64, Order>(&mut v12.open_orders, v13).quantity = v20;
                    };
                    if (v22 == 0) {
                        break
                    };
                };
                if (0x2::linked_table::is_empty<u64, Order>(&v12.open_orders)) {
                    let (v24, _) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::next_leaf<TickLevel>(v3, v4);
                    v4 = v24;
                    destroy_empty_level(0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::remove_leaf_by_index<TickLevel>(v3, v5));
                    let (_, v27) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::find_leaf<TickLevel>(v3, v24);
                    v5 = v27;
                };
                if (v1 == 0) {
                    break
                } else {
                    continue
                };
            };
            let v28 = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::borrow_mut_leaf_by_index<TickLevel>(v2, v7);
            let v29 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v28.open_orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v28.open_orders)) {
                let v30 = 0x2::linked_table::borrow<u64, Order>(&v28.open_orders, v29);
                let v31 = v30.quantity;
                let v32 = if (v1 >= v31) {
                    v31
                } else {
                    v1
                };
                let v33 = &mut arg2.id;
                increase_user_balance(arg0, v33, v0, v32, arg6);
                let v34 = &mut arg2.id;
                increase_user_balance(arg0, v34, v30.owner, v32, !arg6);
                0x2::balance::join<T0>(&mut arg1.total_base_coin, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v32 * (1000 - v30.price) * arg1.token_per_share / 1000, arg7)));
                let v35 = v31 - v32;
                let v36 = OrderFilled{
                    event_market_id : *0x2::object::uid_as_inner(&arg2.id),
                    order_id        : v30.order_id,
                    taker_address   : v0,
                    maker_address   : v30.owner,
                    quantity_filled : v32,
                    quantity_remain : v35,
                    price           : v30.price,
                    is_yes          : arg6,
                    is_opposite     : true,
                };
                0x2::event::emit<OrderFilled>(v36);
                let v37 = v1 - v32;
                v1 = v37;
                if (v35 == 0) {
                    let v38 = 0x2::linked_table::next<u64, Order>(&v28.open_orders, v29);
                    if (!0x1::option::is_none<u64>(v38)) {
                        v29 = *0x1::option::borrow<u64>(v38);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg2.usr_open_orders, v30.owner), v29);
                    0x2::linked_table::remove<u64, Order>(&mut v28.open_orders, v29);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v28.open_orders, v29).quantity = v35;
                };
                if (v37 == 0) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v28.open_orders)) {
                let (v39, _) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::next_leaf<TickLevel>(v2, v6);
                v6 = v39;
                destroy_empty_level(0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::remove_leaf_by_index<TickLevel>(v2, v7));
                let (_, v42) = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::find_leaf<TickLevel>(v2, v39);
                v7 = v42;
            };
            if (v1 == 0) {
                break
            };
        };
        (v1, arg5)
    }

    entry fun migrate(arg0: &mut SuiMarket, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        assert!(arg0.version < 1, 9);
        arg0.version = 1;
    }

    fun order_is_bid_yes(arg0: u64) : (bool, bool) {
        if (arg0 >= 6917529027641081856) {
            return (false, false)
        };
        if (arg0 >= 4611686018427387904) {
            return (false, true)
        };
        if (arg0 >= 2305843009213693952) {
            return (true, false)
        };
        (true, true)
    }

    public entry fun place_buy_limit_order<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: &mut EventMarket<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        assert!(arg4 > 0, 4);
        assert!(arg3 > 0, 2);
        assert!(arg3 < 1000, 2);
        assert!(0x2::coin::value<T0>(&arg7) == arg3 * arg1.token_per_share * arg4 / 1000, 2);
        let (v0, v1) = match_bid<T0>(arg0, arg1, arg2, arg3, arg4, arg7, arg5, arg8);
        let v2 = v1;
        if (v0 > 0) {
            inject_limit_order<T0>(arg0, arg2, arg3, arg4, v0, true, arg5, arg8);
            0x2::balance::join<T0>(&mut arg1.total_base_coin, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v2, v0 * arg1.token_per_share * arg3 / 1000, arg8)));
        };
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg8));
        };
    }

    public entry fun place_buy_market_order<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: &mut EventMarket<T0>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.version == 1, 10);
        assert!(arg3 > 0, 4);
        let (_, v2) = match_bid<T0>(arg0, arg1, arg2, 9223372036854775808, arg3, arg6, arg4, arg7);
        let v3 = v2;
        if (0x2::coin::value<T0>(&v3) == 0) {
            0x2::coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v0);
        };
    }

    public entry fun place_sell_limit_order<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: &mut EventMarket<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.version == 1, 10);
        assert!(arg4 > 0, 4);
        assert!(arg3 > 0, 2);
        assert!(arg3 < 1000, 2);
        let (v1, _) = match_ask<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        if (v1 > 0) {
            let v3 = &mut arg2.id;
            decrease_user_balance(arg0, v3, v0, v1, arg5);
            inject_limit_order<T0>(arg0, arg2, arg3, arg4, v1, false, arg5, arg7);
        };
    }

    public entry fun place_sell_market_order<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: &mut EventMarket<T0>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        assert!(arg3 > 0, 4);
        let (_, v1) = match_ask<T0>(arg0, arg1, arg2, 0, arg3, arg4, arg7);
        assert!(v1 >= arg6, 3);
    }

    fun remove_order(arg0: &mut 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::CritbitTree<TickLevel>, arg1: &mut 0x2::linked_table::LinkedTable<u64, u64>, arg2: u64, arg3: u64, arg4: address) : Order {
        0x2::linked_table::remove<u64, u64>(arg1, arg3);
        assert!(0x2::linked_table::contains<u64, Order>(&0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::borrow_leaf_by_index<TickLevel>(arg0, arg2).open_orders, arg3), 11);
        let v0 = 0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::borrow_mut_leaf_by_index<TickLevel>(arg0, arg2);
        let v1 = 0x2::linked_table::remove<u64, Order>(&mut v0.open_orders, arg3);
        assert!(v1.owner == arg4, 7);
        if (0x2::linked_table::is_empty<u64, Order>(&v0.open_orders)) {
            destroy_empty_level(0xb61e324fa43746f5c24b2db3362afb382b644b32bce39a53f1f796a0109828e0::critbit::remove_leaf_by_index<TickLevel>(arg0, arg2));
        };
        v1
    }

    public entry fun update_event<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        arg1.name = arg3;
        arg1.end_date = arg4;
        arg1.resolver = arg2;
    }

    public entry fun update_market<T0>(arg0: &mut SuiMarket, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        arg0.admin = arg1;
        arg0.resolver = arg2;
        arg0.market_fee = arg3;
        arg0.withdraw_fee = arg4;
    }

    public entry fun withdraw_fee<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fee, 0x2::balance::value<T0>(&arg1.fee)), arg2), v0);
    }

    public entry fun withdraw_win_event<T0>(arg0: &mut SuiMarket, arg1: &mut Event<T0>, arg2: &mut EventMarket<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.version == 1, 10);
        assert!(0x1::option::is_some<bool>(&arg2.is_yes), 1);
        let v1 = *0x1::option::borrow<bool>(&arg2.is_yes);
        let v2 = if (v1) {
            0x2::dynamic_field::borrow_mut<address, ShareBalance>(&mut arg2.id, v0).yes_balance
        } else {
            0x2::dynamic_field::borrow_mut<address, ShareBalance>(&mut arg2.id, v0).no_balance
        };
        if (v2 > 0) {
            let v3 = arg1.token_per_share * v2;
            let v4 = 0x2::coin::take<T0>(&mut arg1.total_base_coin, v3, arg4);
            0x2::balance::join<T0>(&mut arg1.fee, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v3 * arg0.withdraw_fee / 10000, arg4)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
            let v5 = &mut arg2.id;
            decrease_user_balance(arg0, v5, v0, v2, v1);
        };
    }

    // decompiled from Move bytecode v6
}

