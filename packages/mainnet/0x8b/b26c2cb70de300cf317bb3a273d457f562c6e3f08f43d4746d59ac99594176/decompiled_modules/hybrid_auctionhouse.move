module 0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::hybrid_auctionhouse {
    struct Hybrid_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        marketplace: 0x2::object::ID,
        orphaned_caps: 0x2::object::UID,
    }

    struct OrphanedPurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct NftEscrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: T0,
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
    }

    struct DirectForKioskOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_kiosk: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        status: u8,
        fee: u64,
    }

    struct KioskNftCounterOffer<T0: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        policy_id: 0x2::object::ID,
        status: u8,
    }

    struct PurchaseCapOrphaned has copy, drop {
        nft_id: 0x2::object::ID,
        emergency_action: bool,
    }

    struct KioskForDirectOfferCreated has copy, drop {
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee: u64,
    }

    struct DirectForKioskOfferCreated has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_kiosk: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee: u64,
    }

    struct KioskForDirectOfferCancelled has copy, drop {
        offerer: address,
        offered_nft: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee: u64,
    }

    struct DirectForKioskOfferCancelled has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
    }

    struct KioskForDirectOfferAccepted has copy, drop {
        receiver: address,
        sender: address,
        offered_nft: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
    }

    struct DirectForKioskOfferAccepted has copy, drop {
        receiver: address,
        receiver_kiosk_id: 0x2::object::ID,
        sender: address,
        offered_nft_id: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
    }

    struct KioskNftClaimed<phantom T0: store + key> has copy, drop {
        claimer: address,
        offer_id: 0x2::object::ID,
        original_nft_id: 0x2::object::ID,
    }

    public fun accept_direct_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T1>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.id, arg5), 6);
        let DirectForKioskOffer {
            id               : v0,
            offerer          : v1,
            offered_nft_id   : v2,
            requested_kiosk  : v3,
            requested_nft_id : v4,
            status           : v5,
            fee              : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&mut arg0.id, arg5);
        let v7 = v0;
        assert!(v5 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v3, 3);
        assert!(arg4 == v4, 4);
        assert!(arg5 == v2, 4);
        assert!(0x2::kiosk::has_item(arg2, arg4), 5);
        assert!(0x2::kiosk::has_access(arg2, arg3), 12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= v6, 9);
        0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg7));
        let v8 = 0x2::object::uid_to_inner(&v7);
        let NftEscrow {
            id  : v9,
            nft : v10,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, v8);
        let v11 = KioskNftCounterOffer<T1>{
            id              : 0x2::object::new(arg8),
            offerer         : v1,
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : arg4,
            original_nft_id : arg5,
            purchase_cap    : 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg8),
            policy_id       : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T1>>(arg6),
            status          : 0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, KioskNftCounterOffer<T1>>(&mut arg0.id, v8, v11);
        0x2::object::delete(v7);
        0x2::object::delete(v9);
        let v12 = DirectForKioskOfferAccepted{
            receiver          : 0x2::tx_context::sender(arg8),
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            sender            : v1,
            offered_nft_id    : v2,
            received_nft_id   : arg4,
            fee_paid          : v6,
        };
        0x2::event::emit<DirectForKioskOfferAccepted>(v12);
        v10
    }

    public entry fun accept_direct_for_kiosk_offer_entry<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T1>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = accept_direct_for_kiosk_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun accept_kiosk_for_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: T1, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.id, arg5), 6);
        let KioskForDirectOffer {
            id               : v0,
            offerer          : v1,
            offered_kiosk    : v2,
            offered_nft      : v3,
            requested_nft_id : v4,
            purchase_cap     : v5,
            status           : v6,
            fee              : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&mut arg0.id, arg5);
        assert!(v3 == arg5, 4);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v2, 3);
        assert!(0x2::object::id<T1>(&arg6) == v4, 4);
        assert!(0x2::kiosk::has_access(arg3, arg4), 12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) >= v7, 9);
        0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
        0x2::object::delete(v0);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v5, 0x2::coin::zero<0x2::sui::SUI>(arg9));
        0x2::kiosk::lock<T0>(arg3, arg4, arg7, v8);
        0x2::transfer::public_transfer<T1>(arg6, v1);
        let v10 = KioskForDirectOfferAccepted{
            receiver        : 0x2::tx_context::sender(arg9),
            sender          : v1,
            offered_nft     : arg5,
            received_nft_id : v4,
            fee_paid        : v7,
        };
        0x2::event::emit<KioskForDirectOfferAccepted>(v10);
        v9
    }

    public entry fun accept_kiosk_for_direct_offer_create_kiosk<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: T1, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = accept_kiosk_for_direct_offer<T0, T1>(arg0, arg1, arg2, v4, &v2, arg3, arg4, arg5, arg6, arg8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v5, arg7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg8), arg8);
    }

    public fun cancel_direct_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.id, arg1), 6);
        let DirectForKioskOffer {
            id               : v0,
            offerer          : v1,
            offered_nft_id   : v2,
            requested_kiosk  : _,
            requested_nft_id : v4,
            status           : v5,
            fee              : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&mut arg0.id, arg1);
        let v7 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1, 1);
        assert!(v5 == 0, 2);
        let NftEscrow {
            id  : v8,
            nft : v9,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, 0x2::object::uid_to_inner(&v7));
        0x2::object::delete(v7);
        0x2::object::delete(v8);
        let v10 = DirectForKioskOfferCancelled{
            offerer          : v1,
            offered_nft_id   : v2,
            requested_nft_id : v4,
        };
        0x2::event::emit<DirectForKioskOfferCancelled>(v10);
        v9
    }

    public fun cancel_kiosk_for_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.id, arg2), 6);
        let KioskForDirectOffer {
            id               : v0,
            offerer          : v1,
            offered_kiosk    : v2,
            offered_nft      : _,
            requested_nft_id : v4,
            purchase_cap     : v5,
            status           : v6,
            fee              : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&mut arg0.id, arg2);
        assert!(0x2::tx_context::sender(arg3) == v1, 1);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 3);
        0x2::object::delete(v0);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
        let v8 = KioskForDirectOfferCancelled{
            offerer          : v1,
            offered_nft      : arg2,
            requested_nft_id : v4,
            fee              : v7,
        };
        0x2::event::emit<KioskForDirectOfferCancelled>(v8);
    }

    public fun claim_kiosk_nft<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskNftCounterOffer<T0>>(&arg0.id, arg1), 13);
        let KioskNftCounterOffer {
            id              : v0,
            offerer         : v1,
            kiosk_id        : v2,
            nft_id          : _,
            original_nft_id : v4,
            purchase_cap    : v5,
            policy_id       : v6,
            status          : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KioskNftCounterOffer<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg6) == v1, 14);
        assert!(v7 == 0, 2);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg5) == v6, 15);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v2, 3);
        assert!(0x2::kiosk::has_access(arg3, arg4), 12);
        0x2::object::delete(v0);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v5, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg3, arg4, arg5, v8);
        let v10 = KioskNftClaimed<T0>{
            claimer         : v1,
            offer_id        : arg1,
            original_nft_id : v4,
        };
        0x2::event::emit<KioskNftClaimed<T0>>(v10);
        v9
    }

    public entry fun claim_kiosk_nft_create_kiosk<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = claim_kiosk_nft<T0>(arg0, arg1, arg2, v4, &v2, arg3, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v5, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg5), arg5);
    }

    public fun crate_hybrid_auctionhouse(arg0: &0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Hybrid_Auctionhouse_Store {
        assert!(0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::is_admin(arg0, 0x2::tx_context::sender(arg1)), 11);
        Hybrid_Auctionhouse_Store{
            id            : 0x2::object::new(arg1),
            marketplace   : 0x2::object::id<0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse>(arg0),
            orphaned_caps : 0x2::object::new(arg1),
        }
    }

    public entry fun create_and_share_hybrid_auctionhouse_store(arg0: &0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Hybrid_Auctionhouse_Store>(crate_hybrid_auctionhouse(arg0, arg1));
    }

    public fun create_direct_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::object::new(arg5);
        let v3 = DirectForKioskOffer<T0, T1>{
            id               : v2,
            offerer          : v0,
            offered_nft_id   : v1,
            requested_kiosk  : arg2,
            requested_nft_id : arg3,
            status           : 0,
            fee              : arg4,
        };
        let v4 = NftEscrow<T0>{
            id  : 0x2::object::new(arg5),
            nft : arg1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&mut arg0.id, v1, v3);
        0x2::dynamic_object_field::add<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, 0x2::object::uid_to_inner(&v2), v4);
        let v5 = DirectForKioskOfferCreated{
            offerer          : v0,
            offered_nft_id   : v1,
            requested_kiosk  : arg2,
            requested_nft_id : arg3,
            fee              : arg4,
        };
        0x2::event::emit<DirectForKioskOfferCreated>(v5);
    }

    public fun create_kiosk_for_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 5);
        assert!(0x2::kiosk::has_access(arg1, arg2), 12);
        let v2 = KioskForDirectOffer<T0, T1>{
            id               : 0x2::object::new(arg6),
            offerer          : v0,
            offered_kiosk    : v1,
            offered_nft      : arg3,
            requested_nft_id : arg4,
            purchase_cap     : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg6),
            status           : 0,
            fee              : arg5,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&mut arg0.id, arg3, v2);
        let v3 = KioskForDirectOfferCreated{
            offerer          : v0,
            offered_kiosk    : v1,
            offered_nft      : arg3,
            requested_nft_id : arg4,
            fee              : arg5,
        };
        0x2::event::emit<KioskForDirectOfferCreated>(v3);
    }

    public fun direct_for_kiosk_offer_exists<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.id, arg1)
    }

    public entry fun emergency_reset_direct_for_kiosk_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 11);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.id, arg2)) {
            let DirectForKioskOffer {
                id               : v0,
                offerer          : v1,
                offered_nft_id   : _,
                requested_kiosk  : _,
                requested_nft_id : _,
                status           : _,
                fee              : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&mut arg0.id, arg2);
            let v7 = v0;
            let v8 = 0x2::object::uid_to_inner(&v7);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftEscrow<T0>>(&arg0.id, v8)) {
                let NftEscrow {
                    id  : v9,
                    nft : v10,
                } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, v8);
                0x2::object::delete(v9);
                0x2::transfer::public_transfer<T0>(v10, v1);
            };
            0x2::object::delete(v7);
        };
    }

    public entry fun emergency_reset_kiosk_for_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 11);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.id, arg2)) {
            let KioskForDirectOffer {
                id               : v0,
                offerer          : _,
                offered_kiosk    : _,
                offered_nft      : _,
                requested_nft_id : _,
                purchase_cap     : v5,
                status           : _,
                fee              : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&mut arg0.id, arg2);
            0x2::object::delete(v0);
            store_orphaned_cap<T0>(arg0, v5, arg2, true, arg3);
        };
    }

    public fun get_direct_for_kiosk_offer_fee<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, DirectForKioskOffer<T0, T1>>(&arg0.id, arg1).fee
    }

    public fun get_kiosk_for_direct_offer_fee<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.id, arg1).fee
    }

    public fun kiosk_for_direct_offer_exists<T0: store + key, T1: store + key>(arg0: &Hybrid_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, KioskForDirectOffer<T0, T1>>(&arg0.id, arg1)
    }

    public entry fun recover_orphaned_cap<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: &0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x8bb26c2cb70de300cf317bb3a273d457f562c6e3f08f43d4746d59ac99594176::auctionhouse::is_admin(arg1, v0) || 0x2::kiosk::owner(arg2) == v0, 1);
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

    public fun store_orphaned_cap<T0: store + key>(arg0: &mut Hybrid_Auctionhouse_Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
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

