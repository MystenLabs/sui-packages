module 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store has store {
        obj: 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20,
        price: u64,
        owner: address,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        sui20_data: 0x2::bag::Bag,
        fee_rate: u64,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        current_version: u64,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct HourData has copy, drop, store {
        history_volume: u128,
        price: u64,
        extra_data: u256,
    }

    struct UserInfo has copy, drop, store {
        listed_ids: vector<0x2::object::ID>,
        extra_data: u128,
    }

    struct Sui20OrderData has store {
        id: 0x2::object::UID,
        stores: 0x2::bag::Bag,
        tick: 0x1::string::String,
        traders: u64,
        txs: u64,
        total_volume: u128,
        last_price: u64,
        hour_data_table: 0x2::table::Table<u64, HourData>,
        user_infos: 0x2::table::Table<address, UserInfo>,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct StoreV2 has store {
        obj: 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20,
        amount: u64,
        price: u64,
        price_per_amount: u64,
        owner: address,
        index: u64,
        prev_index: u64,
        next_index: u64,
    }

    struct StoreV2Info has copy, drop {
        price_per_amount: u64,
        index: u64,
        prev_index: u64,
        next_index: u64,
    }

    struct DoubleLinkList has copy, drop, store {
        store_v2_lastest_index: u64,
        head: u64,
        tail: u64,
        size: u64,
    }

    struct ListedItem has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        price: u64,
    }

    struct ListedItemV2 has copy, drop {
        store_index: u64,
        id: 0x2::object::ID,
        amount: u64,
        price: u64,
    }

    struct QueryDataEvent has copy, drop {
        tick: 0x1::string::String,
        traders: u64,
        txs: u64,
        volume_24h: u128,
        total_volume: u128,
        last_price: u64,
        price_24h_ago: u64,
        user_listed: vector<ListedItem>,
    }

    struct QueryDataEventV2 has copy, drop {
        tick: 0x1::string::String,
        traders: u64,
        txs: u64,
        volume_24h: u128,
        total_volume: u128,
        last_price: u64,
        price_24h_ago: u64,
        user_listed: vector<ListedItem>,
        total_listed: vector<ListedItemV2>,
    }

    public fun buy(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, Sui20OrderData>(&mut arg0.sui20_data, arg2);
        assert!(0x2::bag::contains<0x2::object::ID>(&v1.stores, arg3), 1002);
        let Store {
            obj   : v2,
            price : v3,
            owner : v4,
        } = 0x2::bag::remove<0x2::object::ID, Store>(&mut v1.stores, arg3);
        let v5 = v2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v3, 1004);
        let (_, v7) = 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::get_sui20_data(&v5);
        let v8 = (((v3 as u128) * (arg0.fee_rate as u128) / (10000 as u128)) as u64);
        if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v8, arg5)));
        };
        let v9 = v3 - v8;
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v9, arg5), v4);
        };
        0x2::transfer::public_transfer<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>(v5, v0);
        remove_listed_id(v1, v0, &arg3);
        let v10 = v3 / v7;
        v1.last_price = v10;
        v1.txs = v1.txs + 1;
        let v11 = 0x2::clock::timestamp_ms(arg1) / 1000 / 3600;
        let v12 = (v3 as u128);
        v1.total_volume = v1.total_volume + v12;
        if (!0x2::table::contains<u64, HourData>(&v1.hour_data_table, v11)) {
            let v13 = if (!0x2::table::contains<u64, HourData>(&v1.hour_data_table, v11 - 1)) {
                0
            } else {
                0x2::table::borrow<u64, HourData>(&v1.hour_data_table, v11 - 1).history_volume
            };
            let v14 = HourData{
                history_volume : v13,
                price          : 0,
                extra_data     : 0,
            };
            0x2::table::add<u64, HourData>(&mut v1.hour_data_table, v11, v14);
        };
        let v15 = 0x2::table::borrow_mut<u64, HourData>(&mut v1.hour_data_table, v11);
        v15.history_volume = v15.history_volume + v12;
        v15.price = v10;
        arg4
    }

    public fun buy_v2(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, Sui20OrderData>(&mut arg0.sui20_data, arg2);
        assert!(0x2::bag::contains<u64>(&v1.stores, arg3), 1002);
        let StoreV2 {
            obj              : v2,
            amount           : _,
            price            : v4,
            price_per_amount : _,
            owner            : v6,
            index            : v7,
            prev_index       : v8,
            next_index       : v9,
        } = 0x2::bag::remove<u64, StoreV2>(&mut v1.stores, arg3);
        let v10 = v2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v4, 1004);
        let (_, v12) = 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::get_sui20_data(&v10);
        let v13 = 0x2::object::id<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>(&v10);
        let v14 = (((v4 as u128) * (arg0.fee_rate as u128) / (10000 as u128)) as u64);
        if (v14 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v14, arg5)));
        };
        let v15 = v4 - v14;
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v15, arg5), v6);
        };
        0x2::transfer::public_transfer<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>(v10, v0);
        let v16 = 0x2::bag::borrow_mut<0x1::string::String, DoubleLinkList>(&mut v1.stores, arg2);
        update_link_list(v16, v7, v8, v9);
        if (v8 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v1.stores, v8).next_index = v9;
        };
        if (v9 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v1.stores, v9).prev_index = v8;
        };
        remove_listed_id(v1, v0, &v13);
        let v17 = v4 / v12;
        v1.last_price = v17;
        v1.txs = v1.txs + 1;
        let v18 = 0x2::clock::timestamp_ms(arg1) / 1000 / 3600;
        let v19 = (v4 as u128);
        v1.total_volume = v1.total_volume + v19;
        if (!0x2::table::contains<u64, HourData>(&v1.hour_data_table, v18)) {
            let v20 = if (!0x2::table::contains<u64, HourData>(&v1.hour_data_table, v18 - 1)) {
                0
            } else {
                0x2::table::borrow<u64, HourData>(&v1.hour_data_table, v18 - 1).history_volume
            };
            let v21 = HourData{
                history_volume : v20,
                price          : 0,
                extra_data     : 0,
            };
            0x2::table::add<u64, HourData>(&mut v1.hour_data_table, v18, v21);
        };
        let v22 = 0x2::table::borrow_mut<u64, HourData>(&mut v1.hour_data_table, v18);
        v22.history_volume = v22.history_volume + v19;
        v22.price = v17;
        arg4
    }

    public fun change_fee_rate(arg0: &mut Global, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 10000, 1009);
        arg0.fee_rate = arg1;
    }

    public fun delist(arg0: &mut Global, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, Sui20OrderData>(&mut arg0.sui20_data, arg1);
        assert!(0x2::bag::contains<0x2::object::ID>(&v1.stores, arg2), 1002);
        let Store {
            obj   : v2,
            price : _,
            owner : v4,
        } = 0x2::bag::remove<0x2::object::ID, Store>(&mut v1.stores, arg2);
        assert!(v4 == v0, 1003);
        0x2::transfer::public_transfer<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>(v2, v0);
        remove_listed_id(v1, v0, &arg2);
    }

    public fun delist_v2(arg0: &mut Global, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, Sui20OrderData>(&mut arg0.sui20_data, arg1);
        assert!(0x2::bag::contains<u64>(&v1.stores, arg2), 1002);
        let StoreV2 {
            obj              : v2,
            amount           : _,
            price            : _,
            price_per_amount : _,
            owner            : v6,
            index            : v7,
            prev_index       : v8,
            next_index       : v9,
        } = 0x2::bag::remove<u64, StoreV2>(&mut v1.stores, arg2);
        let v10 = v2;
        assert!(v6 == v0, 1003);
        let v11 = 0x2::object::id<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>(&v10);
        let v12 = 0x2::bag::borrow_mut<0x1::string::String, DoubleLinkList>(&mut v1.stores, arg1);
        update_link_list(v12, v7, v8, v9);
        if (v8 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v1.stores, v8).next_index = v9;
        };
        if (v9 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v1.stores, v9).prev_index = v8;
        };
        0x2::transfer::public_transfer<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>(v10, v0);
        remove_listed_id(v1, v0, &v11);
    }

    fun get_hour_index(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000 / 3600
    }

    public fun get_market_data(arg0: &Global, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20_data, arg2), 1008);
        let v1 = 0x2::bag::borrow<0x1::string::String, Sui20OrderData>(&arg0.sui20_data, arg2);
        let v2 = v1.total_volume;
        let v3 = get_hour_index(arg1);
        let v4 = v3 - 25;
        let v5 = 0;
        let v6 = 0;
        while (v4 < v3) {
            if (0x2::table::contains<u64, HourData>(&v1.hour_data_table, v4)) {
                let v7 = 0x2::table::borrow<u64, HourData>(&v1.hour_data_table, v4);
                v5 = v2 - v7.history_volume;
                v6 = v7.price;
                break
            };
            v4 = v4 + 1;
        };
        let v8 = 0x1::vector::empty<ListedItem>();
        if (0x2::table::contains<address, UserInfo>(&v1.user_infos, v0)) {
            let v9 = 0x2::table::borrow<address, UserInfo>(&v1.user_infos, v0).listed_ids;
            let v10 = 0;
            while (v10 < 0x1::vector::length<0x2::object::ID>(&v9)) {
                let v11 = *0x1::vector::borrow<0x2::object::ID>(&v9, v10);
                if (0x2::bag::contains<0x2::object::ID>(&v1.stores, v11)) {
                    let v12 = 0x2::bag::borrow<0x2::object::ID, Store>(&v1.stores, v11);
                    let (_, v14) = 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::get_sui20_data(&v12.obj);
                    let v15 = ListedItem{
                        id     : v11,
                        amount : v14,
                        price  : v12.price,
                    };
                    0x1::vector::push_back<ListedItem>(&mut v8, v15);
                };
                v10 = v10 + 1;
            };
        };
        let v16 = QueryDataEvent{
            tick          : arg2,
            traders       : 0,
            txs           : v1.txs,
            volume_24h    : v5,
            total_volume  : v2,
            last_price    : v1.last_price,
            price_24h_ago : v6,
            user_listed   : v8,
        };
        0x2::event::emit<QueryDataEvent>(v16);
    }

    public fun get_market_data_v2(arg0: &Global, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20_data, arg2), 1008);
        let v1 = 0x2::bag::borrow<0x1::string::String, Sui20OrderData>(&arg0.sui20_data, arg2);
        let v2 = v1.total_volume;
        let v3 = get_hour_index(arg1);
        let v4 = v3 - 25;
        let v5 = 0;
        let v6 = 0;
        while (v4 < v3) {
            if (0x2::table::contains<u64, HourData>(&v1.hour_data_table, v4)) {
                let v7 = 0x2::table::borrow<u64, HourData>(&v1.hour_data_table, v4);
                v5 = v2 - v7.history_volume;
                v6 = v7.price;
                break
            };
            v4 = v4 + 1;
        };
        let v8 = 0x1::vector::empty<ListedItem>();
        if (0x2::table::contains<address, UserInfo>(&v1.user_infos, v0)) {
            let v9 = 0x2::table::borrow<address, UserInfo>(&v1.user_infos, v0).listed_ids;
            let v10 = 0;
            while (v10 < 0x1::vector::length<0x2::object::ID>(&v9)) {
                let v11 = *0x1::vector::borrow<0x2::object::ID>(&v9, v10);
                if (0x2::bag::contains<0x2::object::ID>(&v1.stores, v11)) {
                    let v12 = 0x2::bag::borrow<0x2::object::ID, Store>(&v1.stores, v11);
                    let (_, v14) = 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::get_sui20_data(&v12.obj);
                    let v15 = ListedItem{
                        id     : v11,
                        amount : v14,
                        price  : v12.price,
                    };
                    0x1::vector::push_back<ListedItem>(&mut v8, v15);
                };
                v10 = v10 + 1;
            };
        };
        let v16 = 0x1::vector::empty<ListedItemV2>();
        while (0x2::bag::contains<u64>(&v1.stores, arg3)) {
            let v17 = 0x2::bag::borrow<u64, StoreV2>(&v1.stores, arg3);
            let (_, v19) = 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::get_sui20_data(&v17.obj);
            let v20 = ListedItemV2{
                store_index : arg3,
                id          : 0x2::object::id<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>(&v17.obj),
                amount      : v19,
                price       : v17.price,
            };
            0x1::vector::push_back<ListedItemV2>(&mut v16, v20);
            arg3 = v17.next_index;
        };
        let v21 = QueryDataEventV2{
            tick          : arg2,
            traders       : 0,
            txs           : v1.txs,
            volume_24h    : v5,
            total_volume  : v2,
            last_price    : v1.last_price,
            price_24h_ago : v6,
            user_listed   : v8,
            total_listed  : v16,
        };
        0x2::event::emit<QueryDataEventV2>(v21);
    }

    fun get_store_v2_info(arg0: &0x2::bag::Bag, arg1: u64) : StoreV2Info {
        let v0 = 0x2::bag::borrow<u64, StoreV2>(arg0, arg1);
        StoreV2Info{
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
            sui20_data      : 0x2::bag::new(arg0),
            fee_rate        : 0,
            fee             : 0x2::balance::zero<0x2::sui::SUI>(),
            current_version : 0,
            upgrade_bag     : 0x2::bag::new(arg0),
        };
        let v1 = &mut v0;
        init_tick_data(v1, 0x1::string::utf8(b"issp"), arg0);
        0x2::transfer::public_share_object<Global>(v0);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun init_stores_link_list(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String) : (u64, u64) {
        if (!0x2::bag::contains<0x1::string::String>(arg0, arg1)) {
            let v0 = DoubleLinkList{
                store_v2_lastest_index : 0,
                head                   : 0,
                tail                   : 0,
                size                   : 0,
            };
            0x2::bag::add<0x1::string::String, DoubleLinkList>(arg0, arg1, v0);
            return (0, 0)
        };
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, DoubleLinkList>(arg0, arg1);
        (v1.store_v2_lastest_index, v1.head)
    }

    fun init_tick_data(arg0: &mut Global, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : &mut Sui20OrderData {
        if (!0x2::bag::contains<0x1::string::String>(&arg0.sui20_data, arg1)) {
            let v0 = Sui20OrderData{
                id              : 0x2::object::new(arg2),
                stores          : 0x2::bag::new(arg2),
                tick            : arg1,
                traders         : 0,
                txs             : 0,
                total_volume    : 0,
                last_price      : 0,
                hour_data_table : 0x2::table::new<u64, HourData>(arg2),
                user_infos      : 0x2::table::new<address, UserInfo>(arg2),
                upgrade_bag     : 0x2::bag::new(arg2),
            };
            0x2::bag::add<0x1::string::String, Sui20OrderData>(&mut arg0.sui20_data, arg1, v0);
        };
        0x2::bag::borrow_mut<0x1::string::String, Sui20OrderData>(&mut arg0.sui20_data, arg1)
    }

    public fun list(arg0: &mut Global, arg1: 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::get_sui20_data(&arg1);
        assert!(v2 > 0, 1006);
        assert!(arg2 > 0, 1005);
        let v3 = 0x2::object::id<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>(&arg1);
        let v4 = Store{
            obj   : arg1,
            price : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        let v5 = init_tick_data(arg0, v1, arg3);
        v5.txs = v5.txs + 1;
        0x2::bag::add<0x2::object::ID, Store>(&mut v5.stores, v3, v4);
        if (!0x2::table::contains<address, UserInfo>(&v5.user_infos, v0)) {
            let v6 = UserInfo{
                listed_ids : 0x1::vector::empty<0x2::object::ID>(),
                extra_data : 0,
            };
            0x2::table::add<address, UserInfo>(&mut v5.user_infos, v0, v6);
        };
        0x1::vector::push_back<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut v5.user_infos, v0).listed_ids, v3);
    }

    public fun list_v2(arg0: &mut Global, arg1: &mut 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Global, arg2: 0x1::string::String, arg3: vector<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(arg4 > 0, 1005);
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = 0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::merge(arg1, arg2, arg3, arg5);
        let v3 = v1;
        assert!(v2 > 0, 1006);
        let v4 = init_tick_data(arg0, arg2, arg5);
        let v5 = &mut v4.stores;
        let (v6, v7) = init_stores_link_list(v5, arg2);
        let v8 = v6 + 1;
        let v9 = StoreV2{
            obj              : v3,
            amount           : v2,
            price            : arg4,
            price_per_amount : arg4 / v2,
            owner            : v0,
            index            : v8,
            prev_index       : 0,
            next_index       : 0,
        };
        0x2::bag::add<u64, StoreV2>(&mut v4.stores, v8, v9);
        let v10 = 0x2::bag::borrow_mut<0x1::string::String, DoubleLinkList>(&mut v4.stores, arg2);
        v10.store_v2_lastest_index = v8;
        if (v10.head == 0 && v10.tail == 0 && v10.size == 0) {
            v10.head = v8;
            v10.tail = v8;
            v10.size = 1;
            return
        };
        let v11 = get_store_v2_info(&v4.stores, v8);
        let v12 = get_store_v2_info(&v4.stores, v7);
        let v13 = v12.prev_index;
        let v14 = v12.index;
        while (v11.price_per_amount >= v12.price_per_amount) {
            if (0x2::bag::contains<u64>(&v4.stores, v12.next_index)) {
                v13 = v14;
                let v15 = v12.next_index;
                v14 = v15;
                v12 = get_store_v2_info(&v4.stores, v15);
                continue
            };
            v12.next_index = v11.index;
            let v16 = &mut v4.stores;
            update_store_v2(v16, v12);
            v11.prev_index = v12.index;
            v11.next_index = 0;
            let v17 = &mut v4.stores;
            update_store_v2(v17, v11);
            return
        };
        v11.next_index = v14;
        v11.prev_index = v12.prev_index;
        let v18 = &mut v4.stores;
        update_store_v2(v18, v11);
        v12.prev_index = v11.index;
        let v19 = &mut v4.stores;
        update_store_v2(v19, v12);
        if (v13 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v4.stores, v13).next_index = v11.index;
        };
        if (!0x2::table::contains<address, UserInfo>(&v4.user_infos, v0)) {
            let v20 = UserInfo{
                listed_ids : 0x1::vector::empty<0x2::object::ID>(),
                extra_data : 0,
            };
            0x2::table::add<address, UserInfo>(&mut v4.user_infos, v0, v20);
        };
        0x1::vector::push_back<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut v4.user_infos, v0).listed_ids, 0x2::object::id<0x66bca0a8bf805cc9ad9ba6c09ac57a596412e47d1dec70b325e4be49e7e00c34::sui20::Sui20>(&v3));
    }

    fun only_allowed_version(arg0: &Global) {
        assert!(arg0.current_version <= 1, 1000);
    }

    fun only_not_paused(arg0: &Global) {
        assert!(!arg0.is_paused, 1001);
    }

    fun remove_listed_id(arg0: &mut Sui20OrderData, arg1: address, arg2: &0x2::object::ID) {
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_infos, arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&v0.listed_ids, arg2);
        if (v1) {
            0x1::vector::swap_remove<0x2::object::ID>(&mut v0.listed_ids, v2);
        };
    }

    public fun set_paused(arg0: &mut Global, arg1: &mut AdminCap, arg2: bool) {
        arg0.is_paused = arg2;
    }

    public fun set_version(arg0: &mut Global, arg1: &mut AdminCap, arg2: u64) {
        arg0.current_version = arg2;
    }

    fun update_link_list(arg0: &mut DoubleLinkList, arg1: u64, arg2: u64, arg3: u64) {
        if (arg0.head == arg1) {
            arg0.head = arg3;
        };
        if (arg0.tail == arg1) {
            arg0.tail = arg2;
        };
        arg0.size = arg0.size - 1;
    }

    fun update_store_v2(arg0: &mut 0x2::bag::Bag, arg1: StoreV2Info) {
        let v0 = 0x2::bag::borrow_mut<u64, StoreV2>(arg0, arg1.index);
        v0.prev_index = arg1.prev_index;
        v0.next_index = arg1.next_index;
    }

    // decompiled from Move bytecode v6
}

