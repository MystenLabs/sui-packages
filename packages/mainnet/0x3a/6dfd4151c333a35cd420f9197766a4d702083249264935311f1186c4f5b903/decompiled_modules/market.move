module 0x3a6dfd4151c333a35cd420f9197766a4d702083249264935311f1186c4f5b903::market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store has store {
        obj: 0x3a6dfd4151c333a35cd420f9197766a4d702083249264935311f1186c4f5b903::sui20::Sui20,
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

    struct ListedItem has copy, drop {
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
        let (_, v7) = 0x3a6dfd4151c333a35cd420f9197766a4d702083249264935311f1186c4f5b903::sui20::get_sui20_data(&v5);
        let v8 = (((v3 as u128) * (arg0.fee_rate as u128) / (10000 as u128)) as u64);
        if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v8, arg5)));
        };
        let v9 = v3 - v8;
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v9, arg5), v4);
        };
        0x2::transfer::public_transfer<0x3a6dfd4151c333a35cd420f9197766a4d702083249264935311f1186c4f5b903::sui20::Sui20>(v5, v0);
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
        0x2::transfer::public_transfer<0x3a6dfd4151c333a35cd420f9197766a4d702083249264935311f1186c4f5b903::sui20::Sui20>(v2, v0);
        remove_listed_id(v1, v0, &arg2);
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
                    let (_, v14) = 0x3a6dfd4151c333a35cd420f9197766a4d702083249264935311f1186c4f5b903::sui20::get_sui20_data(&v12.obj);
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

    public fun list(arg0: &mut Global, arg1: 0x3a6dfd4151c333a35cd420f9197766a4d702083249264935311f1186c4f5b903::sui20::Sui20, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0x3a6dfd4151c333a35cd420f9197766a4d702083249264935311f1186c4f5b903::sui20::get_sui20_data(&arg1);
        assert!(v2 > 0, 1006);
        assert!(arg2 > 0, 1005);
        let v3 = 0x2::object::id<0x3a6dfd4151c333a35cd420f9197766a4d702083249264935311f1186c4f5b903::sui20::Sui20>(&arg1);
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

    // decompiled from Move bytecode v6
}

