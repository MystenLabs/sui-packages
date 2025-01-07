module 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        seller: address,
        inscription_id: 0x2::object::ID,
        inscription_price: u64,
        amt: u64,
        acc: u64,
    }

    struct Bid has store, key {
        id: 0x2::object::UID,
        bidder: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        amt: u64,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        tick: 0x1::ascii::String,
        version: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        burn_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        community_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: u64,
        listing: 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::CritbitTree<vector<Listing>>,
        bid: 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::CritbitTree<vector<Bid>>,
        listing_info: 0x2::table::Table<address, ListingInfo>,
    }

    struct TradeInfo has store, key {
        id: 0x2::object::UID,
        tick: 0x1::ascii::String,
        burn_ratio: u64,
        community_ratio: u64,
        lock_ratio: u64,
        timestamp: u64,
        yesterday_volume: u64,
        today_volume: u64,
        total_volume: u64,
    }

    struct ListingInfo has store, key {
        id: 0x2::object::UID,
        listing: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct ListingDetail has drop, store {
        inscription_id: 0x2::object::ID,
        unit_price: u64,
        amt: u64,
        acc: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketplaceHouse has key {
        id: 0x2::object::UID,
        market_info: 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>,
        markets: 0x2::table_vec::TableVec<0x1::ascii::String>,
    }

    struct BurnWitness has key {
        id: 0x2::object::UID,
        inscription_id: 0x2::object::ID,
        last_price: u64,
    }

    fun borrow_mut_listing(arg0: &mut 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::CritbitTree<vector<Listing>>, arg1: u64, arg2: 0x2::object::ID) : &mut Listing {
        let v0 = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::borrow_mut_leaf_by_key<vector<Listing>>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::length<Listing>(v0);
        while (v2 > v1) {
            if (arg2 == 0x1::vector::borrow<Listing>(v0, v1).inscription_id) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v1 < v2, 1);
        0x1::vector::borrow_mut<Listing>(v0, v1)
    }

    public fun burn_floor_inscription(arg0: &mut Marketplace, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BurnWitness) {
        assert!(arg0.version == 2, 0);
        let (v0, _) = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::min_leaf<vector<Listing>>(&arg0.listing);
        let v2 = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::borrow_leaf_by_key<vector<Listing>>(&arg0.listing, v0);
        assert!(0x1::vector::length<Listing>(v2) > 0, 1);
        let v3 = 0x1::vector::borrow<Listing>(v2, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.burn_balance) >= v3.price, 6);
        let v4 = BurnWitness{
            id             : 0x2::object::new(arg1),
            inscription_id : v3.inscription_id,
            last_price     : v3.inscription_price,
        };
        0x2::dynamic_field::add<u8, u64>(&mut v4.id, 0, v3.amt);
        (0x2::coin::take<0x2::sui::SUI>(&mut arg0.burn_balance, v3.price, arg1), v4)
    }

    public fun buy(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        let v0 = 0x2::dynamic_field::borrow_mut<u8, TradeInfo>(&mut arg0.id, 0);
        v0.total_volume = v0.total_volume + 0x2::coin::value<0x2::sui::SUI>(arg2);
        if (0x2::clock::timestamp_ms(arg4) - v0.timestamp > 86400000) {
            v0.today_volume = 0x2::coin::value<0x2::sui::SUI>(arg2);
            v0.yesterday_volume = v0.today_volume;
            v0.timestamp = 0x2::clock::timestamp_ms(arg4);
        } else {
            v0.today_volume = v0.today_volume + 0x2::coin::value<0x2::sui::SUI>(arg2);
        };
        assert!(arg0.version == 2, 0);
        let v1 = &mut arg0.listing;
        let v2 = remove_listing(v1, arg3, arg1);
        let v3 = 0x2::object::id<Listing>(&v2);
        let Listing {
            id                : v4,
            price             : v5,
            seller            : v6,
            inscription_id    : v7,
            inscription_price : v8,
            amt               : _,
            acc               : _,
        } = v2;
        0x2::object::delete(v4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v5, 3);
        let v11 = v5 * arg0.fee / 1000;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(arg2, v5 - v11, v6, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v11 * 500 / 1000, arg5)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v11 * v0.burn_ratio / 1000, arg5)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.community_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v11 * v0.community_ratio / 1000, arg5)));
        let v12 = 0x2::table::borrow_mut<address, ListingInfo>(&mut arg0.listing_info, v6);
        0x2::table::remove<0x2::object::ID, bool>(&mut v12.listing, v3);
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&v12.id, v3)) {
            0x2::dynamic_field::remove<0x2::object::ID, ListingDetail>(&mut v12.id, v3);
        };
        if (0x2::table::length<0x2::object::ID, bool>(&v12.listing) == 0) {
            let ListingInfo {
                id      : v13,
                listing : v14,
            } = 0x2::table::remove<address, ListingInfo>(&mut arg0.listing_info, v6);
            0x2::table::destroy_empty<0x2::object::ID, bool>(v14);
            0x2::object::delete(v13);
        };
        let v15 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.id, v7);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::inject_sui(&mut v15, 0x2::coin::split<0x2::sui::SUI>(arg2, v11 * v0.lock_ratio / 1000, arg5));
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::buy_event(v7, v6, 0x2::tx_context::sender(arg5), v5, v8);
        v15
    }

    public fun buy_with_burn_witness(arg0: &mut Marketplace, arg1: BurnWitness, arg2: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecord, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let BurnWitness {
            id             : v0,
            inscription_id : v1,
            last_price     : v2,
        } = arg1;
        0x2::object::delete(v0);
        let v3 = &mut arg3;
        let v4 = buy(arg0, v1, v3, v2, arg4, arg5);
        assert!(0x2::dynamic_field::remove<u8, u64>(&mut arg1.id, 0) == 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v4), 8);
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::burn_floor_event(v1, 0x2::tx_context::sender(arg5), 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v4), 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::acc(&v4), 0x2::coin::value<0x2::sui::SUI>(&arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg3, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_burn(arg2, v4, arg5));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
    }

    public fun buy_with_check(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (!check_listing_exist(&arg0.listing, arg3, arg1)) {
            return
        };
        let v0 = 0x2::dynamic_field::borrow_mut<u8, TradeInfo>(&mut arg0.id, 0);
        v0.total_volume = v0.total_volume + 0x2::coin::value<0x2::sui::SUI>(arg2);
        if (0x2::clock::timestamp_ms(arg4) - v0.timestamp > 86400000) {
            v0.today_volume = 0x2::coin::value<0x2::sui::SUI>(arg2);
            v0.yesterday_volume = v0.today_volume;
            v0.timestamp = 0x2::clock::timestamp_ms(arg4);
        } else {
            v0.today_volume = v0.today_volume + 0x2::coin::value<0x2::sui::SUI>(arg2);
        };
        assert!(arg0.version == 2, 0);
        let v1 = &mut arg0.listing;
        let v2 = remove_listing(v1, arg3, arg1);
        let v3 = 0x2::object::id<Listing>(&v2);
        let Listing {
            id                : v4,
            price             : v5,
            seller            : v6,
            inscription_id    : v7,
            inscription_price : v8,
            amt               : _,
            acc               : _,
        } = v2;
        0x2::object::delete(v4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v5, 3);
        let v11 = v5 * arg0.fee / 1000;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(arg2, v5 - v11, v6, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v11 * 500 / 1000, arg5)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v11 * v0.burn_ratio / 1000, arg5)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.community_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v11 * v0.community_ratio / 1000, arg5)));
        let v12 = 0x2::table::borrow_mut<address, ListingInfo>(&mut arg0.listing_info, v6);
        0x2::table::remove<0x2::object::ID, bool>(&mut v12.listing, v3);
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&v12.id, v3)) {
            0x2::dynamic_field::remove<0x2::object::ID, ListingDetail>(&mut v12.id, v3);
        };
        if (0x2::table::length<0x2::object::ID, bool>(&v12.listing) == 0) {
            let ListingInfo {
                id      : v13,
                listing : v14,
            } = 0x2::table::remove<address, ListingInfo>(&mut arg0.listing_info, v6);
            0x2::table::destroy_empty<0x2::object::ID, bool>(v14);
            0x2::object::delete(v13);
        };
        let v15 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.id, v7);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::inject_sui(&mut v15, 0x2::coin::split<0x2::sui::SUI>(arg2, v11 * v0.lock_ratio / 1000, arg5));
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::buy_event(v7, v6, 0x2::tx_context::sender(arg5), v5, v8);
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v15, 0x2::tx_context::sender(arg5));
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    fun check_listing_exist(arg0: &0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::CritbitTree<vector<Listing>>, arg1: u64, arg2: 0x2::object::ID) : bool {
        let (v0, _) = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::find_leaf<vector<Listing>>(arg0, arg1);
        if (!v0) {
            return false
        };
        let v2 = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::borrow_leaf_by_key<vector<Listing>>(arg0, arg1);
        let v3 = 0;
        let v4 = 0x1::vector::length<Listing>(v2);
        while (v4 > v3) {
            if (arg2 == 0x1::vector::borrow<Listing>(v2, v3).inscription_id) {
                break
            };
            v3 = v3 + 1;
        };
        v3 >= v4 && false || true
    }

    public entry fun createMarket(arg0: vector<u8>, arg1: &mut MarketplaceHouse, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(arg0);
        let v1 = 0x1::ascii::length(&v0);
        assert!(4 <= v1 && v1 <= 32, 5);
        let v2 = Marketplace{
            id                : 0x2::object::new(arg3),
            tick              : 0x1::ascii::string(arg0),
            version           : 2,
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            burn_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            community_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            fee               : 20,
            listing           : 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::new<vector<Listing>>(arg3),
            bid               : 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::new<vector<Bid>>(arg3),
            listing_info      : 0x2::table::new<address, ListingInfo>(arg3),
        };
        let v3 = TradeInfo{
            id               : 0x2::object::new(arg3),
            tick             : 0x1::ascii::string(arg0),
            burn_ratio       : 125,
            community_ratio  : 250,
            lock_ratio       : 125,
            timestamp        : 0x2::clock::timestamp_ms(arg2),
            yesterday_volume : 0,
            today_volume     : 0,
            total_volume     : 0,
        };
        0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut arg1.market_info, 0x1::ascii::string(arg0), 0x2::object::id<Marketplace>(&v2));
        0x2::table_vec::push_back<0x1::ascii::String>(&mut arg1.markets, 0x1::ascii::string(arg0));
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::market_created_event(0x2::object::id<Marketplace>(&v2), 0x2::tx_context::sender(arg3));
        0x2::dynamic_field::add<u8, TradeInfo>(&mut v2.id, 0, v3);
        0x2::transfer::share_object<Marketplace>(v2);
    }

    public entry fun delist(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 0);
        let v0 = &mut arg0.listing;
        let v1 = remove_listing(v0, arg2, arg1);
        let v2 = 0x2::object::id<Listing>(&v1);
        let Listing {
            id                : v3,
            price             : v4,
            seller            : v5,
            inscription_id    : v6,
            inscription_price : _,
            amt               : _,
            acc               : _,
        } = v1;
        0x2::object::delete(v3);
        assert!(0x2::tx_context::sender(arg3) == v5, 2);
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::delisted_event(v6, v5, v4);
        let v10 = 0x2::table::borrow_mut<address, ListingInfo>(&mut arg0.listing_info, v5);
        0x2::table::remove<0x2::object::ID, bool>(&mut v10.listing, v2);
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&v10.id, v2)) {
            0x2::dynamic_field::remove<0x2::object::ID, ListingDetail>(&mut v10.id, v2);
        };
        if (0x2::table::length<0x2::object::ID, bool>(&v10.listing) == 0) {
            let ListingInfo {
                id      : v11,
                listing : v12,
            } = 0x2::table::remove<address, ListingInfo>(&mut arg0.listing_info, v5);
            0x2::table::destroy_empty<0x2::object::ID, bool>(v12);
            0x2::object::delete(v11);
        };
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x2::dynamic_object_field::remove<0x2::object::ID, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.id, v6), v5);
    }

    public fun floor_listing(arg0: &Marketplace, arg1: u64, arg2: u64) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = 0;
        if (arg1 == 0) {
            let (v8, _) = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::min_leaf<vector<Listing>>(&arg0.listing);
            arg1 = v8;
        };
        while (v7 < 50) {
            let v10 = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::borrow_leaf_by_key<vector<Listing>>(&arg0.listing, arg1);
            while (0x1::vector::length<Listing>(v10) > arg2) {
                let v11 = 0x1::vector::borrow<Listing>(v10, arg2);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<Listing>(v11));
                0x1::vector::push_back<u64>(&mut v1, v11.price);
                0x1::vector::push_back<address>(&mut v2, v11.seller);
                0x1::vector::push_back<0x2::object::ID>(&mut v3, v11.inscription_id);
                0x1::vector::push_back<u64>(&mut v4, v11.inscription_price);
                0x1::vector::push_back<u64>(&mut v5, v11.amt);
                0x1::vector::push_back<u64>(&mut v6, v11.acc);
                arg2 = arg2 + 1;
                let v12 = v7 + 1;
                v7 = v12;
                if (v12 >= 50) {
                    0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::floor_price_event(v1, v2, v3, v4, v5, v6);
                    return v0
                };
            };
            arg2 = 0;
            let (v13, v14) = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::next_leaf<vector<Listing>>(&arg0.listing, arg1);
            if (v14 != 9223372036854775808) {
                arg1 = v13;
                continue
            };
            0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::floor_price_event(v1, v2, v3, v4, v5, v6);
            return v0
        };
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::floor_price_event(v1, v2, v3, v4, v5, v6);
        v0
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id                : 0x2::object::new(arg1),
            tick              : 0x1::ascii::string(b"MOVE"),
            version           : 2,
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            burn_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            community_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            fee               : 20,
            listing           : 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::new<vector<Listing>>(arg1),
            bid               : 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::new<vector<Bid>>(arg1),
            listing_info      : 0x2::table::new<address, ListingInfo>(arg1),
        };
        let v1 = 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg1);
        let v2 = TradeInfo{
            id               : 0x2::object::new(arg1),
            tick             : 0x1::ascii::string(b"MOVE"),
            burn_ratio       : 125,
            community_ratio  : 250,
            lock_ratio       : 125,
            timestamp        : 0,
            yesterday_volume : 0,
            today_volume     : 0,
            total_volume     : 0,
        };
        0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut v1, 0x1::ascii::string(b"MOVE"), 0x2::object::id<Marketplace>(&v0));
        let v3 = MarketplaceHouse{
            id          : 0x2::object::new(arg1),
            market_info : v1,
            markets     : 0x2::table_vec::singleton<0x1::ascii::String>(0x1::ascii::string(b"MOVE"), arg1),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKET>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::market_created_event(0x2::object::id<Marketplace>(&v0), 0x2::tx_context::sender(arg1));
        0x2::dynamic_field::add<u8, TradeInfo>(&mut v0.id, 0, v2);
        0x2::transfer::share_object<Marketplace>(v0);
        0x2::transfer::share_object<MarketplaceHouse>(v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public entry fun list(arg0: &mut Marketplace, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.tick == 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick(&arg1), 4);
        assert!(arg0.version == 2, 0);
        let v0 = 0x2::object::id<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg1);
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1);
        let v2 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::acc(&arg1);
        let v3 = arg2 * v1;
        assert!(v3 > 0, 7);
        let v4 = Listing{
            id                : 0x2::object::new(arg3),
            price             : v3,
            seller            : 0x2::tx_context::sender(arg3),
            inscription_id    : v0,
            inscription_price : arg2,
            amt               : v1,
            acc               : v2,
        };
        let v5 = 0x2::object::id<Listing>(&v4);
        let (v6, v7) = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::find_leaf<vector<Listing>>(&arg0.listing, arg2);
        if (v6) {
            0x1::vector::push_back<Listing>(0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::borrow_mut_leaf_by_index<vector<Listing>>(&mut arg0.listing, v7), v4);
        } else {
            0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::insert_leaf<vector<Listing>>(&mut arg0.listing, arg2, 0x1::vector::singleton<Listing>(v4));
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.id, v0, arg1);
        if (0x2::table::contains<address, ListingInfo>(&arg0.listing_info, 0x2::tx_context::sender(arg3))) {
            let v8 = 0x2::table::borrow_mut<address, ListingInfo>(&mut arg0.listing_info, 0x2::tx_context::sender(arg3));
            let v9 = ListingDetail{
                inscription_id : v0,
                unit_price     : arg2,
                amt            : v1,
                acc            : v2,
            };
            0x2::dynamic_field::add<0x2::object::ID, ListingDetail>(&mut v8.id, v5, v9);
            0x2::table::add<0x2::object::ID, bool>(&mut v8.listing, v5, true);
        } else {
            let v10 = 0x2::table::new<0x2::object::ID, bool>(arg3);
            0x2::table::add<0x2::object::ID, bool>(&mut v10, v5, true);
            let v11 = ListingInfo{
                id      : 0x2::object::new(arg3),
                listing : v10,
            };
            let v12 = ListingDetail{
                inscription_id : v0,
                unit_price     : arg2,
                amt            : v1,
                acc            : v2,
            };
            0x2::dynamic_field::add<0x2::object::ID, ListingDetail>(&mut v11.id, v5, v12);
            0x2::table::add<address, ListingInfo>(&mut arg0.listing_info, 0x2::tx_context::sender(arg3), v11);
        };
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::list_event(v0, 0x2::tx_context::sender(arg3), arg2, v1);
    }

    public fun listing_detail(arg0: &Marketplace, arg1: address) : 0x2::object::ID {
        let v0 = 0x2::object::id<ListingInfo>(0x2::table::borrow<address, ListingInfo>(&arg0.listing_info, arg1));
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::listing_info_event(v0);
        v0
    }

    public fun listing_info(arg0: &Marketplace, arg1: address) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x2::table::Table<0x2::object::ID, bool>>(&0x2::table::borrow<address, ListingInfo>(&arg0.listing_info, arg1).listing);
        0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event::listing_info_event(v0);
        v0
    }

    public entry fun migrate_marketplace(arg0: &mut Marketplace) {
        assert!(arg0.version <= 2, 0);
        arg0.version = 2;
    }

    fun remove_listing(arg0: &mut 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::CritbitTree<vector<Listing>>, arg1: u64, arg2: 0x2::object::ID) : Listing {
        let v0 = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::borrow_mut_leaf_by_key<vector<Listing>>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::length<Listing>(v0);
        while (v2 > v1) {
            if (arg2 == 0x1::vector::borrow<Listing>(v0, v1).inscription_id) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v1 < v2, 1);
        if (0x1::vector::length<Listing>(v0) == 0) {
            let (v3, v4) = 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::find_leaf<vector<Listing>>(arg0, arg1);
            if (v3) {
                0x1::vector::destroy_empty<Listing>(0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::critbit::remove_leaf_by_index<vector<Listing>>(arg0, v4));
            };
        };
        0x1::vector::remove<Listing>(v0, v1)
    }

    public entry fun update_market_fee(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 2, 0);
        arg1.fee = arg2;
    }

    public entry fun withdraw_profits(arg0: &AdminCap, arg1: &mut Marketplace, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance)), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

