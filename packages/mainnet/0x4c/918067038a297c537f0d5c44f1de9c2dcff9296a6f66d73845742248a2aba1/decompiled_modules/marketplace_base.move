module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base {
    struct Marketplace has key {
        id: 0x2::object::UID,
        market_fee_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        listing: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::CritbitTree<vector<Listing>>,
        user_listing_table: 0x2::table::Table<address, UserListingInfo>,
        market_fee: u64,
        market_type: u8,
        is_open: bool,
    }

    struct UserListingInfo has store, key {
        id: 0x2::object::UID,
        listing_list: 0x2::table::Table<0x2::object::ID, ListingDetail>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        item_id: 0x2::object::ID,
    }

    struct ListingDetail has drop, store {
        item_id: 0x2::object::ID,
        price: u64,
        list_time: u64,
    }

    struct FloorPriceEvent has copy, drop {
        listing_id_vector: vector<0x2::object::ID>,
        price_vector: vector<u64>,
        seller_vector: vector<address>,
        item_id_vector: vector<0x2::object::ID>,
    }

    struct HighestPriceEvent has copy, drop {
        listing_id_vector: vector<0x2::object::ID>,
        price_vector: vector<u64>,
        seller_vector: vector<address>,
        item_id_vector: vector<0x2::object::ID>,
    }

    struct SellerListingInfoEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct MARKETPLACE_BASE has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_marketplace_state(arg0: &Marketplace, arg1: u8) {
        assert!(get_market_type(arg0) == arg1, 2);
        assert!(is_market_open(arg0), 3);
    }

    public(friend) fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::MarketplaceTradeInfo, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, address, u64) {
        let v0 = &mut arg0.listing;
        let v1 = remove_listing(v0, arg2, arg1);
        let v2 = 0x2::object::id<Listing>(&v1);
        let Listing {
            id      : v3,
            seller  : v4,
            price   : v5,
            item_id : v6,
        } = v1;
        0x2::object::delete(v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) == v5, 2);
        assert!(v6 == arg1, 3);
        let v7 = v5 * arg0.market_fee / 1000;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(arg3, v5 - v7, v4, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.market_fee_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, v7, arg5)));
        let v8 = 0x2::table::borrow_mut<address, UserListingInfo>(&mut arg0.user_listing_table, v4);
        0x2::table::remove<0x2::object::ID, ListingDetail>(&mut v8.listing_list, v2);
        if (0x2::table::contains<0x2::object::ID, ListingDetail>(&v8.listing_list, v2)) {
            0x2::table::remove<0x2::object::ID, ListingDetail>(&mut v8.listing_list, v2);
        };
        if (0x2::table::length<0x2::object::ID, ListingDetail>(&v8.listing_list) == 0) {
            let UserListingInfo {
                id           : v9,
                listing_list : v10,
            } = 0x2::table::remove<address, UserListingInfo>(&mut arg0.user_listing_table, v4);
            0x2::table::destroy_empty<0x2::object::ID, ListingDetail>(v10);
            0x2::object::delete(v9);
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v6), 0x2::tx_context::sender(arg5));
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_marketplace_trade_info_volume(arg4, v5, true);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_marketplace_trade_info_trade_count(arg4, 1, true);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_marketplace_trade_info_listing_count(arg4, 1, false);
        (v2, v4, v5)
    }

    public(friend) fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::MarketplaceTradeInfo, arg4: &0x2::tx_context::TxContext) : (0x2::object::ID, address, u64) {
        let v0 = &mut arg0.listing;
        let v1 = remove_listing(v0, arg2, arg1);
        let v2 = 0x2::object::id<Listing>(&v1);
        let Listing {
            id      : v3,
            seller  : v4,
            price   : v5,
            item_id : v6,
        } = v1;
        0x2::object::delete(v3);
        assert!(0x2::tx_context::sender(arg4) == v4, 0);
        assert!(v6 == arg1, 3);
        let v7 = 0x2::table::borrow_mut<address, UserListingInfo>(&mut arg0.user_listing_table, v4);
        0x2::table::remove<0x2::object::ID, ListingDetail>(&mut v7.listing_list, v2);
        if (0x2::table::contains<0x2::object::ID, ListingDetail>(&v7.listing_list, v2)) {
            0x2::table::remove<0x2::object::ID, ListingDetail>(&mut v7.listing_list, v2);
        };
        if (0x2::table::length<0x2::object::ID, ListingDetail>(&v7.listing_list) == 0) {
            let UserListingInfo {
                id           : v8,
                listing_list : v9,
            } = 0x2::table::remove<address, UserListingInfo>(&mut arg0.user_listing_table, v4);
            0x2::table::destroy_empty<0x2::object::ID, ListingDetail>(v9);
            0x2::object::delete(v8);
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v6), v4);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_marketplace_trade_info_listing_count(arg3, 1, false);
        (v2, v4, v5)
    }

    public fun floor_listing(arg0: &Marketplace, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0;
        if (arg1 == 0) {
            let (v5, _) = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::min_leaf<vector<Listing>>(&arg0.listing);
            arg1 = v5;
        };
        while (v4 < 50) {
            let v7 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::borrow_leaf_by_key<vector<Listing>>(&arg0.listing, arg1);
            while (0x1::vector::length<Listing>(v7) > arg2) {
                let v8 = 0x1::vector::borrow<Listing>(v7, arg2);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<Listing>(v8));
                0x1::vector::push_back<u64>(&mut v1, v8.price);
                0x1::vector::push_back<address>(&mut v2, v8.seller);
                0x1::vector::push_back<0x2::object::ID>(&mut v3, v8.item_id);
                arg2 = arg2 + 1;
                let v9 = v4 + 1;
                v4 = v9;
                if (v9 >= 50) {
                    let v10 = FloorPriceEvent{
                        listing_id_vector : v0,
                        price_vector      : v1,
                        seller_vector     : v2,
                        item_id_vector    : v3,
                    };
                    0x2::event::emit<FloorPriceEvent>(v10);
                    return
                };
            };
            arg2 = 0;
            let (v11, v12) = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::next_leaf<vector<Listing>>(&arg0.listing, arg1);
            if (v12 != 9223372036854775808) {
                arg1 = v11;
                continue
            };
            let v13 = FloorPriceEvent{
                listing_id_vector : v0,
                price_vector      : v1,
                seller_vector     : v2,
                item_id_vector    : v3,
            };
            0x2::event::emit<FloorPriceEvent>(v13);
            return
        };
        let v14 = FloorPriceEvent{
            listing_id_vector : v0,
            price_vector      : v1,
            seller_vector     : v2,
            item_id_vector    : v3,
        };
        0x2::event::emit<FloorPriceEvent>(v14);
    }

    public fun get_market_type(arg0: &Marketplace) : u8 {
        arg0.market_type
    }

    public fun highest_listing(arg0: &Marketplace, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0;
        if (arg1 == 0) {
            let (v5, _) = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::max_leaf<vector<Listing>>(&arg0.listing);
            arg1 = v5;
        };
        while (v4 < 50) {
            let v7 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::borrow_leaf_by_key<vector<Listing>>(&arg0.listing, arg1);
            while (0x1::vector::length<Listing>(v7) > arg2) {
                let v8 = 0x1::vector::borrow<Listing>(v7, arg2);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<Listing>(v8));
                0x1::vector::push_back<u64>(&mut v1, v8.price);
                0x1::vector::push_back<address>(&mut v2, v8.seller);
                0x1::vector::push_back<0x2::object::ID>(&mut v3, v8.item_id);
                arg2 = arg2 + 1;
                let v9 = v4 + 1;
                v4 = v9;
                if (v9 >= 50) {
                    let v10 = HighestPriceEvent{
                        listing_id_vector : v0,
                        price_vector      : v1,
                        seller_vector     : v2,
                        item_id_vector    : v3,
                    };
                    0x2::event::emit<HighestPriceEvent>(v10);
                    return
                };
            };
            arg2 = 0;
            let (v11, v12) = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::previous_leaf<vector<Listing>>(&arg0.listing, arg1);
            if (v12 != 9223372036854775808) {
                arg1 = v11;
                continue
            };
            let v13 = HighestPriceEvent{
                listing_id_vector : v0,
                price_vector      : v1,
                seller_vector     : v2,
                item_id_vector    : v3,
            };
            0x2::event::emit<HighestPriceEvent>(v13);
            return
        };
        let v14 = HighestPriceEvent{
            listing_id_vector : v0,
            price_vector      : v1,
            seller_vector     : v2,
            item_id_vector    : v3,
        };
        0x2::event::emit<HighestPriceEvent>(v14);
    }

    public(friend) fun init_marketplace(arg0: u8, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id                  : 0x2::object::new(arg2),
            market_fee_treasury : 0x2::balance::zero<0x2::sui::SUI>(),
            listing             : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::new<vector<Listing>>(arg2),
            user_listing_table  : 0x2::table::new<address, UserListingInfo>(arg2),
            market_fee          : arg1,
            market_type         : arg0,
            is_open             : false,
        };
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun is_market_open(arg0: &Marketplace) : bool {
        arg0.is_open
    }

    public(friend) fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::MarketplaceTradeInfo, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = Listing{
            id      : 0x2::object::new(arg5),
            seller  : v1,
            price   : arg2,
            item_id : v0,
        };
        let v3 = 0x2::object::id<Listing>(&v2);
        let (v4, v5) = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::find_leaf<vector<Listing>>(&arg0.listing, arg2);
        if (v4) {
            0x1::vector::push_back<Listing>(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::borrow_mut_leaf_by_index<vector<Listing>>(&mut arg0.listing, v5), v2);
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::insert_leaf<vector<Listing>>(&mut arg0.listing, arg2, 0x1::vector::singleton<Listing>(v2));
        };
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        if (0x2::table::contains<address, UserListingInfo>(&arg0.user_listing_table, v1)) {
            let v6 = ListingDetail{
                item_id   : v0,
                price     : arg2,
                list_time : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::table::add<0x2::object::ID, ListingDetail>(&mut 0x2::table::borrow_mut<address, UserListingInfo>(&mut arg0.user_listing_table, v1).listing_list, v3, v6);
        } else {
            let v7 = 0x2::table::new<0x2::object::ID, ListingDetail>(arg5);
            let v8 = ListingDetail{
                item_id   : v0,
                price     : arg2,
                list_time : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::table::add<0x2::object::ID, ListingDetail>(&mut v7, v3, v8);
            let v9 = UserListingInfo{
                id           : 0x2::object::new(arg5),
                listing_list : v7,
            };
            0x2::table::add<address, UserListingInfo>(&mut arg0.user_listing_table, v1, v9);
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_marketplace_trade_info_listing_count(arg3, 1, true);
        (v3, v0)
    }

    fun remove_listing(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::CritbitTree<vector<Listing>>, arg1: u64, arg2: 0x2::object::ID) : Listing {
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::borrow_mut_leaf_by_key<vector<Listing>>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::length<Listing>(v0);
        while (v2 > v1) {
            if (arg2 == 0x1::vector::borrow<Listing>(v0, v1).item_id) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v1 < v2, 1);
        if (0x1::vector::length<Listing>(v0) == 0) {
            let (v3, v4) = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::find_leaf<vector<Listing>>(arg0, arg1);
            if (v3) {
                0x1::vector::destroy_empty<Listing>(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::critbit::remove_leaf_by_index<vector<Listing>>(arg0, v4));
            };
        };
        0x1::vector::remove<Listing>(v0, v1)
    }

    public fun seller_listing_list(arg0: &Marketplace, arg1: address) {
        let v0 = SellerListingInfoEvent{id: 0x2::object::id<UserListingInfo>(0x2::table::borrow<address, UserListingInfo>(&arg0.user_listing_table, arg1))};
        0x2::event::emit<SellerListingInfoEvent>(v0);
    }

    entry fun set_market_open(arg0: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg1: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg2: &mut Marketplace, arg3: bool) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg0);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg0, arg1);
        assert!(arg3 != arg2.is_open, 4);
        arg2.is_open = arg3;
    }

    entry fun withdraw_market_fee_treasury(arg0: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg1: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg2: &mut Marketplace, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg0);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.market_fee_treasury, 0x2::balance::value<0x2::sui::SUI>(&arg2.market_fee_treasury), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

