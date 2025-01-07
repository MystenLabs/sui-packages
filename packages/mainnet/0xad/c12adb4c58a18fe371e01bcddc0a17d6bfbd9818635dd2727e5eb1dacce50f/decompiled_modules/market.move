module 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        seller: address,
        mist_id: 0x2::object::ID,
        mist_price: u64,
        amt: u64,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        version: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: u64,
        listing: 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::CritbitTree<vector<Listing>>,
    }

    struct TradeInfo has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        timestamp: u64,
        yesterday_balance: u64,
        today_balance: u64,
        total_balance: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketplaceHouse has key {
        id: 0x2::object::UID,
        market_info: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        markets: 0x2::table_vec::TableVec<0x1::string::String>,
    }

    fun borrow_mut_listing(arg0: &mut 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::CritbitTree<vector<Listing>>, arg1: u64, arg2: 0x2::object::ID) : &mut Listing {
        let v0 = 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::borrow_mut_leaf_by_key<vector<Listing>>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::length<Listing>(v0);
        while (v2 > v1) {
            if (arg2 == 0x1::vector::borrow<Listing>(v0, v1).mist_id) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v1 < v2, 1);
        0x1::vector::borrow_mut<Listing>(v0, v1)
    }

    public fun buy(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::Mist {
        let v0 = 0x2::dynamic_field::borrow_mut<u8, TradeInfo>(&mut arg0.id, 0);
        v0.total_balance = v0.total_balance + 0x2::coin::value<0x2::sui::SUI>(arg2);
        if (0x2::clock::timestamp_ms(arg4) - v0.timestamp > 86400) {
            v0.today_balance = 0x2::coin::value<0x2::sui::SUI>(arg2);
            v0.yesterday_balance = v0.today_balance;
            v0.timestamp = 0x2::clock::timestamp_ms(arg4);
        } else {
            v0.today_balance = v0.today_balance + 0x2::coin::value<0x2::sui::SUI>(arg2);
        };
        assert!(arg0.version == 1, 0);
        let v1 = &mut arg0.listing;
        let Listing {
            id         : v2,
            price      : v3,
            seller     : v4,
            mist_id    : v5,
            mist_price : _,
            amt        : _,
        } = remove_listing(v1, arg3, arg1);
        0x2::object::delete(v2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v3, 3);
        let v8 = v3 * arg0.fee / 10000;
        let v9 = v3 - v8;
        assert!(v9 > 0, 3);
        0x2::pay::split_and_transfer<0x2::sui::SUI>(arg2, v9, v4, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v8, arg5)));
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::mist_buy_event(v5, v4, 0x2::tx_context::sender(arg5), v3, arg3);
        0x2::dynamic_object_field::remove<0x2::object::ID, 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::Mist>(&mut arg0.id, v5)
    }

    public fun buySUI20(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20::SUI20 {
        let v0 = 0x2::dynamic_field::borrow_mut<u8, TradeInfo>(&mut arg0.id, 0);
        v0.total_balance = v0.total_balance + 0x2::coin::value<0x2::sui::SUI>(arg2);
        if (0x2::clock::timestamp_ms(arg4) - v0.timestamp > 86400) {
            v0.today_balance = 0x2::coin::value<0x2::sui::SUI>(arg2);
            v0.yesterday_balance = v0.today_balance;
            v0.timestamp = 0x2::clock::timestamp_ms(arg4);
        } else {
            v0.today_balance = v0.today_balance + 0x2::coin::value<0x2::sui::SUI>(arg2);
        };
        assert!(arg0.version == 1, 0);
        let v1 = &mut arg0.listing;
        let Listing {
            id         : v2,
            price      : v3,
            seller     : v4,
            mist_id    : v5,
            mist_price : _,
            amt        : _,
        } = remove_listing(v1, arg3, arg1);
        0x2::object::delete(v2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v3, 3);
        let v8 = v3 * arg0.fee / 10000;
        let v9 = v3 - v8;
        assert!(v9 > 0, 3);
        0x2::pay::split_and_transfer<0x2::sui::SUI>(arg2, v9, v4, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v8, arg5)));
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::mist_buy_event(v5, v4, 0x2::tx_context::sender(arg5), v3, arg3);
        0x2::dynamic_object_field::remove<0x2::object::ID, 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20::SUI20>(&mut arg0.id, v5)
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public entry fun createMarket(arg0: vector<u8>, arg1: &mut MarketplaceHouse, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 4, 4);
        let v0 = Marketplace{
            id      : 0x2::object::new(arg3),
            tick    : 0x1::string::utf8(arg0),
            version : 1,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            fee     : 0,
            listing : 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::new<vector<Listing>>(arg3),
        };
        let v1 = TradeInfo{
            id                : 0x2::object::new(arg3),
            tick              : 0x1::string::utf8(arg0),
            timestamp         : 0x2::clock::timestamp_ms(arg2),
            yesterday_balance : 0,
            today_balance     : 0,
            total_balance     : 0,
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.market_info, 0x1::string::utf8(arg0), 0x2::object::id<Marketplace>(&v0));
        0x2::table_vec::push_back<0x1::string::String>(&mut arg1.markets, 0x1::string::utf8(arg0));
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::market_created_event(0x2::object::id<Marketplace>(&v0), 0x2::tx_context::sender(arg3));
        0x2::dynamic_field::add<u8, TradeInfo>(&mut v0.id, 0, v1);
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public entry fun delist(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0.listing;
        let Listing {
            id         : v1,
            price      : v2,
            seller     : v3,
            mist_id    : v4,
            mist_price : _,
            amt        : _,
        } = remove_listing(v0, arg2, arg1);
        0x2::object::delete(v1);
        assert!(0x2::tx_context::sender(arg3) == v3, 2);
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::mist_delisted_event(v4, v3, v2);
        0x2::transfer::public_transfer<0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::Mist>(0x2::dynamic_object_field::remove<0x2::object::ID, 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::Mist>(&mut arg0.id, v4), v3);
    }

    public entry fun delistSUI20(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0.listing;
        let Listing {
            id         : v1,
            price      : v2,
            seller     : v3,
            mist_id    : v4,
            mist_price : _,
            amt        : _,
        } = remove_listing(v0, arg2, arg1);
        0x2::object::delete(v1);
        assert!(0x2::tx_context::sender(arg3) == v3, 2);
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::mist_delisted_event(v4, v3, v2);
        0x2::transfer::public_transfer<0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20::SUI20>(0x2::dynamic_object_field::remove<0x2::object::ID, 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20::SUI20>(&mut arg0.id, v4), v3);
    }

    public fun get_floor_listing(arg0: &Marketplace, arg1: u64, arg2: u64) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        if (arg1 == 0) {
            let (v7, _) = 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::min_leaf<vector<Listing>>(&arg0.listing);
            arg1 = v7;
        };
        while (v6 < arg2 + 50) {
            let v9 = 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::borrow_leaf_by_key<vector<Listing>>(&arg0.listing, arg1);
            while (0x1::vector::length<Listing>(v9) > arg2) {
                let v10 = 0x1::vector::borrow<Listing>(v9, arg2);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<Listing>(v10));
                0x1::vector::push_back<u64>(&mut v1, v10.price);
                0x1::vector::push_back<address>(&mut v2, v10.seller);
                0x1::vector::push_back<0x2::object::ID>(&mut v3, v10.mist_id);
                0x1::vector::push_back<u64>(&mut v4, v10.mist_price);
                0x1::vector::push_back<u64>(&mut v5, v10.amt);
                arg2 = arg2 + 1;
                v6 = v6 + 1;
            };
            arg2 = 0;
            let (v11, v12) = 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::next_leaf<vector<Listing>>(&arg0.listing, arg1);
            if (v12 != 9223372036854775808) {
                arg1 = v11;
                continue
            };
            0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::mist_floor_price_event(v1, v2, v3, v4, v5);
            return v0
        };
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::mist_floor_price_event(v1, v2, v3, v4, v5);
        v0
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id      : 0x2::object::new(arg1),
            tick    : 0x1::string::utf8(b"mist"),
            version : 1,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            fee     : 0,
            listing : 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::new<vector<Listing>>(arg1),
        };
        let v1 = 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1);
        let v2 = TradeInfo{
            id                : 0x2::object::new(arg1),
            tick              : 0x1::string::utf8(b"mist"),
            timestamp         : 0,
            yesterday_balance : 0,
            today_balance     : 0,
            total_balance     : 0,
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut v1, 0x1::string::utf8(b"mist"), 0x2::object::id<Marketplace>(&v0));
        let v3 = MarketplaceHouse{
            id          : 0x2::object::new(arg1),
            market_info : v1,
            markets     : 0x2::table_vec::singleton<0x1::string::String>(0x1::string::utf8(b"mist"), arg1),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKET>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::market_created_event(0x2::object::id<Marketplace>(&v0), 0x2::tx_context::sender(arg1));
        0x2::dynamic_field::add<u8, TradeInfo>(&mut v0.id, 0, v2);
        0x2::transfer::share_object<Marketplace>(v0);
        0x2::transfer::share_object<MarketplaceHouse>(v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public entry fun list(arg0: &mut Marketplace, arg1: 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::Mist, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.tick == 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::mist_tick(&arg1), 5);
        let v0 = 0x2::object::id<0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::Mist>(&arg1);
        let v1 = 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::mist_balance(&arg1);
        let v2 = arg2 / v1;
        let v3 = Listing{
            id         : 0x2::object::new(arg3),
            price      : arg2,
            seller     : 0x2::tx_context::sender(arg3),
            mist_id    : v0,
            mist_price : v2,
            amt        : v1,
        };
        let (v4, v5) = 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::find_leaf<vector<Listing>>(&arg0.listing, v2);
        if (v4) {
            0x1::vector::push_back<Listing>(0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::borrow_mut_leaf_by_index<vector<Listing>>(&mut arg0.listing, v5), v3);
        } else {
            0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::insert_leaf<vector<Listing>>(&mut arg0.listing, v2, 0x1::vector::singleton<Listing>(v3));
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::Mist>(&mut arg0.id, v0, arg1);
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::mist_list_event(v0, 0x2::tx_context::sender(arg3), v2, v1);
    }

    public entry fun listSUI20(arg0: &mut Marketplace, arg1: 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20::SUI20, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.tick == 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20::sui20_tick(&arg1), 5);
        let v0 = 0x2::object::id<0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20::SUI20>(&arg1);
        let v1 = 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20::sui20_balance(&arg1);
        let v2 = arg2 / v1;
        let v3 = Listing{
            id         : 0x2::object::new(arg3),
            price      : arg2,
            seller     : 0x2::tx_context::sender(arg3),
            mist_id    : v0,
            mist_price : v2,
            amt        : v1,
        };
        let (v4, v5) = 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::find_leaf<vector<Listing>>(&arg0.listing, v2);
        if (v4) {
            0x1::vector::push_back<Listing>(0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::borrow_mut_leaf_by_index<vector<Listing>>(&mut arg0.listing, v5), v3);
        } else {
            0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::insert_leaf<vector<Listing>>(&mut arg0.listing, v2, 0x1::vector::singleton<Listing>(v3));
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::sui20::SUI20>(&mut arg0.id, v0, arg1);
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::mist_list_event(v0, 0x2::tx_context::sender(arg3), v2, v1);
    }

    public entry fun modify_price(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0.listing;
        let v1 = borrow_mut_listing(v0, arg2, arg1);
        assert!(v1.seller == 0x2::tx_context::sender(arg4), 2);
        v1.price = arg3;
        0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event::mist_modify_price_event(arg1, 0x2::tx_context::sender(arg4), arg3);
    }

    fun remove_listing(arg0: &mut 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::CritbitTree<vector<Listing>>, arg1: u64, arg2: 0x2::object::ID) : Listing {
        let v0 = 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::borrow_mut_leaf_by_key<vector<Listing>>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::length<Listing>(v0);
        while (v2 > v1) {
            if (arg2 == 0x1::vector::borrow<Listing>(v0, v1).mist_id) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v1 < v2, 1);
        if (0x1::vector::length<Listing>(v0) == 0) {
            let (v3, v4) = 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::find_leaf<vector<Listing>>(arg0, arg1);
            if (v3) {
                0x1::vector::destroy_empty<Listing>(0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::critbit::remove_leaf_by_index<vector<Listing>>(arg0, v4));
            };
        };
        0x1::vector::remove<Listing>(v0, v1)
    }

    public entry fun update_market_fee(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 0);
        arg1.fee = arg2;
    }

    public entry fun withdraw_profits(arg0: &AdminCap, arg1: &mut Marketplace, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance)), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

