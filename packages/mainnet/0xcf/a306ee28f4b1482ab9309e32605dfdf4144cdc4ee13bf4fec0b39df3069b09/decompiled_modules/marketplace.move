module 0xd5dd28cc24009752905689b2ba2bf90bfc8de4549b9123f93519bb8ba9bf9981::marketplace {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct MarketplaceConfig has store, key {
        id: 0x2::object::UID,
        fee: u64,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
        wl: 0x2::table::Table<address, u64>,
    }

    struct CreatorConfig has store, key {
        id: 0x2::object::UID,
        total_creator: u64,
    }

    struct CreatorFee has store, key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        amount: u64,
        owner: address,
        nft_type: 0x1::string::String,
    }

    struct ListingEvent has copy, drop {
        item_id: 0x2::object::ID,
        amount: u64,
        seller: address,
        nft_type: 0x1::string::String,
    }

    struct DeListEvent has copy, drop {
        item_id: 0x2::object::ID,
        seller: address,
        nft_type: 0x1::string::String,
    }

    struct BuyEvent has copy, drop {
        item_id: 0x2::object::ID,
        amount: u64,
        buyer: address,
        nft_type: 0x1::string::String,
    }

    struct ChangePriceEvent has copy, drop {
        item_id: 0x2::object::ID,
        seller: address,
        amount: u64,
    }

    struct CollectCreatorEvent has copy, drop {
        creator: address,
        amount: u64,
    }

    public fun add_creator_fee(arg0: &mut CreatorConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_object_field::exists_with_type<address, CreatorFee>(&mut arg0.id, arg2)) {
            let v0 = CreatorFee{
                id      : 0x2::object::new(arg3),
                creator : arg2,
                balance : 0x2::coin::zero<0x2::sui::SUI>(arg3),
            };
            0x2::dynamic_object_field::add<address, CreatorFee>(&mut arg0.id, arg2, v0);
        };
        0x2::coin::join<0x2::sui::SUI>(&mut 0x2::dynamic_object_field::borrow_mut<address, CreatorFee>(&mut arg0.id, arg2).balance, arg1);
    }

    public fun add_market_fee(arg0: &mut MarketplaceConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, u64>(&arg0.wl, 0x2::tx_context::sender(arg2))) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
        } else {
            0x2::pay::keep<0x2::sui::SUI>(arg1, arg2);
        };
    }

    public entry fun add_wl_no_market_fee(arg0: &mut MarketplaceConfig, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 4);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x2::table::contains<address, u64>(&arg0.wl, v0)) {
                0x2::table::add<address, u64>(&mut arg0.wl, v0, 1);
            };
        };
    }

    public fun buy<T0: store + key, T1>(arg0: &mut MarketplaceConfig, arg1: &mut 0xd5dd28cc24009752905689b2ba2bf90bfc8de4549b9123f93519bb8ba9bf9981::creator_bluemove_fee::RoyaltyCollection, arg2: &mut CreatorConfig, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id       : v0,
            amount   : v1,
            owner    : v2,
            nft_type : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg3);
        let v4 = v0;
        let v5 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        0x2::pay::join<0x2::sui::SUI>(&mut v5, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v5) >= v1, 0);
        assert!(arg5 == v1, 0);
        let v6 = if (0xd5dd28cc24009752905689b2ba2bf90bfc8de4549b9123f93519bb8ba9bf9981::creator_bluemove_fee::check_exists_royalty_collection<T1>(arg1, arg6)) {
            let (v7, v8, v9, v10) = 0xd5dd28cc24009752905689b2ba2bf90bfc8de4549b9123f93519bb8ba9bf9981::creator_bluemove_fee::caculate_royalty_collection<T0>(arg1, v1, &mut v5, arg6);
            assert!(v10 == v3, 4);
            add_creator_fee(arg2, v8, v7, arg6);
            v9
        } else {
            0
        };
        let v11 = v1 * arg0.fee / 10000;
        let v12 = 0x2::coin::split<0x2::sui::SUI>(&mut v5, v1 - v11 - v6, arg6);
        let v13 = 0x2::coin::split<0x2::sui::SUI>(&mut v5, v11, arg6);
        add_market_fee(arg0, v13, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v12, v2);
        0x2::pay::keep<0x2::sui::SUI>(v5, arg6);
        let v14 = BuyEvent{
            item_id  : arg3,
            amount   : v1,
            buyer    : 0x2::tx_context::sender(arg6),
            nft_type : v3,
        };
        0x2::event::emit<BuyEvent>(v14);
        0x2::object::delete(v4);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v4, true)
    }

    public entry fun buy_and_take<T0: store + key, T1>(arg0: &mut MarketplaceConfig, arg1: &mut 0xd5dd28cc24009752905689b2ba2bf90bfc8de4549b9123f93519bb8ba9bf9981::creator_bluemove_fee::RoyaltyCollection, arg2: &mut CreatorConfig, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = buy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun buy_and_take_standard<T0: store + key>(arg0: &mut MarketplaceConfig, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg2: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg3: &mut CreatorConfig, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_standard<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun buy_standard<T0: store + key>(arg0: &mut MarketplaceConfig, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg2: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg3: &mut CreatorConfig, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id       : v0,
            amount   : v1,
            owner    : v2,
            nft_type : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg4);
        let v4 = v0;
        let v5 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::has_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(arg2);
        let v6 = 0x2::vec_set::into_keys<address>(*0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::get_Creators(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(arg2)));
        let v7 = 0x2::coin::zero<0x2::sui::SUI>(arg7);
        0x2::pay::join<0x2::sui::SUI>(&mut v7, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v7) == arg6, 0);
        assert!(arg6 == v1, 0);
        let v8 = v1 * arg0.fee / 10000;
        let v9 = 0x2::coin::split<0x2::sui::SUI>(&mut v7, v8, arg7);
        let v10 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::calculate<T0>(arg1, arg6);
        if (0x1::vector::length<address>(&v6) > 0 && v5) {
        };
        if (0x1::vector::length<address>(&v6) > 0 && v5 && v10 > 0) {
            let v11 = 0x1::vector::length<address>(&v6);
            let v12 = 0;
            let v13 = 0x2::coin::split<0x2::sui::SUI>(&mut v7, v10, arg7);
            while (v12 < v11) {
                let v14 = 0x2::coin::split<0x2::sui::SUI>(&mut v13, v10 / v11, arg7);
                add_creator_fee(arg3, v14, 0x1::vector::pop_back<address>(&mut v6), arg7);
                v12 = v12 + 1;
            };
            0x2::coin::join<0x2::sui::SUI>(&mut v7, v13);
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v2);
        let v15 = BuyEvent{
            item_id  : arg4,
            amount   : v1,
            buyer    : 0x2::tx_context::sender(arg7),
            nft_type : v3,
        };
        0x2::event::emit<BuyEvent>(v15);
        0x2::object::delete(v4);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v4, true)
    }

    public entry fun change_price<T0: store + key, T1>(arg0: &mut MarketplaceConfig, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 1);
        v0.amount = arg2;
        let v1 = ChangePriceEvent{
            item_id : arg1,
            seller  : v0.owner,
            amount  : arg2,
        };
        0x2::event::emit<ChangePriceEvent>(v1);
    }

    public entry fun collect_creator_fee<T0>(arg0: &mut CreatorConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, CreatorFee>(&mut arg0.id, v0);
        assert!(v0 == v1.creator, 1);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1.balance);
        assert!(v2 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1.balance, v2, arg1), v0);
    }

    public entry fun collect_profits(arg0: &mut MarketplaceConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 || v0 == @0x8084455a96bdde21edd8fe48ec3f15dbe1c82b2ee2e0e963d800f3d7d8fbbcd5, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::value<0x2::sui::SUI>(&arg0.balance), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun delist<T0: store + key, T1>(arg0: &mut MarketplaceConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id       : v0,
            amount   : _,
            owner    : v2,
            nft_type : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v4 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        let v5 = DeListEvent{
            item_id  : arg1,
            seller   : 0x2::tx_context::sender(arg2),
            nft_type : v3,
        };
        0x2::event::emit<DeListEvent>(v5);
        0x2::object::delete(v4);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v4, true)
    }

    public entry fun delist_and_take<T0: store + key, T1>(arg0: &mut MarketplaceConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = delist<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_market_fee(arg0: &mut MarketplaceConfig, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        arg0.fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceConfig{
            id      : 0x2::object::new(arg0),
            fee     : 250,
            balance : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            wl      : 0x2::table::new<address, u64>(arg0),
        };
        let v1 = CreatorConfig{
            id            : 0x2::object::new(arg0),
            total_creator : 0,
        };
        0x2::transfer::share_object<CreatorConfig>(v1);
        0x2::transfer::share_object<MarketplaceConfig>(v0);
    }

    public entry fun list<T0: store + key, T1>(arg0: &mut MarketplaceConfig, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = Listing{
            id       : 0x2::object::new(arg3),
            amount   : arg2,
            owner    : 0x2::tx_context::sender(arg3),
            nft_type : 0xd5dd28cc24009752905689b2ba2bf90bfc8de4549b9123f93519bb8ba9bf9981::utils::get_token_name<T1>(),
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v1.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v0, v1);
        let v2 = ListingEvent{
            item_id  : v0,
            amount   : arg2,
            seller   : 0x2::tx_context::sender(arg3),
            nft_type : 0xd5dd28cc24009752905689b2ba2bf90bfc8de4549b9123f93519bb8ba9bf9981::utils::get_token_name<T1>(),
        };
        0x2::event::emit<ListingEvent>(v2);
    }

    public entry fun update_fee_market(arg0: &mut MarketplaceConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 4);
        arg0.fee = arg1;
    }

    // decompiled from Move bytecode v6
}

