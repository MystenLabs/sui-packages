module 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob {
    struct PoolCreated has copy, drop, store {
        pool_id: 0x2::object::ID,
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        taker_fee_rate: u64,
        maker_rebate_rate: u64,
        tick_size: u64,
        lot_size: u64,
    }

    struct OrderPlacedV2<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        owner: 0x2::object::ID,
        base_asset_quantity_placed: u64,
        price: u64,
        expire_timestamp: u64,
    }

    struct OrderCanceled<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        owner: 0x2::object::ID,
        base_asset_quantity_canceled: u64,
        price: u64,
    }

    struct OrderFilledV2<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        owner: 0x2::object::ID,
        total_quantity: u64,
        base_asset_quantity_filled: u64,
        base_asset_quantity_remaining: u64,
        price: u64,
        taker_commission: u64,
        maker_rebates: u64,
    }

    struct Order has drop, store {
        order_id: u64,
        price: u64,
        quantity: u64,
        is_bid: bool,
        owner: 0x2::object::ID,
        expire_timestamp: u64,
    }

    struct TickLevel has store {
        price: u64,
        open_orders: 0x2::linked_table::LinkedTable<u64, Order>,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        bids: 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<TickLevel>,
        asks: 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<TickLevel>,
        next_bid_order_id: u64,
        next_ask_order_id: u64,
        usr_open_orders: 0x2::table::Table<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>,
        taker_fee_rate: u64,
        maker_rebate_rate: u64,
        tick_size: u64,
        lot_size: u64,
        base_custodian: 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::Custodian<T0>,
        quote_custodian: 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::Custodian<T1>,
        creation_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        base_asset_trading_fees: 0x2::balance::Balance<T0>,
        quote_asset_trading_fees: 0x2::balance::Balance<T1>,
    }

    struct OrderPlaced<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        owner: 0x2::object::ID,
        base_asset_quantity_placed: u64,
        price: u64,
    }

    struct OrderFilled<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        owner: 0x2::object::ID,
        total_quantity: u64,
        base_asset_quantity_filled: u64,
        base_asset_quantity_remaining: u64,
        price: u64,
    }

    public fun account_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap) : (u64, u64, u64, u64) {
        let v0 = 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg1);
        let (v1, v2) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::account_balance<T0>(&arg0.base_custodian, v0);
        let (v3, v4) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::account_balance<T1>(&arg0.quote_custodian, v0);
        (v1, v2, v3, v4)
    }

    public fun batch_cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u64>, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap) {
        let v0 = 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0);
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v4 = *0x1::vector::borrow<u64>(&arg1, v2);
            assert!(0x2::linked_table::contains<u64, u64>(v3, v4), 3);
            let v5 = *0x2::linked_table::borrow<u64, u64>(v3, v4);
            let v6 = order_is_bid(v4);
            if (v5 != 0) {
                let v7 = if (v6) {
                    &arg0.bids
                } else {
                    &arg0.asks
                };
                let (v8, v9) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v7, v5);
                assert!(v8, 11);
                v1 = v9;
            };
            let v10 = if (v6) {
                &mut arg0.bids
            } else {
                &mut arg0.asks
            };
            let v11 = remove_order(v10, v3, v1, v4, v0);
            if (v6) {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::unlock_balance<T1>(&mut arg0.quote_custodian, v0, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v11.quantity, v11.price));
            } else {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::unlock_balance<T0>(&mut arg0.base_custodian, v0, v11.quantity);
            };
            emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), &v11);
            v2 = v2 + 1;
        };
    }

    public fun cancel_all_orders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap) {
        let v0 = 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0);
        while (!0x2::linked_table::is_empty<u64, u64>(v1)) {
            let v2 = *0x1::option::borrow<u64>(0x2::linked_table::back<u64, u64>(v1));
            let v3 = order_is_bid(v2);
            let v4 = if (v3) {
                &mut arg0.bids
            } else {
                &mut arg0.asks
            };
            let (_, v6) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v4, *0x2::linked_table::borrow<u64, u64>(v1, v2));
            let v7 = remove_order(v4, v1, v6, v2, v0);
            if (v3) {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::unlock_balance<T1>(&mut arg0.quote_custodian, v0, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v7.quantity, v7.price));
            } else {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::unlock_balance<T0>(&mut arg0.base_custodian, v0, v7.quantity);
            };
            emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), &v7);
        };
    }

    public fun cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap) {
        let v0 = 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0);
        assert!(0x2::linked_table::contains<u64, u64>(v1, arg1), 3);
        let v2 = order_is_bid(arg1);
        let v3 = if (v2) {
            &arg0.bids
        } else {
            &arg0.asks
        };
        let (v4, v5) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v3, *0x2::linked_table::borrow<u64, u64>(v1, arg1));
        assert!(v4, 3);
        let v6 = if (v2) {
            &mut arg0.bids
        } else {
            &mut arg0.asks
        };
        let v7 = remove_order(v6, v1, v5, arg1, v0);
        if (v2) {
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::unlock_balance<T1>(&mut arg0.quote_custodian, v0, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v7.quantity, v7.price));
        } else {
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::unlock_balance<T0>(&mut arg0.base_custodian, v0, v7.quantity);
        };
        emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), &v7);
    }

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap {
        abort 0
    }

    public fun create_pool<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun deposit_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap) {
        assert!(0x2::coin::value<T0>(&arg1) != 0, 7);
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T0>(&mut arg0.base_custodian, 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg2), 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap) {
        assert!(0x2::coin::value<T1>(&arg1) != 0, 8);
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T1>(&mut arg0.quote_custodian, 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg2), 0x2::coin::into_balance<T1>(arg1));
    }

    fun destroy_empty_level(arg0: TickLevel) {
        let TickLevel {
            price       : _,
            open_orders : v1,
        } = arg0;
        0x2::linked_table::destroy_empty<u64, Order>(v1);
    }

    fun emit_order_canceled<T0, T1>(arg0: 0x2::object::ID, arg1: &Order) {
        let v0 = OrderCanceled<T0, T1>{
            pool_id                      : arg0,
            order_id                     : arg1.order_id,
            is_bid                       : arg1.is_bid,
            owner                        : arg1.owner,
            base_asset_quantity_canceled : arg1.quantity,
            price                        : arg1.price,
        };
        0x2::event::emit<OrderCanceled<T0, T1>>(v0);
    }

    fun emit_order_filled<T0, T1>(arg0: 0x2::object::ID, arg1: &Order, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = OrderFilledV2<T0, T1>{
            pool_id                       : arg0,
            order_id                      : arg1.order_id,
            is_bid                        : arg1.is_bid,
            owner                         : arg1.owner,
            total_quantity                : arg1.quantity,
            base_asset_quantity_filled    : arg2,
            base_asset_quantity_remaining : arg1.quantity - arg2,
            price                         : arg1.price,
            taker_commission              : arg3,
            maker_rebates                 : arg4,
        };
        0x2::event::emit<OrderFilledV2<T0, T1>>(v0);
    }

    fun get_level2_book_status(arg0: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<TickLevel>, arg1: u64, arg2: u64) : u64 {
        let v0 = &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_leaf_by_key<TickLevel>(arg0, arg1).open_orders;
        let v1 = 0;
        let v2 = 0x2::linked_table::front<u64, Order>(v0);
        while (!0x1::option::is_none<u64>(v2)) {
            let v3 = 0x2::linked_table::borrow<u64, Order>(v0, *0x1::option::borrow<u64>(v2));
            if (v3.expire_timestamp > arg2) {
                v1 = v1 + v3.quantity;
            };
            let v4 = *0x1::option::borrow<u64>(v2);
            v2 = 0x2::linked_table::next<u64, Order>(v0, v4);
        };
        v1
    }

    public fun get_level2_book_status_ask_side<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (vector<u64>, vector<u64>) {
        let (v0, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(&arg0.asks);
        if (arg1 < v0) {
            arg1 = v0;
        };
        let (v2, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::max_leaf<TickLevel>(&arg0.asks);
        if (arg2 > v2) {
            arg2 = v2;
        };
        let v4 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_closest_key<TickLevel>(&arg0.asks, arg1);
        arg1 = v4;
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (v4 == 0) {
            return (v5, v6)
        };
        while (arg1 <= 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_closest_key<TickLevel>(&arg0.asks, arg2)) {
            0x1::vector::push_back<u64>(&mut v5, arg1);
            0x1::vector::push_back<u64>(&mut v6, get_level2_book_status(&arg0.asks, arg1, 0x2::clock::timestamp_ms(arg3)));
            let (v7, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<TickLevel>(&arg0.asks, arg1);
            if (v7 == 0) {
                break
            };
            arg1 = v7;
        };
        (v5, v6)
    }

    public fun get_level2_book_status_bid_side<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (vector<u64>, vector<u64>) {
        let (v0, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(&arg0.bids);
        if (arg1 < v0) {
            arg1 = v0;
        };
        let (v2, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::max_leaf<TickLevel>(&arg0.bids);
        if (arg2 > v2) {
            arg2 = v2;
        };
        let v4 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_closest_key<TickLevel>(&arg0.bids, arg1);
        arg1 = v4;
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (v4 == 0) {
            return (v5, v6)
        };
        while (arg1 <= 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_closest_key<TickLevel>(&arg0.bids, arg2)) {
            0x1::vector::push_back<u64>(&mut v5, arg1);
            0x1::vector::push_back<u64>(&mut v6, get_level2_book_status(&arg0.bids, arg1, 0x2::clock::timestamp_ms(arg3)));
            let (v7, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<TickLevel>(&arg0.bids, arg1);
            if (v7 == 0) {
                break
            };
            arg1 = v7;
        };
        (v5, v6)
    }

    public fun get_market_price<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        let (v0, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::max_leaf<TickLevel>(&arg0.bids);
        let (v2, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(&arg0.asks);
        (v0, v2)
    }

    public fun get_order_status<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap) : &Order {
        let v0 = 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0);
        assert!(0x2::linked_table::contains<u64, u64>(v1, arg1), 3);
        let v2 = if (arg1 < 9223372036854775808) {
            &arg0.bids
        } else {
            &arg0.asks
        };
        0x2::linked_table::borrow<u64, Order>(&0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_leaf_by_key<TickLevel>(v2, *0x2::linked_table::borrow<u64, u64>(v1, arg1)).open_orders, arg1)
    }

    fun inject_limit_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg5);
        let (v1, v2) = if (arg3) {
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::lock_balance<T1>(&mut arg0.quote_custodian, arg5, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(arg2, arg1));
            arg0.next_bid_order_id = arg0.next_bid_order_id + 1;
            (&mut arg0.bids, arg0.next_bid_order_id)
        } else {
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::lock_balance<T0>(&mut arg0.base_custodian, arg5, arg2);
            arg0.next_ask_order_id = arg0.next_ask_order_id + 1;
            (&mut arg0.asks, arg0.next_ask_order_id)
        };
        let v3 = Order{
            order_id         : v2,
            price            : arg1,
            quantity         : arg2,
            is_bid           : arg3,
            owner            : v0,
            expire_timestamp : arg4,
        };
        let (v4, v5) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v1, arg1);
        let v6 = v5;
        if (!v4) {
            let v7 = TickLevel{
                price       : arg1,
                open_orders : 0x2::linked_table::new<u64, Order>(arg6),
            };
            v6 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::insert_leaf<TickLevel>(v1, arg1, v7);
        };
        0x2::linked_table::push_back<u64, Order>(&mut 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_mut_leaf_by_index<TickLevel>(v1, v6).open_orders, v2, v3);
        let v8 = OrderPlacedV2<T0, T1>{
            pool_id                    : *0x2::object::uid_as_inner(&arg0.id),
            order_id                   : v2,
            is_bid                     : arg3,
            owner                      : v0,
            base_asset_quantity_placed : arg2,
            price                      : arg1,
            expire_timestamp           : arg4,
        };
        0x2::event::emit<OrderPlacedV2<T0, T1>>(v8);
        if (!0x2::table::contains<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0)) {
            0x2::table::add<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0, 0x2::linked_table::new<u64, u64>(arg6));
        };
        0x2::linked_table::push_back<u64, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0), v2, arg1);
        v2
    }

    public fun list_open_orders<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap) : vector<Order> {
        let v0 = 0x2::table::borrow<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg1));
        let v1 = 0x1::vector::empty<Order>();
        let v2 = 0x2::linked_table::front<u64, u64>(v0);
        while (!0x1::option::is_none<u64>(v2)) {
            let v3 = if (order_is_bid(*0x1::option::borrow<u64>(v2))) {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_leaf_by_key<TickLevel>(&arg0.bids, *0x2::linked_table::borrow<u64, u64>(v0, *0x1::option::borrow<u64>(v2)))
            } else {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_leaf_by_key<TickLevel>(&arg0.asks, *0x2::linked_table::borrow<u64, u64>(v0, *0x1::option::borrow<u64>(v2)))
            };
            let v4 = 0x2::linked_table::borrow<u64, Order>(&v3.open_orders, *0x1::option::borrow<u64>(v2));
            let v5 = Order{
                order_id         : v4.order_id,
                price            : v4.price,
                quantity         : v4.quantity,
                is_bid           : v4.is_bid,
                owner            : v4.owner,
                expire_timestamp : v4.expire_timestamp,
            };
            0x1::vector::push_back<Order>(&mut v1, v5);
            let v6 = *0x1::option::borrow<u64>(v2);
            v2 = 0x2::linked_table::next<u64, u64>(v0, v6);
        };
        v1
    }

    fun match_ask<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::zero<T1>();
        let v1 = &mut arg0.bids;
        if (0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v1)) {
            return (arg3, v0)
        };
        let (v2, v3) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::max_leaf<TickLevel>(v1);
        let v4 = v3;
        let v5 = v2;
        while (!0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v1) && v5 >= arg1) {
            let v6 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_mut_leaf_by_index<TickLevel>(v1, v4);
            let v7 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v6.open_orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v6.open_orders)) {
                let v8 = 0x2::linked_table::borrow<u64, Order>(&v6.open_orders, v7);
                let v9 = v8.quantity;
                let v10 = v9;
                let v11 = false;
                if (v8.expire_timestamp <= arg2) {
                    v11 = true;
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::unlock_balance<T1>(&mut arg0.quote_custodian, v8.owner, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v8.quantity, v8.price));
                    emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), v8);
                } else {
                    let v12 = 0x2::balance::value<T0>(&arg3);
                    let v13 = if (v12 >= v9) {
                        v9
                    } else {
                        v12
                    };
                    let v14 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v13, v8.price);
                    let v15 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul(v14, arg0.maker_rebate_rate);
                    let (v16, v17) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v14, arg0.taker_fee_rate);
                    let v18 = v17;
                    if (v16) {
                        v18 = v17 + 1;
                    };
                    v10 = v9 - v13;
                    let v19 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::decrease_user_locked_balance<T1>(&mut arg0.quote_custodian, v8.owner, v14);
                    let v20 = 0x2::balance::split<T1>(&mut v19, v18);
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v8.owner, 0x2::balance::split<T1>(&mut v20, v15));
                    0x2::balance::join<T1>(&mut arg0.quote_asset_trading_fees, v20);
                    0x2::balance::join<T1>(&mut v0, v19);
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T0>(&mut arg0.base_custodian, v8.owner, 0x2::balance::split<T0>(&mut arg3, v13));
                    emit_order_filled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), v8, v13, v18, v15);
                };
                if (v11 || v10 == 0) {
                    let v21 = 0x2::linked_table::next<u64, Order>(&v6.open_orders, v7);
                    if (!0x1::option::is_none<u64>(v21)) {
                        v7 = *0x1::option::borrow<u64>(v21);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v8.owner), v7);
                    0x2::linked_table::remove<u64, Order>(&mut v6.open_orders, v7);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v6.open_orders, v7).quantity = v10;
                };
                if (0x2::balance::value<T0>(&arg3) == 0) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v6.open_orders)) {
                let (v22, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::previous_leaf<TickLevel>(v1, v5);
                v5 = v22;
                destroy_empty_level(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::remove_leaf_by_index<TickLevel>(v1, v4));
                let (_, v25) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v1, v22);
                v4 = v25;
            };
            if (0x2::balance::value<T0>(&arg3) == 0) {
                break
            };
        };
        (arg3, v0)
    }

    fun match_bid<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = arg1;
        let v1 = 0x2::balance::zero<T0>();
        let v2 = &mut arg0.asks;
        if (0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v2)) {
            return (v1, arg4)
        };
        let (v3, v4) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(v2);
        let v5 = v4;
        let v6 = v3;
        while (!0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v2) && v6 <= arg2) {
            let v7 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_mut_leaf_by_index<TickLevel>(v2, v5);
            let v8 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v7.open_orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v7.open_orders)) {
                let v9 = 0x2::linked_table::borrow<u64, Order>(&v7.open_orders, v8);
                let v10 = v9.quantity;
                let v11 = v10;
                let v12 = false;
                if (v9.expire_timestamp <= arg3) {
                    v12 = true;
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::unlock_balance<T0>(&mut arg0.base_custodian, v9.owner, v9.quantity);
                    emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), v9);
                } else {
                    let v13 = if (v0 > v10) {
                        v10
                    } else {
                        v0
                    };
                    let v14 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v13, v9.price);
                    let v15 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul(v14, arg0.maker_rebate_rate);
                    let (v16, v17) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v14, arg0.taker_fee_rate);
                    let v18 = v17;
                    if (v16) {
                        v18 = v17 + 1;
                    };
                    v11 = v10 - v13;
                    v0 = v0 - v13;
                    let v19 = 0x2::balance::split<T1>(&mut arg4, v18);
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v9.owner, 0x2::balance::split<T1>(&mut v19, v15));
                    0x2::balance::join<T1>(&mut arg0.quote_asset_trading_fees, v19);
                    0x2::balance::join<T0>(&mut v1, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::decrease_user_locked_balance<T0>(&mut arg0.base_custodian, v9.owner, v10));
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v9.owner, 0x2::balance::split<T1>(&mut arg4, v14));
                    emit_order_filled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), v9, v10, v18, v15);
                };
                if (v12 || v11 == 0) {
                    let v20 = 0x2::linked_table::next<u64, Order>(&v7.open_orders, v8);
                    if (!0x1::option::is_none<u64>(v20)) {
                        v8 = *0x1::option::borrow<u64>(v20);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v9.owner), v8);
                    0x2::linked_table::remove<u64, Order>(&mut v7.open_orders, v8);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v7.open_orders, v8).quantity = v11;
                };
                if (v0 == 0) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v7.open_orders)) {
                let (v21, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<TickLevel>(v2, v6);
                v6 = v21;
                destroy_empty_level(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::remove_leaf_by_index<TickLevel>(v2, v5));
                let (_, v24) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v2, v21);
                v5 = v24;
            };
            if (v0 == 0) {
                break
            };
        };
        (v1, arg4)
    }

    fun match_bid_with_quote_quantity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = &mut arg0.asks;
        if (0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v1)) {
            return (v0, arg4)
        };
        let (v2, v3) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(v1);
        let v4 = v3;
        let v5 = v2;
        let v6 = false;
        while (!0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v1) && v5 <= arg2) {
            let v7 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_mut_leaf_by_index<TickLevel>(v1, v4);
            let v8 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v7.open_orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v7.open_orders)) {
                let v9 = 0x2::linked_table::borrow<u64, Order>(&v7.open_orders, v8);
                let v10 = v9.quantity;
                let v11 = v10;
                let v12 = false;
                if (v9.expire_timestamp <= arg3) {
                    v12 = true;
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::unlock_balance<T0>(&mut arg0.base_custodian, v9.owner, v9.quantity);
                    emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), v9);
                } else {
                    let v13 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v10, v9.price);
                    let (v14, v15) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v13, arg0.taker_fee_rate);
                    let v16 = v15;
                    if (v14) {
                        v16 = v15 + 1;
                    };
                    let v17 = v13 + v16;
                    let (v18, v19, v20) = if (arg1 > v17) {
                        (v10, v17, v13)
                    } else {
                        v6 = true;
                        let v21 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_div(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_div(arg1, 1000000000 + arg0.taker_fee_rate), v9.price) / arg0.lot_size * arg0.lot_size;
                        let v22 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul(v21, v9.price);
                        let (v23, v24) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v22, arg0.taker_fee_rate);
                        let v25 = v24;
                        if (v23) {
                            v25 = v24 + 1;
                        };
                        (v21, v22 + v25, v22)
                    };
                    let v26 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul(v20, arg0.maker_rebate_rate);
                    v11 = v10 - v18;
                    arg1 = arg1 - v19;
                    let v27 = 0x2::balance::split<T1>(&mut arg4, v19);
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v9.owner, 0x2::balance::split<T1>(&mut v27, v26 + v20));
                    0x2::balance::join<T1>(&mut arg0.quote_asset_trading_fees, v27);
                    0x2::balance::join<T0>(&mut v0, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::decrease_user_locked_balance<T0>(&mut arg0.base_custodian, v9.owner, v18));
                    emit_order_filled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), v9, v18, v19 - v20, v26);
                };
                if (v12 || v11 == 0) {
                    let v28 = 0x2::linked_table::next<u64, Order>(&v7.open_orders, v8);
                    if (!0x1::option::is_none<u64>(v28)) {
                        v8 = *0x1::option::borrow<u64>(v28);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v9.owner), v8);
                    0x2::linked_table::remove<u64, Order>(&mut v7.open_orders, v8);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v7.open_orders, v8).quantity = v11;
                };
                if (v6) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v7.open_orders)) {
                let (v29, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<TickLevel>(v1, v5);
                v5 = v29;
                destroy_empty_level(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::remove_leaf_by_index<TickLevel>(v1, v4));
                let (_, v32) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v1, v29);
                v4 = v32;
            };
            if (v6) {
                break
            };
        };
        (v0, arg4)
    }

    fun order_is_bid(arg0: u64) : bool {
        arg0 < 9223372036854775808
    }

    public fun place_limit_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, u64) {
        assert!(arg2 > 0, 6);
        assert!(arg1 > 0, 5);
        assert!(arg1 % arg0.tick_size == 0, 5);
        assert!(arg2 % arg0.lot_size == 0, 6);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg6), 19);
        let v0 = 0x2::object::id<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap>(arg7);
        let (v1, v2) = if (arg3) {
            let v3 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::account_available_balance<T1>(&arg0.quote_custodian, v0);
            let v4 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::decrease_user_available_balance<T1>(&mut arg0.quote_custodian, arg7, v3);
            let (v5, v6) = match_bid<T0, T1>(arg0, arg2, arg1, 0x2::clock::timestamp_ms(arg6), v4);
            let v7 = v6;
            let v8 = v5;
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T0>(&mut arg0.base_custodian, v0, v8);
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v0, v7);
            (0x2::balance::value<T0>(&v8), v3 - 0x2::balance::value<T1>(&v7))
        } else {
            let v9 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::decrease_user_available_balance<T0>(&mut arg0.base_custodian, arg7, arg2);
            let (v10, v11) = match_ask<T0, T1>(arg0, arg1, 0x2::clock::timestamp_ms(arg6), v9);
            let v12 = v11;
            let v13 = v10;
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T0>(&mut arg0.base_custodian, v0, v13);
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v0, v12);
            (arg2 - 0x2::balance::value<T0>(&v13), 0x2::balance::value<T1>(&v12))
        };
        if (arg5 == 1) {
            return (v1, v2, false, 0)
        };
        if (arg5 == 2) {
            assert!(v1 == arg2, 9);
            return (v1, v2, false, 0)
        };
        if (arg5 == 3) {
            assert!(v1 == 0, 10);
            return (v1, v2, true, inject_limit_order<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7, arg8))
        };
        assert!(arg5 == 0, 14);
        if (arg2 > v1) {
            return (v1, v2, true, inject_limit_order<T0, T1>(arg0, arg1, arg2 - v1, arg3, arg4, arg7, arg8))
        };
        (v1, v2, false, 0)
    }

    public fun place_market_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1 % arg0.lot_size == 0, 6);
        assert!(arg1 != 0, 6);
        if (arg2) {
            let (v0, v1) = match_bid<T0, T1>(arg0, arg1, 9223372036854775808, 0x2::clock::timestamp_ms(arg5), 0x2::coin::into_balance<T1>(arg4));
            0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v0, arg6));
            arg4 = 0x2::coin::from_balance<T1>(v1, arg6);
        } else {
            assert!(arg1 <= 0x2::coin::value<T0>(&arg3), 7);
            let (v2, v3) = match_ask<T0, T1>(arg0, 0, 0x2::clock::timestamp_ms(arg5), 0x2::coin::into_balance<T0>(arg3));
            arg3 = 0x2::coin::from_balance<T0>(v2, arg6);
            0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v3, arg6));
        };
        (arg3, arg4)
    }

    fun remove_order(arg0: &mut 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<TickLevel>, arg1: &mut 0x2::linked_table::LinkedTable<u64, u64>, arg2: u64, arg3: u64, arg4: 0x2::object::ID) : Order {
        0x2::linked_table::remove<u64, u64>(arg1, arg3);
        assert!(0x2::linked_table::contains<u64, Order>(&0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_leaf_by_index<TickLevel>(arg0, arg2).open_orders, arg3), 3);
        let v0 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_mut_leaf_by_index<TickLevel>(arg0, arg2);
        let v1 = 0x2::linked_table::remove<u64, Order>(&mut v0.open_orders, arg3);
        assert!(v1.owner == arg4, 4);
        if (0x2::linked_table::is_empty<u64, Order>(&v0.open_orders)) {
            destroy_empty_level(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::remove_leaf_by_index<TickLevel>(arg0, arg2));
        };
        v1
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        assert!(arg1 > 0, 6);
        assert!(0x2::coin::value<T0>(&arg2) >= arg1, 7);
        let (v0, v1) = place_market_order<T0, T1>(arg0, arg1, false, arg2, arg3, arg4, arg5);
        let v2 = v1;
        (v0, v2, 0x2::coin::value<T1>(&v2) - 0x2::coin::value<T1>(&arg3))
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        assert!(arg1 > 0, 6);
        assert!(0x2::coin::value<T1>(&arg3) >= arg1, 8);
        let (v0, v1) = match_bid_with_quote_quantity<T0, T1>(arg0, arg1, 9223372036854775808, 0x2::clock::timestamp_ms(arg2), 0x2::coin::into_balance<T1>(arg3));
        let v2 = v0;
        (0x2::coin::from_balance<T0>(v2, arg4), 0x2::coin::from_balance<T1>(v1, arg4), 0x2::balance::value<T0>(&v2))
    }

    public fun withdraw_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 6);
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::withdraw_asset<T0>(&mut arg0.base_custodian, arg1, arg2, arg3)
    }

    public fun withdraw_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::AccountCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 0, 6);
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian::withdraw_asset<T1>(&mut arg0.quote_custodian, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

