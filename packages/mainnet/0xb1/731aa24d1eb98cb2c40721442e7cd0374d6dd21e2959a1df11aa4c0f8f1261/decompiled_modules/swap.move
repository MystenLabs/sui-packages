module 0xb1731aa24d1eb98cb2c40721442e7cd0374d6dd21e2959a1df11aa4c0f8f1261::swap {
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

    public fun BuyNFT<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, u64) {
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

    public entry fun DelistNFT<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
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

    public entry fun ListNFT<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
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

    public entry fun accept_swap_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 11);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SwapOffer>(&mut arg0.id, arg1);
        assert!(v0.receiver == 0x2::tx_context::sender(arg8), 8);
        assert!(v0.status == 0, 13);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v0.offerer_kiosk_id, 3);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == v0.receiver_kiosk_id, 3);
        assert!(0x2::kiosk::has_item(arg2, v0.offerer_nft_id), 2);
        assert!(0x2::kiosk::has_item(arg5, v0.receiver_nft_id), 2);
        v0.status = 1;
        0x2::kiosk::list<T0>(arg2, arg3, v0.offerer_nft_id, 0);
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg2, v0.offerer_nft_id, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T1>(arg7, 0x2::transfer_policy::new_request<T1>(v0.receiver_nft_id, 0, 0x2::object::id<0x2::kiosk::Kiosk>(arg5)));
        0x2::kiosk::place<T0>(arg5, arg6, v1);
        0x2::transfer::public_transfer<T1>(0x2::kiosk::take<T1>(arg5, arg6, v0.receiver_nft_id), v0.offerer);
        let v9 = SwapOfferAccepted{
            offer_id          : arg1,
            offerer_kiosk_id  : v0.offerer_kiosk_id,
            offerer_nft_id    : v0.offerer_nft_id,
            receiver_kiosk_id : v0.receiver_kiosk_id,
            receiver_nft_id   : v0.receiver_nft_id,
            offerer           : v0.offerer,
            receiver          : v0.receiver,
        };
        0x2::event::emit<SwapOfferAccepted>(v9);
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

    public entry fun create_swap_offer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(0x2::kiosk::has_item(arg4, arg5), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        let v0 = SwapOffer{
            id                : 0x2::object::new(arg6),
            offerer           : 0x2::tx_context::sender(arg6),
            receiver          : 0x2::kiosk::owner(arg4),
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
            receiver          : 0x2::kiosk::owner(arg4),
        };
        0x2::event::emit<SwapOfferCreated>(v2);
    }

    // decompiled from Move bytecode v6
}

