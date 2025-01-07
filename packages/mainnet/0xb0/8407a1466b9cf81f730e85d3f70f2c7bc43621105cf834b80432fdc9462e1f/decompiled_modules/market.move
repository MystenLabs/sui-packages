module 0xb08407a1466b9cf81f730e85d3f70f2c7bc43621105cf834b80432fdc9462e1f::market {
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

    struct ListedOrder has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        price: u64,
        owner: address,
        index: u64,
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
        assert!(v1 >= 100000, 1006);
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

    fun update_order(arg0: &mut 0x2::bag::Bag, arg1: OrderInfo) {
        let v0 = 0x2::bag::borrow_mut<u64, Order>(arg0, arg1.index);
        v0.prev_index = arg1.prev_index;
        v0.next_index = arg1.next_index;
    }

    // decompiled from Move bytecode v6
}

