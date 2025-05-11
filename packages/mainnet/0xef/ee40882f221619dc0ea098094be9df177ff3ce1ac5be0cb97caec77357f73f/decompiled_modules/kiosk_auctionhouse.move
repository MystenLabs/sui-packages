module 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::kiosk_auctionhouse {
    struct Kiosk_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        orphaned_swap_caps: 0x2::object::UID,
        orphaned_accept_caps: 0x2::object::UID,
        swap_offers: 0x2::object::UID,
        accept_offers: 0x2::object::UID,
    }

    struct SwapOfferKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        type_marker: vector<u8>,
    }

    struct AcceptOfferKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        type_marker: vector<u8>,
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
    }

    struct KioskAuctionhouseStoreCreated has copy, drop {
        creator: address,
        auction_house_id: 0x2::object::ID,
        timestamp: u64,
    }

    public entry fun accept_kiosk_nft_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
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

    public fun accept_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: 0x2::object::ID, arg9: &0x2::transfer_policy::TransferPolicy<T0>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::epoch(arg11);
        let v1 = create_swap_offer_key<T0, T1>(arg8);
        let v2 = create_accept_offer_key<T1>(arg4);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey>(&arg0.swap_offers, v1), 6);
        assert!(!0x2::dynamic_object_field::exists_<AcceptOfferKey>(&arg0.accept_offers, v2), 12);
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
        } = 0x2::dynamic_object_field::remove<SwapOfferKey, SwapOffer<T0, T1>>(&mut arg0.swap_offers, v1);
        assert!(v0 <= v12, 14);
        assert!(v6 == arg8, 4);
        assert!(v9 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == v5, 3);
        assert!(0x2::kiosk::has_item(arg2, arg4), 5);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        assert!(0x2::kiosk::has_access(arg6, arg7), 9);
        let v13 = 0x2::coin::value<0x2::sui::SUI>(&arg10);
        assert!(v13 >= v10, 7);
        let v14 = if (v13 > v10 && v10 > 0) {
            0x2::coin::split<0x2::sui::SUI>(&mut arg10, v13 - v10, arg11)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg11)
        };
        0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg10));
        0x2::object::delete(v3);
        0x2::tx_context::sender(arg11);
        let v15 = AcceptOffer<T1>{
            id              : 0x2::object::new(arg11),
            receiver        : v4,
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : arg4,
            original_nft_id : arg8,
            purchase_cap    : 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg11),
            status          : 0,
            created_at      : v0,
            expires_at      : v0 + 604800,
        };
        0x2::dynamic_object_field::add<AcceptOfferKey, AcceptOffer<T1>>(&mut arg0.accept_offers, v2, v15);
        let (v16, v17) = 0x2::kiosk::purchase_with_cap<T0>(arg5, v8, 0x2::coin::zero<0x2::sui::SUI>(arg11));
        0x2::kiosk::lock<T0>(arg6, arg7, arg9, v16);
        let v18 = ClaimOffer{
            receiver          : 0x2::tx_context::sender(arg11),
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg6),
            sender            : v4,
            sender_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            nft_id            : arg8,
            fee_paid          : v10,
            timestamp         : v0,
        };
        0x2::event::emit<ClaimOffer>(v18);
        (v17, v14)
    }

    public fun accept_offer_exists<T0: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<AcceptOfferKey>(&arg0.accept_offers, create_accept_offer_key<T0>(arg1))
    }

    public fun cancel_kiosk_nft_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_swap_offer_key<T0, T1>(arg2);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey>(&arg0.swap_offers, v0), 6);
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
        } = 0x2::dynamic_object_field::remove<SwapOfferKey, SwapOffer<T0, T1>>(&mut arg0.swap_offers, v0);
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
        let v1 = create_accept_offer_key<T0>(arg4);
        assert!(0x2::dynamic_object_field::exists_<AcceptOfferKey>(&arg0.accept_offers, v1), 6);
        let AcceptOffer {
            id              : v2,
            receiver        : v3,
            kiosk_id        : v4,
            nft_id          : v5,
            original_nft_id : v6,
            purchase_cap    : v7,
            status          : v8,
            created_at      : _,
            expires_at      : v10,
        } = 0x2::dynamic_object_field::remove<AcceptOfferKey, AcceptOffer<T0>>(&mut arg0.accept_offers, v1);
        assert!(v0 <= v10, 14);
        assert!(0x2::tx_context::sender(arg6) == v3, 1);
        assert!(v8 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v4, 3);
        assert!(0x2::kiosk::has_access(arg2, arg3), 9);
        0x2::object::delete(v2);
        let (v11, v12) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v7, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v11);
        let v13 = SwapCompleted{
            offerer      : 0x2::tx_context::sender(arg6),
            receiver     : v3,
            offered_nft  : v5,
            received_nft : v6,
            timestamp    : v0,
        };
        0x2::event::emit<SwapCompleted>(v13);
        v12
    }

    fun create_accept_offer_key<T0: store + key>(arg0: 0x2::object::ID) : AcceptOfferKey {
        AcceptOfferKey{
            nft_id      : arg0,
            type_marker : b"AcceptOffer_T",
        }
    }

    public entry fun create_and_share_kiosk_auctionhouse_store(arg0: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Auctionhouse_Store>(create_kiosk_auctionhouse(arg0, arg1));
    }

    public fun create_kiosk_auctionhouse(arg0: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Auctionhouse_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg0, v0), 8);
        let v1 = Kiosk_Auctionhouse_Store{
            id                   : 0x2::object::new(arg1),
            auction_house        : 0x2::object::id<0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse>(arg0),
            orphaned_swap_caps   : 0x2::object::new(arg1),
            orphaned_accept_caps : 0x2::object::new(arg1),
            swap_offers          : 0x2::object::new(arg1),
            accept_offers        : 0x2::object::new(arg1),
        };
        let v2 = KioskAuctionhouseStoreCreated{
            creator          : v0,
            auction_house_id : 0x2::object::id<0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse>(arg0),
            timestamp        : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<KioskAuctionhouseStoreCreated>(v2);
        v1
    }

    public fun create_kiosk_nft_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = 0x2::tx_context::epoch(arg7);
        let v3 = if (arg6 == 0) {
            v2 + 604800
        } else {
            v2 + arg6
        };
        let v4 = create_swap_offer_key<T0, T1>(arg3);
        assert!(!0x2::dynamic_object_field::exists_<SwapOfferKey>(&arg0.swap_offers, v4), 12);
        assert!(0x2::kiosk::has_item(arg1, arg3), 5);
        assert!(0x2::kiosk::has_access(arg1, arg2), 9);
        assert!(arg5 <= 100000000000000, 10);
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
        0x2::dynamic_object_field::add<SwapOfferKey, SwapOffer<T0, T1>>(&mut arg0.swap_offers, v4, v5);
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

    fun create_swap_offer_key<T0: store + key, T1: store + key>(arg0: 0x2::object::ID) : SwapOfferKey {
        SwapOfferKey{
            nft_id      : arg0,
            type_marker : b"SwapOffer_T1_T2",
        }
    }

    public entry fun emergency_reset_accept_offer<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 8);
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = create_accept_offer_key<T0>(arg2);
        if (0x2::dynamic_object_field::exists_<AcceptOfferKey>(&arg0.accept_offers, v1)) {
            let AcceptOffer {
                id              : v2,
                receiver        : _,
                kiosk_id        : v4,
                nft_id          : _,
                original_nft_id : _,
                purchase_cap    : v7,
                status          : _,
                created_at      : _,
                expires_at      : _,
            } = 0x2::dynamic_object_field::remove<AcceptOfferKey, AcceptOffer<T0>>(&mut arg0.accept_offers, v1);
            0x2::object::delete(v2);
            store_orphaned_accept_cap<T0>(arg0, v7, arg2, v4, true, arg3);
            let v11 = PurchaseCapOrphaned{
                nft_id           : arg2,
                kiosk_id         : v4,
                cap_type         : 1,
                emergency_action : true,
                timestamp        : v0,
            };
            0x2::event::emit<PurchaseCapOrphaned>(v11);
        };
    }

    public entry fun emergency_reset_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 8);
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = create_swap_offer_key<T0, T1>(arg2);
        if (0x2::dynamic_object_field::exists_<SwapOfferKey>(&arg0.swap_offers, v1)) {
            let SwapOffer {
                id            : v2,
                offerer       : _,
                offered_kiosk : v4,
                offered_nft   : _,
                requested_nft : _,
                purchase_cap  : v7,
                status        : _,
                fee           : _,
                created_at    : _,
                expires_at    : _,
            } = 0x2::dynamic_object_field::remove<SwapOfferKey, SwapOffer<T0, T1>>(&mut arg0.swap_offers, v1);
            0x2::object::delete(v2);
            store_orphaned_swap_cap<T0>(arg0, v7, arg2, v4, true, arg3);
            let v12 = PurchaseCapOrphaned{
                nft_id           : arg2,
                kiosk_id         : v4,
                cap_type         : 0,
                emergency_action : true,
                timestamp        : v0,
            };
            0x2::event::emit<PurchaseCapOrphaned>(v12);
        };
    }

    public fun get_auction_house_id(arg0: &Kiosk_Auctionhouse_Store) : 0x2::object::ID {
        arg0.auction_house
    }

    public fun get_offer_expiration<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_swap_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey>(&arg0.swap_offers, v0), 6);
        0x2::dynamic_object_field::borrow<SwapOfferKey, SwapOffer<T0, T1>>(&arg0.swap_offers, v0).expires_at
    }

    public fun get_offer_fee<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_swap_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<SwapOfferKey>(&arg0.swap_offers, v0), 6);
        0x2::dynamic_object_field::borrow<SwapOfferKey, SwapOffer<T0, T1>>(&arg0.swap_offers, v0).fee
    }

    public fun is_offer_expired<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = create_swap_offer_key<T0, T1>(arg1);
        if (!0x2::dynamic_object_field::exists_<SwapOfferKey>(&arg0.swap_offers, v0)) {
            return false
        };
        arg2 > 0x2::dynamic_object_field::borrow<SwapOfferKey, SwapOffer<T0, T1>>(&arg0.swap_offers, v0).expires_at
    }

    public fun offer_exists<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<SwapOfferKey>(&arg0.swap_offers, create_swap_offer_key<T0, T1>(arg1))
    }

    public fun orphaned_accept_cap_exists<T0: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.orphaned_accept_caps, create_orphaned_cap_key(arg1, 1))
    }

    public fun orphaned_swap_cap_exists<T0: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.orphaned_swap_caps, create_orphaned_cap_key(arg1, 0))
    }

    public entry fun recover_orphaned_accept_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 1;
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg1, v1) || 0x2::kiosk::owner(arg2) == v1, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 1);
        let v2 = create_orphaned_cap_key(arg4, v0);
        if (0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.orphaned_accept_caps, v2)) {
            let OrphanedPurchaseCap {
                id                : v3,
                cap               : v4,
                orphaned_at       : _,
                original_kiosk_id : v6,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_accept_caps, v2);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v6, 13);
            0x2::object::delete(v3);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v4);
            let v7 = OrphanedCapRecovered{
                nft_id    : arg4,
                kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                cap_type  : v0,
                recoverer : v1,
                timestamp : 0x2::tx_context::epoch(arg5),
            };
            0x2::event::emit<OrphanedCapRecovered>(v7);
        };
    }

    public entry fun recover_orphaned_swap_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg1, v1) || 0x2::kiosk::owner(arg2) == v1, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 1);
        let v2 = create_orphaned_cap_key(arg4, v0);
        if (0x2::dynamic_object_field::exists_<OrphanedCapKey>(&arg0.orphaned_swap_caps, v2)) {
            let OrphanedPurchaseCap {
                id                : v3,
                cap               : v4,
                orphaned_at       : _,
                original_kiosk_id : v6,
            } = 0x2::dynamic_object_field::remove<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_swap_caps, v2);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v6, 13);
            0x2::object::delete(v3);
            0x2::kiosk::return_purchase_cap<T0>(arg2, v4);
            let v7 = OrphanedCapRecovered{
                nft_id    : arg4,
                kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                cap_type  : v0,
                recoverer : v1,
                timestamp : 0x2::tx_context::epoch(arg5),
            };
            0x2::event::emit<OrphanedCapRecovered>(v7);
        };
    }

    public fun store_orphaned_accept_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        let v1 = 1;
        let v2 = OrphanedPurchaseCap<T0>{
            id                : 0x2::object::new(arg5),
            cap               : arg1,
            orphaned_at       : v0,
            original_kiosk_id : arg3,
        };
        0x2::dynamic_object_field::add<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_accept_caps, create_orphaned_cap_key(arg2, v1), v2);
        let v3 = PurchaseCapOrphaned{
            nft_id           : arg2,
            kiosk_id         : arg3,
            cap_type         : v1,
            emergency_action : arg4,
            timestamp        : v0,
        };
        0x2::event::emit<PurchaseCapOrphaned>(v3);
    }

    public fun store_orphaned_swap_cap<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        let v1 = 0;
        let v2 = OrphanedPurchaseCap<T0>{
            id                : 0x2::object::new(arg5),
            cap               : arg1,
            orphaned_at       : v0,
            original_kiosk_id : arg3,
        };
        0x2::dynamic_object_field::add<OrphanedCapKey, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_swap_caps, create_orphaned_cap_key(arg2, v1), v2);
        let v3 = PurchaseCapOrphaned{
            nft_id           : arg2,
            kiosk_id         : arg3,
            cap_type         : v1,
            emergency_action : arg4,
            timestamp        : v0,
        };
        0x2::event::emit<PurchaseCapOrphaned>(v3);
    }

    // decompiled from Move bytecode v6
}

