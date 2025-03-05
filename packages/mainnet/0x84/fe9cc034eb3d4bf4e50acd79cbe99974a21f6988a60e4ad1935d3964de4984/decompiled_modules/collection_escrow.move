module 0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::collection_escrow {
    struct Ext has drop {
        dummy_field: bool,
    }

    struct CollectionOffer<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        kiosk: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        market_fee: u64,
        royalty_fee: u64,
        policyId: 0x2::object::ID,
        owner: address,
        offer_cap: 0x2::object::ID,
    }

    struct OfferWrapper<phantom T0: store + key> {
        offer: CollectionOffer<T0>,
        item_id: 0x2::object::ID,
        seller: address,
    }

    struct OfferKey<phantom T0: store + key> has copy, drop, store {
        offer: 0x2::object::ID,
    }

    struct OfferCap<phantom T0> has key {
        id: 0x2::object::UID,
        offer: 0x2::object::ID,
    }

    struct Receipt<phantom T0> has key {
        id: 0x2::object::UID,
        offer_cap: 0x2::object::ID,
    }

    struct ReceiptCreatedEvent<phantom T0> has copy, drop {
        receipt_id: 0x2::object::ID,
        offer_cap: 0x2::object::ID,
    }

    struct ReceiptDestroyedEvent<phantom T0> has copy, drop {
        receipt_id: 0x2::object::ID,
        offer_cap: 0x2::object::ID,
    }

    struct NewOfferEvent<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        policyId: 0x2::object::ID,
        owner: address,
        price: u64,
        royalty_fee: u64,
        market_fee: u64,
        offer_cap: 0x2::object::ID,
        offer_id: 0x2::object::ID,
    }

    struct OfferAcceptedEvent<phantom T0> has copy, drop {
        offer: 0x2::object::ID,
        item: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
        offer_cap: 0x2::object::ID,
    }

    struct OfferRevokedEvent<phantom T0> has copy, drop {
        offer: 0x2::object::ID,
        owner: address,
    }

    public fun accept_offer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::MarketPlace, arg7: &mut 0x2::tx_context::TxContext) : (OfferWrapper<T0>, 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::kiosk::has_item_with_type<T0>(arg2, arg4), 412);
        let v0 = Ext{dummy_field: false};
        let v1 = OfferKey<T0>{offer: arg1};
        let v2 = 0x2::bag::remove<OfferKey<T0>, CollectionOffer<T0>>(0x2::kiosk_extension::storage_mut<Ext>(v0, arg0), v1);
        assert!(v2.policyId == 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg5), 413);
        let v3 = v2.market_fee;
        0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::add_balance(arg6, 0x2::coin::take<0x2::sui::SUI>(&mut v2.balance, v3, arg7));
        let v4 = 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, 0x2::balance::value<0x2::sui::SUI>(&v2.balance) - v3 - v2.royalty_fee, arg7);
        let v5 = 0x2::kiosk::purchase_cap_min_price<T0>(&v4);
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v4, 0x2::coin::take<0x2::sui::SUI>(&mut v2.balance, v5, arg7));
        let v8 = v7;
        if (v2.royalty_fee > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v8, 0x2::coin::take<0x2::sui::SUI>(&mut v2.balance, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg5, v5), arg7));
        };
        assert!(0x2::kiosk_extension::can_place<Ext>(arg0), 410);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg5)) {
            let v9 = Ext{dummy_field: false};
            0x2::kiosk_extension::lock<Ext, T0>(v9, arg0, v6, arg5);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v8, arg0);
        } else {
            let v10 = Ext{dummy_field: false};
            0x2::kiosk_extension::place<Ext, T0>(v10, arg0, v6, arg5);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg5)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg5, &mut v8);
        };
        let v11 = OfferWrapper<T0>{
            offer   : v2,
            item_id : arg4,
            seller  : 0x2::tx_context::sender(arg7),
        };
        (v11, v8)
    }

    public fun confirm_offer_accepted<T0: store + key>(arg0: OfferWrapper<T0>, arg1: 0x2::transfer_policy::TransferRequest<T0>, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, arg1);
        let OfferWrapper {
            offer   : v3,
            item_id : v4,
            seller  : v5,
        } = arg0;
        let v6 = v3;
        let CollectionOffer {
            id          : v7,
            kiosk       : _,
            balance     : v9,
            market_fee  : _,
            royalty_fee : _,
            policyId    : _,
            owner       : v13,
            offer_cap   : v14,
        } = v6;
        let v15 = v9;
        let v16 = Receipt<T0>{
            id        : 0x2::object::new(arg3),
            offer_cap : v14,
        };
        let v17 = ReceiptCreatedEvent<T0>{
            receipt_id : 0x2::object::id<Receipt<T0>>(&v16),
            offer_cap  : v14,
        };
        0x2::event::emit<ReceiptCreatedEvent<T0>>(v17);
        0x2::transfer::transfer<Receipt<T0>>(v16, v13);
        let v18 = OfferAcceptedEvent<T0>{
            offer     : 0x2::object::id<CollectionOffer<T0>>(&v6),
            item      : v4,
            buyer     : v13,
            seller    : v5,
            price     : 0x2::balance::value<0x2::sui::SUI>(&v15),
            offer_cap : v14,
        };
        0x2::event::emit<OfferAcceptedEvent<T0>>(v18);
        let v19 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v19), v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v19, 0x2::tx_context::sender(arg3));
        0x2::object::delete(v7);
    }

    public fun destroy_offer_cap<T0: store + key>(arg0: OfferCap<T0>, arg1: Receipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let OfferCap {
            id    : v0,
            offer : _,
        } = arg0;
        let v2 = v0;
        let Receipt {
            id        : v3,
            offer_cap : v4,
        } = arg1;
        let v5 = v4;
        assert!(0x2::object::uid_as_inner(&v2) == &v5, 414);
        0x2::object::delete(v2);
        0x2::object::delete(v3);
    }

    public(friend) fun emit_collection_offer_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: address) {
        let v0 = NewOfferEvent<T0>{
            kiosk       : arg0,
            policyId    : arg1,
            owner       : arg5,
            price       : arg3,
            royalty_fee : 0,
            market_fee  : arg4,
            offer_cap   : arg2,
            offer_id    : arg1,
        };
        0x2::event::emit<NewOfferEvent<T0>>(v0);
    }

    public(friend) fun emit_offer_accepted_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: 0x2::object::ID) {
        let v0 = OfferAcceptedEvent<T0>{
            offer     : arg0,
            item      : arg1,
            buyer     : arg2,
            seller    : arg3,
            price     : arg4,
            offer_cap : arg5,
        };
        0x2::event::emit<OfferAcceptedEvent<T0>>(v0);
    }

    public(friend) fun emit_offer_revoked_event<T0>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = OfferRevokedEvent<T0>{
            offer : arg0,
            owner : arg1,
        };
        0x2::event::emit<OfferRevokedEvent<T0>>(v0);
    }

    public(friend) fun emit_receipt_created_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = ReceiptCreatedEvent<T0>{
            receipt_id : arg0,
            offer_cap  : arg1,
        };
        0x2::event::emit<ReceiptCreatedEvent<T0>>(v0);
    }

    public(friend) fun emit_receipt_destroyed_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = ReceiptDestroyedEvent<T0>{
            receipt_id : arg0,
            offer_cap  : arg1,
        };
        0x2::event::emit<ReceiptDestroyedEvent<T0>>(v0);
    }

    public fun offer<T0: store + key>(arg0: &0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::MarketPlace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v2 = (((0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::get_fee(arg0, 0x2::tx_context::sender(arg5)) as u128) * (v1 as u128) / 10000) as u64);
        let v3 = if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg4)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg4, v1 - v2 - 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg4, v1 - v2 - 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg4, v1 - v2)))
        } else {
            0
        };
        assert!(v1 > v2 + v3, 411);
        let v4 = CollectionOffer<T0>{
            id          : 0x2::object::new(arg5),
            kiosk       : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            balance     : v0,
            market_fee  : v2,
            royalty_fee : v3,
            policyId    : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg4),
            owner       : 0x2::tx_context::sender(arg5),
            offer_cap   : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg4),
        };
        let v5 = OfferCap<T0>{
            id    : 0x2::object::new(arg5),
            offer : 0x2::object::uid_to_inner(&v4.id),
        };
        v4.offer_cap = 0x2::object::id<OfferCap<T0>>(&v5);
        if (0x2::kiosk_extension::is_installed<Ext>(arg1) == false) {
            let v6 = Ext{dummy_field: false};
            0x2::kiosk_extension::add<Ext>(v6, arg1, arg2, 3, arg5);
        } else if (0x2::kiosk_extension::is_enabled<Ext>(arg1) == false) {
            0x2::kiosk_extension::enable<Ext>(arg1, arg2);
        };
        let v7 = NewOfferEvent<T0>{
            kiosk       : v4.kiosk,
            policyId    : v4.policyId,
            owner       : v4.owner,
            price       : v1,
            royalty_fee : v3,
            market_fee  : v2,
            offer_cap   : 0x2::object::uid_to_inner(&v5.id),
            offer_id    : 0x2::object::uid_to_inner(&v4.id),
        };
        0x2::event::emit<NewOfferEvent<T0>>(v7);
        let v8 = Ext{dummy_field: false};
        let v9 = OfferKey<T0>{offer: 0x2::object::uid_to_inner(&v4.id)};
        0x2::bag::add<OfferKey<T0>, CollectionOffer<T0>>(0x2::kiosk_extension::storage_mut<Ext>(v8, arg1), v9, v4);
        0x2::transfer::transfer<OfferCap<T0>>(v5, 0x2::tx_context::sender(arg5));
    }

    public fun revoke_offer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: OfferCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.offer == arg2, 414);
        assert!(0x2::kiosk::has_access(arg0, arg1), 415);
        let v0 = Ext{dummy_field: false};
        let v1 = OfferKey<T0>{offer: arg2};
        let v2 = 0x2::bag::remove<OfferKey<T0>, CollectionOffer<T0>>(0x2::kiosk_extension::storage_mut<Ext>(v0, arg0), v1);
        let CollectionOffer {
            id          : v3,
            kiosk       : _,
            balance     : v5,
            market_fee  : _,
            royalty_fee : _,
            policyId    : _,
            owner       : _,
            offer_cap   : _,
        } = v2;
        0x2::object::delete(v3);
        let OfferCap {
            id    : v11,
            offer : _,
        } = arg3;
        0x2::object::delete(v11);
        let v13 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v13), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg4));
        let v14 = OfferRevokedEvent<T0>{
            offer : 0x2::object::id<CollectionOffer<T0>>(&v2),
            owner : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<OfferRevokedEvent<T0>>(v14);
    }

    // decompiled from Move bytecode v6
}

