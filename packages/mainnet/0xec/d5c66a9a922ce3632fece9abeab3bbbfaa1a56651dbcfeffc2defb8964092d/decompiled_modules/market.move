module 0xecd5c66a9a922ce3632fece9abeab3bbbfaa1a56651dbcfeffc2defb8964092d::market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        market_data: 0x2::bag::Bag,
        fee_rate: u64,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        current_version: u64,
        upgrade_bag_1: 0x2::bag::Bag,
        upgrade_bag_2: 0x2::bag::Bag,
    }

    struct MarketData has store {
        id: 0x2::object::UID,
        orders: 0x2::bag::Bag,
        tick: 0x1::ascii::String,
        traders: u64,
        txs: u64,
        total_volume: u128,
        last_price: u64,
        orders_lastest_index: u64,
        head: u64,
        tail: u64,
        size: u64,
        hour_data_table: 0x2::bag::Bag,
        user_infos: 0x2::bag::Bag,
        upgrade_bag_1: 0x2::bag::Bag,
        upgrade_bag_2: 0x2::bag::Bag,
    }

    struct HourData has copy, drop, store {
        history_volume: u128,
        price: u64,
        extra_data: u256,
    }

    struct Order has store {
        obj: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription,
        amount: u64,
        price: u64,
        price_per_amount: u64,
        owner: address,
        buyer: address,
        index: u64,
        prev_index: u64,
        next_index: u64,
    }

    struct OrderInfo has copy, drop {
        price_per_amount: u64,
        index: u64,
        prev_index: u64,
        next_index: u64,
    }

    struct UserInfo has copy, drop, store {
        listed_index: vector<u64>,
        extra_data: u128,
    }

    struct ListedItem has copy, drop {
        order_index: u64,
        id: 0x2::object::ID,
        amount: u64,
        price: u64,
        owner: address,
        order_info: OrderInfo,
    }

    struct ListedOrder has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        price: u64,
        owner: address,
        index: u64,
    }

    struct DelistedOrder has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        price: u64,
        owner: address,
        index: u64,
    }

    struct Bought has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        price: u64,
        price_per_amount: u64,
        owner: address,
        buyer: address,
        index: u64,
    }

    struct QueryMarketDataEvent has copy, drop {
        tick: 0x1::ascii::String,
        traders: u64,
        txs: u64,
        volume_24h: u128,
        total_volume: u128,
        last_price: u64,
        price_24h_ago: u64,
        floor_price: u64,
        orders_lastest_index: u64,
        head: u64,
        tail: u64,
        size: u64,
        user_listed: vector<ListedItem>,
        total_listed: vector<ListedItem>,
    }

    struct QueryFromIndexEvent has copy, drop {
        from_index: u64,
    }

    public fun buy(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, MarketData>(&mut arg0.market_data, arg2);
        assert!(0x2::bag::contains<u64>(&v1.orders, arg3), 1002);
        let Order {
            obj              : v2,
            amount           : _,
            price            : v4,
            price_per_amount : _,
            owner            : v6,
            buyer            : v7,
            index            : v8,
            prev_index       : v9,
            next_index       : v10,
        } = 0x2::bag::remove<u64, Order>(&mut v1.orders, arg3);
        let v11 = v2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v4, 1004);
        let v12 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v11);
        let v13 = (((v4 as u128) * (arg0.fee_rate as u128) / (10000 as u128)) as u64);
        if (v13 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v13, arg5)));
        };
        let v14 = v4 - v13;
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v14, arg5), v6);
        };
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v11, v0);
        init_user_info_v2(v1, v0);
        remove_listed_index_v2(v1, v6, v8);
        if (v1.head == v8) {
            v1.head = v10;
        };
        if (v1.tail == v8) {
            v1.tail = v9;
        };
        v1.size = v1.size - 1;
        if (v9 > 0) {
            0x2::bag::borrow_mut<u64, Order>(&mut v1.orders, v9).next_index = v10;
        };
        if (v10 > 0) {
            0x2::bag::borrow_mut<u64, Order>(&mut v1.orders, v10).prev_index = v9;
        };
        let v15 = v4 / v12;
        v1.last_price = v15;
        v1.txs = v1.txs + 1;
        let v16 = 0x2::clock::timestamp_ms(arg1) / 1000 / 3600;
        let v17 = (v4 as u128);
        v1.total_volume = v1.total_volume + v17;
        if (!0x2::bag::contains<u64>(&v1.hour_data_table, v16)) {
            let v18 = if (!0x2::bag::contains<u64>(&v1.hour_data_table, v16 - 1)) {
                0
            } else {
                0x2::bag::borrow<u64, HourData>(&v1.hour_data_table, v16 - 1).history_volume
            };
            let v19 = HourData{
                history_volume : v18,
                price          : 0,
                extra_data     : 0,
            };
            0x2::bag::add<u64, HourData>(&mut v1.hour_data_table, v16, v19);
        };
        let v20 = 0x2::bag::borrow_mut<u64, HourData>(&mut v1.hour_data_table, v16);
        v20.history_volume = v20.history_volume + v17;
        v20.price = v15;
        let v21 = Bought{
            id               : 0x2::object::id<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v11),
            amount           : v12,
            price            : v4,
            price_per_amount : v15,
            owner            : v6,
            buyer            : v7,
            index            : v8,
        };
        0x2::event::emit<Bought>(v21);
        arg4
    }

    public fun delist(arg0: &mut Global, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, MarketData>(&mut arg0.market_data, arg1);
        assert!(0x2::bag::contains<u64>(&v1.orders, arg2), 1002);
        let Order {
            obj              : v2,
            amount           : v3,
            price            : v4,
            price_per_amount : _,
            owner            : v6,
            buyer            : _,
            index            : v8,
            prev_index       : v9,
            next_index       : v10,
        } = 0x2::bag::remove<u64, Order>(&mut v1.orders, arg2);
        let v11 = v2;
        assert!(v6 == v0, 1003);
        if (v1.head == v8) {
            v1.head = v10;
        };
        if (v1.tail == v8) {
            v1.tail = v9;
        };
        v1.size = v1.size - 1;
        if (v9 > 0) {
            0x2::bag::borrow_mut<u64, Order>(&mut v1.orders, v9).next_index = v10;
        };
        if (v10 > 0) {
            0x2::bag::borrow_mut<u64, Order>(&mut v1.orders, v10).prev_index = v9;
        };
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v11, v0);
        remove_listed_index_v2(v1, v0, v8);
        let v12 = DelistedOrder{
            id     : 0x2::object::id<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v11),
            amount : v3,
            price  : v4,
            owner  : v6,
            index  : v8,
        };
        0x2::event::emit<DelistedOrder>(v12);
    }

    public fun get_from_index(arg0: &Global, arg1: 0x1::ascii::String, arg2: u64) {
        let v0 = 0x2::bag::borrow<0x1::ascii::String, MarketData>(&arg0.market_data, arg1);
        let v1 = v0.head;
        let v2 = v1;
        let v3 = get_order_info(&v0.orders, v1);
        let v4 = v0.tail;
        let v5 = v4;
        let v6 = get_order_info(&v0.orders, v4);
        if (arg2 < v3.price_per_amount) {
            let v7 = QueryFromIndexEvent{from_index: v1};
            0x2::event::emit<QueryFromIndexEvent>(v7);
            return
        };
        if (arg2 >= v6.price_per_amount) {
            let v8 = QueryFromIndexEvent{from_index: v4};
            0x2::event::emit<QueryFromIndexEvent>(v8);
            return
        };
        while (arg2 >= v3.price_per_amount && arg2 < v6.price_per_amount) {
            let v9 = v3.next_index;
            v2 = v9;
            v3 = get_order_info(&v0.orders, v9);
            let v10 = v6.prev_index;
            v5 = v10;
            v6 = get_order_info(&v0.orders, v10);
        };
        if (arg2 < v3.price_per_amount) {
            let v11 = QueryFromIndexEvent{from_index: v2};
            0x2::event::emit<QueryFromIndexEvent>(v11);
        } else {
            let v12 = QueryFromIndexEvent{from_index: v5};
            0x2::event::emit<QueryFromIndexEvent>(v12);
        };
    }

    fun get_hour_index(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000 / 3600
    }

    public fun get_market_data_v2(arg0: &Global, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.market_data, arg2), 1008);
        let v1 = 0x2::bag::borrow<0x1::ascii::String, MarketData>(&arg0.market_data, arg2);
        let v2 = v1.total_volume;
        let v3 = get_hour_index(arg1);
        let v4 = v3 - 25;
        let v5 = 0;
        let v6 = 0;
        while (v4 < v3) {
            if (0x2::bag::contains<u64>(&v1.hour_data_table, v4)) {
                let v7 = 0x2::bag::borrow<u64, HourData>(&v1.hour_data_table, v4);
                v5 = v2 - v7.history_volume;
                v6 = v7.price;
                break
            };
            v4 = v4 + 1;
        };
        let v8 = 0x1::vector::empty<ListedItem>();
        if (0x2::bag::contains<address>(&v1.user_infos, v0)) {
            let v9 = 0x2::bag::borrow<address, UserInfo>(&v1.user_infos, v0).listed_index;
            let v10 = 0;
            while (v10 < 0x1::vector::length<u64>(&v9)) {
                let v11 = *0x1::vector::borrow<u64>(&v9, v10);
                if (0x2::bag::contains<u64>(&v1.orders, v11)) {
                    let v12 = 0x2::bag::borrow<u64, Order>(&v1.orders, v11);
                    let v13 = ListedItem{
                        order_index : v11,
                        id          : 0x2::object::id<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v12.obj),
                        amount      : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v12.obj),
                        price       : v12.price,
                        owner       : v12.owner,
                        order_info  : get_order_info(&v1.orders, v11),
                    };
                    0x1::vector::push_back<ListedItem>(&mut v8, v13);
                };
                v10 = v10 + 1;
            };
        };
        let v14 = 0x1::vector::empty<ListedItem>();
        let v15 = v1.head;
        let v16 = arg3 * arg4;
        let v17 = 0;
        if (v1.size > v16) {
            while (0x2::bag::contains<u64>(&v1.orders, v15)) {
                let v18 = 0x2::bag::borrow<u64, Order>(&v1.orders, v15);
                if (v17 < v16) {
                    v17 = v17 + 1;
                    v15 = v18.next_index;
                    continue
                };
                let v19 = ListedItem{
                    order_index : v15,
                    id          : 0x2::object::id<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v18.obj),
                    amount      : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v18.obj),
                    price       : v18.price,
                    owner       : v18.owner,
                    order_info  : get_order_info(&v1.orders, v15),
                };
                0x1::vector::push_back<ListedItem>(&mut v14, v19);
                if (0x1::vector::length<ListedItem>(&v14) >= arg5) {
                    break
                };
                v17 = v17 + 1;
                v15 = v18.next_index;
            };
        };
        let v20 = 0;
        if (v1.head > 0) {
            let v21 = get_order_info(&v1.orders, v1.head);
            v20 = v21.price_per_amount;
        };
        let v22 = QueryMarketDataEvent{
            tick                 : arg2,
            traders              : v1.traders,
            txs                  : v1.txs,
            volume_24h           : v5,
            total_volume         : v2,
            last_price           : v1.last_price,
            price_24h_ago        : v6,
            floor_price          : v20,
            orders_lastest_index : v1.orders_lastest_index,
            head                 : v1.head,
            tail                 : v1.tail,
            size                 : v1.size,
            user_listed          : v8,
            total_listed         : v14,
        };
        0x2::event::emit<QueryMarketDataEvent>(v22);
    }

    fun get_order_info(arg0: &0x2::bag::Bag, arg1: u64) : OrderInfo {
        let v0 = 0x2::bag::borrow<u64, Order>(arg0, arg1);
        OrderInfo{
            price_per_amount : v0.price_per_amount,
            index            : v0.index,
            prev_index       : v0.prev_index,
            next_index       : v0.next_index,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id              : 0x2::object::new(arg0),
            is_paused       : false,
            market_data     : 0x2::bag::new(arg0),
            fee_rate        : 0,
            fee             : 0x2::balance::zero<0x2::sui::SUI>(),
            current_version : 0,
            upgrade_bag_1   : 0x2::bag::new(arg0),
            upgrade_bag_2   : 0x2::bag::new(arg0),
        };
        let v1 = &mut v0;
        init_tick_data(v1, 0x1::ascii::string(b"MOVE"), arg0);
        0x2::transfer::public_share_object<Global>(v0);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun init_tick_data(arg0: &mut Global, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : &mut MarketData {
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.market_data, arg1)) {
            let v0 = MarketData{
                id                   : 0x2::object::new(arg2),
                orders               : 0x2::bag::new(arg2),
                tick                 : arg1,
                traders              : 0,
                txs                  : 0,
                total_volume         : 0,
                last_price           : 0,
                orders_lastest_index : 0,
                head                 : 0,
                tail                 : 0,
                size                 : 0,
                hour_data_table      : 0x2::bag::new(arg2),
                user_infos           : 0x2::bag::new(arg2),
                upgrade_bag_1        : 0x2::bag::new(arg2),
                upgrade_bag_2        : 0x2::bag::new(arg2),
            };
            0x2::bag::add<0x1::ascii::String, MarketData>(&mut arg0.market_data, arg1, v0);
        };
        0x2::bag::borrow_mut<0x1::ascii::String, MarketData>(&mut arg0.market_data, arg1)
    }

    fun init_user_info_v2(arg0: &mut MarketData, arg1: address) {
        if (!0x2::bag::contains<address>(&arg0.user_infos, arg1)) {
            let v0 = UserInfo{
                listed_index : vector[],
                extra_data   : 0,
            };
            0x2::bag::add<address, UserInfo>(&mut arg0.user_infos, arg1, v0);
            arg0.traders = arg0.traders + 1;
        };
    }

    public fun list(arg0: &mut Global, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(arg2 > 0, 1005);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::acc(&arg1);
        assert!(v1 >= 100, 1006);
        let v2 = init_tick_data(arg0, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick(&arg1), arg4);
        let v3 = v2.orders_lastest_index + 1;
        let v4 = Order{
            obj              : arg1,
            amount           : v1,
            price            : arg2,
            price_per_amount : arg2 / v1,
            owner            : v0,
            buyer            : @0x0,
            index            : v3,
            prev_index       : 0,
            next_index       : 0,
        };
        0x2::bag::add<u64, Order>(&mut v2.orders, v3, v4);
        init_user_info_v2(v2, v0);
        0x1::vector::push_back<u64>(&mut 0x2::bag::borrow_mut<address, UserInfo>(&mut v2.user_infos, v0).listed_index, v3);
        v2.orders_lastest_index = v3;
        if (v2.head == 0 && v2.tail == 0 && v2.size == 0) {
            v2.head = v3;
            v2.tail = v3;
            v2.size = 1;
            let v5 = ListedOrder{
                id     : 0x2::object::id<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg1),
                amount : v1,
                price  : arg2,
                owner  : v0,
                index  : v3,
            };
            0x2::event::emit<ListedOrder>(v5);
            return
        };
        v2.size = v2.size + 1;
        let v6 = get_order_info(&v2.orders, v3);
        let v7 = if (0x2::bag::contains<u64>(&v2.orders, arg3)) {
            get_order_info(&v2.orders, arg3)
        } else {
            get_order_info(&v2.orders, v2.head)
        };
        let v8 = v7;
        let v9 = v8.prev_index;
        let v10 = v8.index;
        while (v6.price_per_amount >= v8.price_per_amount) {
            if (0x2::bag::contains<u64>(&v2.orders, v8.next_index)) {
                v9 = v10;
                let v11 = v8.next_index;
                v10 = v11;
                v8 = get_order_info(&v2.orders, v11);
                continue
            };
            v8.next_index = v6.index;
            let v12 = &mut v2.orders;
            update_order(v12, v8);
            v6.prev_index = v8.index;
            v6.next_index = 0;
            let v13 = &mut v2.orders;
            update_order(v13, v6);
            v2.tail = v6.index;
            return
        };
        v6.next_index = v10;
        v6.prev_index = v8.prev_index;
        let v14 = &mut v2.orders;
        update_order(v14, v6);
        v8.prev_index = v6.index;
        let v15 = &mut v2.orders;
        update_order(v15, v8);
        if (v9 > 0) {
            0x2::bag::borrow_mut<u64, Order>(&mut v2.orders, v9).next_index = v6.index;
        };
        if (v6.prev_index == 0) {
            v2.head = v6.index;
        };
        let v16 = ListedOrder{
            id     : 0x2::object::id<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg1),
            amount : v1,
            price  : arg2,
            owner  : v0,
            index  : v6.index,
        };
        0x2::event::emit<ListedOrder>(v16);
    }

    fun only_allowed_version(arg0: &Global) {
        assert!(arg0.current_version <= 8, 1000);
    }

    fun only_not_paused(arg0: &Global) {
        assert!(!arg0.is_paused, 1001);
    }

    fun remove_listed_index_v2(arg0: &mut MarketData, arg1: address, arg2: u64) {
        let v0 = 0x2::bag::borrow_mut<address, UserInfo>(&mut arg0.user_infos, arg1);
        let (v1, v2) = 0x1::vector::index_of<u64>(&v0.listed_index, &arg2);
        if (v1) {
            0x1::vector::swap_remove<u64>(&mut v0.listed_index, v2);
        };
    }

    fun update_order(arg0: &mut 0x2::bag::Bag, arg1: OrderInfo) {
        let v0 = 0x2::bag::borrow_mut<u64, Order>(arg0, arg1.index);
        v0.prev_index = arg1.prev_index;
        v0.next_index = arg1.next_index;
    }

    // decompiled from Move bytecode v6
}

