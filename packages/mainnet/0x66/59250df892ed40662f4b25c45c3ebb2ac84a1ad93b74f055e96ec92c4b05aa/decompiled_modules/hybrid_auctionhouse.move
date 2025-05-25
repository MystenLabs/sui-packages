module 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::hybrid_auctionhouse {
    struct Hybrid_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        kiosk_for_direct_offers: 0x2::object::UID,
        direct_for_kiosk_offers: 0x2::object::UID,
        nft_escrows: 0x2::object::UID,
        completed_swaps: 0x2::object::UID,
    }

    struct KioskForDirectOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
        fee_sui: u64,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    struct DirectForKioskOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_kiosk: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        status: u8,
        fee_sui: u64,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    struct NftEscrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: T0,
        offerer: address,
        created_at_ms: u64,
    }

    struct CompletedSwap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        original_offerer: address,
        received_nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        completed_at_ms: u64,
    }

    struct KioskForDirectOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee_sui: u64,
        expires_at_ms: u64,
        duration_hours: u64,
    }

    struct DirectForKioskOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_kiosk: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee_sui: u64,
        expires_at_ms: u64,
        duration_hours: u64,
    }

    struct KioskForDirectOfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        accepter: address,
        offered_nft: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
    }

    struct DirectForKioskOfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        accepter: address,
        offered_nft_id: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        offer_type: u8,
        was_expired: bool,
    }

    struct NftClaimed has copy, drop {
        swap_id: 0x2::object::ID,
        claimer: address,
        nft_id: 0x2::object::ID,
        claimed_at_ms: u64,
    }

    public fun accept_direct_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (T0, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, arg5), 5);
        assert!(0x2::object::id<0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        let DirectForKioskOffer {
            id               : v2,
            offerer          : v3,
            offered_nft_id   : _,
            requested_kiosk  : v5,
            requested_nft_id : v6,
            status           : v7,
            fee_sui          : v8,
            expires_at_ms    : v9,
            created_at_ms    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&mut arg0.direct_for_kiosk_offers, arg5);
        let v11 = v2;
        assert!(v0 != v3, 13);
        assert!(v7 == 0, 2);
        assert!(v1 <= v9, 10);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v5, 3);
        assert!(arg4 == v6, 4);
        assert!(0x2::kiosk::has_item(arg2, arg4), 4);
        assert!(0x2::kiosk::has_access(arg2, arg3), 7);
        let v12 = 0x2::object::uid_to_inner(&v11);
        let v13 = if (v8 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v8, 6);
            if (0x2::coin::value<0x2::sui::SUI>(&arg6) > v8) {
                0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v8, arg8)));
                arg6
            } else {
                0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
                0x2::coin::zero<0x2::sui::SUI>(arg8)
            }
        } else {
            arg6
        };
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftEscrow<T0>>(&arg0.nft_escrows, v12), 14);
        let NftEscrow {
            id            : v14,
            nft           : v15,
            offerer       : _,
            created_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.nft_escrows, v12);
        let v18 = CompletedSwap<T1>{
            id               : 0x2::object::new(arg8),
            original_offerer : v3,
            received_nft_id  : arg4,
            purchase_cap     : 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg8),
            completed_at_ms  : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, CompletedSwap<T1>>(&mut arg0.completed_swaps, 0x2::object::id<CompletedSwap<T1>>(&v18), v18);
        0x2::object::delete(v11);
        0x2::object::delete(v14);
        let v19 = DirectForKioskOfferAccepted{
            offer_id        : v12,
            offerer         : v3,
            accepter        : v0,
            offered_nft_id  : arg5,
            received_nft_id : arg4,
            fee_paid        : v8,
        };
        0x2::event::emit<DirectForKioskOfferAccepted>(v19);
        (v15, v13)
    }

    public entry fun accept_direct_for_kiosk_offer_entry<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = accept_direct_for_kiosk_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = v1;
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun accept_kiosk_for_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: T1, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, arg3), 5);
        assert!(0x2::object::id<0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        let KioskForDirectOffer {
            id               : v1,
            offerer          : v2,
            offered_kiosk    : v3,
            offered_nft      : _,
            requested_nft_id : v5,
            purchase_cap     : v6,
            status           : v7,
            fee_sui          : v8,
            expires_at_ms    : v9,
            created_at_ms    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&mut arg0.kiosk_for_direct_offers, arg3);
        let v11 = v1;
        assert!(v0 != v2, 13);
        assert!(v7 == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg9) <= v9, 10);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v3, 3);
        assert!(0x2::object::id<T1>(&arg4) == v5, 4);
        assert!(0x2::kiosk::has_access(arg5, arg6), 7);
        0x2::object::delete(v11);
        let v12 = if (v8 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) >= v8, 6);
            if (0x2::coin::value<0x2::sui::SUI>(&arg8) > v8) {
                0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg8, v8, arg10)));
                arg8
            } else {
                0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
                0x2::coin::zero<0x2::sui::SUI>(arg10)
            }
        } else {
            arg8
        };
        let (v13, v14) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v6, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        0x2::kiosk::lock<T0>(arg5, arg6, arg7, v13);
        let v15 = KioskForDirectOfferAccepted{
            offer_id        : 0x2::object::uid_to_inner(&v11),
            offerer         : v2,
            accepter        : v0,
            offered_nft     : arg3,
            received_nft_id : v5,
            fee_paid        : v8,
        };
        0x2::event::emit<KioskForDirectOfferAccepted>(v15);
        0x2::transfer::public_transfer<T1>(arg4, v2);
        (v14, v12)
    }

    public entry fun accept_kiosk_for_direct_offer_entry<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: T1, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg9);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let (v5, v6) = accept_kiosk_for_direct_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, v4, &v2, arg5, arg6, arg8, arg9);
        let v7 = v6;
        let v8 = v5;
        if (0x2::coin::value<0x2::sui::SUI>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v8, arg7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v8, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg9), arg9);
    }

    public fun accept_kiosk_for_direct_offer_external<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: T1, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, arg3), 5);
        assert!(0x2::object::id<0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        let KioskForDirectOffer {
            id               : v1,
            offerer          : v2,
            offered_kiosk    : v3,
            offered_nft      : _,
            requested_nft_id : v5,
            purchase_cap     : v6,
            status           : v7,
            fee_sui          : v8,
            expires_at_ms    : v9,
            created_at_ms    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&mut arg0.kiosk_for_direct_offers, arg3);
        let v11 = v1;
        assert!(v0 != v2, 13);
        assert!(v7 == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg7) <= v9, 10);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v3, 3);
        assert!(0x2::object::id<T1>(&arg4) == v5, 4);
        0x2::object::delete(v11);
        let v12 = if (v8 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v8, 6);
            if (0x2::coin::value<0x2::sui::SUI>(&arg6) > v8) {
                0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v8, arg8)));
                arg6
            } else {
                0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
                0x2::coin::zero<0x2::sui::SUI>(arg8)
            }
        } else {
            arg6
        };
        let (v13, v14) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v6, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v15 = KioskForDirectOfferAccepted{
            offer_id        : 0x2::object::uid_to_inner(&v11),
            offerer         : v2,
            accepter        : v0,
            offered_nft     : arg3,
            received_nft_id : v5,
            fee_paid        : v8,
        };
        0x2::event::emit<KioskForDirectOfferAccepted>(v15);
        0x2::transfer::public_transfer<T1>(arg4, v2);
        (v13, v14, v12)
    }

    public fun cancel_direct_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, arg1), 5);
        let DirectForKioskOffer {
            id               : v0,
            offerer          : v1,
            offered_nft_id   : _,
            requested_kiosk  : _,
            requested_nft_id : _,
            status           : v5,
            fee_sui          : _,
            expires_at_ms    : v7,
            created_at_ms    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&mut arg0.direct_for_kiosk_offers, arg1);
        let v9 = v0;
        assert!(0x2::tx_context::sender(arg3) == v1, 1);
        assert!(v5 == 0, 2);
        let v10 = 0x2::object::uid_to_inner(&v9);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftEscrow<T0>>(&arg0.nft_escrows, v10), 14);
        let NftEscrow {
            id            : v11,
            nft           : v12,
            offerer       : _,
            created_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.nft_escrows, v10);
        0x2::object::delete(v9);
        0x2::object::delete(v11);
        let v15 = OfferCancelled{
            offer_id    : v10,
            offerer     : v1,
            offer_type  : 1,
            was_expired : 0x2::clock::timestamp_ms(arg2) > v7,
        };
        0x2::event::emit<OfferCancelled>(v15);
        v12
    }

    public fun cancel_kiosk_for_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, arg2), 5);
        let KioskForDirectOffer {
            id               : v0,
            offerer          : v1,
            offered_kiosk    : v2,
            offered_nft      : _,
            requested_nft_id : _,
            purchase_cap     : v5,
            status           : v6,
            fee_sui          : _,
            expires_at_ms    : v8,
            created_at_ms    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&mut arg0.kiosk_for_direct_offers, arg2);
        let v10 = v0;
        assert!(0x2::tx_context::sender(arg4) == v1, 1);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 3);
        0x2::object::delete(v10);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
        let v11 = OfferCancelled{
            offer_id    : 0x2::object::uid_to_inner(&v10),
            offerer     : v1,
            offer_type  : 0,
            was_expired : 0x2::clock::timestamp_ms(arg3) > v8,
        };
        0x2::event::emit<OfferCancelled>(v11);
    }

    public fun claim_received_nft<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedSwap<T0>>(&arg0.completed_swaps, arg1), 5);
        let CompletedSwap {
            id               : v1,
            original_offerer : v2,
            received_nft_id  : v3,
            purchase_cap     : v4,
            completed_at_ms  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, CompletedSwap<T0>>(&mut arg0.completed_swaps, arg1);
        assert!(v0 == v2, 1);
        assert!(0x2::kiosk::owner(arg3) == v0, 1);
        assert!(0x2::kiosk::has_access(arg3, arg4), 7);
        0x2::object::delete(v1);
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v4, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        0x2::kiosk::lock<T0>(arg3, arg4, arg5, v6);
        let v8 = NftClaimed{
            swap_id       : arg1,
            claimer       : v0,
            nft_id        : v3,
            claimed_at_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<NftClaimed>(v8);
        v7
    }

    public entry fun claim_received_nft_entry<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = claim_received_nft<T0>(arg0, arg1, arg2, v4, &v2, arg3, arg5, arg6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v5, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg6), arg6);
    }

    public fun claim_received_nft_external<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedSwap<T0>>(&arg0.completed_swaps, arg1), 5);
        let CompletedSwap {
            id               : v1,
            original_offerer : v2,
            received_nft_id  : v3,
            purchase_cap     : v4,
            completed_at_ms  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, CompletedSwap<T0>>(&mut arg0.completed_swaps, arg1);
        assert!(v0 == v2, 1);
        assert!(0x2::kiosk::owner(arg3) == v0, 1);
        assert!(0x2::kiosk::has_access(arg3, arg4), 7);
        0x2::object::delete(v1);
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v4, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v8 = NftClaimed{
            swap_id       : arg1,
            claimer       : v0,
            nft_id        : v3,
            claimed_at_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<NftClaimed>(v8);
        (v6, v7)
    }

    public entry fun create_and_share_hybrid_auctionhouse_store(arg0: &0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Hybrid_Auctionhouse_Store>(create_hybrid_auctionhouse(arg0, arg1));
    }

    public fun create_direct_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::object::id<T0>(&arg1);
        validate_fee(arg4);
        validate_duration(arg5);
        assert!(!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, v2), 9);
        let v3 = v1 + arg5;
        let v4 = DirectForKioskOffer<T0, T1>{
            id               : 0x2::object::new(arg7),
            offerer          : v0,
            offered_nft_id   : v2,
            requested_kiosk  : arg2,
            requested_nft_id : arg3,
            status           : 0,
            fee_sui          : arg4,
            expires_at_ms    : v3,
            created_at_ms    : v1,
        };
        let v5 = 0x2::object::id<DirectForKioskOffer<T0, T1>>(&v4);
        let v6 = NftEscrow<T0>{
            id            : 0x2::object::new(arg7),
            nft           : arg1,
            offerer       : v0,
            created_at_ms : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&mut arg0.direct_for_kiosk_offers, v2, v4);
        0x2::dynamic_object_field::add<0x2::object::ID, NftEscrow<T0>>(&mut arg0.nft_escrows, v5, v6);
        let v7 = DirectForKioskOfferCreated{
            offer_id         : v5,
            offerer          : v0,
            offered_nft_id   : v2,
            requested_kiosk  : arg2,
            requested_nft_id : arg3,
            fee_sui          : arg4,
            expires_at_ms    : v3,
            duration_hours   : arg5 / 3600000,
        };
        0x2::event::emit<DirectForKioskOfferCreated>(v7);
    }

    public fun create_hybrid_auctionhouse(arg0: &0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Hybrid_Auctionhouse_Store {
        assert!(0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::is_admin(arg0, 0x2::tx_context::sender(arg1)), 1);
        Hybrid_Auctionhouse_Store{
            id                      : 0x2::object::new(arg1),
            auction_house           : 0x2::object::id<0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse>(arg0),
            kiosk_for_direct_offers : 0x2::object::new(arg1),
            direct_for_kiosk_offers : 0x2::object::new(arg1),
            nft_escrows             : 0x2::object::new(arg1),
            completed_swaps         : 0x2::object::new(arg1),
        }
    }

    public fun create_kiosk_for_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        validate_fee(arg5);
        validate_duration(arg6);
        assert!(arg3 != arg4, 13);
        assert!(!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, arg3), 9);
        assert!(0x2::kiosk::has_item(arg1, arg3), 4);
        assert!(0x2::kiosk::owner(arg1) == v0, 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 7);
        let v2 = v1 + arg6;
        let v3 = KioskForDirectOffer<T0, T1>{
            id               : 0x2::object::new(arg8),
            offerer          : v0,
            offered_kiosk    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offered_nft      : arg3,
            requested_nft_id : arg4,
            purchase_cap     : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg8),
            status           : 0,
            fee_sui          : arg5,
            expires_at_ms    : v2,
            created_at_ms    : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&mut arg0.kiosk_for_direct_offers, arg3, v3);
        let v4 = KioskForDirectOfferCreated{
            offer_id         : 0x2::object::id<KioskForDirectOffer<T0, T1>>(&v3),
            offerer          : v0,
            offered_kiosk    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offered_nft      : arg3,
            requested_nft_id : arg4,
            fee_sui          : arg5,
            expires_at_ms    : v2,
            duration_hours   : arg6 / 3600000,
        };
        0x2::event::emit<KioskForDirectOfferCreated>(v4);
    }

    public fun days_to_ms(arg0: u64) : u64 {
        let v0 = arg0 * 86400000;
        validate_duration(v0);
        v0
    }

    public fun direct_for_kiosk_offer_exists<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, arg1)
    }

    public fun get_auction_house_id(arg0: &Hybrid_Auctionhouse_Store) : 0x2::object::ID {
        arg0.auction_house
    }

    public fun get_direct_for_kiosk_offer_info<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (address, 0x2::object::ID, 0x2::object::ID, u64, u64, bool) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, arg1);
        (v0.offerer, v0.requested_kiosk, v0.requested_nft_id, v0.fee_sui, v0.expires_at_ms, 0x2::clock::timestamp_ms(arg2) > v0.expires_at_ms)
    }

    public fun get_kiosk_for_direct_offer_info<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (address, 0x2::object::ID, 0x2::object::ID, u64, u64, bool) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, arg1);
        (v0.offerer, v0.offered_kiosk, v0.requested_nft_id, v0.fee_sui, v0.expires_at_ms, 0x2::clock::timestamp_ms(arg2) > v0.expires_at_ms)
    }

    public fun hours_to_ms(arg0: u64) : u64 {
        let v0 = arg0 * 3600000;
        validate_duration(v0);
        v0
    }

    public fun is_offer_expired<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, arg1)) {
            return 0x2::clock::timestamp_ms(arg2) > 0x2::dynamic_object_field::borrow<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, arg1).expires_at_ms
        };
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, arg1)) {
            return 0x2::clock::timestamp_ms(arg2) > 0x2::dynamic_object_field::borrow<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.direct_for_kiosk_offers, arg1).expires_at_ms
        };
        false
    }

    public fun kiosk_for_direct_offer_exists<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.kiosk_for_direct_offers, arg1)
    }

    public fun readable_to_sui(arg0: u64, arg1: u64) : u64 {
        arg0 * 1000000000 + arg1
    }

    public fun sui_to_readable(arg0: u64) : (u64, u64) {
        (arg0 / 1000000000, arg0 % 1000000000)
    }

    public fun validate_duration(arg0: u64) {
        assert!(arg0 >= 3600000, 11);
        assert!(arg0 <= 31536000000, 12);
    }

    public fun validate_fee(arg0: u64) {
        assert!(arg0 >= 0, 15);
        assert!(arg0 <= 1000000000000, 8);
    }

    // decompiled from Move bytecode v6
}

