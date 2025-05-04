module 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::solo {
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
    }

    struct NFTTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
        from_kiosk_id: 0x2::object::ID,
    }

    struct Store has key {
        id: 0x2::object::UID,
        admin: address,
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

    struct SwapOfferCancelled has copy, drop {
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
        offerer_kiosk_id: 0x2::object::ID,
        offerer_nft_id: 0x2::object::ID,
        receiver_kiosk_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
        offerer: address,
        receiver: address,
    }

    struct Listing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    public entry fun accept_swap_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::PersonalKioskCap, arg6: &mut 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::PersonalKioskCap, arg7: &0x2::transfer_policy::TransferPolicy<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 11);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SwapOffer>(&mut arg0.id, arg1);
        assert!(v0.receiver == 0x2::tx_context::sender(arg8), 8);
        assert!(v0.status == 0, 13);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v0.offerer_kiosk_id, 3);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg4) == v0.receiver_kiosk_id, 3);
        assert!(0x2::kiosk::has_item(arg2, v0.offerer_nft_id), 2);
        assert!(0x2::kiosk::has_item(arg4, v0.receiver_nft_id), 2);
        assert!(!0x2::kiosk::is_listed(arg2, v0.offerer_nft_id), 6);
        assert!(!0x2::kiosk::is_listed(arg4, v0.receiver_nft_id), 6);
        v0.status = 1;
        let (v1, v2) = 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::borrow_val(arg5);
        let v3 = v1;
        let (v4, v5) = 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::borrow_val(arg6);
        let v6 = v4;
        0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::return_val(arg6, v6, v5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T1>(arg7, 0x2::transfer_policy::new_request<T1>(v0.receiver_nft_id, 0, 0x2::object::id<0x2::kiosk::Kiosk>(arg4)));
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, &v3, v0.offerer_nft_id, 0, arg8), 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v11);
        0x2::kiosk::place<T0>(arg4, &v3, v10);
        0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::return_val(arg5, v3, v2);
        0x2::transfer::public_transfer<T1>(0x2::kiosk::take<T1>(arg4, &v6, v0.receiver_nft_id), v0.offerer);
        let v15 = SwapOfferAccepted{
            offer_id          : arg1,
            offerer_kiosk_id  : v0.offerer_kiosk_id,
            offerer_nft_id    : v0.offerer_nft_id,
            receiver_kiosk_id : v0.receiver_kiosk_id,
            receiver_nft_id   : v0.receiver_nft_id,
            offerer           : v0.offerer,
            receiver          : v0.receiver,
        };
        0x2::event::emit<SwapOfferAccepted>(v15);
    }

    public entry fun buy_and_place_in_kiosk<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::PersonalKioskCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::is_personal(arg1), 10);
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::is_personal(arg5), 10);
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg7), 1);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg2), 9);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing<T0>>(&arg0.id, arg2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v0.kiosk_id, 3);
        assert!(0x2::kiosk::has_item(arg1, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg2), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v0.price, 4);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg3, v0.price, arg7);
        let Listing {
            id          : v2,
            seller      : v3,
            kiosk_id    : _,
            nft_id      : _,
            cap         : v6,
            price       : v7,
            commission  : _,
            beneficiary : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg2);
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v6, v1);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v11);
        let (v15, v16) = 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::borrow_val(arg6);
        let v17 = v15;
        0x2::kiosk::place<T0>(arg5, &v17, v10);
        0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::return_val(arg6, v17, v16);
        0x2::object::delete(v2);
        let v18 = NFTPurchased{
            id       : arg2,
            price    : v7,
            seller   : v3,
            buyer    : 0x2::tx_context::sender(arg7),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTPurchased>(v18);
    }

    public entry fun buy_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::is_personal(arg1), 10);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg2), 9);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing<T0>>(&arg0.id, arg2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v0.kiosk_id, 3);
        assert!(0x2::kiosk::has_item(arg1, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg2), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v0.price, 4);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg3, v0.price, arg5);
        let Listing {
            id          : v2,
            seller      : v3,
            kiosk_id    : _,
            nft_id      : _,
            cap         : v6,
            price       : v7,
            commission  : _,
            beneficiary : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg2);
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v6, v1);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v11);
        0x2::transfer::public_transfer<T0>(v10, 0x2::tx_context::sender(arg5));
        0x2::object::delete(v2);
        let v15 = NFTPurchased{
            id       : arg2,
            price    : v7,
            seller   : v3,
            buyer    : 0x2::tx_context::sender(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTPurchased>(v15);
    }

    public entry fun cancel_swap_offer(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 11);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SwapOffer>(&mut arg0.id, arg1);
        assert!(v0.offerer == 0x2::tx_context::sender(arg2), 8);
        assert!(v0.status == 0, 13);
        v0.status = 2;
        let v1 = SwapOfferCancelled{
            offer_id          : arg1,
            offerer_kiosk_id  : v0.offerer_kiosk_id,
            offerer_nft_id    : v0.offerer_nft_id,
            receiver_kiosk_id : v0.receiver_kiosk_id,
            receiver_nft_id   : v0.receiver_nft_id,
            offerer           : v0.offerer,
            receiver          : v0.receiver,
        };
        0x2::event::emit<SwapOfferCancelled>(v1);
    }

    public entry fun create_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public entry fun create_swap_offer(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::is_personal(arg1), 10);
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::is_personal(arg4), 10);
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg6), 1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(0x2::kiosk::has_item(arg4, arg5), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        let v0 = SwapOffer{
            id                : 0x2::object::new(arg6),
            offerer           : 0x2::tx_context::sender(arg6),
            receiver          : 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::owner(arg4),
            offerer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offerer_nft_id    : arg3,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            receiver_nft_id   : arg5,
            status            : 0,
        };
        let v1 = 0x2::object::id<SwapOffer>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer>(&mut arg0.id, v1, v0);
        let v2 = SwapOfferCreated{
            offer_id          : v1,
            offerer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offerer_nft_id    : arg3,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            receiver_nft_id   : arg5,
            offerer           : 0x2::tx_context::sender(arg6),
            receiver          : 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::owner(arg4),
        };
        0x2::event::emit<SwapOfferCreated>(v2);
    }

    public entry fun delist_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::is_personal(arg1), 10);
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg3), 5);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg3), 9);
        let Listing {
            id          : v0,
            seller      : v1,
            kiosk_id    : _,
            nft_id      : _,
            cap         : v4,
            price       : _,
            commission  : _,
            beneficiary : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3);
        assert!(v1 == 0x2::tx_context::sender(arg4), 8);
        let (v8, v9) = 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::borrow_val(arg2);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v4);
        0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::return_val(arg2, v8, v9);
        0x2::object::delete(v0);
        let v10 = NFTDelisted{
            id       : arg3,
            owner    : 0x2::tx_context::sender(arg4),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTDelisted>(v10);
    }

    public entry fun delist_nft_sui<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg1, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg2), 5);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg2), 9);
        let Listing {
            id          : v0,
            seller      : v1,
            kiosk_id    : _,
            nft_id      : _,
            cap         : v4,
            price       : _,
            commission  : _,
            beneficiary : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg2);
        assert!(v1 == 0x2::tx_context::sender(arg3), 8);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v4);
        0x2::object::delete(v0);
        let v8 = NFTDelisted{
            id       : arg2,
            owner    : 0x2::tx_context::sender(arg3),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTDelisted>(v8);
    }

    public entry fun list_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::is_personal(arg1), 10);
        assert!(0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        assert!(arg4 > 0, 7);
        let (v0, v1) = 0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        0x33c05995bd8e7089cbeb145ed6de245e6140df17088afb884cc198ff5fa52708::personal_kiosk::return_val(arg2, v2, v1);
        let v3 = Listing<T0>{
            id          : 0x2::object::new(arg5),
            seller      : 0x2::tx_context::sender(arg5),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id      : arg3,
            cap         : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, &v2, arg3, arg4, arg5),
            price       : arg4,
            commission  : 0,
            beneficiary : 0x2::tx_context::sender(arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3, v3);
        let v4 = NFTListed{
            id       : arg3,
            price    : arg4,
            owner    : 0x2::tx_context::sender(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTListed>(v4);
    }

    public entry fun list_nft_sui<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        assert!(arg4 > 0, 7);
        let v0 = Listing<T0>{
            id          : 0x2::object::new(arg5),
            seller      : 0x2::tx_context::sender(arg5),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id      : arg3,
            cap         : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4, arg5),
            price       : arg4,
            commission  : 0,
            beneficiary : 0x2::tx_context::sender(arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3, v0);
        let v1 = NFTListed{
            id       : arg3,
            price    : arg4,
            owner    : 0x2::tx_context::sender(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTListed>(v1);
    }

    public fun transfer_with_kiosk_cap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        assert!(!0x2::kiosk::is_listed(arg0, arg2), 6);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        0x2::transfer::public_transfer<T0>(v0, arg3);
        let v2 = NFTTransferred{
            nft_id        : arg2,
            from          : 0x2::tx_context::sender(arg4),
            to            : arg3,
            from_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::event::emit<NFTTransferred>(v2);
        v1
    }

    public fun transfer_with_personal_kiosk_cap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_access(arg2, arg3), 3);
        assert!(0x2::kiosk::has_item(arg0, arg4), 2);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg4, 0, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5));
        0x2::kiosk::place<T0>(arg2, arg3, v0);
        let v2 = NFTTransferred{
            nft_id        : arg4,
            from          : 0x2::tx_context::sender(arg5),
            to            : 0x2::kiosk::owner(arg2),
            from_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::event::emit<NFTTransferred>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

