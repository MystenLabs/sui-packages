module 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::clob {
    struct ClobCap has key {
        id: 0x2::object::UID,
    }

    struct Order has drop, store {
        order_id: u64,
        price: u64,
        original_quantity: u64,
        quantity: u64,
        is_bid: bool,
        owner: address,
    }

    struct TickLevel has store {
        price: u64,
        orders: 0x2::linked_table::LinkedTable<u64, Order>,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        buy_list: 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::CritbitTree<TickLevel>,
        sell_list: 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::CritbitTree<TickLevel>,
        usr_list: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, u64>>,
        current_order_id: u64,
        current_price: u64,
        price_decimals: u8,
        token0: 0x1::type_name::TypeName,
        token1: 0x1::type_name::TypeName,
        token0_decimals: u8,
        token1_decimals: u8,
        token0_balance: 0x2::balance::Balance<T0>,
        token1_balance: 0x2::balance::Balance<T1>,
        token0_fee_balance: 0x2::balance::Balance<T0>,
        token1_fee_balance: 0x2::balance::Balance<T1>,
        fee_rate: u64,
        state: bool,
        usr_mark: 0x2::table::Table<address, u8>,
        version: u64,
    }

    struct PriceDepth has drop {
        sell_price_list: vector<u64>,
        sell_original_quantity_list: vector<u64>,
        sell_quantity_list: vector<u64>,
        buy_price_list: vector<u64>,
        buy_original_quantity_list: vector<u64>,
        buy_quantity_list: vector<u64>,
    }

    struct OrderPlaced has copy, drop {
        pool_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        owner: address,
        quantity: u64,
        price: u64,
    }

    struct OrderCanceled has copy, drop {
        pool_id: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        owner: address,
        quantity_canceled: u64,
        price: u64,
        force: bool,
    }

    struct OrderCompleteFilled has copy, drop {
        pool_id: 0x2::object::ID,
        order_id: u64,
    }

    struct OrderFilled has copy, drop, store {
        pool_id: 0x2::object::ID,
        is_bid: bool,
        bid_order_id: u64,
        ask_order_id: u64,
        token0_deal_quantity: u64,
        token1_deal_quantity: u64,
        token0_fee_quantity: u64,
        token1_fee_quantity: u64,
        price: u64,
    }

    public fun batch_cancel_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 6, 301);
        let v0 = 0x2::tx_context::sender(arg2);
        batch_cancel_order_internal<T0, T1>(arg0, arg1, v0, false, arg2);
    }

    fun batch_cancel_order_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u64>, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_list, arg2), 0);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_list, arg2);
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v1);
            assert!(0x2::linked_table::contains<u64, u64>(v2, v3), 0);
            let v4 = *0x2::linked_table::borrow<u64, u64>(v2, v3);
            let (v5, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(&arg0.buy_list, v4);
            if (v4 != 0) {
                let v7 = if (v5) {
                    &arg0.buy_list
                } else {
                    &arg0.sell_list
                };
                let (v8, v9) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(v7, v4);
                assert!(v8, 1);
                v0 = v9;
            };
            let v10 = if (v5) {
                &mut arg0.buy_list
            } else {
                &mut arg0.sell_list
            };
            let v11 = remove_order(*0x2::object::uid_as_inner(&arg0.id), v10, v2, v0, v3, arg3);
            if (v5) {
                if (v11.price == 9223372036854775808) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token1_balance, v11.quantity, arg4), v11.owner);
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token1_balance, convert_amount_token0_token1(arg0.token0_decimals, arg0.token1_decimals, v11.quantity * v11.price / 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0.price_decimals)), arg4), v11.owner);
                };
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token0_balance, v11.quantity, arg4), v11.owner);
            };
            v1 = v1 + 1;
        };
    }

    public entry fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 6, 301);
        assert!(arg2 > 0, 0);
        assert!(arg2 < 9223372036854775808, 1);
        assert!(can_deal<T0, T1>(arg0, 0x2::tx_context::sender(arg4)), 2);
        let v0 = convert_amount_token0_token1(arg0.token0_decimals, arg0.token1_decimals, arg3 * arg2 / 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0.price_decimals));
        assert!(v0 > 0, 3);
        0x2::balance::join<T1>(&mut arg0.token1_balance, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg1), v0));
        let v1 = inject_limit_order<T0, T1>(arg0, arg2, arg3, arg3, true, arg4);
        let (v2, v3) = match_bid<T0, T1>(arg0, arg3, arg2, v1, arg4);
        let (_, v5) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(&arg0.buy_list, arg2);
        let v6 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_mut_leaf_by_index<TickLevel>(&mut arg0.buy_list, v5);
        let v7 = 0x2::linked_table::borrow_mut<u64, Order>(&mut v6.orders, v1);
        if (arg3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token0_balance, arg3 - v2 - v3), arg4), v7.owner);
        };
        if (v2 > 0) {
            v7.quantity = v2;
        } else {
            0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_list, v7.owner), v1);
            0x2::linked_table::remove<u64, Order>(&mut v6.orders, v1);
            if (0x2::linked_table::is_empty<u64, Order>(&v6.orders)) {
                destroy_empty_level(0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::remove_leaf_by_index<TickLevel>(&mut arg0.buy_list, v5));
            };
            let v8 = OrderCompleteFilled{
                pool_id  : *0x2::object::uid_as_inner(&arg0.id),
                order_id : v1,
            };
            0x2::event::emit<OrderCompleteFilled>(v8);
        };
    }

    public fun can_deal<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : bool {
        arg0.state || usr_mark<T0, T1>(arg0, arg1) == 2
    }

    fun convert_amount_token0_token1(arg0: u8, arg1: u8, arg2: u64) : u64 {
        if (arg0 == arg1) {
            arg2
        } else if (arg0 > arg1) {
            arg2 / 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0 - arg1)
        } else {
            arg2 * 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg1 - arg0)
        }
    }

    fun convert_amount_token1_token0(arg0: u8, arg1: u8, arg2: u64) : u64 {
        if (arg0 == arg1) {
            arg2
        } else if (arg0 > arg1) {
            arg2 * 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0 - arg1)
        } else {
            arg2 / 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg1 - arg0)
        }
    }

    public entry fun create_pool<T0, T1>(arg0: &mut ClobCap, arg1: u64, arg2: u8, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id                 : 0x2::object::new(arg5),
            owner              : 0x2::tx_context::sender(arg5),
            buy_list           : 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::new<TickLevel>(arg5),
            sell_list          : 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::new<TickLevel>(arg5),
            usr_list           : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, u64>>(arg5),
            current_order_id   : 0,
            current_price      : arg1,
            price_decimals     : arg2,
            token0             : 0x1::type_name::get<T0>(),
            token1             : 0x1::type_name::get<T1>(),
            token0_decimals    : arg3,
            token1_decimals    : arg4,
            token0_balance     : 0x2::balance::zero<T0>(),
            token1_balance     : 0x2::balance::zero<T1>(),
            token0_fee_balance : 0x2::balance::zero<T0>(),
            token1_fee_balance : 0x2::balance::zero<T1>(),
            fee_rate           : 0,
            state              : false,
            usr_mark           : 0x2::table::new<address, u8>(arg5),
            version            : 6,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    fun destroy_empty_level(arg0: TickLevel) {
        let TickLevel {
            price  : _,
            orders : v1,
        } = arg0;
        0x2::linked_table::destroy_empty<u64, Order>(v1);
    }

    public entry fun force_batch_cancel_order<T0, T1>(arg0: &mut ClobCap, arg1: &mut Pool<T0, T1>, arg2: vector<vector<u64>>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            batch_cancel_order_internal<T0, T1>(arg1, *0x1::vector::borrow<vector<u64>>(&arg2, v0), *0x1::vector::borrow<address>(&arg3, v0), true, arg4);
            v0 = v0 + 1;
        };
    }

    public entry fun increase_pool_balance<T0, T1>(arg0: &mut ClobCap, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64) {
        if (arg4 > 0) {
            0x2::balance::join<T0>(&mut arg1.token0_balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg4));
        };
        if (arg5 > 0) {
            0x2::balance::join<T1>(&mut arg1.token1_balance, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg3), arg5));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClobCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ClobCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun inject_limit_order<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = if (arg4) {
            arg0.current_order_id = arg0.current_order_id + 1;
            (&mut arg0.buy_list, arg0.current_order_id)
        } else {
            arg0.current_order_id = arg0.current_order_id + 1;
            (&mut arg0.sell_list, arg0.current_order_id)
        };
        let v3 = Order{
            order_id          : v2,
            price             : arg1,
            original_quantity : arg2,
            quantity          : arg3,
            is_bid            : arg4,
            owner             : v0,
        };
        let (v4, v5) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(v1, arg1);
        let v6 = v5;
        if (!v4) {
            let v7 = TickLevel{
                price  : arg1,
                orders : 0x2::linked_table::new<u64, Order>(arg5),
            };
            v6 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::insert_leaf<TickLevel>(v1, arg1, v7);
        };
        0x2::linked_table::push_back<u64, Order>(&mut 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_mut_leaf_by_index<TickLevel>(v1, v6).orders, v2, v3);
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_list, v0)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_list, v0, 0x2::linked_table::new<u64, u64>(arg5));
        };
        0x2::linked_table::push_back<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_list, v0), v2, arg1);
        let v8 = OrderPlaced{
            pool_id  : *0x2::object::uid_as_inner(&arg0.id),
            order_id : v2,
            is_bid   : arg4,
            owner    : v0,
            quantity : arg3,
            price    : arg1,
        };
        0x2::event::emit<OrderPlaced>(v8);
        v2
    }

    public entry fun market_buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 6, 301);
        assert!(can_deal<T0, T1>(arg0, 0x2::tx_context::sender(arg3)), 2);
        assert!(arg2 > 0, 3);
        0x2::balance::join<T1>(&mut arg0.token1_balance, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg1), arg2));
        let v0 = inject_limit_order<T0, T1>(arg0, 9223372036854775808, arg2, arg2, true, arg3);
        let (v1, v2, v3) = match_bid_with_b_quantity<T0, T1>(arg0, arg2, v0, arg3);
        let (_, v5) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(&arg0.buy_list, 9223372036854775808);
        let v6 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_mut_leaf_by_index<TickLevel>(&mut arg0.buy_list, v5);
        let v7 = 0x2::linked_table::borrow_mut<u64, Order>(&mut v6.orders, v0);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token0_balance, v1 - v3), arg3), v7.owner);
        };
        if (v2 > 0) {
            v7.quantity = v2;
        } else {
            0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_list, v7.owner), v0);
            0x2::linked_table::remove<u64, Order>(&mut v6.orders, v0);
            if (0x2::linked_table::is_empty<u64, Order>(&v6.orders)) {
                destroy_empty_level(0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::remove_leaf_by_index<TickLevel>(&mut arg0.buy_list, v5));
            };
            let v8 = OrderCompleteFilled{
                pool_id  : *0x2::object::uid_as_inner(&arg0.id),
                order_id : v0,
            };
            0x2::event::emit<OrderCompleteFilled>(v8);
        };
    }

    fun match_ask<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = &mut arg0.buy_list;
        if (0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::is_empty<TickLevel>(v5)) {
            return (arg1, v1, v3)
        };
        let (v6, v7) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::max_leaf<TickLevel>(v5);
        let v8 = v7;
        let v9 = v6;
        if (arg2 == 0) {
            assert!(v6 != 9223372036854775808, 3);
        };
        while (!0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::is_empty<TickLevel>(v5) && v9 >= arg2) {
            let v10 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_mut_leaf_by_index<TickLevel>(v5, v8);
            let v11 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v10.orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v10.orders)) {
                let v12 = 0x2::linked_table::borrow<u64, Order>(&v10.orders, v11);
                let v13 = v12.price;
                let v14 = v13;
                if (v13 == 9223372036854775808) {
                    v14 = arg2;
                };
                let v15 = v12.quantity;
                if (v12.price == 9223372036854775808) {
                    v15 = convert_amount_token1_token0(arg0.token0_decimals, arg0.token1_decimals, v12.quantity * 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0.price_decimals) / v14);
                };
                let v16 = if (v0 >= v15) {
                    v15
                } else {
                    v0
                };
                let v17 = 0;
                if (arg0.fee_rate > 0) {
                    v17 = v16 * arg0.fee_rate / 10000;
                };
                let v18 = convert_amount_token0_token1(arg0.token0_decimals, arg0.token1_decimals, v16 * v14 / 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0.price_decimals));
                let v19 = 0;
                if (arg0.fee_rate > 0) {
                    v19 = v18 * arg0.fee_rate / 10000;
                };
                if (v19 > 0) {
                    v4 = v4 + v19;
                    0x2::balance::join<T1>(&mut arg0.token1_fee_balance, 0x2::balance::split<T1>(&mut arg0.token1_balance, v19));
                };
                v2 = v2 + v18;
                let v20 = v15 - v16;
                let v21 = v0 - v16;
                v0 = v21;
                let v22 = 0x2::balance::split<T0>(&mut arg0.token0_balance, v15);
                if (v17 > 0) {
                    0x2::balance::join<T0>(&mut arg0.token0_fee_balance, 0x2::balance::split<T0>(&mut v22, v17));
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v22, arg4), v12.owner);
                let v23 = OrderFilled{
                    pool_id              : *0x2::object::uid_as_inner(&arg0.id),
                    is_bid               : false,
                    bid_order_id         : v11,
                    ask_order_id         : arg3,
                    token0_deal_quantity : v15,
                    token1_deal_quantity : v18,
                    token0_fee_quantity  : v17,
                    token1_fee_quantity  : v19,
                    price                : v14,
                };
                0x2::event::emit<OrderFilled>(v23);
                arg0.current_price = v14;
                if (v20 == 0) {
                    let v24 = 0x2::linked_table::next<u64, Order>(&v10.orders, v11);
                    if (!0x1::option::is_none<u64>(v24)) {
                        v11 = *0x1::option::borrow<u64>(v24);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_list, v12.owner), v11);
                    0x2::linked_table::remove<u64, Order>(&mut v10.orders, v11);
                    let v25 = OrderCompleteFilled{
                        pool_id  : *0x2::object::uid_as_inner(&arg0.id),
                        order_id : v11,
                    };
                    0x2::event::emit<OrderCompleteFilled>(v25);
                } else {
                    let v26 = 0x2::linked_table::borrow_mut<u64, Order>(&mut v10.orders, v11);
                    if (v26.price == 9223372036854775808) {
                        v26.quantity = convert_amount_token0_token1(arg0.token0_decimals, arg0.token1_decimals, v20 * v14 / 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0.price_decimals));
                    } else {
                        v26.quantity = v20;
                    };
                };
                if (v21 == 0) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v10.orders)) {
                let (v27, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::previous_leaf<TickLevel>(v5, v9);
                v9 = v27;
                destroy_empty_level(0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::remove_leaf_by_index<TickLevel>(v5, v8));
                let (_, v30) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(v5, v27);
                v8 = v30;
            };
            if (v0 == 0) {
                break
            };
        };
        (v0, v2, v4)
    }

    fun match_bid<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut arg0.sell_list;
        if (0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::is_empty<TickLevel>(v3)) {
            return (arg1, v1)
        };
        let (v4, v5) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::min_leaf<TickLevel>(v3);
        let v6 = v5;
        let v7 = v4;
        while (!0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::is_empty<TickLevel>(v3) && v7 <= arg2) {
            let v8 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_mut_leaf_by_index<TickLevel>(v3, v6);
            let v9 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v8.orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v8.orders)) {
                let v10 = 0x2::linked_table::borrow<u64, Order>(&v8.orders, v9);
                let v11 = v10.quantity;
                let v12 = if (v0 > v11) {
                    v11
                } else {
                    v0
                };
                let v13 = 0;
                if (arg0.fee_rate > 0) {
                    v13 = v12 * arg0.fee_rate / 10000;
                };
                if (v13 > 0) {
                    v2 = v2 + v13;
                    0x2::balance::join<T0>(&mut arg0.token0_fee_balance, 0x2::balance::split<T0>(&mut arg0.token0_balance, v13));
                };
                let v14 = convert_amount_token0_token1(arg0.token0_decimals, arg0.token1_decimals, v12 * arg2 / 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0.price_decimals));
                let v15 = 0;
                if (arg0.fee_rate > 0) {
                    v15 = v14 * arg0.fee_rate / 10000;
                };
                let v16 = 0x2::balance::split<T1>(&mut arg0.token1_balance, v14);
                if (v15 > 0) {
                    0x2::balance::join<T1>(&mut arg0.token1_fee_balance, 0x2::balance::split<T1>(&mut v16, v15));
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg4), v10.owner);
                let v17 = OrderFilled{
                    pool_id              : *0x2::object::uid_as_inner(&arg0.id),
                    is_bid               : true,
                    bid_order_id         : arg3,
                    ask_order_id         : v9,
                    token0_deal_quantity : v12,
                    token1_deal_quantity : v14,
                    token0_fee_quantity  : v13,
                    token1_fee_quantity  : v15,
                    price                : arg2,
                };
                0x2::event::emit<OrderFilled>(v17);
                let v18 = v11 - v12;
                let v19 = v0 - v12;
                v0 = v19;
                arg0.current_price = arg2;
                if (v18 == 0) {
                    let v20 = 0x2::linked_table::next<u64, Order>(&v8.orders, v9);
                    if (!0x1::option::is_none<u64>(v20)) {
                        v9 = *0x1::option::borrow<u64>(v20);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_list, v10.owner), v9);
                    0x2::linked_table::remove<u64, Order>(&mut v8.orders, v9);
                    let v21 = OrderCompleteFilled{
                        pool_id  : *0x2::object::uid_as_inner(&arg0.id),
                        order_id : v9,
                    };
                    0x2::event::emit<OrderCompleteFilled>(v21);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v8.orders, v9).quantity = v18;
                };
                if (v19 == 0) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v8.orders)) {
                let (v22, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::next_leaf<TickLevel>(v3, v7);
                v7 = v22;
                destroy_empty_level(0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::remove_leaf_by_index<TickLevel>(v3, v6));
                let (_, v25) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(v3, v22);
                v6 = v25;
            };
            if (v0 == 0) {
                break
            };
        };
        (v0, v2)
    }

    fun match_bid_with_b_quantity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = &mut arg0.sell_list;
        if (0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::is_empty<TickLevel>(v5)) {
            return (v1, arg1, v3)
        };
        let (v6, v7) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::min_leaf<TickLevel>(v5);
        let v8 = v7;
        let v9 = v6;
        assert!(v6 != 0, 3);
        while (!0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::is_empty<TickLevel>(v5) && v9 <= 9223372036854775808) {
            let v10 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_mut_leaf_by_index<TickLevel>(v5, v8);
            let v11 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Order>(&v10.orders));
            while (!0x2::linked_table::is_empty<u64, Order>(&v10.orders)) {
                let v12 = 0x2::linked_table::borrow<u64, Order>(&v10.orders, v11);
                let v13 = v12.quantity;
                let v14 = convert_amount_token1_token0(arg0.token0_decimals, arg0.token1_decimals, v0 * 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0.price_decimals) / v12.price);
                if (v14 == 0) {
                    v0 = 0;
                    break
                };
                let v15 = if (v14 > v13) {
                    v13
                } else {
                    v14
                };
                let v16 = 0;
                if (arg0.fee_rate > 0) {
                    v16 = v15 * arg0.fee_rate / 10000;
                };
                if (v16 > 0) {
                    v4 = v4 + v16;
                    0x2::balance::join<T0>(&mut arg0.token0_fee_balance, 0x2::balance::split<T0>(&mut arg0.token0_balance, v16));
                };
                v2 = v2 + v15;
                let v17 = convert_amount_token0_token1(arg0.token0_decimals, arg0.token1_decimals, v15 * v12.price / 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::math::pow(10, arg0.price_decimals));
                let v18 = 0;
                if (arg0.fee_rate > 0) {
                    v18 = v17 * arg0.fee_rate / 10000;
                };
                let v19 = 0x2::balance::split<T1>(&mut arg0.token1_balance, v17);
                if (v18 > 0) {
                    0x2::balance::join<T1>(&mut arg0.token1_fee_balance, 0x2::balance::split<T1>(&mut v19, v18));
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v19, arg3), v12.owner);
                let v20 = OrderFilled{
                    pool_id              : *0x2::object::uid_as_inner(&arg0.id),
                    is_bid               : true,
                    bid_order_id         : arg2,
                    ask_order_id         : v11,
                    token0_deal_quantity : v15,
                    token1_deal_quantity : v17,
                    token0_fee_quantity  : v16,
                    token1_fee_quantity  : v18,
                    price                : v12.price,
                };
                0x2::event::emit<OrderFilled>(v20);
                let v21 = v13 - v15;
                let v22 = v0 - v17;
                v0 = v22;
                arg0.current_price = v12.price;
                if (v21 == 0) {
                    let v23 = 0x2::linked_table::next<u64, Order>(&v10.orders, v11);
                    if (!0x1::option::is_none<u64>(v23)) {
                        v11 = *0x1::option::borrow<u64>(v23);
                    };
                    0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_list, v12.owner), v11);
                    0x2::linked_table::remove<u64, Order>(&mut v10.orders, v11);
                    let v24 = OrderCompleteFilled{
                        pool_id  : *0x2::object::uid_as_inner(&arg0.id),
                        order_id : v11,
                    };
                    0x2::event::emit<OrderCompleteFilled>(v24);
                } else {
                    0x2::linked_table::borrow_mut<u64, Order>(&mut v10.orders, v11).quantity = v21;
                };
                if (v22 == 0) {
                    break
                };
            };
            if (0x2::linked_table::is_empty<u64, Order>(&v10.orders)) {
                let (v25, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::next_leaf<TickLevel>(v5, v9);
                v9 = v25;
                destroy_empty_level(0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::remove_leaf_by_index<TickLevel>(v5, v8));
                let (_, v28) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(v5, v25);
                v8 = v28;
            };
            if (v0 == 0) {
                break
            };
        };
        (v2, v0, v4)
    }

    public entry fun migrate<T0, T1>(arg0: &mut ClobCap, arg1: &mut Pool<T0, T1>) {
        assert!(arg1.version < 6, 0);
        arg1.version = 6;
    }

    fun order_is_bid<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : bool {
        let (v0, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(&arg0.buy_list, arg1);
        v0
    }

    public fun pool_price_depth<T0, T1>(arg0: &Pool<T0, T1>) : PriceDepth {
        pool_price_depth_v2<T0, T1>(arg0, 5)
    }

    public fun pool_price_depth_v2<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : PriceDepth {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &arg0.sell_list;
        if (!0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::is_empty<TickLevel>(v6)) {
            let (v7, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::min_leaf<TickLevel>(v6);
            let v9 = v7;
            while (v9 >= 0) {
                if (0x1::vector::length<u64>(&v0) >= arg1) {
                    break
                };
                let (v10, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(v6, v9);
                if (!v10) {
                    break
                };
                let v12 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_leaf_by_key<TickLevel>(v6, v9);
                let v13 = &v12.orders;
                0x1::vector::push_back<u64>(&mut v0, v12.price);
                let v14 = 0x2::linked_table::front<u64, Order>(v13);
                let v15 = 0;
                let v16 = 0;
                while (!0x1::option::is_none<u64>(v14)) {
                    let v17 = 0x2::linked_table::borrow<u64, Order>(v13, *0x1::option::borrow<u64>(v14));
                    v15 = v15 + v17.original_quantity;
                    v16 = v16 + v17.quantity;
                    let v18 = *0x1::option::borrow<u64>(v14);
                    v14 = 0x2::linked_table::next<u64, Order>(v13, v18);
                };
                0x1::vector::push_back<u64>(&mut v1, v15);
                0x1::vector::push_back<u64>(&mut v2, v16);
                let (v19, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::next_leaf<TickLevel>(v6, v9);
                v9 = v19;
            };
        };
        let v21 = &arg0.buy_list;
        if (!0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::is_empty<TickLevel>(v21)) {
            let (v22, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::max_leaf<TickLevel>(v21);
            let v24 = v22;
            while (v24 != 0) {
                if (0x1::vector::length<u64>(&v3) >= arg1) {
                    break
                };
                let v25 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_leaf_by_key<TickLevel>(v21, v24);
                let v26 = &v25.orders;
                0x1::vector::push_back<u64>(&mut v3, v25.price);
                let v27 = 0x2::linked_table::front<u64, Order>(v26);
                let v28 = 0;
                let v29 = 0;
                while (!0x1::option::is_none<u64>(v27)) {
                    let v30 = 0x2::linked_table::borrow<u64, Order>(v26, *0x1::option::borrow<u64>(v27));
                    v28 = v28 + v30.original_quantity;
                    v29 = v29 + v30.quantity;
                    let v31 = *0x1::option::borrow<u64>(v27);
                    v27 = 0x2::linked_table::next<u64, Order>(v26, v31);
                };
                0x1::vector::push_back<u64>(&mut v4, v28);
                0x1::vector::push_back<u64>(&mut v5, v29);
                let (v32, _) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::previous_leaf<TickLevel>(v21, v24);
                v24 = v32;
            };
        };
        PriceDepth{
            sell_price_list             : v0,
            sell_original_quantity_list : v1,
            sell_quantity_list          : v2,
            buy_price_list              : v3,
            buy_original_quantity_list  : v4,
            buy_quantity_list           : v5,
        }
    }

    fun remove_order(arg0: 0x2::object::ID, arg1: &mut 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::CritbitTree<TickLevel>, arg2: &mut 0x2::linked_table::LinkedTable<u64, u64>, arg3: u64, arg4: u64, arg5: bool) : Order {
        0x2::linked_table::remove<u64, u64>(arg2, arg4);
        assert!(0x2::linked_table::contains<u64, Order>(&0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_leaf_by_index<TickLevel>(arg1, arg3).orders, arg4), 0);
        let v0 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_mut_leaf_by_index<TickLevel>(arg1, arg3);
        let v1 = 0x2::linked_table::remove<u64, Order>(&mut v0.orders, arg4);
        if (0x2::linked_table::is_empty<u64, Order>(&v0.orders)) {
            destroy_empty_level(0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::remove_leaf_by_index<TickLevel>(arg1, arg3));
        };
        let v2 = OrderCanceled{
            pool_id           : arg0,
            order_id          : v1.order_id,
            is_bid            : v1.is_bid,
            owner             : v1.owner,
            quantity_canceled : v1.quantity,
            price             : v1.price,
            force             : arg5,
        };
        0x2::event::emit<OrderCanceled>(v2);
        v1
    }

    public entry fun sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 6, 301);
        assert!(arg2 < 9223372036854775808, 1);
        assert!(can_deal<T0, T1>(arg0, 0x2::tx_context::sender(arg4)), 2);
        assert!(arg3 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.token0_balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg3));
        let v0 = inject_limit_order<T0, T1>(arg0, arg2, arg3, arg3, false, arg4);
        let (v1, v2, v3) = match_ask<T0, T1>(arg0, arg3, arg2, v0, arg4);
        let (_, v5) = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::find_leaf<TickLevel>(&arg0.sell_list, arg2);
        let v6 = 0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_mut_leaf_by_index<TickLevel>(&mut arg0.sell_list, v5);
        let v7 = 0x2::linked_table::borrow_mut<u64, Order>(&mut v6.orders, v0);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token1_balance, v2 - v3), arg4), v7.owner);
        };
        if (v1 > 0) {
            v7.quantity = v1;
        } else {
            0x2::linked_table::remove<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.usr_list, v7.owner), v0);
            0x2::linked_table::remove<u64, Order>(&mut v6.orders, v0);
            if (0x2::linked_table::is_empty<u64, Order>(&v6.orders)) {
                destroy_empty_level(0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::remove_leaf_by_index<TickLevel>(&mut arg0.sell_list, v5));
            };
            let v8 = OrderCompleteFilled{
                pool_id  : *0x2::object::uid_as_inner(&arg0.id),
                order_id : v0,
            };
            0x2::event::emit<OrderCompleteFilled>(v8);
        };
    }

    public entry fun take_pool_fee<T0, T1>(arg0: &mut ClobCap, arg1: &mut Pool<T0, T1>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token0_balance, arg3), arg5), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.token1_balance, arg4), arg5), arg2);
    }

    public entry fun update_fee_rate<T0, T1>(arg0: &mut ClobCap, arg1: &mut Pool<T0, T1>, arg2: u64) {
        arg1.fee_rate = arg2;
    }

    public entry fun update_state<T0, T1>(arg0: &mut ClobCap, arg1: &mut Pool<T0, T1>, arg2: bool) {
        arg1.state = arg2;
    }

    public entry fun update_usr_mark<T0, T1>(arg0: &mut ClobCap, arg1: &mut Pool<T0, T1>, arg2: address, arg3: u8) {
        if (0x2::table::contains<address, u8>(&arg1.usr_mark, arg2)) {
            0x2::table::remove<address, u8>(&mut arg1.usr_mark, arg2);
        };
        0x2::table::add<address, u8>(&mut arg1.usr_mark, arg2, arg3);
    }

    public fun usr_mark<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : u8 {
        if (0x2::table::contains<address, u8>(&arg0.usr_mark, arg1)) {
            *0x2::table::borrow<address, u8>(&arg0.usr_mark, arg1)
        } else {
            0
        }
    }

    public fun usr_orders_for_address<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : vector<Order> {
        let v0 = 0x1::vector::empty<Order>();
        let v1 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.usr_list, arg1);
        let v2 = 0x2::linked_table::front<u64, u64>(v1);
        while (!0x1::option::is_none<u64>(v2)) {
            let v3 = *0x2::linked_table::borrow<u64, u64>(v1, *0x1::option::borrow<u64>(v2));
            let v4 = if (order_is_bid<T0, T1>(arg0, v3)) {
                0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_leaf_by_key<TickLevel>(&arg0.buy_list, v3)
            } else {
                0x8d504d6cc74ee2ca93d5b1b0ec259433b8b819a1dc097701cefd42aefc237014::critbit::borrow_leaf_by_key<TickLevel>(&arg0.sell_list, v3)
            };
            let v5 = 0x2::linked_table::borrow<u64, Order>(&v4.orders, *0x1::option::borrow<u64>(v2));
            let v6 = Order{
                order_id          : v5.order_id,
                price             : v5.price,
                original_quantity : v5.original_quantity,
                quantity          : v5.quantity,
                is_bid            : v5.is_bid,
                owner             : v5.owner,
            };
            0x1::vector::push_back<Order>(&mut v0, v6);
            let v7 = *0x1::option::borrow<u64>(v2);
            v2 = 0x2::linked_table::next<u64, u64>(v1, v7);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

