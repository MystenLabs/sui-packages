module 0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::kiosk_auctionhouse {
    struct Kiosk_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        orphaned_caps: 0x2::object::UID,
    }

    struct OrphanedPurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
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
    }

    struct AcceptOffer<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        receiver: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
    }

    struct PurchaseCapOrphaned has copy, drop {
        nft_id: 0x2::object::ID,
        emergency_action: bool,
    }

    struct SwapOfferCreated has copy, drop {
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        fee: u64,
    }

    struct SwapOfferCancelled has copy, drop {
        offerer: address,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
    }

    struct ClaimOffer has copy, drop {
        receiver: address,
        receiver_kiosk_id: 0x2::object::ID,
        sender: address,
        sender_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        fee_paid: u64,
    }

    struct SwapCompleted has copy, drop {
        offerer: address,
        receiver: address,
        offered_nft: 0x2::object::ID,
        received_nft: 0x2::object::ID,
    }

    public fun accept_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: 0x2::object::ID, arg9: &0x2::transfer_policy::TransferPolicy<T0>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg8), 6);
        let SwapOffer {
            id            : v0,
            offerer       : v1,
            offered_kiosk : v2,
            offered_nft   : v3,
            requested_nft : _,
            purchase_cap  : v5,
            status        : v6,
            fee           : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg8);
        assert!(v3 == arg8, 4);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == v2, 3);
        assert!(0x2::kiosk::has_item(arg2, arg4), 5);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        assert!(0x2::kiosk::has_access(arg6, arg7), 9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg10) >= v7, 7);
        0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg10));
        0x2::object::delete(v0);
        0x2::tx_context::sender(arg11);
        let v8 = AcceptOffer<T1>{
            id              : 0x2::object::new(arg11),
            receiver        : v1,
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : arg4,
            original_nft_id : arg8,
            purchase_cap    : 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg11),
            status          : 0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, AcceptOffer<T1>>(&mut arg0.id, arg4, v8);
        let (v9, v10) = 0x2::kiosk::purchase_with_cap<T0>(arg5, v5, 0x2::coin::zero<0x2::sui::SUI>(arg11));
        0x2::kiosk::lock<T0>(arg6, arg7, arg9, v9);
        let v11 = ClaimOffer{
            receiver          : 0x2::tx_context::sender(arg11),
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg6),
            sender            : v1,
            sender_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            nft_id            : arg8,
            fee_paid          : v7,
        };
        0x2::event::emit<ClaimOffer>(v11);
        v10
    }

    public entry fun accept_offer_create_kiosk<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg10);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = accept_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v4, &v2, arg6, arg7, arg8, arg10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg7, &mut v5, arg9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg7, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg10), arg10);
    }

    public fun accept_offer_exists<T0: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptOffer<T0>>(&arg0.id, arg1)
    }

    public fun cancel_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg2), 6);
        let SwapOffer {
            id            : v0,
            offerer       : v1,
            offered_kiosk : v2,
            offered_nft   : _,
            requested_nft : v4,
            purchase_cap  : v5,
            status        : v6,
            fee           : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg2);
        assert!(0x2::tx_context::sender(arg3) == v1, 1);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 3);
        0x2::object::delete(v0);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
        let v8 = SwapOfferCancelled{
            offerer       : v1,
            offered_nft   : arg2,
            requested_nft : v4,
        };
        0x2::event::emit<SwapOfferCancelled>(v8);
    }

    public fun claim_swap_creator_nft<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptOffer<T0>>(&arg0.id, arg4), 6);
        let AcceptOffer {
            id              : v0,
            receiver        : v1,
            kiosk_id        : v2,
            nft_id          : v3,
            original_nft_id : v4,
            purchase_cap    : v5,
            status          : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, AcceptOffer<T0>>(&mut arg0.id, arg4);
        assert!(0x2::tx_context::sender(arg6) == v1, 1);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 3);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        0x2::object::delete(v0);
        let (v7, v8) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v5, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v7);
        let v9 = SwapCompleted{
            offerer      : 0x2::tx_context::sender(arg6),
            receiver     : v1,
            offered_nft  : v3,
            received_nft : v4,
        };
        0x2::event::emit<SwapCompleted>(v9);
        v8
    }

    public entry fun claim_swap_creator_nft_create_kiosk<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = claim_swap_creator_nft<T0>(arg0, arg1, v4, &v2, arg2, arg3, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v5, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg5), arg5);
    }

    public entry fun complete_atomic_swap<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg10: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg6), 6);
        let SwapOffer {
            id            : v0,
            offerer       : v1,
            offered_kiosk : v2,
            offered_nft   : v3,
            requested_nft : v4,
            purchase_cap  : v5,
            status        : v6,
            fee           : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg6);
        assert!(v3 == arg6, 4);
        assert!(v4 == arg4, 4);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == v2, 3);
        assert!(0x2::kiosk::has_item(arg2, arg4), 5);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        assert!(0x2::kiosk::has_access(arg7, arg8), 9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg11) >= v7, 7);
        0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg11));
        0x2::object::delete(v0);
        let (v8, v9) = 0x2::kiosk::new(arg14);
        let v10 = v9;
        let v11 = v8;
        let (v12, v13) = 0x2::kiosk::purchase_with_cap<T0>(arg5, v5, 0x2::coin::zero<0x2::sui::SUI>(arg14));
        let v14 = v13;
        0x2::kiosk::lock<T0>(&mut v11, &v10, arg9, v12);
        if (0x2::coin::value<0x2::sui::SUI>(&arg12) > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg9, &mut v14, arg12);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg12);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v14, &v11);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg9, v14);
        let (v18, v19) = 0x2::kiosk::purchase_with_cap<T1>(arg2, 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg14), 0x2::coin::zero<0x2::sui::SUI>(arg14));
        let v20 = v19;
        0x2::kiosk::lock<T1>(arg7, arg8, arg10, v18);
        if (0x2::coin::value<0x2::sui::SUI>(&arg13) > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T1>(arg10, &mut v20, arg13);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg13);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T1>(&mut v20, arg7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T1>(arg10, v20);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v11);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v11, v10, arg14), arg14);
        let v24 = SwapCompleted{
            offerer      : 0x2::tx_context::sender(arg14),
            receiver     : v1,
            offered_nft  : arg4,
            received_nft : arg6,
        };
        0x2::event::emit<SwapCompleted>(v24);
        let v25 = SwapCompleted{
            offerer      : v1,
            receiver     : 0x2::tx_context::sender(arg14),
            offered_nft  : arg6,
            received_nft : arg4,
        };
        0x2::event::emit<SwapCompleted>(v25);
    }

    public entry fun create_and_share_kiosk_auctionhouse_store(arg0: &0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Auctionhouse_Store>(create_kiosk_auctionhouse(arg0, arg1));
    }

    public fun create_kiosk_auctionhouse(arg0: &0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Auctionhouse_Store {
        Kiosk_Auctionhouse_Store{
            id            : 0x2::object::new(arg1),
            auction_house : 0x2::object::id<0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse>(arg0),
            orphaned_caps : 0x2::object::new(arg1),
        }
    }

    public fun create_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 5);
        assert!(0x2::kiosk::has_access(arg1, arg2), 9);
        let v2 = SwapOffer<T0, T1>{
            id            : 0x2::object::new(arg6),
            offerer       : v0,
            offered_kiosk : v1,
            offered_nft   : arg3,
            requested_nft : arg4,
            purchase_cap  : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg6),
            status        : 0,
            fee           : arg5,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg3, v2);
        let v3 = SwapOfferCreated{
            offerer       : v0,
            offered_kiosk : v1,
            offered_nft   : arg3,
            requested_nft : arg4,
            fee           : arg5,
        };
        0x2::event::emit<SwapOfferCreated>(v3);
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

    public entry fun emergency_reset_accept_offer<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 8);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptOffer<T0>>(&arg0.id, arg2)) {
            let AcceptOffer {
                id              : v0,
                receiver        : _,
                kiosk_id        : _,
                nft_id          : _,
                original_nft_id : _,
                purchase_cap    : v5,
                status          : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, AcceptOffer<T0>>(&mut arg0.id, arg2);
            0x2::object::delete(v0);
            store_orphaned_cap<T0>(arg0, v5, arg2, true, arg3);
        };
    }

    public entry fun emergency_reset_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 8);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg2)) {
            let SwapOffer {
                id            : v0,
                offerer       : _,
                offered_kiosk : _,
                offered_nft   : _,
                requested_nft : _,
                purchase_cap  : v5,
                status        : _,
                fee           : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg2);
            0x2::object::delete(v0);
            store_orphaned_cap<T0>(arg0, v5, arg2, true, arg3);
        };
    }

    public fun get_offer_fee<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1).fee
    }

    public fun offer_exists<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1)
    }

    public entry fun recover_orphaned_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::is_admin(arg1, v0) || 0x2::kiosk::owner(arg2) == v0, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 1);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, OrphanedPurchaseCap<T0>>(&arg0.orphaned_caps, arg4)) {
            let OrphanedPurchaseCap {
                id  : v1,
                cap : v2,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_caps, arg4);
            0x2::object::delete(v1);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v2);
        };
    }

    public fun store_orphaned_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = OrphanedPurchaseCap<T0>{
            id  : 0x2::object::new(arg4),
            cap : arg1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_caps, arg2, v0);
        let v1 = PurchaseCapOrphaned{
            nft_id           : arg2,
            emergency_action : arg3,
        };
        0x2::event::emit<PurchaseCapOrphaned>(v1);
    }

    // decompiled from Move bytecode v6
}

