module 0xe84cb929b82554b9aedd9a7476531ffebe2a8134886f251dcb011bc0929e68a7::ninja {
    struct Store has key {
        id: 0x2::object::UID,
        auction_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct SwapOffer<T0: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offererd_kiosk: 0x2::object::ID,
        offererd_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
    }

    struct AcceptOffer<T0: store + key> has store, key {
        id: 0x2::object::UID,
        receiver: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
    }

    struct SwapOfferCreated has copy, drop {
        offerer: address,
        offererd_kiosk: 0x2::object::ID,
        offererd_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
    }

    struct ClaimOffer has copy, drop {
        receiver: address,
        receiver_kiosk_id: 0x2::object::ID,
        sender: address,
        sender_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    struct SwapOfferCancelled has copy, drop {
        offerer: address,
        offererd_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
    }

    public fun accept_offer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &0x2::transfer_policy::TransferPolicy<T0>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let SwapOffer {
            id             : v0,
            offerer        : v1,
            offererd_kiosk : _,
            offererd_nft   : v3,
            requested_nft  : _,
            purchase_cap   : v5,
            status         : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0>>(&mut arg0.id, arg7);
        assert!(v3 == arg7, 6);
        0x2::object::delete(v0);
        0x2::tx_context::sender(arg9);
        let v7 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v8 = AcceptOffer<T0>{
            id           : 0x2::object::new(arg9),
            receiver     : v1,
            kiosk_id     : v7,
            nft_id       : arg3,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg9),
            status       : 0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, AcceptOffer<T0>>(&mut arg0.id, v7, v8);
        let (v9, v10) = 0x2::kiosk::purchase_with_cap<T0>(arg4, v5, 0x2::coin::zero<0x2::sui::SUI>(arg9));
        0x2::kiosk::lock<T0>(arg5, arg6, arg8, v9);
        v10
    }

    public fun cancel_offer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let SwapOffer {
            id             : v0,
            offerer        : v1,
            offererd_kiosk : _,
            offererd_nft   : _,
            requested_nft  : v4,
            purchase_cap   : v5,
            status         : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0>>(&mut arg0.id, arg2);
        assert!(0x2::tx_context::sender(arg4) == v1, 0);
        0x2::object::delete(v0);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
        let v7 = SwapOfferCancelled{
            offerer       : v1,
            offererd_nft  : arg2,
            requested_nft : v4,
        };
        0x2::event::emit<SwapOfferCancelled>(v7);
    }

    public fun claim_swap_creator_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let AcceptOffer {
            id           : v0,
            receiver     : v1,
            kiosk_id     : _,
            nft_id       : _,
            purchase_cap : v4,
            status       : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, AcceptOffer<T0>>(&mut arg0.id, arg4);
        assert!(0x2::tx_context::sender(arg6) == v1, 0);
        0x2::object::delete(v0);
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v6);
        v7
    }

    public fun create_offer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = SwapOffer<T0>{
            id             : 0x2::object::new(arg5),
            offerer        : v0,
            offererd_kiosk : v1,
            offererd_nft   : arg3,
            requested_nft  : arg4,
            purchase_cap   : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg5),
            status         : 0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer<T0>>(&mut arg0.id, arg3, v2);
        let v3 = SwapOfferCreated{
            offerer        : v0,
            offererd_kiosk : v1,
            offererd_nft   : arg3,
            requested_nft  : arg4,
        };
        0x2::event::emit<SwapOfferCreated>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v2 = Store{
            id                : 0x2::object::new(arg0),
            auction_kiosk_cap : v1,
        };
        0x2::transfer::share_object<Store>(v2);
    }

    // decompiled from Move bytecode v6
}

