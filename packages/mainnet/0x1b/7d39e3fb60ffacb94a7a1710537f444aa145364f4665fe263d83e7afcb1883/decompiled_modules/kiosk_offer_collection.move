module 0x1b7d39e3fb60ffacb94a7a1710537f444aa145364f4665fe263d83e7afcb1883::kiosk_offer_collection {
    struct CollectionOfferData has store, key {
        id: 0x2::object::UID,
        current_id: u64,
    }

    struct AcceptedItem<phantom T0: store + key> has store {
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct CollectionOfferItem<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        collection_offer_id: u64,
        collection_type: 0x1::string::String,
        quantity: u64,
        price_per_item: u64,
        paids: 0x2::coin::Coin<0x2::sui::SUI>,
        accepted_items: 0x2::vec_map::VecMap<0x2::object::ID, AcceptedItem<T0>>,
        nft_ids: vector<0x2::object::ID>,
    }

    struct OfferCollectionEvent has copy, drop, store {
        collection_offer_id: u64,
        collection_type: 0x1::string::String,
        offerer: address,
        quantity: u64,
        price_per_item: u64,
        amount_paid: u64,
    }

    struct CancelOfferCollectionEvent has copy, drop, store {
        collection_offer_id: u64,
        collection_type: 0x1::string::String,
        offerer: address,
        quantity: u64,
        price_per_item: u64,
        amount_recived: u64,
    }

    struct AcceptOfferCollectionEvent has copy, drop, store {
        collection_offer_id: u64,
        nft_id: 0x2::object::ID,
        collection_type: 0x1::string::String,
        accepter: address,
        accepter_kiosk: 0x2::object::ID,
        remain_quantity: u64,
        price_per_item: u64,
    }

    struct ClaimNFTEvent has copy, drop, store {
        collection_offer_id: u64,
        nft_id: 0x2::object::ID,
        collection_type: 0x1::string::String,
    }

    public entry fun accept_offer_collection<T0: store + key>(arg0: &mut 0x1b7d39e3fb60ffacb94a7a1710537f444aa145364f4665fe263d83e7afcb1883::kiosk_trade::Market, arg1: &mut CollectionOfferData, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1b7d39e3fb60ffacb94a7a1710537f444aa145364f4665fe263d83e7afcb1883::utils::get_token_name<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, CollectionOfferItem<T0>>(&mut arg1.id, arg2);
        assert!(v1 == v2.collection_type, 2);
        if (0x1b7d39e3fb60ffacb94a7a1710537f444aa145364f4665fe263d83e7afcb1883::kiosk_trade::is_listing<T0>(arg0, arg5)) {
            0x1b7d39e3fb60ffacb94a7a1710537f444aa145364f4665fe263d83e7afcb1883::kiosk_trade::kiosk_delist<T0>(arg0, arg3, arg5, arg6);
        };
        let (v3, v4) = 0x1b7d39e3fb60ffacb94a7a1710537f444aa145364f4665fe263d83e7afcb1883::kiosk_trade::get_market_fee(arg0, v2.price_per_item);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut v2.paids, v2.price_per_item, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v3, arg6), v4);
        let v6 = AcceptedItem<T0>{
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            nft_id       : arg5,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg3, arg4, arg5, 0, arg6),
        };
        v2.quantity = v2.quantity - 1;
        0x2::vec_map::insert<0x2::object::ID, AcceptedItem<T0>>(&mut v2.accepted_items, arg5, v6);
        0x1::vector::push_back<0x2::object::ID>(&mut v2.nft_ids, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v0);
        let v7 = AcceptOfferCollectionEvent{
            collection_offer_id : arg2,
            nft_id              : arg5,
            collection_type     : v1,
            accepter            : v0,
            accepter_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            remain_quantity     : v2.quantity,
            price_per_item      : v2.price_per_item,
        };
        0x2::event::emit<AcceptOfferCollectionEvent>(v7);
    }

    public entry fun cancel_offer_collection<T0: store + key>(arg0: &mut CollectionOfferData, arg1: u64, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let CollectionOfferItem {
            id                  : v1,
            offerer             : v2,
            collection_offer_id : _,
            collection_type     : v4,
            quantity            : _,
            price_per_item      : v6,
            paids               : v7,
            accepted_items      : v8,
            nft_ids             : v9,
        } = 0x2::dynamic_object_field::remove<u64, CollectionOfferItem<T0>>(&mut arg0.id, arg1);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        assert!(v0 == v2, 3);
        while (!0x2::vec_map::is_empty<0x2::object::ID, AcceptedItem<T0>>(&v11)) {
            let v13 = 0x2::coin::split<0x2::sui::SUI>(&mut arg6, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, 0), arg7);
            claim_nft<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::pop_back<0x2::object::ID>(&mut v10), v13, arg7);
        };
        0x2::pay::join<0x2::sui::SUI>(&mut v12, arg6);
        0x2::pay::keep<0x2::sui::SUI>(v12, arg7);
        0x2::vec_map::destroy_empty<0x2::object::ID, AcceptedItem<T0>>(v11);
        0x2::object::delete(v1);
        let v14 = CancelOfferCollectionEvent{
            collection_offer_id : arg1,
            collection_type     : v4,
            offerer             : v0,
            quantity            : 0,
            price_per_item      : v6,
            amount_recived      : 0x2::coin::value<0x2::sui::SUI>(&v12),
        };
        0x2::event::emit<CancelOfferCollectionEvent>(v14);
    }

    public entry fun claim_nft<T0: store + key>(arg0: &mut CollectionOfferData, arg1: u64, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1b7d39e3fb60ffacb94a7a1710537f444aa145364f4665fe263d83e7afcb1883::utils::get_token_name<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, CollectionOfferItem<T0>>(&mut arg0.id, arg1);
        assert!(v0 == v1.collection_type, 2);
        assert!(0x2::tx_context::sender(arg8) == v1.offerer, 3);
        let (_, v3) = 0x2::vec_map::remove<0x2::object::ID, AcceptedItem<T0>>(&mut v1.accepted_items, &arg6);
        let (_, v5) = 0x1::vector::index_of<0x2::object::ID>(&v1.nft_ids, &arg6);
        0x1::vector::remove<0x2::object::ID>(&mut v1.nft_ids, v5);
        let AcceptedItem {
            kiosk_id     : _,
            nft_id       : _,
            purchase_cap : v8,
        } = v3;
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, 0) == 0x2::coin::value<0x2::sui::SUI>(&arg7), 1);
        let (v9, v10) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v8, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v11 = v10;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v11, arg7);
        0x2::kiosk::lock<T0>(arg4, arg5, arg2, v9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v11, arg4);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v11);
        if (v1.quantity == 0 && 0x2::vec_map::is_empty<0x2::object::ID, AcceptedItem<T0>>(&v1.accepted_items)) {
            let CollectionOfferItem {
                id                  : v15,
                offerer             : _,
                collection_offer_id : _,
                collection_type     : _,
                quantity            : _,
                price_per_item      : _,
                paids               : v21,
                accepted_items      : v22,
                nft_ids             : _,
            } = 0x2::dynamic_object_field::remove<u64, CollectionOfferItem<T0>>(&mut arg0.id, arg1);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v21);
            0x2::vec_map::destroy_empty<0x2::object::ID, AcceptedItem<T0>>(v22);
            0x2::object::delete(v15);
        };
        let v24 = ClaimNFTEvent{
            collection_offer_id : arg1,
            nft_id              : arg6,
            collection_type     : v0,
        };
        0x2::event::emit<ClaimNFTEvent>(v24);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionOfferData{
            id         : 0x2::object::new(arg0),
            current_id : 0,
        };
        0x2::transfer::public_share_object<CollectionOfferData>(v0);
    }

    public entry fun offer_collection<T0: store + key>(arg0: &mut CollectionOfferData, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1b7d39e3fb60ffacb94a7a1710537f444aa145364f4665fe263d83e7afcb1883::utils::get_token_name<T0>();
        let v2 = arg2 * arg1;
        assert!(v2 == 0x2::coin::value<0x2::sui::SUI>(&arg3), 1);
        let v3 = arg0.current_id + 1;
        let v4 = CollectionOfferItem<T0>{
            id                  : 0x2::object::new(arg4),
            offerer             : v0,
            collection_offer_id : v3,
            collection_type     : v1,
            quantity            : arg2,
            price_per_item      : arg1,
            paids               : arg3,
            accepted_items      : 0x2::vec_map::empty<0x2::object::ID, AcceptedItem<T0>>(),
            nft_ids             : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::dynamic_object_field::add<u64, CollectionOfferItem<T0>>(&mut arg0.id, v3, v4);
        let v5 = OfferCollectionEvent{
            collection_offer_id : v3,
            collection_type     : v1,
            offerer             : v0,
            quantity            : arg2,
            price_per_item      : arg1,
            amount_paid         : v2,
        };
        0x2::event::emit<OfferCollectionEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

