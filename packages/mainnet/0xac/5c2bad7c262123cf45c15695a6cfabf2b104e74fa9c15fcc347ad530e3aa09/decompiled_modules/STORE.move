module 0xac5c2bad7c262123cf45c15695a6cfabf2b104e74fa9c15fcc347ad530e3aa09::STORE {
    struct NFTListed has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct NFTDelisted has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct NFTPurchased has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
        kiosk_id: 0x2::object::ID,
        royalty_paid: u64,
    }

    struct SwapOffer has store, key {
        id: 0x2::object::UID,
        offerer: address,
        receiver: address,
        offerer_kiosk_id: 0x2::object::ID,
        offerer_nft_id: 0x2::object::ID,
        receiver_kiosk_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
        status: u8,
    }

    struct SwapOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        offerer_kiosk_id: 0x2::object::ID,
        offerer_nft_id: 0x2::object::ID,
        receiver_kiosk_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
        offerer: address,
        receiver: address,
    }

    struct SwapOfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        receiver: address,
        offerer_nft_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
    }

    struct SwapOfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        receiver: address,
        offerer_nft_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
    }

    struct Store has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct Listing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
    }

    public entry fun accept_offer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg1), 10);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer>(&mut arg0.id, arg3);
        assert!(v0.receiver == 0x2::tx_context::sender(arg6), 8);
        assert!(v0.status == 0, 6);
        assert!(v0.receiver_kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 7);
        let v1 = v0.offerer;
        let v2 = v0.receiver_nft_id;
        assert!(0x2::kiosk::has_item(arg1, v2), 2);
        let (v3, v4) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v5 = v3;
        0x2::kiosk::list<T0>(arg1, &v5, v2, 0);
        let (v6, v7) = 0x2::kiosk::purchase<T0>(arg1, v2, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v8 = v7;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg4)) {
            let v9 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg4, 0);
            if (v9 > 0) {
                assert!(0x2::coin::value<0x2::sui::SUI>(arg5) >= v9, 4);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v8, 0x2::coin::split<0x2::sui::SUI>(arg5, v9, arg6));
            };
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg4)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v8, arg1);
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v8);
        0x2::kiosk::place<T0>(arg1, &v5, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::uid_to_inner(&v0.id)));
        v0.status = 1;
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer>(&mut arg0.id, arg3, v0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v5, v4);
        let v13 = SwapOfferAccepted{
            offer_id        : arg3,
            offerer         : v1,
            receiver        : 0x2::tx_context::sender(arg6),
            offerer_nft_id  : v0.offerer_nft_id,
            receiver_nft_id : v2,
        };
        0x2::event::emit<SwapOfferAccepted>(v13);
        0x2::transfer::public_transfer<T0>(v6, v1);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, &v5, v2), v1);
    }

    public entry fun buy_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 10);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg2) == 0x2::tx_context::sender(arg8), 1);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg4), 9);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing<T0>>(&arg0.id, arg4);
        let v1 = v0.price;
        let v2 = v0.seller;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v0.kiosk_id, 3);
        assert!(0x2::kiosk::has_item(arg1, arg4), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg4), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) >= v1, 4);
        let Listing {
            id       : v3,
            seller   : _,
            kiosk_id : _,
            nft_id   : _,
            cap      : v7,
            price    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg4);
        let (v9, v10) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg3);
        let v11 = v9;
        let (v12, v13) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v7, 0x2::coin::split<0x2::sui::SUI>(arg5, v1, arg8));
        let v14 = v13;
        0x2::kiosk::lock<T0>(arg2, &v11, arg6, v12);
        0x2::object::delete(v3);
        let v15 = 0;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg6)) {
            let v16 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, v1);
            assert!(0x2::coin::value<0x2::sui::SUI>(arg7) >= v16, 4);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v14, 0x2::coin::split<0x2::sui::SUI>(arg7, v16, arg8));
            v15 = v16;
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v14, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v14);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg3, v11, v10);
        if (0x2::coin::value<0x2::sui::SUI>(arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, 0x2::coin::value<0x2::sui::SUI>(arg5), arg8), 0x2::tx_context::sender(arg8));
        };
        if (0x2::coin::value<0x2::sui::SUI>(arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg7, 0x2::coin::value<0x2::sui::SUI>(arg7), arg8), 0x2::tx_context::sender(arg8));
        };
        let v20 = NFTPurchased{
            id           : arg4,
            price        : v1,
            seller       : v2,
            buyer        : 0x2::tx_context::sender(arg8),
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            royalty_paid : v15,
        };
        0x2::event::emit<NFTPurchased>(v20);
    }

    public entry fun cancel_offer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg1), 10);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer>(&mut arg0.id, arg3);
        assert!(v0.offerer == 0x2::tx_context::sender(arg4), 8);
        assert!(v0.status == 0, 6);
        assert!(v0.offerer_kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 7);
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v3 = v1;
        0x2::kiosk::place<T0>(arg1, &v3, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::uid_to_inner(&v0.id)));
        v0.status = 2;
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer>(&mut arg0.id, arg3, v0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v3, v2);
        let v4 = SwapOfferCancelled{
            offer_id        : arg3,
            offerer         : 0x2::tx_context::sender(arg4),
            receiver        : v0.receiver,
            offerer_nft_id  : v0.offerer_nft_id,
            receiver_nft_id : v0.receiver_nft_id,
        };
        0x2::event::emit<SwapOfferCancelled>(v4);
    }

    public entry fun create_offer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg1), 10);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(0x2::kiosk::has_item(arg4, arg5), 2);
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        if (0x2::kiosk::is_listed(arg1, arg3)) {
            0x2::kiosk::delist<T0>(arg1, &v2, arg3);
        };
        0x2::kiosk::list<T0>(arg1, &v2, arg3, 0);
        let (v3, v4) = 0x2::kiosk::purchase<T0>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v5 = v4;
        let v6 = v3;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg6)) {
            let v7 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, 0);
            if (v7 > 0) {
                assert!(0x2::coin::value<0x2::sui::SUI>(arg7) >= v7, 4);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v5, 0x2::coin::split<0x2::sui::SUI>(arg7, v7, arg8));
            };
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg6)) {
            let (v8, v9) = 0x2::kiosk::new(arg8);
            let v10 = v9;
            let v11 = v8;
            0x2::kiosk::place<T0>(&mut v11, &v10, v3);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v11);
            v6 = 0x2::kiosk::take<T0>(&mut v11, &v10, arg3);
            0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v11, 0x2::tx_context::sender(arg8));
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v10, 0x2::tx_context::sender(arg8));
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v5);
        let v15 = 0x2::object::new(arg8);
        let v16 = SwapOffer{
            id                : v15,
            offerer           : 0x2::tx_context::sender(arg8),
            receiver          : 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg4),
            offerer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offerer_nft_id    : arg3,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            receiver_nft_id   : arg5,
            status            : 0,
        };
        let v17 = 0x2::object::id<SwapOffer>(&v16);
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer>(&mut arg0.id, v17, v16);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::uid_to_inner(&v15), v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v2, v1);
        let v18 = SwapOfferCreated{
            offer_id          : v17,
            offerer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offerer_nft_id    : arg3,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            receiver_nft_id   : arg5,
            offerer           : 0x2::tx_context::sender(arg8),
            receiver          : 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg4),
        };
        0x2::event::emit<SwapOfferCreated>(v18);
    }

    public entry fun create_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public entry fun delist_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg1, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg2), 5);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg2), 9);
        let Listing {
            id       : v0,
            seller   : v1,
            kiosk_id : _,
            nft_id   : _,
            cap      : v4,
            price    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg2);
        assert!(v1 == 0x2::tx_context::sender(arg3), 8);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v4);
        0x2::object::delete(v0);
        let v6 = NFTDelisted{
            id       : arg2,
            owner    : 0x2::tx_context::sender(arg3),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTDelisted>(v6);
    }

    public entry fun list_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg1), 10);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        assert!(arg4 > 0, 7);
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        let v3 = Listing<T0>{
            id       : 0x2::object::new(arg5),
            seller   : 0x2::tx_context::sender(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id   : arg3,
            cap      : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, &v2, arg3, arg4, arg5),
            price    : arg4,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3, v3);
        let v4 = NFTListed{
            id       : arg3,
            price    : arg4,
            owner    : 0x2::tx_context::sender(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTListed>(v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v2, v1);
    }

    // decompiled from Move bytecode v6
}

