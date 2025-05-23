module 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::hybrid_auctionhouse {
    struct Hybrid_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        marketplace: 0x2::object::ID,
        kiosk_for_direct_orphaned_caps: 0x2::object::UID,
        direct_for_kiosk_orphaned_caps: 0x2::object::UID,
        counter_offer_orphaned_caps: 0x2::object::UID,
        kiosk_for_direct_offers: 0x2::object::UID,
        direct_for_kiosk_offers: 0x2::object::UID,
        nft_escrows: 0x2::object::UID,
        counter_offers: 0x2::object::UID,
        expired_offers: 0x2::object::UID,
    }

    struct KioskForDirectKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        type_marker: vector<u8>,
    }

    struct DirectForKioskKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        type_marker: vector<u8>,
    }

    struct EscrowKey has copy, drop, store {
        offer_id: 0x2::object::ID,
        type_marker: vector<u8>,
    }

    struct CounterOfferKey has copy, drop, store {
        offer_id: 0x2::object::ID,
        type_marker: vector<u8>,
    }

    struct OrphanedCapKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        cap_type: u8,
    }

    struct ExpiredOfferKey has copy, drop, store {
        offer_id: 0x2::object::ID,
        offer_type: u8,
        expiration: u64,
    }

    struct ExpiredOfferMarker has store, key {
        id: 0x2::object::UID,
    }

    struct OrphanedPurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        orphaned_at: u64,
        original_kiosk_id: 0x2::object::ID,
        original_offerer: address,
    }

    struct NftEscrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: T0,
        created_at: u64,
        offerer: address,
    }

    struct KioskForDirectOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
        fee: u64,
        created_at: u64,
        expires_at: u64,
    }

    struct DirectForKioskOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_kiosk: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        status: u8,
        fee: u64,
        created_at: u64,
        expires_at: u64,
    }

    struct KioskNftCounterOffer<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        policy_id: 0x2::object::ID,
        status: u8,
        created_at: u64,
        expires_at: u64,
    }

    struct HybridAuctionhouseStoreCreated has copy, drop {
        creator: address,
        marketplace_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct PurchaseCapOrphaned has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        cap_type: u8,
        emergency_action: bool,
        timestamp: u64,
        original_offerer: address,
    }

    struct KioskForDirectOfferCreated has copy, drop {
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct DirectForKioskOfferCreated has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_kiosk: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct KioskForDirectOfferCancelled has copy, drop {
        offerer: address,
        offered_nft: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee: u64,
        timestamp: u64,
    }

    struct DirectForKioskOfferCancelled has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct KioskForDirectOfferAccepted has copy, drop {
        receiver: address,
        sender: address,
        offered_nft: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
        timestamp: u64,
    }

    struct DirectForKioskOfferAccepted has copy, drop {
        receiver: address,
        receiver_kiosk_id: 0x2::object::ID,
        sender: address,
        offered_nft_id: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
        timestamp: u64,
    }

    struct KioskNftClaimed<phantom T0: store + key> has copy, drop {
        claimer: address,
        offer_id: 0x2::object::ID,
        original_nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct OrphanedCapRecovered has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        cap_type: u8,
        recoverer: address,
        timestamp: u64,
        original_offerer: address,
    }

    struct EmergencyReset has copy, drop {
        nft_id: 0x2::object::ID,
        cap_type: u8,
        admin: address,
        timestamp: u64,
        reason: vector<u8>,
    }

    struct OfferExpired has copy, drop {
        offer_id: 0x2::object::ID,
        offer_type: u8,
        nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct CleanupAttempted has copy, drop {
        timestamp: u64,
        marketplace_id: 0x2::object::ID,
    }

    public fun accept_kiosk_for_native<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: T1, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::coin::Coin<0x2::sui::SUI>, address, T1) {
        validate_auction_house(arg0, arg1);
        let v0 = 0x2::tx_context::epoch(arg9);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = create_kiosk_for_direct_key<T0, T1>(arg5);
        assert!(0x2::dynamic_object_field::exists_<KioskForDirectKey>(&arg0.kiosk_for_direct_offers, v2), 6);
        let KioskForDirectOffer {
            id               : v3,
            offerer          : v4,
            offered_kiosk    : v5,
            offered_nft      : v6,
            requested_nft_id : v7,
            purchase_cap     : v8,
            status           : v9,
            fee              : v10,
            created_at       : _,
            expires_at       : v12,
        } = 0x2::dynamic_object_field::remove<KioskForDirectKey, KioskForDirectOffer<T0, T1>>(&mut arg0.kiosk_for_direct_offers, v2);
        let v13 = v3;
        assert!(v0 <= v12, 15);
        assert!(v6 == arg5, 4);
        assert!(v9 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v5, 3);
        assert!(0x2::object::id<T1>(&arg6) == v7, 4);
        assert!(0x2::kiosk::has_access(arg3, arg4), 9);
        validate_not_self_trade(v4, v1);
        let v14 = create_expired_offer_key(0x2::object::uid_to_inner(&v13), 0, v12);
        if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v14)) {
            let ExpiredOfferMarker { id: v15 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v14);
            0x2::object::delete(v15);
        };
        let v16 = &mut arg8;
        let v17 = handle_fee_payment(v16, v10, arg9);
        0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
        0x2::object::delete(v13);
        let (v18, v19) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v8, 0x2::coin::zero<0x2::sui::SUI>(arg9));
        0x2::kiosk::lock<T0>(arg3, arg4, arg7, v18);
        let v20 = KioskForDirectOfferAccepted{
            receiver        : v1,
            sender          : v4,
            offered_nft     : arg5,
            received_nft_id : v7,
            fee_paid        : v10,
            timestamp       : v0,
        };
        0x2::event::emit<KioskForDirectOfferAccepted>(v20);
        (v19, v17, v4, arg6)
    }

    public entry fun accept_kiosk_for_native_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: T1, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let (v0, v1) = 0x2::kiosk::new(arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let (v5, v6, v7, v8) = accept_kiosk_for_native<T0, T1>(arg0, arg1, arg2, v4, &v2, arg3, arg4, arg5, arg6, arg8);
        let v9 = v6;
        let v10 = v5;
        if (0x2::coin::value<0x2::sui::SUI>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v9);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v10, arg7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v10, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v10);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg8), arg8);
        0x2::transfer::public_transfer<T1>(v8, v7);
    }

    public fun accept_native_for_kiosk<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T1>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : (T0, 0x2::coin::Coin<0x2::sui::SUI>) {
        validate_auction_house(arg0, arg1);
        let v0 = 0x2::tx_context::epoch(arg8);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = create_direct_for_kiosk_key<T0, T1>(arg5);
        assert!(0x2::dynamic_object_field::exists_<DirectForKioskKey>(&arg0.direct_for_kiosk_offers, v2), 6);
        let DirectForKioskOffer {
            id               : v3,
            offerer          : v4,
            offered_nft_id   : v5,
            requested_kiosk  : v6,
            requested_nft_id : v7,
            status           : v8,
            fee              : v9,
            created_at       : _,
            expires_at       : v11,
        } = 0x2::dynamic_object_field::remove<DirectForKioskKey, DirectForKioskOffer<T0, T1>>(&mut arg0.direct_for_kiosk_offers, v2);
        let v12 = v3;
        assert!(v0 <= v11, 15);
        assert!(v8 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v6, 3);
        assert!(arg4 == v7, 4);
        assert!(arg5 == v5, 4);
        assert!(0x2::kiosk::has_item(arg2, arg4), 5);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        validate_not_self_trade(v4, v1);
        let v13 = 0x2::object::uid_to_inner(&v12);
        let v14 = create_expired_offer_key(v13, 1, v11);
        if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v14)) {
            let ExpiredOfferMarker { id: v15 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v14);
            0x2::object::delete(v15);
        };
        let v16 = &mut arg7;
        let v17 = handle_fee_payment(v16, v9, arg8);
        0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg7));
        let v18 = create_escrow_key<T0>(v13);
        assert!(0x2::dynamic_object_field::exists_<EscrowKey>(&arg0.nft_escrows, v18), 13);
        let NftEscrow {
            id         : v19,
            nft        : v20,
            created_at : _,
            offerer    : _,
        } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v18);
        let v23 = v0 + 604800;
        let v24 = KioskNftCounterOffer<T1>{
            id              : 0x2::object::new(arg8),
            offerer         : v4,
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : arg4,
            original_nft_id : arg5,
            purchase_cap    : 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg8),
            policy_id       : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T1>>(arg6),
            status          : 0,
            created_at      : v0,
            expires_at      : v23,
        };
        0x2::dynamic_object_field::add<CounterOfferKey, KioskNftCounterOffer<T1>>(&mut arg0.counter_offers, create_counter_offer_key<T1>(v13), v24);
        track_offer_expiration(arg0, v13, 2, v23, arg8);
        0x2::object::delete(v12);
        0x2::object::delete(v19);
        let v25 = DirectForKioskOfferAccepted{
            receiver          : v1,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            sender            : v4,
            offered_nft_id    : v5,
            received_nft_id   : arg4,
            fee_paid          : v9,
            timestamp         : v0,
        };
        0x2::event::emit<DirectForKioskOfferAccepted>(v25);
        (v20, v17)
    }

    public entry fun accept_native_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T1>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let (v0, v1) = accept_native_for_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = v1;
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun cancel_kiosk_for_native_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_kiosk_for_direct_key<T0, T1>(arg2);
        assert!(0x2::dynamic_object_field::exists_<KioskForDirectKey>(&arg0.kiosk_for_direct_offers, v0), 6);
        let KioskForDirectOffer {
            id               : v1,
            offerer          : v2,
            offered_kiosk    : v3,
            offered_nft      : _,
            requested_nft_id : v5,
            purchase_cap     : v6,
            status           : v7,
            fee              : v8,
            created_at       : _,
            expires_at       : v10,
        } = 0x2::dynamic_object_field::remove<KioskForDirectKey, KioskForDirectOffer<T0, T1>>(&mut arg0.kiosk_for_direct_offers, v0);
        let v11 = v1;
        assert!(0x2::tx_context::sender(arg3) == v2, 1);
        assert!(v7 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v3, 3);
        let v12 = create_expired_offer_key(0x2::object::uid_to_inner(&v11), 0, v10);
        if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v12)) {
            let ExpiredOfferMarker { id: v13 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v12);
            0x2::object::delete(v13);
        };
        0x2::object::delete(v11);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v6);
        let v14 = KioskForDirectOfferCancelled{
            offerer          : v2,
            offered_nft      : arg2,
            requested_nft_id : v5,
            fee              : v8,
            timestamp        : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<KioskForDirectOfferCancelled>(v14);
    }

    public fun cancel_native_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = create_direct_for_kiosk_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<DirectForKioskKey>(&arg0.direct_for_kiosk_offers, v0), 6);
        let DirectForKioskOffer {
            id               : v1,
            offerer          : v2,
            offered_nft_id   : v3,
            requested_kiosk  : _,
            requested_nft_id : v5,
            status           : v6,
            fee              : _,
            created_at       : _,
            expires_at       : v9,
        } = 0x2::dynamic_object_field::remove<DirectForKioskKey, DirectForKioskOffer<T0, T1>>(&mut arg0.direct_for_kiosk_offers, v0);
        let v10 = v1;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        assert!(v6 == 0, 2);
        let v11 = 0x2::object::uid_to_inner(&v10);
        let v12 = create_expired_offer_key(v11, 1, v9);
        if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v12)) {
            let ExpiredOfferMarker { id: v13 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v12);
            0x2::object::delete(v13);
        };
        let v14 = create_escrow_key<T0>(v11);
        assert!(0x2::dynamic_object_field::exists_<EscrowKey>(&arg0.nft_escrows, v14), 13);
        let NftEscrow {
            id         : v15,
            nft        : v16,
            created_at : _,
            offerer    : _,
        } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v14);
        0x2::object::delete(v10);
        0x2::object::delete(v15);
        let v19 = DirectForKioskOfferCancelled{
            offerer          : v2,
            offered_nft_id   : v3,
            requested_nft_id : v5,
            timestamp        : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<DirectForKioskOfferCancelled>(v19);
        v16
    }

    public fun claim_kiosk_nft<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = create_counter_offer_key<T0>(arg1);
        assert!(0x2::dynamic_object_field::exists_<CounterOfferKey>(&arg0.counter_offers, v1), 10);
        let KioskNftCounterOffer {
            id              : v2,
            offerer         : v3,
            kiosk_id        : v4,
            nft_id          : _,
            original_nft_id : v6,
            purchase_cap    : v7,
            policy_id       : v8,
            status          : v9,
            created_at      : _,
            expires_at      : v11,
        } = 0x2::dynamic_object_field::remove<CounterOfferKey, KioskNftCounterOffer<T0>>(&mut arg0.counter_offers, v1);
        assert!(v0 <= v11, 15);
        assert!(0x2::tx_context::sender(arg6) == v3, 1);
        assert!(v9 == 0, 2);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg5) == v8, 11);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v4, 3);
        assert!(0x2::kiosk::has_access(arg3, arg4), 9);
        let v12 = create_expired_offer_key(arg1, 2, v11);
        if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v12)) {
            let ExpiredOfferMarker { id: v13 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v12);
            0x2::object::delete(v13);
        };
        0x2::object::delete(v2);
        let (v14, v15) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v7, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg3, arg4, arg5, v14);
        let v16 = KioskNftClaimed<T0>{
            claimer         : v3,
            offer_id        : arg1,
            original_nft_id : v6,
            timestamp       : v0,
        };
        0x2::event::emit<KioskNftClaimed<T0>>(v16);
        v15
    }

    public entry fun claim_kiosk_nft_offer<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let (v0, v1) = 0x2::kiosk::new(arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = claim_kiosk_nft<T0>(arg0, arg2, arg3, v4, &v2, arg4, arg6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v5, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg6), arg6);
    }

    public entry fun cleanup_counter_offer_entry<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        cleanup_expired_counter_offer<T0>(arg0, arg2, arg3);
    }

    public entry fun cleanup_direct_for_kiosk_offer_entry<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        cleanup_expired_direct_for_kiosk_offer<T0, T1>(arg0, arg2, arg3);
    }

    public fun cleanup_expired_counter_offer<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = create_counter_offer_key<T0>(arg1);
        if (0x2::dynamic_object_field::exists_with_type<CounterOfferKey, KioskNftCounterOffer<T0>>(&arg0.counter_offers, v1)) {
            if (0x2::dynamic_object_field::borrow<CounterOfferKey, KioskNftCounterOffer<T0>>(&arg0.counter_offers, v1).expires_at <= v0) {
                let KioskNftCounterOffer {
                    id              : v2,
                    offerer         : v3,
                    kiosk_id        : v4,
                    nft_id          : v5,
                    original_nft_id : v6,
                    purchase_cap    : v7,
                    policy_id       : _,
                    status          : _,
                    created_at      : _,
                    expires_at      : v11,
                } = 0x2::dynamic_object_field::remove<CounterOfferKey, KioskNftCounterOffer<T0>>(&mut arg0.counter_offers, v1);
                let v12 = create_expired_offer_key(arg1, 2, v11);
                if (0x2::dynamic_object_field::exists_with_type<ExpiredOfferKey, ExpiredOfferMarker>(&arg0.expired_offers, v12)) {
                    let ExpiredOfferMarker { id: v13 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v12);
                    0x2::object::delete(v13);
                };
                0x2::object::delete(v2);
                store_orphaned_counter_offer_cap<T0>(arg0, v7, v5, v4, v3, false, arg2);
                let v14 = OfferExpired{
                    offer_id   : arg1,
                    offer_type : 2,
                    nft_id     : v6,
                    timestamp  : v0,
                };
                0x2::event::emit<OfferExpired>(v14);
            };
        };
    }

    public fun cleanup_expired_direct_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = create_direct_for_kiosk_key<T0, T1>(arg1);
        if (0x2::dynamic_object_field::exists_with_type<DirectForKioskKey, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, v1)) {
            if (0x2::dynamic_object_field::borrow<DirectForKioskKey, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, v1).expires_at <= v0) {
                let DirectForKioskOffer {
                    id               : v2,
                    offerer          : v3,
                    offered_nft_id   : v4,
                    requested_kiosk  : _,
                    requested_nft_id : _,
                    status           : _,
                    fee              : _,
                    created_at       : _,
                    expires_at       : v10,
                } = 0x2::dynamic_object_field::remove<DirectForKioskKey, DirectForKioskOffer<T0, T1>>(&mut arg0.direct_for_kiosk_offers, v1);
                let v11 = v2;
                let v12 = 0x2::object::uid_to_inner(&v11);
                let v13 = create_expired_offer_key(v12, 1, v10);
                if (0x2::dynamic_object_field::exists_with_type<ExpiredOfferKey, ExpiredOfferMarker>(&arg0.expired_offers, v13)) {
                    let ExpiredOfferMarker { id: v14 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v13);
                    0x2::object::delete(v14);
                };
                let v15 = create_escrow_key<T0>(v12);
                if (0x2::dynamic_object_field::exists_with_type<EscrowKey, NftEscrow<T0>>(&arg0.nft_escrows, v15)) {
                    let NftEscrow {
                        id         : v16,
                        nft        : v17,
                        created_at : _,
                        offerer    : _,
                    } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v15);
                    0x2::object::delete(v16);
                    0x2::transfer::public_transfer<T0>(v17, v3);
                };
                0x2::object::delete(v11);
                let v20 = OfferExpired{
                    offer_id   : v12,
                    offer_type : 1,
                    nft_id     : v4,
                    timestamp  : v0,
                };
                0x2::event::emit<OfferExpired>(v20);
            };
        };
    }

    public fun cleanup_expired_kiosk_for_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = create_kiosk_for_direct_key<T0, T1>(arg1);
        if (0x2::dynamic_object_field::exists_with_type<KioskForDirectKey, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, v1)) {
            if (0x2::dynamic_object_field::borrow<KioskForDirectKey, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, v1).expires_at <= v0) {
                let KioskForDirectOffer {
                    id               : v2,
                    offerer          : v3,
                    offered_kiosk    : v4,
                    offered_nft      : v5,
                    requested_nft_id : _,
                    purchase_cap     : v7,
                    status           : _,
                    fee              : _,
                    created_at       : _,
                    expires_at       : v11,
                } = 0x2::dynamic_object_field::remove<KioskForDirectKey, KioskForDirectOffer<T0, T1>>(&mut arg0.kiosk_for_direct_offers, v1);
                let v12 = v2;
                let v13 = 0x2::object::uid_to_inner(&v12);
                let v14 = create_expired_offer_key(v13, 0, v11);
                if (0x2::dynamic_object_field::exists_with_type<ExpiredOfferKey, ExpiredOfferMarker>(&arg0.expired_offers, v14)) {
                    let ExpiredOfferMarker { id: v15 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v14);
                    0x2::object::delete(v15);
                };
                0x2::object::delete(v12);
                store_orphaned_kiosk_for_direct_cap<T0>(arg0, v7, v5, v4, v3, false, arg2);
                let v16 = OfferExpired{
                    offer_id   : v13,
                    offer_type : 0,
                    nft_id     : v5,
                    timestamp  : v0,
                };
                0x2::event::emit<OfferExpired>(v16);
            };
        };
    }

    public entry fun cleanup_kiosk_for_direct_offer_entry<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        cleanup_expired_kiosk_for_direct_offer<T0, T1>(arg0, arg2, arg3);
    }

    public fun counter_offer_exists<T0: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<CounterOfferKey>(&arg0.counter_offers, create_counter_offer_key<T0>(arg1))
    }

    public entry fun create_and_share_hybrid_auctionhouse_store(arg0: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Hybrid_Auctionhouse_Store>(create_hybrid_auctionhouse(arg0, arg1));
    }

    fun create_counter_offer_key<T0: store + key>(arg0: 0x2::object::ID) : CounterOfferKey {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"KioskNftCounterOffer_");
        0x1::vector::append<u8>(&mut v0, type_name_bytes<T0>());
        CounterOfferKey{
            offer_id    : arg0,
            type_marker : v0,
        }
    }

    fun create_direct_for_kiosk_key<T0: store + key, T1: store + key>(arg0: 0x2::object::ID) : DirectForKioskKey {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"DirectForKioskOffer_");
        0x1::vector::append<u8>(&mut v0, type_name_bytes<T0>());
        0x1::vector::append<u8>(&mut v0, b"_");
        0x1::vector::append<u8>(&mut v0, type_name_bytes<T1>());
        DirectForKioskKey{
            nft_id      : arg0,
            type_marker : v0,
        }
    }

    fun create_escrow_key<T0: store + key>(arg0: 0x2::object::ID) : EscrowKey {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"NftEscrow_");
        0x1::vector::append<u8>(&mut v0, type_name_bytes<T0>());
        EscrowKey{
            offer_id    : arg0,
            type_marker : v0,
        }
    }

    fun create_expired_offer_key(arg0: 0x2::object::ID, arg1: u8, arg2: u64) : ExpiredOfferKey {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 17);
        ExpiredOfferKey{
            offer_id   : arg0,
            offer_type : arg1,
            expiration : arg2,
        }
    }

    public fun create_hybrid_auctionhouse(arg0: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Hybrid_Auctionhouse_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg0, v0), 8);
        let v1 = Hybrid_Auctionhouse_Store{
            id                             : 0x2::object::new(arg1),
            marketplace                    : 0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg0),
            kiosk_for_direct_orphaned_caps : 0x2::object::new(arg1),
            direct_for_kiosk_orphaned_caps : 0x2::object::new(arg1),
            counter_offer_orphaned_caps    : 0x2::object::new(arg1),
            kiosk_for_direct_offers        : 0x2::object::new(arg1),
            direct_for_kiosk_offers        : 0x2::object::new(arg1),
            nft_escrows                    : 0x2::object::new(arg1),
            counter_offers                 : 0x2::object::new(arg1),
            expired_offers                 : 0x2::object::new(arg1),
        };
        let v2 = HybridAuctionhouseStoreCreated{
            creator        : v0,
            marketplace_id : 0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg0),
            timestamp      : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<HybridAuctionhouseStoreCreated>(v2);
        v1
    }

    fun create_kiosk_for_direct_key<T0: store + key, T1: store + key>(arg0: 0x2::object::ID) : KioskForDirectKey {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"KioskForDirectOffer_");
        0x1::vector::append<u8>(&mut v0, type_name_bytes<T0>());
        0x1::vector::append<u8>(&mut v0, b"_");
        0x1::vector::append<u8>(&mut v0, type_name_bytes<T1>());
        KioskForDirectKey{
            nft_id      : arg0,
            type_marker : v0,
        }
    }

    public fun create_kiosk_for_native_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = 0x2::tx_context::epoch(arg7);
        validate_fee(arg5);
        let v3 = v2 + validate_duration(arg6);
        let v4 = create_kiosk_for_direct_key<T0, T1>(arg3);
        assert!(!0x2::dynamic_object_field::exists_<KioskForDirectKey>(&arg0.kiosk_for_direct_offers, v4), 14);
        assert!(0x2::kiosk::has_item(arg1, arg3), 5);
        assert!(0x2::kiosk::has_access(arg1, arg2), 9);
        let v5 = 0x2::object::new(arg7);
        let v6 = KioskForDirectOffer<T0, T1>{
            id               : v5,
            offerer          : v0,
            offered_kiosk    : v1,
            offered_nft      : arg3,
            requested_nft_id : arg4,
            purchase_cap     : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg7),
            status           : 0,
            fee              : arg5,
            created_at       : v2,
            expires_at       : v3,
        };
        0x2::dynamic_object_field::add<KioskForDirectKey, KioskForDirectOffer<T0, T1>>(&mut arg0.kiosk_for_direct_offers, v4, v6);
        track_offer_expiration(arg0, 0x2::object::uid_to_inner(&v5), 0, v3, arg7);
        let v7 = KioskForDirectOfferCreated{
            offerer          : v0,
            offered_kiosk    : v1,
            offered_nft      : arg3,
            requested_nft_id : arg4,
            fee              : arg5,
            expires_at       : v3,
            timestamp        : v2,
        };
        0x2::event::emit<KioskForDirectOfferCreated>(v7);
    }

    public fun create_native_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::tx_context::epoch(arg6);
        validate_fee(arg4);
        let v3 = v2 + validate_duration(arg5);
        let v4 = create_direct_for_kiosk_key<T0, T1>(v1);
        assert!(!0x2::dynamic_object_field::exists_<DirectForKioskKey>(&arg0.direct_for_kiosk_offers, v4), 14);
        let v5 = 0x2::object::new(arg6);
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = DirectForKioskOffer<T0, T1>{
            id               : v5,
            offerer          : v0,
            offered_nft_id   : v1,
            requested_kiosk  : arg2,
            requested_nft_id : arg3,
            status           : 0,
            fee              : arg4,
            created_at       : v2,
            expires_at       : v3,
        };
        let v8 = NftEscrow<T0>{
            id         : 0x2::object::new(arg6),
            nft        : arg1,
            created_at : v2,
            offerer    : v0,
        };
        0x2::dynamic_object_field::add<DirectForKioskKey, DirectForKioskOffer<T0, T1>>(&mut arg0.direct_for_kiosk_offers, v4, v7);
        0x2::dynamic_object_field::add<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, create_escrow_key<T0>(v6), v8);
        track_offer_expiration(arg0, v6, 1, v3, arg6);
        let v9 = DirectForKioskOfferCreated{
            offerer          : v0,
            offered_nft_id   : v1,
            requested_kiosk  : arg2,
            requested_nft_id : arg3,
            fee              : arg4,
            expires_at       : v3,
            timestamp        : v2,
        };
        0x2::event::emit<DirectForKioskOfferCreated>(v9);
    }

    fun create_orphaned_cap_key(arg0: 0x2::object::ID, arg1: u8) : OrphanedCapKey {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 17);
        OrphanedCapKey{
            nft_id   : arg0,
            cap_type : arg1,
        }
    }

    public fun direct_for_kiosk_offer_exists<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<DirectForKioskKey>(&arg0.direct_for_kiosk_offers, create_direct_for_kiosk_key<T0, T1>(arg1))
    }

    public entry fun emergency_reset_counter_offer<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v0), 8);
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = create_counter_offer_key<T0>(arg2);
        if (0x2::dynamic_object_field::exists_<CounterOfferKey>(&arg0.counter_offers, v2)) {
            let KioskNftCounterOffer {
                id              : v3,
                offerer         : v4,
                kiosk_id        : v5,
                nft_id          : v6,
                original_nft_id : _,
                purchase_cap    : v8,
                policy_id       : _,
                status          : _,
                created_at      : _,
                expires_at      : v12,
            } = 0x2::dynamic_object_field::remove<CounterOfferKey, KioskNftCounterOffer<T0>>(&mut arg0.counter_offers, v2);
            let v13 = create_expired_offer_key(arg2, 2, v12);
            if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v13)) {
                let ExpiredOfferMarker { id: v14 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v13);
                0x2::object::delete(v14);
            };
            0x2::object::delete(v3);
            store_orphaned_counter_offer_cap<T0>(arg0, v8, v6, v5, v4, true, arg4);
            let v15 = EmergencyReset{
                nft_id    : v6,
                cap_type  : 2,
                admin     : v0,
                timestamp : v1,
                reason    : arg3,
            };
            0x2::event::emit<EmergencyReset>(v15);
        };
    }

    public entry fun emergency_reset_direct_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v0), 8);
        let v1 = create_direct_for_kiosk_key<T0, T1>(arg2);
        if (0x2::dynamic_object_field::exists_<DirectForKioskKey>(&arg0.direct_for_kiosk_offers, v1)) {
            let DirectForKioskOffer {
                id               : v2,
                offerer          : v3,
                offered_nft_id   : _,
                requested_kiosk  : _,
                requested_nft_id : _,
                status           : _,
                fee              : _,
                created_at       : _,
                expires_at       : v10,
            } = 0x2::dynamic_object_field::remove<DirectForKioskKey, DirectForKioskOffer<T0, T1>>(&mut arg0.direct_for_kiosk_offers, v1);
            let v11 = v2;
            let v12 = 0x2::object::uid_to_inner(&v11);
            let v13 = create_expired_offer_key(v12, 1, v10);
            if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v13)) {
                let ExpiredOfferMarker { id: v14 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v13);
                0x2::object::delete(v14);
            };
            let v15 = create_escrow_key<T0>(v12);
            if (0x2::dynamic_object_field::exists_<EscrowKey>(&arg0.nft_escrows, v15)) {
                let NftEscrow {
                    id         : v16,
                    nft        : v17,
                    created_at : _,
                    offerer    : _,
                } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v15);
                0x2::object::delete(v16);
                0x2::transfer::public_transfer<T0>(v17, v3);
            };
            0x2::object::delete(v11);
            let v20 = EmergencyReset{
                nft_id    : arg2,
                cap_type  : 1,
                admin     : v0,
                timestamp : 0x2::tx_context::epoch(arg4),
                reason    : arg3,
            };
            0x2::event::emit<EmergencyReset>(v20);
        };
    }

    public entry fun emergency_reset_kiosk_for_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v0), 8);
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = create_kiosk_for_direct_key<T0, T1>(arg2);
        if (0x2::dynamic_object_field::exists_<KioskForDirectKey>(&arg0.kiosk_for_direct_offers, v2)) {
            let KioskForDirectOffer {
                id               : v3,
                offerer          : v4,
                offered_kiosk    : v5,
                offered_nft      : _,
                requested_nft_id : _,
                purchase_cap     : v8,
                status           : _,
                fee              : _,
                created_at       : _,
                expires_at       : v12,
            } = 0x2::dynamic_object_field::remove<KioskForDirectKey, KioskForDirectOffer<T0, T1>>(&mut arg0.kiosk_for_direct_offers, v2);
            let v13 = v3;
            let v14 = create_expired_offer_key(0x2::object::uid_to_inner(&v13), 0, v12);
            if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v14)) {
                let ExpiredOfferMarker { id: v15 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v14);
                0x2::object::delete(v15);
            };
            0x2::object::delete(v13);
            store_orphaned_kiosk_for_direct_cap<T0>(arg0, v8, arg2, v5, v4, true, arg4);
            let v16 = EmergencyReset{
                nft_id    : arg2,
                cap_type  : 0,
                admin     : v0,
                timestamp : v1,
                reason    : arg3,
            };
            0x2::event::emit<EmergencyReset>(v16);
        };
    }

    public fun get_counter_offer_expiration<T0: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_counter_offer_key<T0>(arg1);
        assert!(0x2::dynamic_object_field::exists_<CounterOfferKey>(&arg0.counter_offers, v0), 10);
        0x2::dynamic_object_field::borrow<CounterOfferKey, KioskNftCounterOffer<T0>>(&arg0.counter_offers, v0).expires_at
    }

    public fun get_direct_for_kiosk_offer_expiration<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_direct_for_kiosk_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<DirectForKioskKey>(&arg0.direct_for_kiosk_offers, v0), 6);
        0x2::dynamic_object_field::borrow<DirectForKioskKey, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, v0).expires_at
    }

    public fun get_direct_for_kiosk_offer_fee<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_direct_for_kiosk_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<DirectForKioskKey>(&arg0.direct_for_kiosk_offers, v0), 6);
        0x2::dynamic_object_field::borrow<DirectForKioskKey, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, v0).fee
    }

    public fun get_kiosk_for_direct_offer_expiration<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_kiosk_for_direct_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<KioskForDirectKey>(&arg0.kiosk_for_direct_offers, v0), 6);
        0x2::dynamic_object_field::borrow<KioskForDirectKey, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, v0).expires_at
    }

    public fun get_kiosk_for_direct_offer_fee<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_kiosk_for_direct_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<KioskForDirectKey>(&arg0.kiosk_for_direct_offers, v0), 6);
        0x2::dynamic_object_field::borrow<KioskForDirectKey, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, v0).fee
    }

    public fun get_marketplace_id(arg0: &Hybrid_Auctionhouse_Store) : 0x2::object::ID {
        arg0.marketplace
    }

    fun handle_fee_payment(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        assert!(v0 >= arg1, 7);
        if (v0 > arg1 && arg1 > 0) {
            0x2::coin::split<0x2::sui::SUI>(arg0, v0 - arg1, arg2)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg2)
        }
    }

    public fun kiosk_for_direct_offer_exists<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<KioskForDirectKey>(&arg0.kiosk_for_direct_offers, create_kiosk_for_direct_key<T0, T1>(arg1))
    }

    public fun orphaned_cap_exists(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: u8) : bool {
        arg2 == 0 && 0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.kiosk_for_direct_orphaned_caps, create_orphaned_cap_key(arg1, arg2)) || arg2 == 1 && 0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.direct_for_kiosk_orphaned_caps, create_orphaned_cap_key(arg1, arg2)) || arg2 == 2 && 0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.counter_offer_orphaned_caps, create_orphaned_cap_key(arg1, arg2))
    }

    public entry fun recover_orphaned_cap<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        recover_orphaned_cap_from_storage<T0>(arg0, arg1, arg2, arg3, arg4, 0, arg5);
        recover_orphaned_cap_from_storage<T0>(arg0, arg1, arg2, arg3, arg4, 1, arg5);
        recover_orphaned_cap_from_storage<T0>(arg0, arg1, arg2, arg3, arg4, 2, arg5);
    }

    fun recover_orphaned_cap_from_storage<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v0) || 0x2::kiosk::owner(arg2) == v0, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        let v1 = create_orphaned_cap_key(arg4, arg5);
        if (arg5 == 0 && 0x2::dynamic_object_field::exists_with_type<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&arg0.kiosk_for_direct_orphaned_caps, v1)) {
            let OrphanedPurchaseCap {
                id                : v2,
                cap               : v3,
                orphaned_at       : _,
                original_kiosk_id : v5,
                original_offerer  : v6,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.kiosk_for_direct_orphaned_caps, v1);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v5, 16);
            0x2::object::delete(v2);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v3);
            let v7 = OrphanedCapRecovered{
                nft_id           : arg4,
                kiosk_id         : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                cap_type         : arg5,
                recoverer        : v0,
                timestamp        : 0x2::tx_context::epoch(arg6),
                original_offerer : v6,
            };
            0x2::event::emit<OrphanedCapRecovered>(v7);
        } else if (arg5 == 1 && 0x2::dynamic_object_field::exists_with_type<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&arg0.direct_for_kiosk_orphaned_caps, v1)) {
            let OrphanedPurchaseCap {
                id                : v8,
                cap               : v9,
                orphaned_at       : _,
                original_kiosk_id : v11,
                original_offerer  : v12,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.direct_for_kiosk_orphaned_caps, v1);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v11, 16);
            0x2::object::delete(v8);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v9);
            let v13 = OrphanedCapRecovered{
                nft_id           : arg4,
                kiosk_id         : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                cap_type         : arg5,
                recoverer        : v0,
                timestamp        : 0x2::tx_context::epoch(arg6),
                original_offerer : v12,
            };
            0x2::event::emit<OrphanedCapRecovered>(v13);
        } else if (arg5 == 2 && 0x2::dynamic_object_field::exists_with_type<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&arg0.counter_offer_orphaned_caps, v1)) {
            let OrphanedPurchaseCap {
                id                : v14,
                cap               : v15,
                orphaned_at       : _,
                original_kiosk_id : v17,
                original_offerer  : v18,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.counter_offer_orphaned_caps, v1);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v17, 16);
            0x2::object::delete(v14);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v15);
            let v19 = OrphanedCapRecovered{
                nft_id           : arg4,
                kiosk_id         : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                cap_type         : arg5,
                recoverer        : v0,
                timestamp        : 0x2::tx_context::epoch(arg6),
                original_offerer : v18,
            };
            0x2::event::emit<OrphanedCapRecovered>(v19);
        };
    }

    public entry fun recover_orphaned_counter_offer_cap<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let v0 = 2;
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v1) || 0x2::kiosk::owner(arg2) == v1, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        let v2 = create_orphaned_cap_key(arg4, v0);
        if (0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.counter_offer_orphaned_caps, v2)) {
            let OrphanedPurchaseCap {
                id                : v3,
                cap               : v4,
                orphaned_at       : _,
                original_kiosk_id : v6,
                original_offerer  : v7,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.counter_offer_orphaned_caps, v2);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v6, 16);
            0x2::object::delete(v3);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v4);
            let v8 = OrphanedCapRecovered{
                nft_id           : arg4,
                kiosk_id         : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                cap_type         : v0,
                recoverer        : v1,
                timestamp        : 0x2::tx_context::epoch(arg5),
                original_offerer : v7,
            };
            0x2::event::emit<OrphanedCapRecovered>(v8);
        };
    }

    public entry fun recover_orphaned_direct_for_kiosk_cap<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let v0 = 1;
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v1) || 0x2::kiosk::owner(arg2) == v1, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        let v2 = create_orphaned_cap_key(arg4, v0);
        if (0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.direct_for_kiosk_orphaned_caps, v2)) {
            let OrphanedPurchaseCap {
                id                : v3,
                cap               : v4,
                orphaned_at       : _,
                original_kiosk_id : v6,
                original_offerer  : v7,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.direct_for_kiosk_orphaned_caps, v2);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v6, 16);
            0x2::object::delete(v3);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v4);
            let v8 = OrphanedCapRecovered{
                nft_id           : arg4,
                kiosk_id         : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                cap_type         : v0,
                recoverer        : v1,
                timestamp        : 0x2::tx_context::epoch(arg5),
                original_offerer : v7,
            };
            0x2::event::emit<OrphanedCapRecovered>(v8);
        };
    }

    public entry fun recover_orphaned_kiosk_for_direct_cap<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let v0 = 0;
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v1) || 0x2::kiosk::owner(arg2) == v1, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        let v2 = create_orphaned_cap_key(arg4, v0);
        if (0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.kiosk_for_direct_orphaned_caps, v2)) {
            let OrphanedPurchaseCap {
                id                : v3,
                cap               : v4,
                orphaned_at       : _,
                original_kiosk_id : v6,
                original_offerer  : v7,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.kiosk_for_direct_orphaned_caps, v2);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v6, 16);
            0x2::object::delete(v3);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v4);
            let v8 = OrphanedCapRecovered{
                nft_id           : arg4,
                kiosk_id         : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                cap_type         : v0,
                recoverer        : v1,
                timestamp        : 0x2::tx_context::epoch(arg5),
                original_offerer : v7,
            };
            0x2::event::emit<OrphanedCapRecovered>(v8);
        };
    }

    public fun store_orphaned_counter_offer_cap<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 2;
        let v2 = OrphanedPurchaseCap<T0>{
            id                : 0x2::object::new(arg6),
            cap               : arg1,
            orphaned_at       : v0,
            original_kiosk_id : arg3,
            original_offerer  : arg4,
        };
        0x2::dynamic_object_field::add<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.counter_offer_orphaned_caps, create_orphaned_cap_key(arg2, v1), v2);
        let v3 = PurchaseCapOrphaned{
            nft_id           : arg2,
            kiosk_id         : arg3,
            cap_type         : v1,
            emergency_action : arg5,
            timestamp        : v0,
            original_offerer : arg4,
        };
        0x2::event::emit<PurchaseCapOrphaned>(v3);
    }

    public fun store_orphaned_direct_for_kiosk_cap<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 1;
        let v2 = OrphanedPurchaseCap<T0>{
            id                : 0x2::object::new(arg6),
            cap               : arg1,
            orphaned_at       : v0,
            original_kiosk_id : arg3,
            original_offerer  : arg4,
        };
        0x2::dynamic_object_field::add<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.direct_for_kiosk_orphaned_caps, create_orphaned_cap_key(arg2, v1), v2);
        let v3 = PurchaseCapOrphaned{
            nft_id           : arg2,
            kiosk_id         : arg3,
            cap_type         : v1,
            emergency_action : arg5,
            timestamp        : v0,
            original_offerer : arg4,
        };
        0x2::event::emit<PurchaseCapOrphaned>(v3);
    }

    public fun store_orphaned_kiosk_for_direct_cap<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 0;
        let v2 = OrphanedPurchaseCap<T0>{
            id                : 0x2::object::new(arg6),
            cap               : arg1,
            orphaned_at       : v0,
            original_kiosk_id : arg3,
            original_offerer  : arg4,
        };
        0x2::dynamic_object_field::add<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.kiosk_for_direct_orphaned_caps, create_orphaned_cap_key(arg2, v1), v2);
        let v3 = PurchaseCapOrphaned{
            nft_id           : arg2,
            kiosk_id         : arg3,
            cap_type         : v1,
            emergency_action : arg5,
            timestamp        : v0,
            original_offerer : arg4,
        };
        0x2::event::emit<PurchaseCapOrphaned>(v3);
    }

    fun track_offer_expiration(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ExpiredOfferMarker{id: 0x2::object::new(arg4)};
        0x2::dynamic_object_field::add<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, create_expired_offer_key(arg1, arg2, arg3), v0);
    }

    fun type_name_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun validate_auction_house(arg0: &Hybrid_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse) {
        assert!(0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg1) == arg0.marketplace, 21);
    }

    fun validate_duration(arg0: u64) : u64 {
        if (arg0 == 0) {
            604800
        } else {
            assert!(arg0 >= 3600, 20);
            assert!(arg0 <= 2592000, 20);
            arg0
        }
    }

    fun validate_fee(arg0: u64) {
        assert!(arg0 >= 0, 19);
        assert!(arg0 <= 100000000000000, 12);
    }

    fun validate_not_self_trade(arg0: address, arg1: address) {
        assert!(arg0 != arg1, 22);
    }

    // decompiled from Move bytecode v6
}

