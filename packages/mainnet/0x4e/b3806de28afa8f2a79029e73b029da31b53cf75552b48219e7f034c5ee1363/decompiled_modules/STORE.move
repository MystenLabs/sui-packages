module 0x4eb3806de28afa8f2a79029e73b029da31b53cf75552b48219e7f034c5ee1363::STORE {
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

    struct SwapOfferDemo has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offerer_kiosk_id: 0x2::object::ID,
        offerer_nft_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
        status: u8,
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

    struct PersonalKioskCap has key {
        id: 0x2::object::UID,
        cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
    }

    struct Borrow {
        cap_id: 0x2::object::ID,
        owned_id: 0x2::object::ID,
    }

    public entry fun accept_swap_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x2::transfer_policy::TransferPolicy<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 11);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SwapOffer>(&arg0.id, arg1);
        assert!(v0.receiver == 0x2::tx_context::sender(arg6), 8);
        assert!(v0.status == 0, 13);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v0.receiver_kiosk_id, 3);
        assert!(0x2::kiosk::has_item(arg2, v0.receiver_nft_id), 2);
        let v1 = v0.offerer_kiosk_id;
        let v2 = v0.offerer_nft_id;
        let v3 = v0.receiver_kiosk_id;
        let v4 = v0.receiver_nft_id;
        let v5 = v0.offerer;
        let v6 = v0.receiver;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T1>(arg5, 0x2::transfer_policy::new_request<T1>(v4, 0, v3));
        0x2::kiosk::place<T0>(arg2, arg3, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::uid_to_inner(&v0.id)));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, 0x2::transfer_policy::new_request<T0>(v2, 0, v1));
        0x2::transfer::public_transfer<T1>(0x2::kiosk::take<T1>(arg2, arg3, v4), v5);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SwapOffer>(&mut arg0.id, arg1).status = 1;
        let SwapOffer {
            id                : v13,
            offerer           : _,
            receiver          : _,
            offerer_kiosk_id  : _,
            offerer_nft_id    : _,
            receiver_kiosk_id : _,
            receiver_nft_id   : _,
            status            : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer>(&mut arg0.id, arg1);
        0x2::object::delete(v13);
        let v21 = SwapOfferAccepted{
            offer_id          : arg1,
            offerer_kiosk_id  : v1,
            offerer_nft_id    : v2,
            receiver_kiosk_id : v3,
            receiver_nft_id   : v4,
            offerer           : v5,
            receiver          : v6,
        };
        0x2::event::emit<SwapOfferAccepted>(v21);
    }

    public fun borrow_val(arg0: &mut PersonalKioskCap) : (0x2::kiosk::KioskOwnerCap, Borrow) {
        let v0 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg0.cap);
        let v1 = Borrow{
            cap_id   : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v0),
            owned_id : 0x2::object::id<PersonalKioskCap>(arg0),
        };
        (v0, v1)
    }

    public fun buy_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, u64) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg2), 9);
        let Listing {
            id          : v0,
            seller      : v1,
            kiosk_id    : v2,
            nft_id      : _,
            cap         : v4,
            price       : v5,
            commission  : _,
            beneficiary : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 3);
        assert!(0x2::kiosk::has_item(arg1, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg2), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v5, 4);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v4, 0x2::coin::split<0x2::sui::SUI>(arg3, v5, arg5));
        0x2::object::delete(v0);
        let v10 = NFTPurchased{
            id       : arg2,
            price    : v5,
            seller   : v1,
            buyer    : 0x2::tx_context::sender(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTPurchased>(v10);
        (v8, v9, v5)
    }

    public entry fun cancel_swap_offer<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 11);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SwapOffer>(&arg0.id, arg1);
        assert!(v0.offerer == 0x2::tx_context::sender(arg4), 8);
        assert!(v0.status == 0, 13);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v0.offerer_kiosk_id, 3);
        let v1 = v0.receiver;
        0x2::kiosk::place<T0>(arg2, arg3, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::uid_to_inner(&v0.id)));
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SwapOffer>(&mut arg0.id, arg1).status = 2;
        let SwapOffer {
            id                : v2,
            offerer           : _,
            receiver          : _,
            offerer_kiosk_id  : _,
            offerer_nft_id    : _,
            receiver_kiosk_id : _,
            receiver_nft_id   : _,
            status            : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer>(&mut arg0.id, arg1);
        0x2::object::delete(v2);
        let v10 = SwapOfferCancelled{
            offer_id          : arg1,
            offerer_kiosk_id  : v0.offerer_kiosk_id,
            offerer_nft_id    : v0.offerer_nft_id,
            receiver_kiosk_id : v0.receiver_kiosk_id,
            receiver_nft_id   : v0.receiver_nft_id,
            offerer           : v0.offerer,
            receiver          : v1,
        };
        0x2::event::emit<SwapOfferCancelled>(v10);
    }

    public entry fun create_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public entry fun create_swap_offer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(0x2::kiosk::has_item(arg4, arg5), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        0x2::kiosk::list<T0>(arg1, arg2, arg3, 0);
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v1);
        let v5 = 0x2::object::new(arg7);
        let v6 = SwapOffer{
            id                : v5,
            offerer           : 0x2::tx_context::sender(arg7),
            receiver          : 0x2::kiosk::owner(arg4),
            offerer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offerer_nft_id    : arg3,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            receiver_nft_id   : arg5,
            status            : 0,
        };
        let v7 = 0x2::object::id<SwapOffer>(&v6);
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer>(&mut arg0.id, v7, v6);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::uid_to_inner(&v5), v0);
        let v8 = SwapOfferCreated{
            offer_id          : v7,
            offerer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offerer_nft_id    : arg3,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            receiver_nft_id   : arg5,
            offerer           : 0x2::tx_context::sender(arg7),
            receiver          : 0x2::kiosk::owner(arg4),
        };
        0x2::event::emit<SwapOfferCreated>(v8);
    }

    public entry fun delist_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
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

    public entry fun list_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
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

    public entry fun list_nft_personal<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut PersonalKioskCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        assert!(arg4 > 0, 7);
        let (v0, v1) = borrow_val(arg2);
        let v2 = v0;
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
        return_val(arg2, v2, v1);
    }

    public fun return_val(arg0: &mut PersonalKioskCap, arg1: 0x2::kiosk::KioskOwnerCap, arg2: Borrow) {
        let Borrow {
            cap_id   : v0,
            owned_id : v1,
        } = arg2;
        assert!(0x2::object::id<PersonalKioskCap>(arg0) == v1, 1);
        assert!(0x2::object::id<0x2::kiosk::KioskOwnerCap>(&arg1) == v0, 0);
        0x1::option::fill<0x2::kiosk::KioskOwnerCap>(&mut arg0.cap, arg1);
    }

    // decompiled from Move bytecode v6
}

