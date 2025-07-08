module 0xdee9::clob {
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
        bids: 0xdee9::critbit::CritbitTree<TickLevel>,
        asks: 0xdee9::critbit::CritbitTree<TickLevel>,
        next_bid_order_id: u64,
        next_ask_order_id: u64,
        usr_open_orders: 0x2::table::Table<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>,
        taker_fee_rate: u64,
        maker_rebate_rate: u64,
        tick_size: u64,
        lot_size: u64,
        base_custodian: 0xdee9::custodian::Custodian<T0>,
        quote_custodian: 0xdee9::custodian::Custodian<T1>,
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

    public fun account_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xdee9::custodian::AccountCap) : (u64, u64, u64, u64) {
        let v0 = 0x2::object::id<0xdee9::custodian::AccountCap>(arg1);
        let (v1, v2) = 0xdee9::custodian::account_balance<T0>(&arg0.base_custodian, v0);
        let (v3, v4) = 0xdee9::custodian::account_balance<T1>(&arg0.quote_custodian, v0);
        (v1, v2, v3, v4)
    }

    public fun batch_cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u64>, arg2: &0xdee9::custodian::AccountCap) {
        let v0 = 0x2::object::id<0xdee9::custodian::AccountCap>(arg2);
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
                let (v8, v9) = 0xdee9::critbit::find_leaf<TickLevel>(v7, v5);
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
                0xdee9::custodian::unlock_balance<T1>(&mut arg0.quote_custodian, v0, 0xdee9::math::mul(v11.quantity, v11.price));
            } else {
                0xdee9::custodian::unlock_balance<T0>(&mut arg0.base_custodian, v0, v11.quantity);
            };
            emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), &v11);
            v2 = v2 + 1;
        };
    }

    public fun cancel_all_orders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xdee9::custodian::AccountCap) {
        let v0 = 0x2::object::id<0xdee9::custodian::AccountCap>(arg1);
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
            let (_, v6) = 0xdee9::critbit::find_leaf<TickLevel>(v4, *0x2::linked_table::borrow<u64, u64>(v1, v2));
            let v7 = remove_order(v4, v1, v6, v2, v0);
            if (v3) {
                0xdee9::custodian::unlock_balance<T1>(&mut arg0.quote_custodian, v0, 0xdee9::math::mul(v7.quantity, v7.price));
            } else {
                0xdee9::custodian::unlock_balance<T0>(&mut arg0.base_custodian, v0, v7.quantity);
            };
            emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), &v7);
        };
    }

    public fun cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian::AccountCap) {
        let v0 = 0x2::object::id<0xdee9::custodian::AccountCap>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0);
        assert!(0x2::linked_table::contains<u64, u64>(v1, arg1), 3);
        let v2 = order_is_bid(arg1);
        let v3 = if (v2) {
            &arg0.bids
        } else {
            &arg0.asks
        };
        let (v4, v5) = 0xdee9::critbit::find_leaf<TickLevel>(v3, *0x2::linked_table::borrow<u64, u64>(v1, arg1));
        assert!(v4, 3);
        let v6 = if (v2) {
            &mut arg0.bids
        } else {
            &mut arg0.asks
        };
        let v7 = remove_order(v6, v1, v5, arg1, v0);
        if (v2) {
            0xdee9::custodian::unlock_balance<T1>(&mut arg0.quote_custodian, v0, 0xdee9::math::mul(v7.quantity, v7.price));
        } else {
            0xdee9::custodian::unlock_balance<T0>(&mut arg0.base_custodian, v0, v7.quantity);
        };
        emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), &v7);
    }

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) : 0xdee9::custodian::AccountCap {
        abort 0
    }

    public fun create_pool<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun deposit_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0xdee9::custodian::AccountCap) {
        abort 1337
    }

    public fun deposit_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0xdee9::custodian::AccountCap) {
        abort 1337
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

    fun get_level2_book_status(arg0: &0xdee9::critbit::CritbitTree<TickLevel>, arg1: u64, arg2: u64) : u64 {
        let v0 = &0xdee9::critbit::borrow_leaf_by_key<TickLevel>(arg0, arg1).open_orders;
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
        let (v0, _) = 0xdee9::critbit::min_leaf<TickLevel>(&arg0.asks);
        if (arg1 < v0) {
            arg1 = v0;
        };
        let (v2, _) = 0xdee9::critbit::max_leaf<TickLevel>(&arg0.asks);
        if (arg2 > v2) {
            arg2 = v2;
        };
        let v4 = 0xdee9::critbit::find_closest_key<TickLevel>(&arg0.asks, arg1);
        arg1 = v4;
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (v4 == 0) {
            return (v5, v6)
        };
        while (arg1 <= 0xdee9::critbit::find_closest_key<TickLevel>(&arg0.asks, arg2)) {
            0x1::vector::push_back<u64>(&mut v5, arg1);
            0x1::vector::push_back<u64>(&mut v6, get_level2_book_status(&arg0.asks, arg1, 0x2::clock::timestamp_ms(arg3)));
            let (v7, _) = 0xdee9::critbit::next_leaf<TickLevel>(&arg0.asks, arg1);
            if (v7 == 0) {
                break
            };
            arg1 = v7;
        };
        (v5, v6)
    }

    public fun get_level2_book_status_bid_side<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (vector<u64>, vector<u64>) {
        let (v0, _) = 0xdee9::critbit::min_leaf<TickLevel>(&arg0.bids);
        if (arg1 < v0) {
            arg1 = v0;
        };
        let (v2, _) = 0xdee9::critbit::max_leaf<TickLevel>(&arg0.bids);
        if (arg2 > v2) {
            arg2 = v2;
        };
        let v4 = 0xdee9::critbit::find_closest_key<TickLevel>(&arg0.bids, arg1);
        arg1 = v4;
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (v4 == 0) {
            return (v5, v6)
        };
        while (arg1 <= 0xdee9::critbit::find_closest_key<TickLevel>(&arg0.bids, arg2)) {
            0x1::vector::push_back<u64>(&mut v5, arg1);
            0x1::vector::push_back<u64>(&mut v6, get_level2_book_status(&arg0.bids, arg1, 0x2::clock::timestamp_ms(arg3)));
            let (v7, _) = 0xdee9::critbit::next_leaf<TickLevel>(&arg0.bids, arg1);
            if (v7 == 0) {
                break
            };
            arg1 = v7;
        };
        (v5, v6)
    }

    public fun get_market_price<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        let (v0, _) = 0xdee9::critbit::max_leaf<TickLevel>(&arg0.bids);
        let (v2, _) = 0xdee9::critbit::min_leaf<TickLevel>(&arg0.asks);
        (v0, v2)
    }

    public fun get_order_status<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian::AccountCap) : &Order {
        let v0 = 0x2::object::id<0xdee9::custodian::AccountCap>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0);
        assert!(0x2::linked_table::contains<u64, u64>(v1, arg1), 3);
        let v2 = if (arg1 < 9223372036854775808) {
            &arg0.bids
        } else {
            &arg0.asks
        };
        0x2::linked_table::borrow<u64, Order>(&0xdee9::critbit::borrow_leaf_by_key<TickLevel>(v2, *0x2::linked_table::borrow<u64, u64>(v1, arg1)).open_orders, arg1)
    }

    public fun list_open_orders<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xdee9::custodian::AccountCap) : vector<Order> {
        let v0 = 0x2::table::borrow<0x2::object::ID, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, 0x2::object::id<0xdee9::custodian::AccountCap>(arg1));
        let v1 = 0x1::vector::empty<Order>();
        let v2 = 0x2::linked_table::front<u64, u64>(v0);
        while (!0x1::option::is_none<u64>(v2)) {
            let v3 = if (order_is_bid(*0x1::option::borrow<u64>(v2))) {
                0xdee9::critbit::borrow_leaf_by_key<TickLevel>(&arg0.bids, *0x2::linked_table::borrow<u64, u64>(v0, *0x1::option::borrow<u64>(v2)))
            } else {
                0xdee9::critbit::borrow_leaf_by_key<TickLevel>(&arg0.asks, *0x2::linked_table::borrow<u64, u64>(v0, *0x1::option::borrow<u64>(v2)))
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

    fun order_is_bid(arg0: u64) : bool {
        arg0 < 9223372036854775808
    }

    public fun place_limit_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0xdee9::custodian::AccountCap, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, u64) {
        abort 1337
    }

    public fun place_market_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 1337
    }

    fun remove_order(arg0: &mut 0xdee9::critbit::CritbitTree<TickLevel>, arg1: &mut 0x2::linked_table::LinkedTable<u64, u64>, arg2: u64, arg3: u64, arg4: 0x2::object::ID) : Order {
        0x2::linked_table::remove<u64, u64>(arg1, arg3);
        assert!(0x2::linked_table::contains<u64, Order>(&0xdee9::critbit::borrow_leaf_by_index<TickLevel>(arg0, arg2).open_orders, arg3), 3);
        let v0 = 0xdee9::critbit::borrow_mut_leaf_by_index<TickLevel>(arg0, arg2);
        let v1 = 0x2::linked_table::remove<u64, Order>(&mut v0.open_orders, arg3);
        assert!(v1.owner == arg4, 4);
        if (0x2::linked_table::is_empty<u64, Order>(&v0.open_orders)) {
            destroy_empty_level(0xdee9::critbit::remove_leaf_by_index<TickLevel>(arg0, arg2));
        };
        v1
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        abort 1337
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        abort 1337
    }

    public fun withdraw_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian::AccountCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 6);
        0xdee9::custodian::withdraw_asset<T0>(&mut arg0.base_custodian, arg1, arg2, arg3)
    }

    public fun withdraw_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian::AccountCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 0, 6);
        0xdee9::custodian::withdraw_asset<T1>(&mut arg0.quote_custodian, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

