module 0xdee9::clob_v2 {
    struct PoolCreated has copy, drop, store {
        pool_id: 0x2::object::ID,
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        taker_fee_rate: u64,
        maker_rebate_rate: u64,
        tick_size: u64,
        lot_size: u64,
    }

    struct OrderPlaced<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u64,
        client_order_id: u64,
        is_bid: bool,
        owner: address,
        original_quantity: u64,
        base_asset_quantity_placed: u64,
        price: u64,
        expire_timestamp: u64,
    }

    struct OrderCanceled<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u64,
        client_order_id: u64,
        is_bid: bool,
        owner: address,
        original_quantity: u64,
        base_asset_quantity_canceled: u64,
        price: u64,
    }

    struct AllOrdersCanceledComponent<phantom T0, phantom T1> has copy, drop, store {
        order_id: u64,
        client_order_id: u64,
        is_bid: bool,
        owner: address,
        original_quantity: u64,
        base_asset_quantity_canceled: u64,
        price: u64,
    }

    struct AllOrdersCanceled<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        orders_canceled: vector<AllOrdersCanceledComponent<T0, T1>>,
    }

    struct OrderFilled<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u64,
        taker_client_order_id: u64,
        maker_client_order_id: u64,
        is_bid: bool,
        taker_address: address,
        maker_address: address,
        original_quantity: u64,
        base_asset_quantity_filled: u64,
        base_asset_quantity_remaining: u64,
        price: u64,
        taker_commission: u64,
        maker_rebates: u64,
    }

    struct DepositAsset<phantom T0> has copy, drop, store {
        pool_id: 0x2::object::ID,
        quantity: u64,
        owner: address,
    }

    struct WithdrawAsset<phantom T0> has copy, drop, store {
        pool_id: 0x2::object::ID,
        quantity: u64,
        owner: address,
    }

    struct MatchedOrderMetadata<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        taker_address: address,
        maker_address: address,
        base_asset_quantity_filled: u64,
        price: u64,
        taker_commission: u64,
        maker_rebates: u64,
    }

    struct Order has drop, store {
        order_id: u64,
        client_order_id: u64,
        price: u64,
        original_quantity: u64,
        quantity: u64,
        is_bid: bool,
        owner: address,
        expire_timestamp: u64,
        self_matching_prevention: u8,
    }

    struct TickLevel has store {
        price: u64,
        open_orders: 0x2::linked_table::LinkedTable<u64, Order>,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        bids: 0xdee9::critbit::CritbitTree<TickLevel>,
        asks: 0xdee9::critbit::CritbitTree<TickLevel>,
        next_bid_order_id: u64,
        next_ask_order_id: u64,
        usr_open_orders: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, u64>>,
        taker_fee_rate: u64,
        maker_rebate_rate: u64,
        tick_size: u64,
        lot_size: u64,
        base_custodian: 0xdee9::custodian_v2::Custodian<T0>,
        quote_custodian: 0xdee9::custodian_v2::Custodian<T1>,
        creation_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        base_asset_trading_fees: 0x2::balance::Balance<T0>,
        quote_asset_trading_fees: 0x2::balance::Balance<T1>,
    }

    struct PoolOwnerCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public fun account_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap) : (u64, u64, u64, u64) {
        let v0 = 0xdee9::custodian_v2::account_owner(arg1);
        let (v1, v2) = 0xdee9::custodian_v2::account_balance<T0>(&arg0.base_custodian, v0);
        let (v3, v4) = 0xdee9::custodian_v2::account_balance<T1>(&arg0.quote_custodian, v0);
        (v1, v2, v3, v4)
    }

    public fun asks<T0, T1>(arg0: &Pool<T0, T1>) : &0xdee9::critbit::CritbitTree<TickLevel> {
        &arg0.asks
    }

    public fun batch_cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u64>, arg2: &0xdee9::custodian_v2::AccountCap) {
        let v0 = 0xdee9::custodian_v2::account_owner(arg2);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0);
        let v4 = 0x1::vector::empty<AllOrdersCanceledComponent<T0, T1>>();
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v5 = *0x1::vector::borrow<u64>(&arg1, v2);
            assert!(0x2::linked_table::contains<u64, u64>(v3, v5), 3);
            let v6 = *0x2::linked_table::borrow<u64, u64>(v3, v5);
            let v7 = order_is_bid(v5);
            if (v6 != 0) {
                let v8 = if (v7) {
                    &arg0.bids
                } else {
                    &arg0.asks
                };
                let (v9, v10) = 0xdee9::critbit::find_leaf<TickLevel>(v8, v6);
                assert!(v9, 11);
                v1 = v10;
            };
            let v11 = if (v7) {
                &mut arg0.bids
            } else {
                &mut arg0.asks
            };
            let v12 = remove_order(v11, v3, v1, v5, v0);
            if (v7) {
                let (_, v14) = 0xdee9::math::unsafe_mul_round(v12.quantity, v12.price);
                0xdee9::custodian_v2::unlock_balance<T1>(&mut arg0.quote_custodian, v0, v14);
            } else {
                0xdee9::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v0, v12.quantity);
            };
            let v15 = AllOrdersCanceledComponent<T0, T1>{
                order_id                     : v12.order_id,
                client_order_id              : v12.client_order_id,
                is_bid                       : v12.is_bid,
                owner                        : v12.owner,
                original_quantity            : v12.original_quantity,
                base_asset_quantity_canceled : v12.quantity,
                price                        : v12.price,
            };
            0x1::vector::push_back<AllOrdersCanceledComponent<T0, T1>>(&mut v4, v15);
            v2 = v2 + 1;
        };
        if (!0x1::vector::is_empty<AllOrdersCanceledComponent<T0, T1>>(&v4)) {
            let v16 = AllOrdersCanceled<T0, T1>{
                pool_id         : *0x2::object::uid_as_inner(&arg0.id),
                orders_canceled : v4,
            };
            0x2::event::emit<AllOrdersCanceled<T0, T1>>(v16);
        };
    }

    public fun bids<T0, T1>(arg0: &Pool<T0, T1>) : &0xdee9::critbit::CritbitTree<TickLevel> {
        &arg0.bids
    }

    public fun cancel_all_orders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap) {
        let v0 = 0xdee9::custodian_v2::account_owner(arg1);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0);
        let v2 = 0x1::vector::empty<AllOrdersCanceledComponent<T0, T1>>();
        while (!0x2::linked_table::is_empty<u64, u64>(v1)) {
            let v3 = *0x1::option::borrow<u64>(0x2::linked_table::back<u64, u64>(v1));
            let v4 = order_is_bid(v3);
            let v5 = if (v4) {
                &mut arg0.bids
            } else {
                &mut arg0.asks
            };
            let (_, v7) = 0xdee9::critbit::find_leaf<TickLevel>(v5, *0x2::linked_table::borrow<u64, u64>(v1, v3));
            let v8 = remove_order(v5, v1, v7, v3, v0);
            if (v4) {
                let (_, v10) = 0xdee9::math::unsafe_mul_round(v8.quantity, v8.price);
                0xdee9::custodian_v2::unlock_balance<T1>(&mut arg0.quote_custodian, v0, v10);
            } else {
                0xdee9::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v0, v8.quantity);
            };
            let v11 = AllOrdersCanceledComponent<T0, T1>{
                order_id                     : v8.order_id,
                client_order_id              : v8.client_order_id,
                is_bid                       : v8.is_bid,
                owner                        : v8.owner,
                original_quantity            : v8.original_quantity,
                base_asset_quantity_canceled : v8.quantity,
                price                        : v8.price,
            };
            0x1::vector::push_back<AllOrdersCanceledComponent<T0, T1>>(&mut v2, v11);
        };
        if (!0x1::vector::is_empty<AllOrdersCanceledComponent<T0, T1>>(&v2)) {
            let v12 = AllOrdersCanceled<T0, T1>{
                pool_id         : *0x2::object::uid_as_inner(&arg0.id),
                orders_canceled : v2,
            };
            0x2::event::emit<AllOrdersCanceled<T0, T1>>(v12);
        };
    }

    public fun cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap) {
        let v0 = 0xdee9::custodian_v2::account_owner(arg2);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0);
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
            let (_, v9) = 0xdee9::math::unsafe_mul_round(v7.quantity, v7.price);
            0xdee9::custodian_v2::unlock_balance<T1>(&mut arg0.quote_custodian, v0, v9);
        } else {
            0xdee9::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v0, v7.quantity);
        };
        emit_order_canceled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), &v7);
    }

    public fun clean_up_expired_orders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: vector<u64>, arg3: vector<address>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<address>(&arg3), 13);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<AllOrdersCanceledComponent<T0, T1>>();
        while (v1 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v5 = *0x1::vector::borrow<address>(&arg3, v1);
            if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v5)) {
                continue
            };
            let v6 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v5);
            if (!0x2::linked_table::contains<u64, u64>(v6, v4)) {
                continue
            };
            let v7 = *0x2::linked_table::borrow<u64, u64>(v6, v4);
            let v8 = order_is_bid(v4);
            let v9 = if (v8) {
                &mut arg0.bids
            } else {
                &mut arg0.asks
            };
            if (v7 != 0) {
                let (v10, v11) = 0xdee9::critbit::find_leaf<TickLevel>(v9, v7);
                assert!(v10, 11);
                v2 = v11;
            };
            let v12 = remove_order(v9, v6, v2, v4, v5);
            assert!(v12.expire_timestamp < 0x2::clock::timestamp_ms(arg1), 19);
            if (v8) {
                let (_, v14) = 0xdee9::math::unsafe_mul_round(v12.quantity, v12.price);
                0xdee9::custodian_v2::unlock_balance<T1>(&mut arg0.quote_custodian, v5, v14);
            } else {
                0xdee9::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v5, v12.quantity);
            };
            let v15 = AllOrdersCanceledComponent<T0, T1>{
                order_id                     : v12.order_id,
                client_order_id              : v12.client_order_id,
                is_bid                       : v12.is_bid,
                owner                        : v12.owner,
                original_quantity            : v12.original_quantity,
                base_asset_quantity_canceled : v12.quantity,
                price                        : v12.price,
            };
            0x1::vector::push_back<AllOrdersCanceledComponent<T0, T1>>(&mut v3, v15);
            v1 = v1 + 1;
        };
        if (!0x1::vector::is_empty<AllOrdersCanceledComponent<T0, T1>>(&v3)) {
            let v16 = AllOrdersCanceled<T0, T1>{
                pool_id         : *0x2::object::uid_as_inner(&arg0.id),
                orders_canceled : v3,
            };
            0x2::event::emit<AllOrdersCanceled<T0, T1>>(v16);
        };
    }

    public(friend) fun clone_order(arg0: &Order) : Order {
        Order{
            order_id                 : arg0.order_id,
            client_order_id          : arg0.client_order_id,
            price                    : arg0.price,
            original_quantity        : arg0.original_quantity,
            quantity                 : arg0.quantity,
            is_bid                   : arg0.is_bid,
            owner                    : arg0.owner,
            expire_timestamp         : arg0.expire_timestamp,
            self_matching_prevention : arg0.self_matching_prevention,
        }
    }

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) : 0xdee9::custodian_v2::AccountCap {
        abort 1337
    }

    public fun create_customized_pool<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 1337
    }

    public fun create_customized_pool_v2<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, PoolOwnerCap) {
        abort 1337
    }

    public fun create_customized_pool_with_return<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        abort 1337
    }

    public fun create_pool<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 1337
    }

    public fun create_pool_with_return<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        abort 1337
    }

    public fun delete_pool_owner_cap(arg0: PoolOwnerCap) {
        let PoolOwnerCap {
            id    : v0,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun deposit_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0xdee9::custodian_v2::AccountCap) {
        abort 1337
    }

    public fun deposit_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0xdee9::custodian_v2::AccountCap) {
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
            client_order_id              : arg1.client_order_id,
            is_bid                       : arg1.is_bid,
            owner                        : arg1.owner,
            original_quantity            : arg1.original_quantity,
            base_asset_quantity_canceled : arg1.quantity,
            price                        : arg1.price,
        };
        0x2::event::emit<OrderCanceled<T0, T1>>(v0);
    }

    public fun expire_timestamp(arg0: &Order) : u64 {
        arg0.expire_timestamp
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
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        if (0xdee9::critbit::is_empty<TickLevel>(&arg0.asks)) {
            return (v0, v1)
        };
        let (v2, _) = 0xdee9::critbit::min_leaf<TickLevel>(&arg0.asks);
        if (arg2 < v2) {
            return (v0, v1)
        };
        if (arg1 < v2) {
            arg1 = v2;
        };
        let (v4, _) = 0xdee9::critbit::max_leaf<TickLevel>(&arg0.asks);
        if (arg2 > v4) {
            arg2 = v4;
        };
        arg1 = 0xdee9::critbit::find_closest_key<TickLevel>(&arg0.asks, arg1);
        while (arg1 <= 0xdee9::critbit::find_closest_key<TickLevel>(&arg0.asks, arg2)) {
            let v6 = get_level2_book_status(&arg0.asks, arg1, 0x2::clock::timestamp_ms(arg3));
            if (v6 != 0) {
                0x1::vector::push_back<u64>(&mut v0, arg1);
                0x1::vector::push_back<u64>(&mut v1, v6);
            };
            let (v7, _) = 0xdee9::critbit::next_leaf<TickLevel>(&arg0.asks, arg1);
            if (v7 == 0) {
                break
            };
            arg1 = v7;
        };
        (v0, v1)
    }

    public fun get_level2_book_status_bid_side<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        if (0xdee9::critbit::is_empty<TickLevel>(&arg0.bids)) {
            return (v0, v1)
        };
        let (v2, _) = 0xdee9::critbit::min_leaf<TickLevel>(&arg0.bids);
        let (v4, _) = 0xdee9::critbit::max_leaf<TickLevel>(&arg0.bids);
        if (arg1 > v4) {
            return (v0, v1)
        };
        if (arg1 < v2) {
            arg1 = v2;
        };
        if (arg2 > v4) {
            arg2 = v4;
        };
        arg1 = 0xdee9::critbit::find_closest_key<TickLevel>(&arg0.bids, arg1);
        while (arg1 <= 0xdee9::critbit::find_closest_key<TickLevel>(&arg0.bids, arg2)) {
            let v6 = get_level2_book_status(&arg0.bids, arg1, 0x2::clock::timestamp_ms(arg3));
            if (v6 != 0) {
                0x1::vector::push_back<u64>(&mut v0, arg1);
                0x1::vector::push_back<u64>(&mut v1, v6);
            };
            let (v7, _) = 0xdee9::critbit::next_leaf<TickLevel>(&arg0.bids, arg1);
            if (v7 == 0) {
                break
            };
            arg1 = v7;
        };
        (v0, v1)
    }

    public fun get_market_price<T0, T1>(arg0: &Pool<T0, T1>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        let v0 = if (!0xdee9::critbit::is_empty<TickLevel>(&arg0.bids)) {
            let (v1, _) = 0xdee9::critbit::max_leaf<TickLevel>(&arg0.bids);
            0x1::option::some<u64>(v1)
        } else {
            0x1::option::none<u64>()
        };
        let v3 = if (!0xdee9::critbit::is_empty<TickLevel>(&arg0.asks)) {
            let (v4, _) = 0xdee9::critbit::min_leaf<TickLevel>(&arg0.asks);
            0x1::option::some<u64>(v4)
        } else {
            0x1::option::none<u64>()
        };
        (v0, v3)
    }

    public fun get_order_status<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap) : &Order {
        let v0 = 0xdee9::custodian_v2::account_owner(arg2);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0);
        assert!(0x2::linked_table::contains<u64, u64>(v1, arg1), 3);
        let v2 = if (arg1 < 9223372036854775808) {
            &arg0.bids
        } else {
            &arg0.asks
        };
        0x2::linked_table::borrow<u64, Order>(&0xdee9::critbit::borrow_leaf_by_key<TickLevel>(v2, *0x2::linked_table::borrow<u64, u64>(v1, arg1)).open_orders, arg1)
    }

    public fun is_bid(arg0: &Order) : bool {
        arg0.is_bid
    }

    public fun list_open_orders<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap) : vector<Order> {
        let v0 = 0xdee9::custodian_v2::account_owner(arg1);
        let v1 = 0x1::vector::empty<Order>();
        if (!usr_open_orders_exist<T0, T1>(arg0, v0)) {
            return v1
        };
        let v2 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0);
        let v3 = 0x2::linked_table::front<u64, u64>(v2);
        while (!0x1::option::is_none<u64>(v3)) {
            let v4 = if (order_is_bid(*0x1::option::borrow<u64>(v3))) {
                0xdee9::critbit::borrow_leaf_by_key<TickLevel>(&arg0.bids, *0x2::linked_table::borrow<u64, u64>(v2, *0x1::option::borrow<u64>(v3)))
            } else {
                0xdee9::critbit::borrow_leaf_by_key<TickLevel>(&arg0.asks, *0x2::linked_table::borrow<u64, u64>(v2, *0x1::option::borrow<u64>(v3)))
            };
            let v5 = 0x2::linked_table::borrow<u64, Order>(&v4.open_orders, *0x1::option::borrow<u64>(v3));
            let v6 = Order{
                order_id                 : v5.order_id,
                client_order_id          : v5.client_order_id,
                price                    : v5.price,
                original_quantity        : v5.original_quantity,
                quantity                 : v5.quantity,
                is_bid                   : v5.is_bid,
                owner                    : v5.owner,
                expire_timestamp         : v5.expire_timestamp,
                self_matching_prevention : v5.self_matching_prevention,
            };
            0x1::vector::push_back<Order>(&mut v1, v6);
            let v7 = *0x1::option::borrow<u64>(v3);
            v3 = 0x2::linked_table::next<u64, u64>(v2, v7);
        };
        v1
    }

    public fun maker_rebate_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.maker_rebate_rate
    }

    public fun matched_order_metadata_info<T0, T1>(arg0: &MatchedOrderMetadata<T0, T1>) : (0x2::object::ID, u64, bool, address, address, u64, u64, u64, u64) {
        abort 1337
    }

    public fun open_orders(arg0: &TickLevel) : &0x2::linked_table::LinkedTable<u64, Order> {
        &arg0.open_orders
    }

    public fun order_id(arg0: &Order) : u64 {
        arg0.order_id
    }

    fun order_is_bid(arg0: u64) : bool {
        arg0 < 9223372036854775808
    }

    public fun original_quantity(arg0: &Order) : u64 {
        arg0.original_quantity
    }

    public fun owner(arg0: &Order) : address {
        arg0.owner
    }

    public fun place_limit_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: bool, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0xdee9::custodian_v2::AccountCap, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, u64) {
        abort 1337
    }

    public fun place_limit_order_with_metadata<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: bool, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0xdee9::custodian_v2::AccountCap, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, u64, vector<MatchedOrderMetadata<T0, T1>>) {
        abort 1337
    }

    public fun place_market_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 1337
    }

    public fun place_market_order_with_metadata<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, vector<MatchedOrderMetadata<T0, T1>>) {
        abort 1337
    }

    public fun pool_size<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0xdee9::critbit::size<TickLevel>(&arg0.asks) + 0xdee9::critbit::size<TickLevel>(&arg0.bids)
    }

    public fun quantity(arg0: &Order) : u64 {
        arg0.quantity
    }

    public fun quote_asset_trading_fees_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_asset_trading_fees)
    }

    fun remove_order(arg0: &mut 0xdee9::critbit::CritbitTree<TickLevel>, arg1: &mut 0x2::linked_table::LinkedTable<u64, u64>, arg2: u64, arg3: u64, arg4: address) : Order {
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

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        abort 1337
    }

    public fun swap_exact_base_for_quote_with_metadata<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, vector<MatchedOrderMetadata<T0, T1>>) {
        abort 1337
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        abort 1337
    }

    public fun swap_exact_quote_for_base_with_metadata<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, vector<MatchedOrderMetadata<T0, T1>>) {
        abort 1337
    }

    public fun taker_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.taker_fee_rate
    }

    public fun tick_level(arg0: &Order) : u64 {
        arg0.price
    }

    public fun tick_size<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.tick_size
    }

    public fun usr_open_orders<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, u64>> {
        &arg0.usr_open_orders
    }

    public fun usr_open_orders_exist<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, arg1)
    }

    public fun usr_open_orders_for_address<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : &0x2::linked_table::LinkedTable<u64, u64> {
        0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, arg1)
    }

    public fun withdraw_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 6);
        let v0 = WithdrawAsset<T0>{
            pool_id  : *0x2::object::uid_as_inner(&arg0.id),
            quantity : arg1,
            owner    : 0xdee9::custodian_v2::account_owner(arg2),
        };
        0x2::event::emit<WithdrawAsset<T0>>(v0);
        0xdee9::custodian_v2::withdraw_asset<T0>(&mut arg0.base_custodian, arg1, arg2, arg3)
    }

    public fun withdraw_fees<T0, T1>(arg0: &PoolOwnerCap, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.owner == 0x2::object::uid_to_address(&arg1.id), 1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.quote_asset_trading_fees, quote_asset_trading_fees_value<T0, T1>(arg1)), arg2)
    }

    public fun withdraw_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 0, 6);
        let v0 = WithdrawAsset<T1>{
            pool_id  : *0x2::object::uid_as_inner(&arg0.id),
            quantity : arg1,
            owner    : 0xdee9::custodian_v2::account_owner(arg2),
        };
        0x2::event::emit<WithdrawAsset<T1>>(v0);
        0xdee9::custodian_v2::withdraw_asset<T1>(&mut arg0.quote_custodian, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

