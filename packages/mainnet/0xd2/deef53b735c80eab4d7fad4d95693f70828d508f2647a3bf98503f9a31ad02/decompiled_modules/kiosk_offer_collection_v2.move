module 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_offer_collection_v2 {
    struct CollectionOfferDataV2 has store, key {
        id: 0x2::object::UID,
        current_id: u64,
    }

    struct AcceptedItemV2<phantom T0: store + key> has store {
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct CollectionOfferItemV2<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        collection_offer_id: u64,
        collection_type: 0x1::string::String,
        quantity: u64,
        price_per_item: u64,
        paids: 0x2::coin::Coin<0x2::sui::SUI>,
        accepted_items: 0x2::vec_map::VecMap<0x2::object::ID, AcceptedItemV2<T0>>,
        nft_ids: vector<0x2::object::ID>,
    }

    struct BidderBagV2 has store, key {
        id: 0x2::object::UID,
    }

    struct OfferCollectionEventV2 has copy, drop, store {
        collection_offer_id: u64,
        collection_type: 0x1::string::String,
        offerer: address,
        quantity: u64,
        price_per_item: u64,
        amount_paid: u64,
    }

    struct CancelOfferCollectionEventV2 has copy, drop, store {
        collection_offer_id: u64,
        collection_type: 0x1::string::String,
        offerer: address,
        quantity: u64,
        price_per_item: u64,
        amount_recived: u64,
    }

    struct AcceptOfferCollectionEventV2 has copy, drop, store {
        collection_offer_id: u64,
        nft_id: 0x2::object::ID,
        collection_type: 0x1::string::String,
        accepter: address,
        accepter_kiosk: 0x2::object::ID,
        remain_quantity: u64,
        price_per_item: u64,
    }

    struct ClaimNFTEventV2 has copy, drop, store {
        nft_id: 0x2::object::ID,
        collection_type: 0x1::string::String,
    }

    public entry fun accept_offer_collection_v2<T0: store + key>(arg0: &mut 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::Market, arg1: &mut CollectionOfferDataV2, arg2: &mut BidderBagV2, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, CollectionOfferItemV2<T0>>(&mut arg1.id, arg3);
        assert!(v1 == v2.collection_type, 2);
        assert!(v2.quantity > 0, 6);
        if (0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::is_listing<T0>(arg0, arg6)) {
            0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::kiosk_delist<T0>(arg0, arg4, arg6, arg7);
        };
        let (v3, v4) = 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::get_market_fee(arg0, v2.price_per_item);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut v2.paids, v2.price_per_item, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v3, arg7), v4);
        let v6 = AcceptedItemV2<T0>{
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            nft_id       : arg6,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg4, arg5, arg6, 0, arg7),
        };
        v2.quantity = v2.quantity - 1;
        0x2::vec_map::insert<0x2::object::ID, AcceptedItemV2<T0>>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<0x2::object::ID, AcceptedItemV2<T0>>>(&mut arg2.id, 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::generate_bag_name<T0>(v0)), arg6, v6);
        0x1::vector::push_back<0x2::object::ID>(&mut v2.nft_ids, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v0);
        let v7 = AcceptOfferCollectionEventV2{
            collection_offer_id : arg3,
            nft_id              : arg6,
            collection_type     : v1,
            accepter            : v0,
            accepter_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            remain_quantity     : v2.quantity,
            price_per_item      : v2.price_per_item,
        };
        0x2::event::emit<AcceptOfferCollectionEventV2>(v7);
    }

    public entry fun cancel_offer_collection_v2<T0: store + key>(arg0: &mut CollectionOfferDataV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let CollectionOfferItemV2 {
            id                  : v1,
            offerer             : v2,
            collection_offer_id : _,
            collection_type     : v4,
            quantity            : v5,
            price_per_item      : v6,
            paids               : v7,
            accepted_items      : v8,
            nft_ids             : _,
        } = 0x2::dynamic_object_field::remove<u64, CollectionOfferItemV2<T0>>(&mut arg0.id, arg1);
        let v10 = v7;
        assert!(v0 == v2, 3);
        assert!(v5 > 0, 4);
        0x2::pay::keep<0x2::sui::SUI>(v10, arg2);
        0x2::vec_map::destroy_empty<0x2::object::ID, AcceptedItemV2<T0>>(v8);
        0x2::object::delete(v1);
        let v11 = CancelOfferCollectionEventV2{
            collection_offer_id : arg1,
            collection_type     : v4,
            offerer             : v0,
            quantity            : 0,
            price_per_item      : v6,
            amount_recived      : 0x2::coin::value<0x2::sui::SUI>(&v10),
        };
        0x2::event::emit<CancelOfferCollectionEventV2>(v11);
    }

    public entry fun claim_nft_v2<T0: store + key>(arg0: &mut BidderBagV2, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, AcceptedItemV2<T0>>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<0x2::object::ID, AcceptedItemV2<T0>>>(&mut arg0.id, 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::generate_bag_name<T0>(0x2::tx_context::sender(arg7))), &arg5);
        let AcceptedItemV2 {
            kiosk_id     : _,
            nft_id       : _,
            purchase_cap : v4,
        } = v1;
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg1, 0) == 0x2::coin::value<0x2::sui::SUI>(&arg6), 1);
        let (v5, v6) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v4, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v7 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg1, &mut v7, arg6);
        0x2::kiosk::lock<T0>(arg3, arg4, arg1, v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v7, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v7);
        let v11 = ClaimNFTEventV2{
            nft_id          : arg5,
            collection_type : 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>(),
        };
        0x2::event::emit<ClaimNFTEventV2>(v11);
    }

    public entry fun create_init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        let v0 = CollectionOfferDataV2{
            id         : 0x2::object::new(arg0),
            current_id : 0,
        };
        0x2::transfer::public_share_object<CollectionOfferDataV2>(v0);
        let v1 = BidderBagV2{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<BidderBagV2>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionOfferDataV2{
            id         : 0x2::object::new(arg0),
            current_id : 0,
        };
        0x2::transfer::public_share_object<CollectionOfferDataV2>(v0);
        let v1 = BidderBagV2{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<BidderBagV2>(v1);
    }

    public entry fun offer_collection_v2<T0: store + key>(arg0: &mut CollectionOfferDataV2, arg1: &mut BidderBagV2, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>();
        let v2 = arg3 * arg2;
        assert!(v2 == 0x2::coin::value<0x2::sui::SUI>(&arg4), 1);
        let v3 = arg0.current_id + 1;
        let v4 = 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::generate_bag_name<T0>(v0);
        if (!0x2::dynamic_field::exists_with_type<0x1::string::String, 0x2::vec_map::VecMap<0x2::object::ID, AcceptedItemV2<T0>>>(&arg1.id, v4)) {
            0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<0x2::object::ID, AcceptedItemV2<T0>>>(&mut arg0.id, v4, 0x2::vec_map::empty<0x2::object::ID, AcceptedItemV2<T0>>());
        };
        let v5 = CollectionOfferItemV2<T0>{
            id                  : 0x2::object::new(arg5),
            offerer             : v0,
            collection_offer_id : v3,
            collection_type     : v1,
            quantity            : arg3,
            price_per_item      : arg2,
            paids               : arg4,
            accepted_items      : 0x2::vec_map::empty<0x2::object::ID, AcceptedItemV2<T0>>(),
            nft_ids             : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::dynamic_object_field::add<u64, CollectionOfferItemV2<T0>>(&mut arg0.id, v3, v5);
        arg0.current_id = v3;
        let v6 = OfferCollectionEventV2{
            collection_offer_id : v3,
            collection_type     : v1,
            offerer             : v0,
            quantity            : arg3,
            price_per_item      : arg2,
            amount_paid         : v2,
        };
        0x2::event::emit<OfferCollectionEventV2>(v6);
    }

    // decompiled from Move bytecode v6
}

