module 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2 {
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
        bids: 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<TickLevel>,
        asks: 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<TickLevel>,
        next_bid_order_id: u64,
        next_ask_order_id: u64,
        usr_open_orders: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, u64>>,
        taker_fee_rate: u64,
        maker_rebate_rate: u64,
        tick_size: u64,
        lot_size: u64,
        base_custodian: 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::Custodian<T0>,
        quote_custodian: 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::Custodian<T1>,
        creation_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        base_asset_trading_fees: 0x2::balance::Balance<T0>,
        quote_asset_trading_fees: 0x2::balance::Balance<T1>,
    }

    struct PoolOwnerCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public fun account_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap) : (u64, u64, u64, u64) {
        let v0 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1);
        let (v1, v2) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_balance<T0>(&arg0.base_custodian, v0);
        let (v3, v4) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_balance<T1>(&arg0.quote_custodian, v0);
        (v1, v2, v3, v4)
    }

    public fun asks<T0, T1>(arg0: &Pool<T0, T1>) : &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<TickLevel> {
        &arg0.asks
    }

    public fun batch_cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u64>, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap) {
        let v0 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg2);
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
                let (v9, v10) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v8, v6);
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
                let (_, v14) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v12.quantity, v12.price);
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T1>(&mut arg0.quote_custodian, v0, v14);
            } else {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v0, v12.quantity);
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

    public fun bids<T0, T1>(arg0: &Pool<T0, T1>) : &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<TickLevel> {
        &arg0.bids
    }

    public fun cancel_all_orders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap) {
        let v0 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1);
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
            let (_, v7) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v5, *0x2::linked_table::borrow<u64, u64>(v1, v3));
            let v8 = remove_order(v5, v1, v7, v3, v0);
            if (v4) {
                let (_, v10) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v8.quantity, v8.price);
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T1>(&mut arg0.quote_custodian, v0, v10);
            } else {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v0, v8.quantity);
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

    public fun cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap) {
        let v0 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg2);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0);
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
            let (_, v9) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v7.quantity, v7.price);
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T1>(&mut arg0.quote_custodian, v0, v9);
        } else {
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v0, v7.quantity);
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
                let (v10, v11) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v9, v7);
                assert!(v10, 11);
                v2 = v11;
            };
            let v12 = remove_order(v9, v6, v2, v4, v5);
            assert!(v12.expire_timestamp < 0x2::clock::timestamp_ms(arg1), 19);
            if (v8) {
                let (_, v14) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v12.quantity, v12.price);
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T1>(&mut arg0.quote_custodian, v5, v14);
            } else {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v5, v12.quantity);
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

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap {
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::mint_account_cap(arg0)
    }

    public fun create_customized_pool<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        create_pool_<T0, T1>(arg2, arg3, arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5);
    }

    public fun create_customized_pool_v2<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, PoolOwnerCap) {
        create_pool_with_return_<T0, T1>(arg2, arg3, arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5)
    }

    public fun create_customized_pool_with_return<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let (v0, v1) = create_pool_with_return_<T0, T1>(arg2, arg3, arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5);
        0x2::transfer::public_transfer<PoolOwnerCap>(v1, 0x2::tx_context::sender(arg5));
        v0
    }

    public fun create_pool<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        create_customized_pool<T0, T1>(arg0, arg1, 2500000, 1500000, arg2, arg3);
    }

    fun create_pool_<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_pool_with_return_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<PoolOwnerCap>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun create_pool_with_return<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        create_customized_pool_with_return<T0, T1>(arg0, arg1, 2500000, 1500000, arg2, arg3)
    }

    fun create_pool_with_return_<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, PoolOwnerCap) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg4) == 100000000000, 18);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul(arg3, arg2) > 0, 20);
        assert!(v0 != v1, 16);
        assert!(arg0 >= arg1, 2);
        let v2 = 0x2::object::new(arg5);
        let v3 = PoolOwnerCap{
            id    : 0x2::object::new(arg5),
            owner : 0x2::object::uid_to_address(&v2),
        };
        let v4 = PoolCreated{
            pool_id           : *0x2::object::uid_as_inner(&v2),
            base_asset        : v0,
            quote_asset       : v1,
            taker_fee_rate    : arg0,
            maker_rebate_rate : arg1,
            tick_size         : arg2,
            lot_size          : arg3,
        };
        0x2::event::emit<PoolCreated>(v4);
        let v5 = Pool<T0, T1>{
            id                       : v2,
            bids                     : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::new<TickLevel>(arg5),
            asks                     : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::new<TickLevel>(arg5),
            next_bid_order_id        : 1,
            next_ask_order_id        : 9223372036854775808,
            usr_open_orders          : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, u64>>(arg5),
            taker_fee_rate           : arg0,
            maker_rebate_rate        : arg1,
            tick_size                : arg2,
            lot_size                 : arg3,
            base_custodian           : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::new<T0>(arg5),
            quote_custodian          : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::new<T1>(arg5),
            creation_fee             : arg4,
            base_asset_trading_fees  : 0x2::balance::zero<T0>(),
            quote_asset_trading_fees : 0x2::balance::zero<T1>(),
        };
        (v5, v3)
    }

    public fun delete_pool_owner_cap(arg0: PoolOwnerCap) {
        let PoolOwnerCap {
            id    : v0,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun deposit_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 != 0, 7);
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T0>(&mut arg0.base_custodian, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg2), 0x2::coin::into_balance<T0>(arg1));
        let v1 = DepositAsset<T0>{
            pool_id  : *0x2::object::uid_as_inner(&arg0.id),
            quantity : v0,
            owner    : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg2),
        };
        0x2::event::emit<DepositAsset<T0>>(v1);
    }

    public fun deposit_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 != 0, 8);
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T1>(&mut arg0.quote_custodian, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg2), 0x2::coin::into_balance<T1>(arg1));
        let v1 = DepositAsset<T1>{
            pool_id  : *0x2::object::uid_as_inner(&arg0.id),
            quantity : v0,
            owner    : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg2),
        };
        0x2::event::emit<DepositAsset<T1>>(v1);
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

    fun emit_order_filled<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: &Order, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = OrderFilled<T0, T1>{
            pool_id                       : arg0,
            order_id                      : arg3.order_id,
            taker_client_order_id         : arg1,
            maker_client_order_id         : arg3.client_order_id,
            is_bid                        : arg3.is_bid,
            taker_address                 : arg2,
            maker_address                 : arg3.owner,
            original_quantity             : arg3.original_quantity,
            base_asset_quantity_filled    : arg4,
            base_asset_quantity_remaining : arg3.quantity - arg4,
            price                         : arg3.price,
            taker_commission              : arg5,
            maker_rebates                 : arg6,
        };
        0x2::event::emit<OrderFilled<T0, T1>>(v0);
    }

    public fun expire_timestamp(arg0: &Order) : u64 {
        arg0.expire_timestamp
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
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        if (0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(&arg0.asks)) {
            return (v0, v1)
        };
        let (v2, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(&arg0.asks);
        if (arg2 < v2) {
            return (v0, v1)
        };
        if (arg1 < v2) {
            arg1 = v2;
        };
        let (v4, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::max_leaf<TickLevel>(&arg0.asks);
        if (arg2 > v4) {
            arg2 = v4;
        };
        arg1 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_closest_key<TickLevel>(&arg0.asks, arg1);
        while (arg1 <= 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_closest_key<TickLevel>(&arg0.asks, arg2)) {
            let v6 = get_level2_book_status(&arg0.asks, arg1, 0x2::clock::timestamp_ms(arg3));
            if (v6 != 0) {
                0x1::vector::push_back<u64>(&mut v0, arg1);
                0x1::vector::push_back<u64>(&mut v1, v6);
            };
            let (v7, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<TickLevel>(&arg0.asks, arg1);
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
        if (0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(&arg0.bids)) {
            return (v0, v1)
        };
        let (v2, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(&arg0.bids);
        let (v4, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::max_leaf<TickLevel>(&arg0.bids);
        if (arg1 > v4) {
            return (v0, v1)
        };
        if (arg1 < v2) {
            arg1 = v2;
        };
        if (arg2 > v4) {
            arg2 = v4;
        };
        arg1 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_closest_key<TickLevel>(&arg0.bids, arg1);
        while (arg1 <= 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_closest_key<TickLevel>(&arg0.bids, arg2)) {
            let v6 = get_level2_book_status(&arg0.bids, arg1, 0x2::clock::timestamp_ms(arg3));
            if (v6 != 0) {
                0x1::vector::push_back<u64>(&mut v0, arg1);
                0x1::vector::push_back<u64>(&mut v1, v6);
            };
            let (v7, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<TickLevel>(&arg0.bids, arg1);
            if (v7 == 0) {
                break
            };
            arg1 = v7;
        };
        (v0, v1)
    }

    public fun get_market_price<T0, T1>(arg0: &Pool<T0, T1>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        let v0 = if (!0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(&arg0.bids)) {
            let (v1, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::max_leaf<TickLevel>(&arg0.bids);
            0x1::option::some<u64>(v1)
        } else {
            0x1::option::none<u64>()
        };
        let v3 = if (!0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(&arg0.asks)) {
            let (v4, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(&arg0.asks);
            0x1::option::some<u64>(v4)
        } else {
            0x1::option::none<u64>()
        };
        (v0, v3)
    }

    public fun get_order_status<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap) : &Order {
        let v0 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg2);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0), 12);
        let v1 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0);
        assert!(0x2::linked_table::contains<u64, u64>(v1, arg1), 3);
        let v2 = if (arg1 < 9223372036854775808) {
            &arg0.bids
        } else {
            &arg0.asks
        };
        0x2::linked_table::borrow<u64, Order>(&0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_leaf_by_key<TickLevel>(v2, *0x2::linked_table::borrow<u64, u64>(v1, arg1)).open_orders, arg1)
    }

    fun inject_limit_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u8, arg7: u64, arg8: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg8);
        let (v1, v2) = if (arg5) {
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::lock_balance<T1>(&mut arg0.quote_custodian, arg8, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(arg4, arg2));
            arg0.next_bid_order_id = arg0.next_bid_order_id + 1;
            (&mut arg0.bids, arg0.next_bid_order_id)
        } else {
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::lock_balance<T0>(&mut arg0.base_custodian, arg8, arg4);
            arg0.next_ask_order_id = arg0.next_ask_order_id + 1;
            (&mut arg0.asks, arg0.next_ask_order_id)
        };
        let v3 = Order{
            order_id                 : v2,
            client_order_id          : arg1,
            price                    : arg2,
            original_quantity        : arg3,
            quantity                 : arg4,
            is_bid                   : arg5,
            owner                    : v0,
            expire_timestamp         : arg7,
            self_matching_prevention : arg6,
        };
        let (v4, v5) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v1, arg2);
        let v6 = v5;
        if (!v4) {
            let v7 = TickLevel{
                price       : arg2,
                open_orders : 0x2::linked_table::new<u64, Order>(arg9),
            };
            v6 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::insert_leaf<TickLevel>(v1, arg2, v7);
        };
        0x2::linked_table::push_back<u64, Order>(&mut 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_mut_leaf_by_index<TickLevel>(v1, v6).open_orders, v2, v3);
        let v8 = OrderPlaced<T0, T1>{
            pool_id                    : *0x2::object::uid_as_inner(&arg0.id),
            order_id                   : v2,
            client_order_id            : arg1,
            is_bid                     : arg5,
            owner                      : v0,
            original_quantity          : arg3,
            base_asset_quantity_placed : arg4,
            price                      : arg2,
            expire_timestamp           : arg7,
        };
        0x2::event::emit<OrderPlaced<T0, T1>>(v8);
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0, 0x2::linked_table::new<u64, u64>(arg9));
        };
        0x2::linked_table::push_back<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v0), v2, arg2);
        v2
    }

    public fun is_bid(arg0: &Order) : bool {
        arg0.is_bid
    }

    public fun list_open_orders<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap) : vector<Order> {
        let v0 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1);
        let v1 = 0x1::vector::empty<Order>();
        if (!usr_open_orders_exist<T0, T1>(arg0, v0)) {
            return v1
        };
        let v2 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_open_orders, v0);
        let v3 = 0x2::linked_table::front<u64, u64>(v2);
        while (!0x1::option::is_none<u64>(v3)) {
            let v4 = if (order_is_bid(*0x1::option::borrow<u64>(v3))) {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_leaf_by_key<TickLevel>(&arg0.bids, *0x2::linked_table::borrow<u64, u64>(v2, *0x1::option::borrow<u64>(v3)))
            } else {
                0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_leaf_by_key<TickLevel>(&arg0.asks, *0x2::linked_table::borrow<u64, u64>(v2, *0x1::option::borrow<u64>(v3)))
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

    fun match_ask<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<vector<MatchedOrderMetadata<T0, T1>>>) {
        let v0 = 0x2::balance::zero<T1>();
        let v1 = &mut arg0.bids;
        let v2 = 0x1::vector::empty<MatchedOrderMetadata<T0, T1>>();
        if (0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v1)) {
            return (arg5, v0, 0x1::option::none<vector<MatchedOrderMetadata<T0, T1>>>())
        };
        let (v3, v4) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::max_leaf<TickLevel>(v1);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x1::vector::empty<AllOrdersCanceledComponent<T0, T1>>();
        while (!0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v1) && v6 >= arg3) {
            let v8 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_mut_leaf_by_index<TickLevel>(v1, v5);
            let v9 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v8.open_orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v8.open_orders)) {
                let v10 = 0x2::linked_table::borrow<u64, Order>(&v8.open_orders, v9);
                let v11 = v10.quantity;
                let v12 = v11;
                let v13 = false;
                if (v10.expire_timestamp <= arg4 || 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1) == v10.owner) {
                    v13 = true;
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T1>(&mut arg0.quote_custodian, v10.owner, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v10.quantity, v10.price));
                    let v14 = AllOrdersCanceledComponent<T0, T1>{
                        order_id                     : v10.order_id,
                        client_order_id              : v10.client_order_id,
                        is_bid                       : v10.is_bid,
                        owner                        : v10.owner,
                        original_quantity            : v10.original_quantity,
                        base_asset_quantity_canceled : v10.quantity,
                        price                        : v10.price,
                    };
                    0x1::vector::push_back<AllOrdersCanceledComponent<T0, T1>>(&mut v7, v14);
                } else {
                    let v15 = 0x2::balance::value<T0>(&arg5);
                    let v16 = if (v15 >= v11) {
                        v11
                    } else {
                        v15
                    };
                    let (v17, v18) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v16, v10.price);
                    if (v17) {
                        0x2::balance::join<T1>(&mut arg0.quote_asset_trading_fees, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::decrease_user_locked_balance<T1>(&mut arg0.quote_custodian, v10.owner, 1));
                    };
                    let v19 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul(v18, arg0.maker_rebate_rate);
                    let (v20, v21) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v18, arg0.taker_fee_rate);
                    let v22 = v21;
                    if (v20) {
                        v22 = v21 + 1;
                    };
                    v12 = v11 - v16;
                    let v23 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::decrease_user_locked_balance<T1>(&mut arg0.quote_custodian, v10.owner, v18);
                    let v24 = 0x2::balance::split<T1>(&mut v23, v22);
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v10.owner, 0x2::balance::split<T1>(&mut v24, v19));
                    0x2::balance::join<T1>(&mut arg0.quote_asset_trading_fees, v24);
                    0x2::balance::join<T1>(&mut v0, v23);
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T0>(&mut arg0.base_custodian, v10.owner, 0x2::balance::split<T0>(&mut arg5, v16));
                    emit_order_filled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), arg2, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1), v10, v16, v22, v19);
                    if (arg6) {
                        0x1::vector::push_back<MatchedOrderMetadata<T0, T1>>(&mut v2, matched_order_metadata<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1), v10, v16, v22, v19));
                    };
                };
                if (v13 || v12 == 0) {
                    let v25 = 0x2::linked_table::next<u64, Order>(&v8.open_orders, v9);
                    if (!0x1::option::is_none<u64>(v25)) {
                        v9 = *0x1::option::borrow<u64>(v25);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v10.owner), v9);
                    0x2::linked_table::remove<u64, Order>(&mut v8.open_orders, v9);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v8.open_orders, v9).quantity = v12;
                };
                if (0x2::balance::value<T0>(&arg5) == 0) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v8.open_orders)) {
                let (v26, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::previous_leaf<TickLevel>(v1, v6);
                v6 = v26;
                destroy_empty_level(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::remove_leaf_by_index<TickLevel>(v1, v5));
                let (_, v29) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v1, v26);
                v5 = v29;
            };
            if (0x2::balance::value<T0>(&arg5) == 0) {
                break
            };
        };
        if (!0x1::vector::is_empty<AllOrdersCanceledComponent<T0, T1>>(&v7)) {
            let v30 = AllOrdersCanceled<T0, T1>{
                pool_id         : *0x2::object::uid_as_inner(&arg0.id),
                orders_canceled : v7,
            };
            0x2::event::emit<AllOrdersCanceled<T0, T1>>(v30);
        };
        let v31 = if (arg6) {
            0x1::option::some<vector<MatchedOrderMetadata<T0, T1>>>(v2)
        } else {
            0x1::option::none<vector<MatchedOrderMetadata<T0, T1>>>()
        };
        (arg5, v0, v31)
    }

    fun match_bid<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T1>, arg7: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<vector<MatchedOrderMetadata<T0, T1>>>) {
        let v0 = arg3;
        let v1 = 0x2::balance::zero<T0>();
        let v2 = &mut arg0.asks;
        let v3 = 0x1::vector::empty<MatchedOrderMetadata<T0, T1>>();
        if (0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v2)) {
            return (v1, arg6, 0x1::option::none<vector<MatchedOrderMetadata<T0, T1>>>())
        };
        let (v4, v5) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(v2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1::vector::empty<AllOrdersCanceledComponent<T0, T1>>();
        while (!0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v2) && v7 <= arg4) {
            let v9 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_mut_leaf_by_index<TickLevel>(v2, v6);
            let v10 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v9.open_orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v9.open_orders)) {
                let v11 = 0x2::linked_table::borrow<u64, Order>(&v9.open_orders, v10);
                let v12 = v11.quantity;
                let v13 = v12;
                let v14 = false;
                if (v11.expire_timestamp <= arg5 || 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1) == v11.owner) {
                    v14 = true;
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v11.owner, v11.quantity);
                    let v15 = AllOrdersCanceledComponent<T0, T1>{
                        order_id                     : v11.order_id,
                        client_order_id              : v11.client_order_id,
                        is_bid                       : v11.is_bid,
                        owner                        : v11.owner,
                        original_quantity            : v11.original_quantity,
                        base_asset_quantity_canceled : v11.quantity,
                        price                        : v11.price,
                    };
                    0x1::vector::push_back<AllOrdersCanceledComponent<T0, T1>>(&mut v8, v15);
                } else {
                    let v16 = if (v0 > v12) {
                        v12
                    } else {
                        v0
                    };
                    let v17 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v16, v11.price);
                    let v18 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul(v17, arg0.maker_rebate_rate);
                    let (v19, v20) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v17, arg0.taker_fee_rate);
                    let v21 = v20;
                    if (v19) {
                        v21 = v20 + 1;
                    };
                    v13 = v12 - v16;
                    v0 = v0 - v16;
                    let v22 = 0x2::balance::split<T1>(&mut arg6, v21);
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v11.owner, 0x2::balance::split<T1>(&mut v22, v18));
                    0x2::balance::join<T1>(&mut arg0.quote_asset_trading_fees, v22);
                    0x2::balance::join<T0>(&mut v1, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::decrease_user_locked_balance<T0>(&mut arg0.base_custodian, v11.owner, v12));
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v11.owner, 0x2::balance::split<T1>(&mut arg6, v17));
                    emit_order_filled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), arg2, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1), v11, v12, v21, v18);
                    if (arg7) {
                        0x1::vector::push_back<MatchedOrderMetadata<T0, T1>>(&mut v3, matched_order_metadata<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1), v11, v12, v21, v18));
                    };
                };
                if (v14 || v13 == 0) {
                    let v23 = 0x2::linked_table::next<u64, Order>(&v9.open_orders, v10);
                    if (!0x1::option::is_none<u64>(v23)) {
                        v10 = *0x1::option::borrow<u64>(v23);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v11.owner), v10);
                    0x2::linked_table::remove<u64, Order>(&mut v9.open_orders, v10);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v9.open_orders, v10).quantity = v13;
                };
                if (v0 == 0) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v9.open_orders)) {
                let (v24, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<TickLevel>(v2, v7);
                v7 = v24;
                destroy_empty_level(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::remove_leaf_by_index<TickLevel>(v2, v6));
                let (_, v27) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v2, v24);
                v6 = v27;
            };
            if (v0 == 0) {
                break
            };
        };
        if (!0x1::vector::is_empty<AllOrdersCanceledComponent<T0, T1>>(&v8)) {
            let v28 = AllOrdersCanceled<T0, T1>{
                pool_id         : *0x2::object::uid_as_inner(&arg0.id),
                orders_canceled : v8,
            };
            0x2::event::emit<AllOrdersCanceled<T0, T1>>(v28);
        };
        let v29 = if (arg7) {
            0x1::option::some<vector<MatchedOrderMetadata<T0, T1>>>(v3)
        } else {
            0x1::option::none<vector<MatchedOrderMetadata<T0, T1>>>()
        };
        (v1, arg6, v29)
    }

    fun match_bid_with_quote_quantity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T1>, arg7: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<vector<MatchedOrderMetadata<T0, T1>>>) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = &mut arg0.asks;
        let v2 = 0x1::vector::empty<MatchedOrderMetadata<T0, T1>>();
        if (0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v1)) {
            return (v0, arg6, 0x1::option::none<vector<MatchedOrderMetadata<T0, T1>>>())
        };
        let (v3, v4) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<TickLevel>(v1);
        let v5 = v4;
        let v6 = v3;
        let v7 = false;
        let v8 = 0x1::vector::empty<AllOrdersCanceledComponent<T0, T1>>();
        while (!0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::is_empty<TickLevel>(v1) && v6 <= arg4) {
            let v9 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_mut_leaf_by_index<TickLevel>(v1, v5);
            let v10 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v9.open_orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v9.open_orders)) {
                let v11 = 0x2::linked_table::borrow<u64, Order>(&v9.open_orders, v10);
                let v12 = v11.quantity;
                let v13 = v12;
                let v14 = false;
                if (v11.expire_timestamp <= arg5 || 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1) == v11.owner) {
                    v14 = true;
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::unlock_balance<T0>(&mut arg0.base_custodian, v11.owner, v11.quantity);
                    let v15 = AllOrdersCanceledComponent<T0, T1>{
                        order_id                     : v11.order_id,
                        client_order_id              : v11.client_order_id,
                        is_bid                       : v11.is_bid,
                        owner                        : v11.owner,
                        original_quantity            : v11.original_quantity,
                        base_asset_quantity_canceled : v11.quantity,
                        price                        : v11.price,
                    };
                    0x1::vector::push_back<AllOrdersCanceledComponent<T0, T1>>(&mut v8, v15);
                } else {
                    let v16 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::mul(v12, v11.price);
                    let (v17, v18) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v16, arg0.taker_fee_rate);
                    let v19 = v18;
                    if (v17) {
                        v19 = v18 + 1;
                    };
                    let v20 = v16 + v19;
                    let (v21, v22, v23) = if (arg3 > v20) {
                        (v12, v20, v16)
                    } else {
                        v7 = true;
                        let v24 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_div(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_div(arg3, 1000000000 + arg0.taker_fee_rate), v11.price) / arg0.lot_size * arg0.lot_size;
                        let v25 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul(v24, v11.price);
                        let (v26, v27) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul_round(v25, arg0.taker_fee_rate);
                        let v28 = v27;
                        if (v26) {
                            v28 = v27 + 1;
                        };
                        (v24, v25 + v28, v25)
                    };
                    let v29 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::math::unsafe_mul(v23, arg0.maker_rebate_rate);
                    v13 = v12 - v21;
                    arg3 = arg3 - v22;
                    let v30 = 0x2::balance::split<T1>(&mut arg6, v22);
                    0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v11.owner, 0x2::balance::split<T1>(&mut v30, v29 + v23));
                    0x2::balance::join<T1>(&mut arg0.quote_asset_trading_fees, v30);
                    0x2::balance::join<T0>(&mut v0, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::decrease_user_locked_balance<T0>(&mut arg0.base_custodian, v11.owner, v21));
                    emit_order_filled<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), arg2, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1), v11, v21, v22 - v23, v29);
                    if (arg7) {
                        0x1::vector::push_back<MatchedOrderMetadata<T0, T1>>(&mut v2, matched_order_metadata<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg1), v11, v21, v22 - v23, v29));
                    };
                };
                if (v14 || v13 == 0) {
                    let v31 = 0x2::linked_table::next<u64, Order>(&v9.open_orders, v10);
                    if (!0x1::option::is_none<u64>(v31)) {
                        v10 = *0x1::option::borrow<u64>(v31);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_open_orders, v11.owner), v10);
                    0x2::linked_table::remove<u64, Order>(&mut v9.open_orders, v10);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v9.open_orders, v10).quantity = v13;
                };
                if (v7) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v9.open_orders)) {
                let (v32, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<TickLevel>(v1, v6);
                v6 = v32;
                destroy_empty_level(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::remove_leaf_by_index<TickLevel>(v1, v5));
                let (_, v35) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::find_leaf<TickLevel>(v1, v32);
                v5 = v35;
            };
            if (v7) {
                break
            };
        };
        if (!0x1::vector::is_empty<AllOrdersCanceledComponent<T0, T1>>(&v8)) {
            let v36 = AllOrdersCanceled<T0, T1>{
                pool_id         : *0x2::object::uid_as_inner(&arg0.id),
                orders_canceled : v8,
            };
            0x2::event::emit<AllOrdersCanceled<T0, T1>>(v36);
        };
        let v37 = if (arg7) {
            0x1::option::some<vector<MatchedOrderMetadata<T0, T1>>>(v2)
        } else {
            0x1::option::none<vector<MatchedOrderMetadata<T0, T1>>>()
        };
        (v0, arg6, v37)
    }

    fun matched_order_metadata<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: &Order, arg3: u64, arg4: u64, arg5: u64) : MatchedOrderMetadata<T0, T1> {
        MatchedOrderMetadata<T0, T1>{
            pool_id                    : arg0,
            order_id                   : arg2.order_id,
            is_bid                     : arg2.is_bid,
            taker_address              : arg1,
            maker_address              : arg2.owner,
            base_asset_quantity_filled : arg3,
            price                      : arg2.price,
            taker_commission           : arg4,
            maker_rebates              : arg5,
        }
    }

    public fun matched_order_metadata_info<T0, T1>(arg0: &MatchedOrderMetadata<T0, T1>) : (0x2::object::ID, u64, bool, address, address, u64, u64, u64, u64) {
        (arg0.pool_id, arg0.order_id, arg0.is_bid, arg0.taker_address, arg0.maker_address, arg0.base_asset_quantity_filled, arg0.price, arg0.taker_commission, arg0.maker_rebates)
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

    public fun place_limit_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: bool, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, u64) {
        let (v0, v1, v2, v3, _) = place_limit_order_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, false, arg10);
        (v0, v1, v2, v3)
    }

    fun place_limit_order_int<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: bool, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, u64, 0x1::option::Option<vector<MatchedOrderMetadata<T0, T1>>>) {
        assert!(arg4 == 0, 21);
        assert!(arg3 > 0, 6);
        assert!(arg2 > 0, 5);
        assert!(arg2 % arg0.tick_size == 0, 5);
        assert!(arg3 % arg0.lot_size == 0, 6);
        assert!(arg6 > 0x2::clock::timestamp_ms(arg8), 19);
        let v0 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg9);
        let (v1, v2, v3) = if (arg5) {
            let v4 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_available_balance<T1>(&arg0.quote_custodian, v0);
            let v5 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::decrease_user_available_balance<T1>(&mut arg0.quote_custodian, arg9, v4);
            let (v6, v7, v8) = match_bid<T0, T1>(arg0, arg9, arg1, arg3, arg2, 0x2::clock::timestamp_ms(arg8), v5, arg10);
            let v9 = v7;
            let v10 = v6;
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T0>(&mut arg0.base_custodian, v0, v10);
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v0, v9);
            (v8, 0x2::balance::value<T0>(&v10), v4 - 0x2::balance::value<T1>(&v9))
        } else {
            let v11 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::decrease_user_available_balance<T0>(&mut arg0.base_custodian, arg9, arg3);
            let (v12, v13, v14) = match_ask<T0, T1>(arg0, arg9, arg1, arg2, 0x2::clock::timestamp_ms(arg8), v11, arg10);
            let v15 = v13;
            let v16 = v12;
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T0>(&mut arg0.base_custodian, v0, v16);
            0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::increase_user_available_balance<T1>(&mut arg0.quote_custodian, v0, v15);
            (v14, arg3 - 0x2::balance::value<T0>(&v16), 0x2::balance::value<T1>(&v15))
        };
        if (arg7 == 1) {
            return (v2, v3, false, 0, v1)
        };
        if (arg7 == 2) {
            assert!(v2 == arg3, 9);
            return (v2, v3, false, 0, v1)
        };
        if (arg7 == 3) {
            assert!(v2 == 0, 10);
            return (v2, v3, true, inject_limit_order<T0, T1>(arg0, arg1, arg2, arg3, arg3, arg5, arg4, arg6, arg9, arg11), v1)
        };
        assert!(arg7 == 0, 14);
        if (arg3 > v2) {
            return (v2, v3, true, inject_limit_order<T0, T1>(arg0, arg1, arg2, arg3, arg3 - v2, arg5, arg4, arg6, arg9, arg11), v1)
        };
        (v2, v3, false, 0, v1)
    }

    public fun place_limit_order_with_metadata<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: bool, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, bool, u64, vector<MatchedOrderMetadata<T0, T1>>) {
        let (v0, v1, v2, v3, v4) = place_limit_order_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, true, arg10);
        let v5 = v4;
        (v0, v1, v2, v3, 0x1::option::extract<vector<MatchedOrderMetadata<T0, T1>>>(&mut v5))
    }

    public fun place_market_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, _) = place_market_order_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, arg8);
        (v0, v1)
    }

    fun place_market_order_int<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1::option::Option<vector<MatchedOrderMetadata<T0, T1>>>) {
        assert!(arg3 % arg0.lot_size == 0, 6);
        assert!(arg3 != 0, 6);
        let v0 = if (arg4) {
            let (v1, v2, v3) = match_bid<T0, T1>(arg0, arg1, arg2, arg3, 9223372036854775808, 0x2::clock::timestamp_ms(arg7), 0x2::coin::into_balance<T1>(arg6), arg8);
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v1, arg9));
            arg6 = 0x2::coin::from_balance<T1>(v2, arg9);
            v3
        } else {
            assert!(arg3 <= 0x2::coin::value<T0>(&arg5), 7);
            let (v4, v5, v6) = match_ask<T0, T1>(arg0, arg1, arg2, 0, 0x2::clock::timestamp_ms(arg7), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, arg3, arg9)), arg8);
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v4, arg9));
            0x2::coin::join<T1>(&mut arg6, 0x2::coin::from_balance<T1>(v5, arg9));
            v6
        };
        (arg5, arg6, v0)
    }

    public fun place_market_order_with_metadata<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, vector<MatchedOrderMetadata<T0, T1>>) {
        let (v0, v1, v2) = place_market_order_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, true, arg8);
        let v3 = v2;
        (v0, v1, 0x1::option::extract<vector<MatchedOrderMetadata<T0, T1>>>(&mut v3))
    }

    public fun pool_size<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::size<TickLevel>(&arg0.asks) + 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::size<TickLevel>(&arg0.bids)
    }

    public fun quantity(arg0: &Order) : u64 {
        arg0.quantity
    }

    public fun quote_asset_trading_fees_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_asset_trading_fees)
    }

    fun remove_order(arg0: &mut 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<TickLevel>, arg1: &mut 0x2::linked_table::LinkedTable<u64, u64>, arg2: u64, arg3: u64, arg4: address) : Order {
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

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        assert!(arg3 > 0, 6);
        assert!(0x2::coin::value<T0>(&arg4) >= arg3, 7);
        let (v0, v1) = place_market_order<T0, T1>(arg0, arg2, arg1, arg3, false, arg4, arg5, arg6, arg7);
        let v2 = v1;
        (v0, v2, 0x2::coin::value<T1>(&v2) - 0x2::coin::value<T1>(&arg5))
    }

    public fun swap_exact_base_for_quote_with_metadata<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, vector<MatchedOrderMetadata<T0, T1>>) {
        let (v0, v1, v2) = place_market_order_int<T0, T1>(arg0, arg2, arg1, arg3, false, arg4, arg5, arg6, true, arg7);
        let v3 = v2;
        let v4 = v1;
        (v0, v4, 0x2::coin::value<T1>(&v4) - 0x2::coin::value<T1>(&arg5), 0x1::option::extract<vector<MatchedOrderMetadata<T0, T1>>>(&mut v3))
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        assert!(arg3 > 0, 6);
        assert!(0x2::coin::value<T1>(&arg5) >= arg3, 8);
        let (v0, v1, _) = match_bid_with_quote_quantity<T0, T1>(arg0, arg2, arg1, arg3, 9223372036854775808, 0x2::clock::timestamp_ms(arg4), 0x2::coin::into_balance<T1>(arg5), false);
        let v3 = v0;
        (0x2::coin::from_balance<T0>(v3, arg6), 0x2::coin::from_balance<T1>(v1, arg6), 0x2::balance::value<T0>(&v3))
    }

    public fun swap_exact_quote_for_base_with_metadata<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, vector<MatchedOrderMetadata<T0, T1>>) {
        assert!(arg3 > 0, 6);
        assert!(0x2::coin::value<T1>(&arg5) >= arg3, 8);
        let (v0, v1, v2) = match_bid_with_quote_quantity<T0, T1>(arg0, arg2, arg1, arg3, 9223372036854775808, 0x2::clock::timestamp_ms(arg4), 0x2::coin::into_balance<T1>(arg5), true);
        let v3 = v2;
        let v4 = v0;
        (0x2::coin::from_balance<T0>(v4, arg6), 0x2::coin::from_balance<T1>(v1, arg6), 0x2::balance::value<T0>(&v4), 0x1::option::extract<vector<MatchedOrderMetadata<T0, T1>>>(&mut v3))
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

    public fun withdraw_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 6);
        let v0 = WithdrawAsset<T0>{
            pool_id  : *0x2::object::uid_as_inner(&arg0.id),
            quantity : arg1,
            owner    : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg2),
        };
        0x2::event::emit<WithdrawAsset<T0>>(v0);
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::withdraw_asset<T0>(&mut arg0.base_custodian, arg1, arg2, arg3)
    }

    public fun withdraw_fees<T0, T1>(arg0: &PoolOwnerCap, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.owner == 0x2::object::uid_to_address(&arg1.id), 1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.quote_asset_trading_fees, quote_asset_trading_fees_value<T0, T1>(arg1)), arg2)
    }

    public fun withdraw_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::AccountCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 0, 6);
        let v0 = WithdrawAsset<T1>{
            pool_id  : *0x2::object::uid_as_inner(&arg0.id),
            quantity : arg1,
            owner    : 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::account_owner(arg2),
        };
        0x2::event::emit<WithdrawAsset<T1>>(v0);
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2::withdraw_asset<T1>(&mut arg0.quote_custodian, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

