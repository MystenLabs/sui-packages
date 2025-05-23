module 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::kiosk_auctionhouse {
    struct Kiosk_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        orphaned_swap_caps: 0x2::object::UID,
        orphaned_accept_caps: 0x2::object::UID,
        swap_offers: 0x2::object::UID,
        accept_offers: 0x2::object::UID,
    }

    struct SwapOfferKey<phantom T0: store + key, phantom T1: store + key> has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct AcceptOfferKey<phantom T0: store + key> has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct OrphanedCapKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        cap_type: u8,
    }

    struct OrphanedPurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        orphaned_at: u64,
        original_kiosk_id: 0x2::object::ID,
        original_offerer: address,
    }

    struct SwapOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
        fee: u64,
        created_at: u64,
        expires_at: u64,
    }

    struct AcceptOffer<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        receiver: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
        created_at: u64,
        expires_at: u64,
    }

    struct PurchaseCapOrphaned has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        cap_type: u8,
        emergency_action: bool,
        timestamp: u64,
        original_offerer: address,
        reason: vector<u8>,
    }

    struct SwapOfferCreated has copy, drop {
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        fee: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct SwapOfferCancelled has copy, drop {
        offerer: address,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        timestamp: u64,
    }

    struct ClaimOffer has copy, drop {
        receiver: address,
        receiver_kiosk_id: 0x2::object::ID,
        sender: address,
        sender_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        fee_paid: u64,
        timestamp: u64,
    }

    struct SwapCompleted has copy, drop {
        offerer: address,
        receiver: address,
        offered_nft: 0x2::object::ID,
        received_nft: 0x2::object::ID,
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

    struct KioskAuctionhouseStoreCreated has copy, drop {
        creator: address,
        auction_house_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct NewKioskCapAvailable has copy, drop {
        offerer: address,
        kiosk_id: 0x2::object::ID,
        holder: address,
        timestamp: u64,
    }

    public entry fun accept_kiosk_nft_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg10);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let (v5, v6) = accept_kiosk_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v4, &v2, arg6, arg7, arg8, arg10);
        let v7 = v6;
        let v8 = v5;
        if (0x2::coin::value<0x2::sui::SUI>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg7, &mut v8, arg9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v8, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg7, v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg10), arg10);
    }

    public fun accept_kiosk_nft_offer_direct<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg10: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::epoch(arg14);
        let v1 = 0x2::tx_context::sender(arg14);
        assert!(0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        let v2 = create_swap_offer_key<T0, T1>(arg6);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v2), 6);
        let SwapOffer {
            id            : v3,
            offerer       : v4,
            offered_kiosk : v5,
            offered_nft   : v6,
            requested_nft : _,
            purchase_cap  : v8,
            status        : v9,
            fee           : v10,
            created_at    : _,
            expires_at    : v12,
        } = 0x2::dynamic_object_field::remove<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&mut arg0.swap_offers, v2);
        validate_not_self_swap(v4, v1);
        assert!(v0 <= v12, 14);
        assert!(v6 == arg6, 4);
        assert!(v9 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == v5, 3);
        assert!(0x2::kiosk::has_item(arg2, arg4), 5);
        validate_kiosk_access(arg2, arg3);
        validate_kiosk_access(arg7, arg8);
        assert!(0x2::kiosk::owner(arg7) == v4, 1);
        let v13 = &mut arg11;
        let v14 = handle_fee_payment(v13, v10, arg14);
        if (v10 > 0) {
            0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg11));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg11);
        };
        0x2::object::delete(v3);
        let (v15, v16) = 0x2::kiosk::new(arg14);
        let v17 = v16;
        let v18 = v15;
        let (v19, v20) = 0x2::kiosk::purchase_with_cap<T0>(arg5, v8, 0x2::coin::zero<0x2::sui::SUI>(arg14));
        let v21 = v20;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg9, &mut v21, arg12);
        0x2::kiosk::lock<T0>(&mut v18, &v17, arg9, v19);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v21, &v18);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg9, v21);
        let (v25, v26) = 0x2::kiosk::purchase_with_cap<T1>(arg2, 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg14), 0x2::coin::zero<0x2::sui::SUI>(arg14));
        let v27 = v26;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T1>(arg10, &mut v27, arg13);
        0x2::kiosk::lock<T1>(arg7, arg8, arg10, v25);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T1>(&mut v27, arg7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T1>(arg10, v27);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v18);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v18, v17, arg14), arg14);
        let v31 = SwapCompleted{
            offerer      : v4,
            receiver     : v1,
            offered_nft  : arg6,
            received_nft : arg4,
            timestamp    : v0,
        };
        0x2::event::emit<SwapCompleted>(v31);
        let v32 = ClaimOffer{
            receiver          : v1,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v18),
            sender            : v4,
            sender_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            nft_id            : arg6,
            fee_paid          : v10,
            timestamp         : v0,
        };
        0x2::event::emit<ClaimOffer>(v32);
        let v33 = ClaimOffer{
            receiver          : v4,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg7),
            sender            : v1,
            sender_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id            : arg4,
            fee_paid          : 0,
            timestamp         : v0,
        };
        0x2::event::emit<ClaimOffer>(v33);
        v14
    }

    public entry fun accept_kiosk_nft_offer_direct_entry<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg10: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = accept_kiosk_nft_offer_direct<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg14));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    public fun accept_kiosk_nft_offer_with_new_offerer_kiosk<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::object::ID) {
        let (v0, v1) = 0x2::kiosk::new(arg12);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = accept_kiosk_nft_offer_direct<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4, &v2, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg12), arg12);
        (v5, 0x2::object::id<0x2::kiosk::Kiosk>(&v3))
    }

    public entry fun accept_kiosk_nft_offer_with_new_offerer_kiosk_entry<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = accept_kiosk_nft_offer_with_new_offerer_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = v0;
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg12));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
    }

    public fun accept_kiosk_nft_offer_with_new_offerer_kiosk_to_address<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: address, arg8: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg9: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = create_swap_offer_key<T0, T1>(arg6);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v0), 6);
        assert!(0x2::dynamic_object_field::borrow<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&arg0.swap_offers, v0).offerer == arg7, 1);
        let (v1, v2) = 0x2::kiosk::new(arg13);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = accept_kiosk_nft_offer_direct<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v5, &v3, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v4, v3, arg13), arg13);
        let v7 = NewKioskCapAvailable{
            offerer   : arg7,
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
            holder    : 0x2::tx_context::sender(arg13),
            timestamp : 0x2::tx_context::epoch(arg13),
        };
        0x2::event::emit<NewKioskCapAvailable>(v7);
        v6
    }

    public entry fun accept_kiosk_nft_offer_with_new_offerer_kiosk_to_address_entry<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: address, arg8: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg9: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = accept_kiosk_nft_offer_with_new_offerer_kiosk_to_address<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    public fun accept_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: 0x2::object::ID, arg9: &0x2::transfer_policy::TransferPolicy<T0>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::epoch(arg11);
        let v1 = 0x2::tx_context::sender(arg11);
        assert!(0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        let v2 = create_swap_offer_key<T0, T1>(arg8);
        let v3 = create_accept_offer_key<T1>(arg4);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v2), 6);
        assert!(!0x2::dynamic_object_field::exists_<AcceptOfferKey<T1>>(&arg0.accept_offers, v3), 12);
        let SwapOffer {
            id            : v4,
            offerer       : v5,
            offered_kiosk : v6,
            offered_nft   : v7,
            requested_nft : _,
            purchase_cap  : v9,
            status        : v10,
            fee           : v11,
            created_at    : _,
            expires_at    : v13,
        } = 0x2::dynamic_object_field::remove<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&mut arg0.swap_offers, v2);
        validate_not_self_swap(v5, v1);
        assert!(v0 <= v13, 14);
        assert!(v7 == arg8, 4);
        assert!(v10 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == v6, 3);
        assert!(0x2::kiosk::has_item(arg2, arg4), 5);
        validate_kiosk_access(arg2, arg3);
        validate_kiosk_access(arg6, arg7);
        let v14 = &mut arg10;
        let v15 = handle_fee_payment(v14, v11, arg11);
        if (v11 > 0) {
            0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg10));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg10);
        };
        0x2::object::delete(v4);
        let v16 = AcceptOffer<T1>{
            id              : 0x2::object::new(arg11),
            receiver        : v5,
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : arg4,
            original_nft_id : arg8,
            purchase_cap    : 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg11),
            status          : 0,
            created_at      : v0,
            expires_at      : v0 + 31104000,
        };
        0x2::dynamic_object_field::add<AcceptOfferKey<T1>, AcceptOffer<T1>>(&mut arg0.accept_offers, v3, v16);
        let (v17, v18) = 0x2::kiosk::purchase_with_cap<T0>(arg5, v9, 0x2::coin::zero<0x2::sui::SUI>(arg11));
        0x2::kiosk::lock<T0>(arg6, arg7, arg9, v17);
        let v19 = ClaimOffer{
            receiver          : v1,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg6),
            sender            : v5,
            sender_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            nft_id            : arg8,
            fee_paid          : v11,
            timestamp         : v0,
        };
        0x2::event::emit<ClaimOffer>(v19);
        (v18, v15)
    }

    public fun accept_offer_exists<T0: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<AcceptOfferKey<T0>>(&arg0.accept_offers, create_accept_offer_key<T0>(arg1))
    }

    public fun can_direct_swap<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::kiosk::Kiosk, arg3: u64) : bool {
        let v0 = create_swap_offer_key<T0, T1>(arg1);
        if (!0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v0)) {
            return false
        };
        let v1 = 0x2::dynamic_object_field::borrow<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&arg0.swap_offers, v0);
        if (v1.status == 0) {
            if (arg3 <= v1.expires_at) {
                0x2::kiosk::owner(arg2) == v1.offerer
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun cancel_kiosk_nft_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_swap_offer_key<T0, T1>(arg2);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v0), 6);
        let SwapOffer {
            id            : v1,
            offerer       : v2,
            offered_kiosk : v3,
            offered_nft   : _,
            requested_nft : v5,
            purchase_cap  : v6,
            status        : v7,
            fee           : _,
            created_at    : _,
            expires_at    : _,
        } = 0x2::dynamic_object_field::remove<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&mut arg0.swap_offers, v0);
        assert!(0x2::tx_context::sender(arg3) == v2, 1);
        assert!(v7 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v3, 3);
        0x2::object::delete(v1);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v6);
        let v11 = SwapOfferCancelled{
            offerer       : v2,
            offered_nft   : arg2,
            requested_nft : v5,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<SwapOfferCancelled>(v11);
    }

    public entry fun claim_kiosk_nft_offer<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = claim_offer<T0>(arg0, arg1, v4, &v2, arg2, arg3, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v5, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg5), arg5);
    }

    public fun claim_offer<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = create_accept_offer_key<T0>(arg4);
        assert!(0x2::dynamic_object_field::exists_<AcceptOfferKey<T0>>(&arg0.accept_offers, v2), 6);
        let AcceptOffer {
            id              : v3,
            receiver        : v4,
            kiosk_id        : v5,
            nft_id          : v6,
            original_nft_id : v7,
            purchase_cap    : v8,
            status          : v9,
            created_at      : _,
            expires_at      : v11,
        } = 0x2::dynamic_object_field::remove<AcceptOfferKey<T0>, AcceptOffer<T0>>(&mut arg0.accept_offers, v2);
        assert!(v0 <= v11, 14);
        assert!(v1 == v4, 1);
        assert!(v9 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v5, 3);
        validate_kiosk_access(arg2, arg3);
        0x2::object::delete(v3);
        let (v12, v13) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v8, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v12);
        let v14 = SwapCompleted{
            offerer      : v1,
            receiver     : v4,
            offered_nft  : v6,
            received_nft : v7,
            timestamp    : v0,
        };
        0x2::event::emit<SwapCompleted>(v14);
        v13
    }

    fun create_accept_offer_key<T0: store + key>(arg0: 0x2::object::ID) : AcceptOfferKey<T0> {
        AcceptOfferKey<T0>{nft_id: arg0}
    }

    public entry fun create_and_share_kiosk_auctionhouse_store(arg0: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Auctionhouse_Store>(create_kiosk_auctionhouse(arg0, arg1));
    }

    public fun create_kiosk_auctionhouse(arg0: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Auctionhouse_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg0, v0), 8);
        let v1 = Kiosk_Auctionhouse_Store{
            id                   : 0x2::object::new(arg1),
            auction_house        : 0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg0),
            orphaned_swap_caps   : 0x2::object::new(arg1),
            orphaned_accept_caps : 0x2::object::new(arg1),
            swap_offers          : 0x2::object::new(arg1),
            accept_offers        : 0x2::object::new(arg1),
        };
        let v2 = KioskAuctionhouseStoreCreated{
            creator          : v0,
            auction_house_id : 0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg0),
            timestamp        : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<KioskAuctionhouseStoreCreated>(v2);
        v1
    }

    public fun create_kiosk_nft_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = 0x2::tx_context::epoch(arg7);
        validate_fee(arg5);
        let v3 = v2 + validate_duration(arg6);
        assert!(arg3 != arg4, 17);
        let v4 = create_swap_offer_key<T0, T1>(arg3);
        assert!(!0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v4), 12);
        assert!(0x2::kiosk::has_item(arg1, arg3), 5);
        validate_kiosk_access(arg1, arg2);
        let v5 = SwapOffer<T0, T1>{
            id            : 0x2::object::new(arg7),
            offerer       : v0,
            offered_kiosk : v1,
            offered_nft   : arg3,
            requested_nft : arg4,
            purchase_cap  : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg7),
            status        : 0,
            fee           : arg5,
            created_at    : v2,
            expires_at    : v3,
        };
        0x2::dynamic_object_field::add<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&mut arg0.swap_offers, v4, v5);
        let v6 = SwapOfferCreated{
            offerer       : v0,
            offered_kiosk : v1,
            offered_nft   : arg3,
            requested_nft : arg4,
            fee           : arg5,
            expires_at    : v3,
            timestamp     : v2,
        };
        0x2::event::emit<SwapOfferCreated>(v6);
    }

    fun create_orphaned_cap_key(arg0: 0x2::object::ID, arg1: u8) : OrphanedCapKey {
        OrphanedCapKey{
            nft_id   : arg0,
            cap_type : arg1,
        }
    }

    public entry fun create_personal_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg0), arg0);
    }

    public fun create_personal_kiosk_ptb(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        (0x2::object::id<0x2::kiosk::Kiosk>(&v2), 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg0))
    }

    fun create_swap_offer_key<T0: store + key, T1: store + key>(arg0: 0x2::object::ID) : SwapOfferKey<T0, T1> {
        SwapOfferKey<T0, T1>{nft_id: arg0}
    }

    public entry fun emergency_reset_accept_offer<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg4)), 8);
        let v0 = create_accept_offer_key<T0>(arg2);
        if (0x2::dynamic_object_field::exists_<AcceptOfferKey<T0>>(&arg0.accept_offers, v0)) {
            let AcceptOffer {
                id              : v1,
                receiver        : v2,
                kiosk_id        : v3,
                nft_id          : _,
                original_nft_id : _,
                purchase_cap    : v6,
                status          : _,
                created_at      : _,
                expires_at      : _,
            } = 0x2::dynamic_object_field::remove<AcceptOfferKey<T0>, AcceptOffer<T0>>(&mut arg0.accept_offers, v0);
            0x2::object::delete(v1);
            store_orphaned_accept_cap<T0>(arg0, v6, arg2, v3, v2, true, arg3, arg4);
        };
    }

    public entry fun emergency_reset_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg4)), 8);
        let v0 = create_swap_offer_key<T0, T1>(arg2);
        if (0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v0)) {
            let SwapOffer {
                id            : v1,
                offerer       : v2,
                offered_kiosk : v3,
                offered_nft   : _,
                requested_nft : _,
                purchase_cap  : v6,
                status        : _,
                fee           : _,
                created_at    : _,
                expires_at    : _,
            } = 0x2::dynamic_object_field::remove<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&mut arg0.swap_offers, v0);
            0x2::object::delete(v1);
            store_orphaned_swap_cap<T0>(arg0, v6, arg2, v3, v2, true, arg3, arg4);
        };
    }

    public fun get_auction_house_id(arg0: &Kiosk_Auctionhouse_Store) : 0x2::object::ID {
        arg0.auction_house
    }

    public fun get_offer_creator<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : address {
        let v0 = create_swap_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v0), 6);
        0x2::dynamic_object_field::borrow<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&arg0.swap_offers, v0).offerer
    }

    public fun get_offer_expiration<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_swap_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v0), 6);
        0x2::dynamic_object_field::borrow<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&arg0.swap_offers, v0).expires_at
    }

    public fun get_offer_fee<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_swap_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v0), 6);
        0x2::dynamic_object_field::borrow<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&arg0.swap_offers, v0).fee
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

    public fun is_offer_expired<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = create_swap_offer_key<T0, T1>(arg1);
        if (!0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, v0)) {
            return false
        };
        arg2 > 0x2::dynamic_object_field::borrow<SwapOfferKey<T0, T1>, SwapOffer<T0, T1>>(&arg0.swap_offers, v0).expires_at
    }

    public fun offer_exists<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<SwapOfferKey<T0, T1>>(&arg0.swap_offers, create_swap_offer_key<T0, T1>(arg1))
    }

    public fun orphaned_accept_cap_exists(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.orphaned_accept_caps, create_orphaned_cap_key(arg1, 1))
    }

    public fun orphaned_swap_cap_exists(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.orphaned_swap_caps, create_orphaned_cap_key(arg1, 0))
    }

    public entry fun recover_orphaned_accept_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 1;
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v1) || 0x2::kiosk::owner(arg2) == v1, 1);
        validate_kiosk_access(arg2, arg3);
        let v2 = create_orphaned_cap_key(arg4, v0);
        if (0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.orphaned_accept_caps, v2)) {
            let OrphanedPurchaseCap {
                id                : v3,
                cap               : v4,
                orphaned_at       : _,
                original_kiosk_id : v6,
                original_offerer  : v7,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_accept_caps, v2);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v6, 13);
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

    public entry fun recover_orphaned_swap_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v1) || 0x2::kiosk::owner(arg2) == v1, 1);
        validate_kiosk_access(arg2, arg3);
        let v2 = create_orphaned_cap_key(arg4, v0);
        if (0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.orphaned_swap_caps, v2)) {
            let OrphanedPurchaseCap {
                id                : v3,
                cap               : v4,
                orphaned_at       : _,
                original_kiosk_id : v6,
                original_offerer  : v7,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_swap_caps, v2);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v6, 13);
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

    public fun store_orphaned_accept_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: bool, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg7);
        let v1 = 1;
        let v2 = OrphanedPurchaseCap<T0>{
            id                : 0x2::object::new(arg7),
            cap               : arg1,
            orphaned_at       : v0,
            original_kiosk_id : arg3,
            original_offerer  : arg4,
        };
        0x2::dynamic_object_field::add<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_accept_caps, create_orphaned_cap_key(arg2, v1), v2);
        let v3 = PurchaseCapOrphaned{
            nft_id           : arg2,
            kiosk_id         : arg3,
            cap_type         : v1,
            emergency_action : arg5,
            timestamp        : v0,
            original_offerer : arg4,
            reason           : arg6,
        };
        0x2::event::emit<PurchaseCapOrphaned>(v3);
    }

    public fun store_orphaned_swap_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: bool, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg7);
        let v1 = 0;
        let v2 = OrphanedPurchaseCap<T0>{
            id                : 0x2::object::new(arg7),
            cap               : arg1,
            orphaned_at       : v0,
            original_kiosk_id : arg3,
            original_offerer  : arg4,
        };
        0x2::dynamic_object_field::add<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_swap_caps, create_orphaned_cap_key(arg2, v1), v2);
        let v3 = PurchaseCapOrphaned{
            nft_id           : arg2,
            kiosk_id         : arg3,
            cap_type         : v1,
            emergency_action : arg5,
            timestamp        : v0,
            original_offerer : arg4,
            reason           : arg6,
        };
        0x2::event::emit<PurchaseCapOrphaned>(v3);
    }

    fun validate_duration(arg0: u64) : u64 {
        if (arg0 == 0) {
            31104000
        } else {
            assert!(arg0 >= 3600, 15);
            assert!(arg0 <= 124416000, 15);
            arg0
        }
    }

    fun validate_fee(arg0: u64) {
        assert!(arg0 >= 0, 16);
        assert!(arg0 <= 100000000000000, 10);
    }

    fun validate_kiosk_access(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9);
    }

    fun validate_not_self_swap(arg0: address, arg1: address) {
        assert!(arg0 != arg1, 17);
    }

    // decompiled from Move bytecode v6
}

