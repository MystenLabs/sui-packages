module 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::offer_collection {
    struct OfferCollectionData has store, key {
        id: 0x2::object::UID,
        current_id: u64,
    }

    struct OfferCollectionItem has store, key {
        id: 0x2::object::UID,
        offer_collection_id: u64,
        offerer: address,
        amount_per_item: u64,
        quantity_offer_items: u64,
        coins_locked: 0x2::coin::Coin<0x2::sui::SUI>,
        collection_type: 0x1::string::String,
    }

    struct OfferCollectionEvent has copy, drop {
        offer_collection_id: u64,
        offerer: address,
        amount_per_item: u64,
        quantity_offer_items: u64,
        collection_type: 0x1::string::String,
    }

    struct CancelOfferCollectionEvent has copy, drop {
        offer_collection_id: u64,
        offerer: address,
        amount_per_item: u64,
        quantity_offer_items: u64,
        collection_type: 0x1::string::String,
        amount_recived: u64,
    }

    struct AcceptOfferCollectionEvent has copy, drop {
        offer_collection_id: u64,
        item_id: 0x2::object::ID,
        offerer: address,
        accepter: address,
        collection_type: 0x1::string::String,
        amount_per_item: u64,
        amount_recived: u64,
        quantity_offer_items: u64,
    }

    public entry fun offer_collection<T0>(arg0: &mut OfferCollectionData, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 * arg2 == 0x2::coin::value<0x2::sui::SUI>(&arg3), 4);
        let v1 = 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::utils::get_token_name<T0>();
        let v2 = OfferCollectionItem{
            id                   : 0x2::object::new(arg4),
            offer_collection_id  : arg0.current_id + 1,
            offerer              : v0,
            amount_per_item      : arg1,
            quantity_offer_items : arg2,
            coins_locked         : arg3,
            collection_type      : v1,
        };
        0x2::dynamic_object_field::add<u64, OfferCollectionItem>(&mut arg0.id, arg0.current_id + 1, v2);
        arg0.current_id = arg0.current_id + 1;
        let v3 = OfferCollectionEvent{
            offer_collection_id  : arg0.current_id,
            offerer              : v0,
            amount_per_item      : arg1,
            quantity_offer_items : arg2,
            collection_type      : v1,
        };
        0x2::event::emit<OfferCollectionEvent>(v3);
    }

    public entry fun accept_offer_collection<T0: store + key>(arg0: &mut 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::MarketplaceConfig, arg1: &mut 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::creator_bluemove_fee::RoyaltyCollection, arg2: &mut 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::CreatorConfig, arg3: &mut OfferCollectionData, arg4: u64, arg5: T0, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::utils::get_token_name<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, OfferCollectionItem>(&mut arg3.id, arg4);
        assert!(v2.quantity_offer_items > 0, 2);
        assert!(v2.collection_type == v1, 3);
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut v2.coins_locked, v2.amount_per_item, arg6);
        let v4 = v2.amount_per_item;
        let v5 = if (0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::creator_bluemove_fee::check_exists_royalty_collection<T0>(arg1, arg6)) {
            let (v6, v7, v8, v9) = 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::creator_bluemove_fee::caculate_royalty_collection<T0>(arg1, v4, &mut v3, arg6);
            assert!(v1 == v9, 1);
            0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::add_creator_fee(arg2, v7, v6, arg6);
            v8
        } else {
            0
        };
        let v10 = v4 * 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::get_market_fee(arg0, arg6) / 10000;
        0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::add_market_fee(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v3, v10, arg6), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v0);
        v2.quantity_offer_items = v2.quantity_offer_items - 1;
        let v11 = AcceptOfferCollectionEvent{
            offer_collection_id  : arg4,
            item_id              : 0x2::object::id<T0>(&arg5),
            offerer              : v2.offerer,
            accepter             : v0,
            collection_type      : v1,
            amount_per_item      : v2.amount_per_item,
            amount_recived       : v4 - v10 - v5,
            quantity_offer_items : v2.quantity_offer_items,
        };
        0x2::event::emit<AcceptOfferCollectionEvent>(v11);
        if (v2.quantity_offer_items == 0) {
            let OfferCollectionItem {
                id                   : v12,
                offer_collection_id  : _,
                offerer              : _,
                amount_per_item      : _,
                quantity_offer_items : _,
                coins_locked         : v17,
                collection_type      : _,
            } = 0x2::dynamic_object_field::remove<u64, OfferCollectionItem>(&mut arg3.id, arg4);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v17);
            0x2::object::delete(v12);
        };
        0x2::transfer::public_transfer<T0>(arg5, v2.offerer);
    }

    public entry fun accept_offer_collection_standard<T0: store + key>(arg0: &mut 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::MarketplaceConfig, arg1: &mut 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::CreatorConfig, arg2: &mut OfferCollectionData, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg4: u64, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg6: T0, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::utils::get_token_name<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, OfferCollectionItem>(&mut arg2.id, arg4);
        assert!(v2.quantity_offer_items > 0, 2);
        assert!(v2.collection_type == v1, 3);
        let v3 = 0x2::vec_set::into_keys<address>(*0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::get_Creators(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(arg5)));
        let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut v2.coins_locked, v2.amount_per_item, arg7);
        let v5 = v2.amount_per_item;
        let v6 = v5 * 0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::get_market_fee(arg0, arg7) / 10000;
        let v7 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::calculate<T0>(arg3, v5);
        let v8 = if (0x1::vector::length<address>(&v3) > 0) {
            v5 - v6 - v7
        } else {
            v5 - v6
        };
        0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::add_market_fee(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg7), arg7);
        if (0x1::vector::length<address>(&v3) > 0 && 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::has_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(arg5) && v7 > 0) {
            let v9 = 0x1::vector::length<address>(&v3);
            let v10 = 0;
            let v11 = 0x2::coin::split<0x2::sui::SUI>(&mut v4, v7, arg7);
            while (v10 < v9) {
                0xcfb2c292c36d7c767d5dc6f494e41e8397d3793930421db34887f0ffef6da13e::marketplace::add_creator_fee(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v11, v7 / v9, arg7), 0x1::vector::pop_back<address>(&mut v3), arg7);
                v10 = v10 + 1;
            };
            0x2::coin::join<0x2::sui::SUI>(&mut v4, v11);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0);
        v2.quantity_offer_items = v2.quantity_offer_items - 1;
        let v12 = AcceptOfferCollectionEvent{
            offer_collection_id  : arg4,
            item_id              : 0x2::object::id<T0>(&arg6),
            offerer              : v2.offerer,
            accepter             : v0,
            collection_type      : v1,
            amount_per_item      : v2.amount_per_item,
            amount_recived       : v8,
            quantity_offer_items : v2.quantity_offer_items,
        };
        0x2::event::emit<AcceptOfferCollectionEvent>(v12);
        if (v2.quantity_offer_items == 0) {
            let OfferCollectionItem {
                id                   : v13,
                offer_collection_id  : _,
                offerer              : _,
                amount_per_item      : _,
                quantity_offer_items : _,
                coins_locked         : v18,
                collection_type      : _,
            } = 0x2::dynamic_object_field::remove<u64, OfferCollectionItem>(&mut arg2.id, arg4);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v18);
            0x2::object::delete(v13);
        };
        0x2::transfer::public_transfer<T0>(arg6, v2.offerer);
    }

    public entry fun cancel_offer_collection<T0>(arg0: &mut OfferCollectionData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let OfferCollectionItem {
            id                   : v1,
            offer_collection_id  : v2,
            offerer              : v3,
            amount_per_item      : v4,
            quantity_offer_items : _,
            coins_locked         : v6,
            collection_type      : v7,
        } = 0x2::dynamic_object_field::remove<u64, OfferCollectionItem>(&mut arg0.id, arg1);
        let v8 = v6;
        assert!(v0 == v3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v0);
        0x2::object::delete(v1);
        let v9 = CancelOfferCollectionEvent{
            offer_collection_id  : v2,
            offerer              : v3,
            amount_per_item      : v4,
            quantity_offer_items : 0,
            collection_type      : v7,
            amount_recived       : 0x2::coin::value<0x2::sui::SUI>(&v8),
        };
        0x2::event::emit<CancelOfferCollectionEvent>(v9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OfferCollectionData{
            id         : 0x2::object::new(arg0),
            current_id : 0,
        };
        0x2::transfer::public_share_object<OfferCollectionData>(v0);
    }

    // decompiled from Move bytecode v6
}

