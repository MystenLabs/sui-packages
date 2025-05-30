module 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store has store {
        obj: 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20,
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

    struct UserInfoV2 has copy, drop, store {
        listed_index: vector<u64>,
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
        obj: 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20,
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
        store_v2_info: StoreV2Info,
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
        user_listed: vector<ListedItemV2>,
        total_listed: vector<ListedItemV2>,
        linkList: DoubleLinkList,
        floor_price: u64,
    }

    struct QueryFromIndexEvent has copy, drop {
        from_index: u64,
    }

    public fun buy(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
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
        let (_, v12) = 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::get_sui20_data(&v10);
        let v13 = (((v4 as u128) * (arg0.fee_rate as u128) / (10000 as u128)) as u64);
        if (v13 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v13, arg5)));
        };
        let v14 = v4 - v13;
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v14, arg5), v6);
        };
        0x2::transfer::public_transfer<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(v10, v0);
        init_user_info_v2(v1, v0);
        remove_listed_index_v2(v1, v6, v7);
        let v15 = 0x2::bag::borrow_mut<0x1::string::String, DoubleLinkList>(&mut v1.stores, arg2);
        update_link_list(v15, v7, v8, v9);
        if (v8 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v1.stores, v8).next_index = v9;
        };
        if (v9 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v1.stores, v9).prev_index = v8;
        };
        let v16 = v4 / v12;
        v1.last_price = v16;
        v1.txs = v1.txs + 1;
        let v17 = 0x2::clock::timestamp_ms(arg1) / 1000 / 3600;
        let v18 = (v4 as u128);
        v1.total_volume = v1.total_volume + v18;
        if (!0x2::table::contains<u64, HourData>(&v1.hour_data_table, v17)) {
            let v19 = if (!0x2::table::contains<u64, HourData>(&v1.hour_data_table, v17 - 1)) {
                0
            } else {
                0x2::table::borrow<u64, HourData>(&v1.hour_data_table, v17 - 1).history_volume
            };
            let v20 = HourData{
                history_volume : v19,
                price          : 0,
                extra_data     : 0,
            };
            0x2::table::add<u64, HourData>(&mut v1.hour_data_table, v17, v20);
        };
        let v21 = 0x2::table::borrow_mut<u64, HourData>(&mut v1.hour_data_table, v17);
        v21.history_volume = v21.history_volume + v18;
        v21.price = v16;
        arg4
    }

    public fun change_fee_rate(arg0: &mut Global, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 10000, 1009);
        arg0.fee_rate = arg1;
    }

    public fun delist(arg0: &mut Global, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
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
        assert!(v6 == v0, 1003);
        let v10 = 0x2::bag::borrow_mut<0x1::string::String, DoubleLinkList>(&mut v1.stores, arg1);
        update_link_list(v10, v7, v8, v9);
        if (v8 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v1.stores, v8).next_index = v9;
        };
        if (v9 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v1.stores, v9).prev_index = v8;
        };
        0x2::transfer::public_transfer<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(v2, v0);
        remove_listed_index_v2(v1, v0, v7);
    }

    public fun get_from_index(arg0: &Global, arg1: 0x1::string::String, arg2: u64) {
        let v0 = 0x2::bag::borrow<0x1::string::String, Sui20OrderData>(&arg0.sui20_data, arg1);
        let v1 = *0x2::bag::borrow<0x1::string::String, DoubleLinkList>(&v0.stores, arg1);
        let v2 = v1.head;
        let v3 = v2;
        let v4 = get_store_v2_info(&v0.stores, v2);
        let v5 = v1.tail;
        let v6 = v5;
        let v7 = get_store_v2_info(&v0.stores, v5);
        if (arg2 < v4.price_per_amount) {
            let v8 = QueryFromIndexEvent{from_index: v2};
            0x2::event::emit<QueryFromIndexEvent>(v8);
            return
        };
        if (arg2 >= v7.price_per_amount) {
            let v9 = QueryFromIndexEvent{from_index: v5};
            0x2::event::emit<QueryFromIndexEvent>(v9);
            return
        };
        while (arg2 >= v4.price_per_amount && arg2 < v7.price_per_amount) {
            let v10 = v4.next_index;
            v3 = v10;
            v4 = get_store_v2_info(&v0.stores, v10);
            let v11 = v7.prev_index;
            v6 = v11;
            v7 = get_store_v2_info(&v0.stores, v11);
        };
        if (arg2 < v4.price_per_amount) {
            let v12 = QueryFromIndexEvent{from_index: v3};
            0x2::event::emit<QueryFromIndexEvent>(v12);
        } else {
            let v13 = QueryFromIndexEvent{from_index: v6};
            0x2::event::emit<QueryFromIndexEvent>(v13);
        };
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
                    let (_, v14) = 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::get_sui20_data(&v12.obj);
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

    public fun get_market_data_v2(arg0: &Global, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20_data, arg2), 1008);
        let v1 = 0x2::bag::borrow<0x1::string::String, Sui20OrderData>(&arg0.sui20_data, arg2);
        let v2 = *0x2::bag::borrow<0x1::string::String, DoubleLinkList>(&v1.stores, arg2);
        let v3 = v1.total_volume;
        let v4 = get_hour_index(arg1);
        let v5 = v4 - 25;
        let v6 = 0;
        let v7 = 0;
        while (v5 < v4) {
            if (0x2::table::contains<u64, HourData>(&v1.hour_data_table, v5)) {
                let v8 = 0x2::table::borrow<u64, HourData>(&v1.hour_data_table, v5);
                v6 = v3 - v8.history_volume;
                v7 = v8.price;
                break
            };
            v5 = v5 + 1;
        };
        let v9 = 0x1::vector::empty<ListedItemV2>();
        if (0x2::bag::contains<address>(&v1.upgrade_bag, v0)) {
            let v10 = 0x2::bag::borrow<address, UserInfoV2>(&v1.upgrade_bag, v0).listed_index;
            let v11 = 0;
            while (v11 < 0x1::vector::length<u64>(&v10)) {
                let v12 = *0x1::vector::borrow<u64>(&v10, v11);
                if (0x2::bag::contains<u64>(&v1.stores, v12)) {
                    let v13 = 0x2::bag::borrow<u64, StoreV2>(&v1.stores, v12);
                    let (_, v15) = 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::get_sui20_data(&v13.obj);
                    let v16 = ListedItemV2{
                        store_index   : v12,
                        id            : 0x2::object::id<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(&v13.obj),
                        amount        : v15,
                        price         : v13.price,
                        store_v2_info : get_store_v2_info(&v1.stores, v12),
                    };
                    0x1::vector::push_back<ListedItemV2>(&mut v9, v16);
                };
                v11 = v11 + 1;
            };
        };
        let v17 = 0x1::vector::empty<ListedItemV2>();
        let v18 = v2.head;
        let v19 = arg3 * arg4;
        let v20 = 0;
        if (v2.size > v19) {
            while (0x2::bag::contains<u64>(&v1.stores, v18)) {
                let v21 = 0x2::bag::borrow<u64, StoreV2>(&v1.stores, v18);
                if (v20 < v19) {
                    v20 = v20 + 1;
                    v18 = v21.next_index;
                    continue
                };
                let (_, v23) = 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::get_sui20_data(&v21.obj);
                let v24 = ListedItemV2{
                    store_index   : v18,
                    id            : 0x2::object::id<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(&v21.obj),
                    amount        : v23,
                    price         : v21.price,
                    store_v2_info : get_store_v2_info(&v1.stores, v18),
                };
                0x1::vector::push_back<ListedItemV2>(&mut v17, v24);
                if (0x1::vector::length<ListedItemV2>(&v17) >= arg5) {
                    break
                };
                v20 = v20 + 1;
                v18 = v21.next_index;
            };
        };
        let v25 = 0;
        if (v2.head > 0) {
            let v26 = get_store_v2_info(&v1.stores, v2.head);
            v25 = v26.price_per_amount;
        };
        let v27 = QueryDataEventV2{
            tick          : arg2,
            traders       : v1.traders,
            txs           : v1.txs,
            volume_24h    : v6,
            total_volume  : v3,
            last_price    : v1.last_price,
            price_24h_ago : v7,
            user_listed   : v9,
            total_listed  : v17,
            linkList      : v2,
            floor_price   : v25,
        };
        0x2::event::emit<QueryDataEventV2>(v27);
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

    fun init_user_info_v2(arg0: &mut Sui20OrderData, arg1: address) {
        if (!0x2::bag::contains<address>(&arg0.upgrade_bag, arg1)) {
            let v0 = UserInfoV2{
                listed_index : vector[],
                extra_data   : 0,
            };
            0x2::bag::add<address, UserInfoV2>(&mut arg0.upgrade_bag, arg1, v0);
            arg0.traders = arg0.traders + 1;
        };
    }

    public fun list(arg0: &mut Global, arg1: 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(arg1, 0x2::tx_context::sender(arg3));
    }

    public fun list_v2(arg0: &mut Global, arg1: &mut 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Global, arg2: 0x1::string::String, arg3: vector<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(&arg3)) {
            0x2::transfer::public_transfer<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(0x1::vector::pop_back<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(&mut arg3), 0x2::tx_context::sender(arg5));
        };
        0x1::vector::destroy_empty<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(arg3);
    }

    public fun list_v3(arg0: &mut Global, arg1: &mut 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Global, arg2: 0x1::string::String, arg3: vector<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(&arg3)) {
            0x2::transfer::public_transfer<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(0x1::vector::pop_back<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(&mut arg3), 0x2::tx_context::sender(arg6));
        };
        0x1::vector::destroy_empty<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(arg3);
    }

    public fun list_v4(arg0: &mut Global, arg1: &mut 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Global, arg2: 0x1::string::String, arg3: vector<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(arg6 >= 100000, 1006);
        assert!(arg4 > 0, 1005);
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, v2, v3, v4) = 0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::merge_v2(arg1, arg2, arg3, arg6, arg7);
        assert!(arg6 > 0, 1006);
        assert!(v3 >= arg6, 1010);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::Sui20>(v2, v0);
        } else {
            0x9d938c9d9a8440e427f733d93d0761644ad0c4c04b55fd1531a9afba92e60fe0::sui20::destroy_zero(v2);
        };
        let v5 = init_tick_data(arg0, arg2, arg7);
        let v6 = &mut v5.stores;
        let (v7, v8) = init_stores_link_list(v6, arg2);
        let v9 = v7 + 1;
        let v10 = StoreV2{
            obj              : v1,
            amount           : arg6,
            price            : arg4,
            price_per_amount : arg4 / arg6,
            owner            : v0,
            index            : v9,
            prev_index       : 0,
            next_index       : 0,
        };
        0x2::bag::add<u64, StoreV2>(&mut v5.stores, v9, v10);
        init_user_info_v2(v5, v0);
        0x1::vector::push_back<u64>(&mut 0x2::bag::borrow_mut<address, UserInfoV2>(&mut v5.upgrade_bag, v0).listed_index, v9);
        let v11 = *0x2::bag::borrow<0x1::string::String, DoubleLinkList>(&v5.stores, arg2);
        v11.store_v2_lastest_index = v9;
        let v12 = &mut v5.stores;
        set_link_list(v12, arg2, v11);
        if (v11.head == 0 && v11.tail == 0 && v11.size == 0) {
            v11.head = v9;
            v11.tail = v9;
            v11.size = 1;
            let v13 = &mut v5.stores;
            set_link_list(v13, arg2, v11);
            return
        };
        v11.size = v11.size + 1;
        let v14 = get_store_v2_info(&v5.stores, v9);
        let v15 = if (0x2::bag::contains<u64>(&v5.stores, arg5)) {
            get_store_v2_info(&v5.stores, arg5)
        } else {
            get_store_v2_info(&v5.stores, v8)
        };
        let v16 = v15;
        let v17 = v16.prev_index;
        let v18 = v16.index;
        while (v14.price_per_amount >= v16.price_per_amount) {
            if (0x2::bag::contains<u64>(&v5.stores, v16.next_index)) {
                v17 = v18;
                let v19 = v16.next_index;
                v18 = v19;
                v16 = get_store_v2_info(&v5.stores, v19);
                continue
            };
            v16.next_index = v14.index;
            let v20 = &mut v5.stores;
            update_store_v2(v20, v16);
            v14.prev_index = v16.index;
            v14.next_index = 0;
            let v21 = &mut v5.stores;
            update_store_v2(v21, v14);
            v11.tail = v14.index;
            let v22 = &mut v5.stores;
            set_link_list(v22, arg2, v11);
            return
        };
        v14.next_index = v18;
        v14.prev_index = v16.prev_index;
        let v23 = &mut v5.stores;
        update_store_v2(v23, v14);
        v16.prev_index = v14.index;
        let v24 = &mut v5.stores;
        update_store_v2(v24, v16);
        if (v17 > 0) {
            0x2::bag::borrow_mut<u64, StoreV2>(&mut v5.stores, v17).next_index = v14.index;
        };
        if (v14.prev_index == 0) {
            v11.head = v14.index;
        };
        let v25 = &mut v5.stores;
        set_link_list(v25, arg2, v11);
    }

    fun only_allowed_version(arg0: &Global) {
        assert!(arg0.current_version <= 8, 1000);
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

    fun remove_listed_index_v2(arg0: &mut Sui20OrderData, arg1: address, arg2: u64) {
        let v0 = 0x2::bag::borrow_mut<address, UserInfoV2>(&mut arg0.upgrade_bag, arg1);
        let (v1, v2) = 0x1::vector::index_of<u64>(&v0.listed_index, &arg2);
        if (v1) {
            0x1::vector::swap_remove<u64>(&mut v0.listed_index, v2);
        };
    }

    fun set_link_list(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String, arg2: DoubleLinkList) {
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, DoubleLinkList>(arg0, arg1);
        v0.store_v2_lastest_index = arg2.store_v2_lastest_index;
        v0.head = arg2.head;
        v0.tail = arg2.tail;
        v0.size = arg2.size;
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

    public fun withdraw_fee(arg0: &mut Global, arg1: &mut AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

