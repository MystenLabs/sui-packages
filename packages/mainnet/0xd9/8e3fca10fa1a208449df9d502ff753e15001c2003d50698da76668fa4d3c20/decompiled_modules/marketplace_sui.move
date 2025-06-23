module 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::marketplace_sui {
    struct DungeonObjDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        dungeon_item_id: 0x2::object::ID,
    }

    struct ListingInfo has store, key {
        id: 0x2::object::UID,
        plyaer_listing_list: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct ListingDetail has drop, store {
        dungeon_item_id: 0x2::object::ID,
        price: u64,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        listing: 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::CritbitTree<vector<Listing>>,
        plyaer_listing_map: 0x2::table::Table<address, ListingInfo>,
        fee: u64,
        version: u64,
    }

    struct TradeInfo has store, key {
        id: 0x2::object::UID,
        total_volume: u64,
    }

    struct ListEvent has copy, drop {
        listing_id: 0x2::object::ID,
        dungeon_item_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct RelistEvent has copy, drop {
        listing_id: 0x2::object::ID,
        dungeon_item_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct DelistEvent has copy, drop {
        listing_id: 0x2::object::ID,
        dungeon_item_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct BuyEvent has copy, drop {
        listing_id: 0x2::object::ID,
        dungeon_item_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
    }

    struct FloorPriceEvent has copy, drop {
        listing_id_vector: vector<0x2::object::ID>,
        price_vector: vector<u64>,
        seller_vector: vector<address>,
        dungeon_item_id_vector: vector<0x2::object::ID>,
    }

    struct HighestPriceEvent has copy, drop {
        listing_id_vector: vector<0x2::object::ID>,
        price_vector: vector<u64>,
        seller_vector: vector<address>,
        dungeon_item_id_vector: vector<0x2::object::ID>,
    }

    struct SellerListingInfoEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct MARKETPLACE_SUI has drop {
        dummy_field: bool,
    }

    public fun admin_init_market(arg0: &0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id                 : 0x2::object::new(arg1),
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            listing            : 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::new<vector<Listing>>(arg1),
            plyaer_listing_map : 0x2::table::new<address, ListingInfo>(arg1),
            fee                : 25,
            version            : 1,
        };
        let v1 = TradeInfo{
            id           : 0x2::object::new(arg1),
            total_volume : 0,
        };
        0x2::dynamic_field::add<u8, TradeInfo>(&mut v0.id, 0, v1);
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun admin_migrate(arg0: &0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::AdminCap, arg1: &mut Marketplace) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    public fun admin_update_marketplace_fee(arg0: &0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::AdminCap, arg1: &mut Marketplace, arg2: u64) {
        assert!(arg1.version == 1, 0);
        assert!(arg2 <= 100, 0);
        arg1.fee = arg2;
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = &mut arg0.listing;
        let v1 = remove_listing(v0, arg2, arg1);
        let v2 = 0x2::object::id<Listing>(&v1);
        let Listing {
            id              : v3,
            seller          : v4,
            price           : v5,
            dungeon_item_id : v6,
        } = v1;
        0x2::object::delete(v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) == v5, 2);
        assert!(v6 == arg1, 3);
        let v7 = 0x2::dynamic_field::borrow_mut<u8, TradeInfo>(&mut arg0.id, 0);
        v7.total_volume = v7.total_volume + v5;
        let v8 = v5 * arg0.fee / 1000;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(arg3, v5 - v8, v4, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, v8, arg4)));
        let v9 = 0x2::table::borrow_mut<address, ListingInfo>(&mut arg0.plyaer_listing_map, v4);
        0x2::table::remove<0x2::object::ID, bool>(&mut v9.plyaer_listing_list, v2);
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&v9.id, v2)) {
            0x2::dynamic_field::remove<0x2::object::ID, ListingDetail>(&mut v9.id, v2);
        };
        if (0x2::table::length<0x2::object::ID, bool>(&v9.plyaer_listing_list) == 0) {
            let ListingInfo {
                id                  : v10,
                plyaer_listing_list : v11,
            } = 0x2::table::remove<address, ListingInfo>(&mut arg0.plyaer_listing_map, v4);
            0x2::table::destroy_empty<0x2::object::ID, bool>(v11);
            0x2::object::delete(v10);
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v6), 0x2::tx_context::sender(arg4));
        let v12 = BuyEvent{
            listing_id      : v2,
            dungeon_item_id : v6,
            seller          : v4,
            buyer           : 0x2::tx_context::sender(arg4),
            price           : v5,
        };
        0x2::event::emit<BuyEvent>(v12);
    }

    public fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = &mut arg0.listing;
        let v1 = remove_listing(v0, arg2, arg1);
        let v2 = 0x2::object::id<Listing>(&v1);
        let Listing {
            id              : v3,
            seller          : v4,
            price           : v5,
            dungeon_item_id : v6,
        } = v1;
        0x2::object::delete(v3);
        assert!(0x2::tx_context::sender(arg3) == v4, 2);
        assert!(v6 == arg1, 3);
        let v7 = 0x2::table::borrow_mut<address, ListingInfo>(&mut arg0.plyaer_listing_map, v4);
        0x2::table::remove<0x2::object::ID, bool>(&mut v7.plyaer_listing_list, v2);
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&v7.id, v2)) {
            0x2::dynamic_field::remove<0x2::object::ID, ListingDetail>(&mut v7.id, v2);
        };
        if (0x2::table::length<0x2::object::ID, bool>(&v7.plyaer_listing_list) == 0) {
            let ListingInfo {
                id                  : v8,
                plyaer_listing_list : v9,
            } = 0x2::table::remove<address, ListingInfo>(&mut arg0.plyaer_listing_map, v4);
            0x2::table::destroy_empty<0x2::object::ID, bool>(v9);
            0x2::object::delete(v8);
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v6), v4);
        let v10 = DelistEvent{
            listing_id      : v2,
            dungeon_item_id : v6,
            seller          : v4,
            price           : v5,
        };
        0x2::event::emit<DelistEvent>(v10);
    }

    public fun floor_listing(arg0: &Marketplace, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0;
        if (arg1 == 0) {
            let (v5, _) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::min_leaf<vector<Listing>>(&arg0.listing);
            arg1 = v5;
        };
        while (v4 < 50) {
            let v7 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::borrow_leaf_by_key<vector<Listing>>(&arg0.listing, arg1);
            while (0x1::vector::length<Listing>(v7) > arg2) {
                let v8 = 0x1::vector::borrow<Listing>(v7, arg2);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<Listing>(v8));
                0x1::vector::push_back<u64>(&mut v1, v8.price);
                0x1::vector::push_back<address>(&mut v2, v8.seller);
                0x1::vector::push_back<0x2::object::ID>(&mut v3, v8.dungeon_item_id);
                arg2 = arg2 + 1;
                let v9 = v4 + 1;
                v4 = v9;
                if (v9 >= 50) {
                    let v10 = FloorPriceEvent{
                        listing_id_vector      : v0,
                        price_vector           : v1,
                        seller_vector          : v2,
                        dungeon_item_id_vector : v3,
                    };
                    0x2::event::emit<FloorPriceEvent>(v10);
                    return
                };
            };
            arg2 = 0;
            let (v11, v12) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::next_leaf<vector<Listing>>(&arg0.listing, arg1);
            if (v12 != 9223372036854775808) {
                arg1 = v11;
                continue
            };
            let v13 = FloorPriceEvent{
                listing_id_vector      : v0,
                price_vector           : v1,
                seller_vector          : v2,
                dungeon_item_id_vector : v3,
            };
            0x2::event::emit<FloorPriceEvent>(v13);
            return
        };
        let v14 = FloorPriceEvent{
            listing_id_vector      : v0,
            price_vector           : v1,
            seller_vector          : v2,
            dungeon_item_id_vector : v3,
        };
        0x2::event::emit<FloorPriceEvent>(v14);
    }

    public fun highest_listing(arg0: &Marketplace, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0;
        if (arg1 == 0) {
            let (v5, _) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::max_leaf<vector<Listing>>(&arg0.listing);
            arg1 = v5;
        };
        while (v4 < 50) {
            let v7 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::borrow_leaf_by_key<vector<Listing>>(&arg0.listing, arg1);
            while (0x1::vector::length<Listing>(v7) > arg2) {
                let v8 = 0x1::vector::borrow<Listing>(v7, arg2);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<Listing>(v8));
                0x1::vector::push_back<u64>(&mut v1, v8.price);
                0x1::vector::push_back<address>(&mut v2, v8.seller);
                0x1::vector::push_back<0x2::object::ID>(&mut v3, v8.dungeon_item_id);
                arg2 = arg2 + 1;
                let v9 = v4 + 1;
                v4 = v9;
                if (v9 >= 50) {
                    let v10 = HighestPriceEvent{
                        listing_id_vector      : v0,
                        price_vector           : v1,
                        seller_vector          : v2,
                        dungeon_item_id_vector : v3,
                    };
                    0x2::event::emit<HighestPriceEvent>(v10);
                    return
                };
            };
            arg2 = 0;
            let (v11, v12) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::previous_leaf<vector<Listing>>(&arg0.listing, arg1);
            if (v12 != 9223372036854775808) {
                arg1 = v11;
                continue
            };
            let v13 = HighestPriceEvent{
                listing_id_vector      : v0,
                price_vector           : v1,
                seller_vector          : v2,
                dungeon_item_id_vector : v3,
            };
            0x2::event::emit<HighestPriceEvent>(v13);
            return
        };
        let v14 = HighestPriceEvent{
            listing_id_vector      : v0,
            price_vector           : v1,
            seller_vector          : v2,
            dungeon_item_id_vector : v3,
        };
        0x2::event::emit<HighestPriceEvent>(v14);
    }

    fun init(arg0: MARKETPLACE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id                 : 0x2::object::new(arg1),
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            listing            : 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::new<vector<Listing>>(arg1),
            plyaer_listing_map : 0x2::table::new<address, ListingInfo>(arg1),
            fee                : 25,
            version            : 1,
        };
        let v1 = TradeInfo{
            id           : 0x2::object::new(arg1),
            total_volume : 0,
        };
        0x2::dynamic_field::add<u8, TradeInfo>(&mut v0.id, 0, v1);
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Listing{
            id              : 0x2::object::new(arg3),
            seller          : v1,
            price           : arg2,
            dungeon_item_id : v0,
        };
        let v3 = 0x2::object::id<Listing>(&v2);
        let (v4, v5) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::find_leaf<vector<Listing>>(&arg0.listing, arg2);
        if (v4) {
            0x1::vector::push_back<Listing>(0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::borrow_mut_leaf_by_index<vector<Listing>>(&mut arg0.listing, v5), v2);
        } else {
            0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::insert_leaf<vector<Listing>>(&mut arg0.listing, arg2, 0x1::vector::singleton<Listing>(v2));
        };
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        if (0x2::table::contains<address, ListingInfo>(&arg0.plyaer_listing_map, v1)) {
            let v6 = 0x2::table::borrow_mut<address, ListingInfo>(&mut arg0.plyaer_listing_map, v1);
            let v7 = ListingDetail{
                dungeon_item_id : v0,
                price           : arg2,
            };
            0x2::dynamic_field::add<0x2::object::ID, ListingDetail>(&mut v6.id, v3, v7);
            0x2::table::add<0x2::object::ID, bool>(&mut v6.plyaer_listing_list, v3, true);
        } else {
            let v8 = 0x2::table::new<0x2::object::ID, bool>(arg3);
            0x2::table::add<0x2::object::ID, bool>(&mut v8, v3, true);
            let v9 = ListingInfo{
                id                  : 0x2::object::new(arg3),
                plyaer_listing_list : v8,
            };
            let v10 = ListingDetail{
                dungeon_item_id : v0,
                price           : arg2,
            };
            0x2::dynamic_field::add<0x2::object::ID, ListingDetail>(&mut v9.id, v3, v10);
            0x2::table::add<address, ListingInfo>(&mut arg0.plyaer_listing_map, v1, v9);
        };
        let v11 = ListEvent{
            listing_id      : v3,
            dungeon_item_id : v0,
            seller          : v1,
            price           : arg2,
        };
        0x2::event::emit<ListEvent>(v11);
    }

    fun remove_listing(arg0: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::CritbitTree<vector<Listing>>, arg1: u64, arg2: 0x2::object::ID) : Listing {
        let v0 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::borrow_mut_leaf_by_key<vector<Listing>>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::length<Listing>(v0);
        while (v2 > v1) {
            if (arg2 == 0x1::vector::borrow<Listing>(v0, v1).dungeon_item_id) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v1 < v2, 8);
        if (0x1::vector::length<Listing>(v0) == 0) {
            let (v3, v4) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::find_leaf<vector<Listing>>(arg0, arg1);
            if (v3) {
                0x1::vector::destroy_empty<Listing>(0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::remove_leaf_by_index<vector<Listing>>(arg0, v4));
            };
        };
        0x1::vector::remove<Listing>(v0, v1)
    }

    public fun seller_listing_list(arg0: &Marketplace, arg1: address) {
        let v0 = SellerListingInfoEvent{id: 0x2::object::id<ListingInfo>(0x2::table::borrow<address, ListingInfo>(&arg0.plyaer_listing_map, arg1))};
        0x2::event::emit<SellerListingInfoEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

