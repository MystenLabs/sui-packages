module 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::kiosk_auctionhouse {
    struct Kiosk_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
    }

    struct SwapOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
        fee_amount_sui: u64,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    struct CompletedSwap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        original_offerer: address,
        received_nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        completed_at_ms: u64,
    }

    struct SwapOfferCreated has copy, drop {
        swap_id: 0x2::object::ID,
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        fee_amount_sui: u64,
        expires_at_ms: u64,
        duration_hours: u64,
    }

    struct SwapOfferCancelled has copy, drop {
        swap_id: 0x2::object::ID,
        offerer: address,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        was_expired: bool,
    }

    struct SwapCompleted has copy, drop {
        swap_id: 0x2::object::ID,
        offerer: address,
        accepter: address,
        offered_nft: 0x2::object::ID,
        received_nft: 0x2::object::ID,
        fee_paid_sui: u64,
    }

    struct NftClaimed has copy, drop {
        swap_id: 0x2::object::ID,
        claimer: address,
        nft_id: 0x2::object::ID,
        claimed_at_ms: u64,
    }

    public fun accept_swap_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &0x2::transfer_policy::TransferPolicy<T0>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg6), 5);
        assert!(0x2::object::id<0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        let SwapOffer {
            id             : v2,
            offerer        : v3,
            offered_kiosk  : v4,
            offered_nft    : _,
            requested_nft  : v6,
            purchase_cap   : v7,
            status         : v8,
            fee_amount_sui : v9,
            expires_at_ms  : v10,
            created_at_ms  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg6);
        let v12 = v2;
        assert!(v0 != v3, 14);
        assert!(v8 == 0, 2);
        assert!(v1 <= v10, 11);
        assert!(arg4 == v6, 4);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == v4, 3);
        assert!(0x2::kiosk::has_item(arg2, arg4), 4);
        assert!(0x2::kiosk::owner(arg2) == v0, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 7);
        assert!(0x2::kiosk::has_access(arg7, arg8), 7);
        0x2::object::delete(v12);
        let v13 = if (v9 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg10) >= v9, 6);
            if (0x2::coin::value<0x2::sui::SUI>(&arg10) > v9) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg10, v9, arg12), 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::get_owner(arg1));
                arg10
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg10, 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::get_owner(arg1));
                0x2::coin::zero<0x2::sui::SUI>(arg12)
            }
        } else {
            arg10
        };
        let (v14, v15) = 0x2::kiosk::purchase_with_cap<T0>(arg5, v7, 0x2::coin::zero<0x2::sui::SUI>(arg12));
        let v16 = CompletedSwap<T1>{
            id               : 0x2::object::new(arg12),
            original_offerer : v3,
            received_nft_id  : arg4,
            purchase_cap     : 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg12),
            completed_at_ms  : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, CompletedSwap<T1>>(&mut arg0.id, 0x2::object::id<CompletedSwap<T1>>(&v16), v16);
        0x2::kiosk::lock<T0>(arg7, arg8, arg9, v14);
        let v17 = SwapCompleted{
            swap_id      : 0x2::object::uid_to_inner(&v12),
            offerer      : v3,
            accepter     : v0,
            offered_nft  : arg6,
            received_nft : arg4,
            fee_paid_sui : v9,
        };
        0x2::event::emit<SwapCompleted>(v17);
        (v15, v13)
    }

    public fun accept_swap_offer_external<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg6), 5);
        assert!(0x2::object::id<0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        let SwapOffer {
            id             : v2,
            offerer        : v3,
            offered_kiosk  : v4,
            offered_nft    : _,
            requested_nft  : v6,
            purchase_cap   : v7,
            status         : v8,
            fee_amount_sui : v9,
            expires_at_ms  : v10,
            created_at_ms  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg6);
        let v12 = v2;
        assert!(v0 != v3, 14);
        assert!(v8 == 0, 2);
        assert!(v1 <= v10, 11);
        assert!(arg4 == v6, 4);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == v4, 3);
        assert!(0x2::kiosk::has_item(arg2, arg4), 4);
        assert!(0x2::kiosk::owner(arg2) == v0, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 7);
        0x2::object::delete(v12);
        let v13 = if (v9 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) >= v9, 6);
            if (0x2::coin::value<0x2::sui::SUI>(&arg8) > v9) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg8, v9, arg10), 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::get_owner(arg1));
                arg8
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg8, 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::get_owner(arg1));
                0x2::coin::zero<0x2::sui::SUI>(arg10)
            }
        } else {
            arg8
        };
        let (v14, v15) = 0x2::kiosk::purchase_with_cap<T0>(arg5, v7, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        let v16 = CompletedSwap<T1>{
            id               : 0x2::object::new(arg10),
            original_offerer : v3,
            received_nft_id  : arg4,
            purchase_cap     : 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg10),
            completed_at_ms  : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, CompletedSwap<T1>>(&mut arg0.id, 0x2::object::id<CompletedSwap<T1>>(&v16), v16);
        let v17 = SwapCompleted{
            swap_id      : 0x2::object::uid_to_inner(&v12),
            offerer      : v3,
            accepter     : v0,
            offered_nft  : arg6,
            received_nft : arg4,
            fee_paid_sui : v9,
        };
        0x2::event::emit<SwapCompleted>(v17);
        (v14, v15, v13)
    }

    public entry fun accept_swap_offer_with_new_kiosk<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg11);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let (v5, v6) = accept_swap_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4, &v2, arg7, arg8, arg10, arg11);
        let v7 = v6;
        let v8 = v5;
        if (0x2::coin::value<0x2::sui::SUI>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, 0x2::tx_context::sender(arg11));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg7, &mut v8, arg9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v8, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg7, v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg11), arg11);
    }

    public fun batch_check_swaps_expired<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            0x1::vector::push_back<bool>(&mut v0, is_swap_expired<T0, T1>(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1), arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun cancel_swap_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg2), 5);
        let SwapOffer {
            id             : v0,
            offerer        : v1,
            offered_kiosk  : v2,
            offered_nft    : _,
            requested_nft  : v4,
            purchase_cap   : v5,
            status         : v6,
            fee_amount_sui : _,
            expires_at_ms  : v8,
            created_at_ms  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg2);
        let v10 = v0;
        assert!(0x2::tx_context::sender(arg4) == v1, 1);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 3);
        0x2::object::delete(v10);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
        let v11 = SwapOfferCancelled{
            swap_id       : 0x2::object::uid_to_inner(&v10),
            offerer       : v1,
            offered_nft   : arg2,
            requested_nft : v4,
            was_expired   : 0x2::clock::timestamp_ms(arg3) > v8,
        };
        0x2::event::emit<SwapOfferCancelled>(v11);
    }

    public entry fun cancel_swap_offer_entry<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        cancel_swap_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun claim_received_nft<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedSwap<T0>>(&arg0.id, arg1), 5);
        let CompletedSwap {
            id               : v1,
            original_offerer : v2,
            received_nft_id  : v3,
            purchase_cap     : v4,
            completed_at_ms  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, CompletedSwap<T0>>(&mut arg0.id, arg1);
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

    public fun claim_received_nft_internal<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedSwap<T0>>(&arg0.id, arg1), 5);
        let CompletedSwap {
            id               : v1,
            original_offerer : v2,
            received_nft_id  : v3,
            purchase_cap     : v4,
            completed_at_ms  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, CompletedSwap<T0>>(&mut arg0.id, arg1);
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

    public entry fun claim_received_nft_to_new_kiosk<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = claim_received_nft_internal<T0>(arg0, arg1, arg2, v4, &v2, arg3, arg5, arg6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v5, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg6), arg6);
    }

    public fun completed_swap_exists<T0: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedSwap<T0>>(&arg0.id, arg1)
    }

    public entry fun create_and_share_kiosk_auctionhouse_store(arg0: &0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Auctionhouse_Store>(create_kiosk_auctionhouse(arg0, arg1));
    }

    public fun create_kiosk_auctionhouse(arg0: &0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Auctionhouse_Store {
        assert!(0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::is_admin(arg0, 0x2::tx_context::sender(arg1)), 1);
        Kiosk_Auctionhouse_Store{
            id            : 0x2::object::new(arg1),
            auction_house : 0x2::object::id<0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse::AuctionHouse>(arg0),
        }
    }

    public entry fun create_personal_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg0), arg0);
    }

    public fun create_swap_offer_days<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_swap_offer_with_duration<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, days_to_ms(arg6), arg7, arg8);
    }

    public entry fun create_swap_offer_days_entry<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_swap_offer_days<T0, T1>(arg0, arg1, arg2, arg3, arg4, sui_to_mist(arg5), arg6, arg7, arg8);
    }

    public fun create_swap_offer_hours<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_swap_offer_with_duration<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, hours_to_ms(arg6), arg7, arg8);
    }

    public entry fun create_swap_offer_hours_entry<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_swap_offer_hours<T0, T1>(arg0, arg1, arg2, arg3, arg4, sui_to_mist(arg5), arg6, arg7, arg8);
    }

    public fun create_swap_offer_with_duration<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        validate_fee_amount(arg5);
        validate_duration(arg6);
        assert!(arg3 != arg4, 14);
        assert!(!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg3), 10);
        assert!(0x2::kiosk::has_item(arg1, arg3), 4);
        assert!(0x2::kiosk::owner(arg1) == v0, 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 7);
        let v2 = v1 + arg6;
        let v3 = SwapOffer<T0, T1>{
            id             : 0x2::object::new(arg8),
            offerer        : v0,
            offered_kiosk  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offered_nft    : arg3,
            requested_nft  : arg4,
            purchase_cap   : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg8),
            status         : 0,
            fee_amount_sui : arg5,
            expires_at_ms  : v2,
            created_at_ms  : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg3, v3);
        let v4 = SwapOfferCreated{
            swap_id        : 0x2::object::id<SwapOffer<T0, T1>>(&v3),
            offerer        : v0,
            offered_kiosk  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offered_nft    : arg3,
            requested_nft  : arg4,
            fee_amount_sui : arg5,
            expires_at_ms  : v2,
            duration_hours : arg6 / 3600000,
        };
        0x2::event::emit<SwapOfferCreated>(v4);
    }

    public fun days_to_ms(arg0: u64) : u64 {
        let v0 = arg0 * 86400000;
        validate_duration(v0);
        v0
    }

    public fun get_auction_house_id(arg0: &Kiosk_Auctionhouse_Store) : 0x2::object::ID {
        arg0.auction_house
    }

    public fun get_completed_swap_info<T0: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : (address, 0x2::object::ID, u64) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedSwap<T0>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, CompletedSwap<T0>>(&arg0.id, arg1);
        (v0.original_offerer, v0.received_nft_id, v0.completed_at_ms)
    }

    public fun get_fee_info() : (u64, u64, u64, u64) {
        (100000000, 1000000000000, mist_to_sui(100000000), mist_to_sui(1000000000000))
    }

    public fun get_fee_limits_sui() : (u64, u64) {
        (mist_to_sui(100000000), mist_to_sui(1000000000000))
    }

    public fun get_limits() : (u64, u64, u64, u64, u64, u64) {
        (3600000, 31536000000, get_min_duration_hours(), get_max_duration_days(), mist_to_sui(100000000), mist_to_sui(1000000000000))
    }

    public fun get_max_duration_days() : u64 {
        31536000000 / 86400000
    }

    public fun get_min_duration_hours() : u64 {
        3600000 / 3600000
    }

    public fun get_remaining_hours<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        get_remaining_time_ms<T0, T1>(arg0, arg1, arg2) / 3600000
    }

    public fun get_remaining_time_ms<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1)) {
            return 0
        };
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 >= v0.expires_at_ms) {
            0
        } else {
            v0.expires_at_ms - v1
        }
    }

    public fun get_swap_basic_info<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : (address, 0x2::object::ID, u64, u64, u64) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1);
        (v0.offerer, v0.requested_nft, v0.fee_amount_sui, v0.expires_at_ms, v0.created_at_ms)
    }

    public fun get_swap_expiration_info<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64, u64, bool) {
        let v0 = get_remaining_time_ms<T0, T1>(arg0, arg1, arg2);
        (v0, v0 / 3600000, v0 / 86400000, v0 == 0)
    }

    public fun get_swap_info_with_time<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (address, 0x2::object::ID, u64, u64, bool) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1);
        (v0.offerer, v0.requested_nft, v0.fee_amount_sui, get_remaining_time_ms<T0, T1>(arg0, arg1, arg2), 0x2::clock::timestamp_ms(arg2) > v0.expires_at_ms)
    }

    public fun get_swap_type_names<T0: store + key, T1: store + key>() : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (0x1::type_name::get<T0>(), 0x1::type_name::get<T1>())
    }

    public fun hours_to_ms(arg0: u64) : u64 {
        let v0 = arg0 * 3600000;
        validate_duration(v0);
        v0
    }

    public fun is_swap_expired<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1)) {
            return false
        };
        0x2::clock::timestamp_ms(arg2) > 0x2::dynamic_object_field::borrow<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1).expires_at_ms
    }

    public fun is_valid_duration(arg0: u64) : bool {
        arg0 >= 3600000 && arg0 <= 31536000000
    }

    public fun is_valid_fee(arg0: u64) : bool {
        arg0 == 0 || arg0 >= 100000000 && arg0 <= 1000000000000
    }

    public fun minutes_to_ms(arg0: u64) : u64 {
        let v0 = arg0 * 60000;
        validate_duration(v0);
        v0
    }

    public fun mist_to_sui(arg0: u64) : u64 {
        arg0 / 1000000000
    }

    public fun sui_to_mist(arg0: u64) : u64 {
        arg0 * 1000000000
    }

    public fun swap_offer_exists<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1)
    }

    public fun validate_duration(arg0: u64) {
        assert!(arg0 >= 3600000, 12);
        assert!(arg0 <= 31536000000, 13);
    }

    public fun validate_fee_amount(arg0: u64) {
        if (arg0 > 0) {
            assert!(arg0 >= 100000000, 9);
            assert!(arg0 <= 1000000000000, 8);
        };
    }

    // decompiled from Move bytecode v6
}

