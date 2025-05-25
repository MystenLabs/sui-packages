module 0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::kiosk_auctionhouse {
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
        fee_bps: u16,
        fee_coin_type: 0x1::type_name::TypeName,
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
        fee_bps: u16,
        fee_coin_type: 0x1::type_name::TypeName,
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
        fee_paid: u64,
        fee_coin_type: 0x1::type_name::TypeName,
    }

    struct NftClaimed has copy, drop {
        swap_id: 0x2::object::ID,
        claimer: address,
        nft_id: 0x2::object::ID,
        claimed_at_ms: u64,
    }

    public fun accept_swap_offer<T0: store + key, T1: store + key, T2>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &0x2::transfer_policy::TransferPolicy<T0>, arg10: 0x2::coin::Coin<T2>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::coin::Coin<T2>) {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg6), 5);
        assert!(0x2::object::id<0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        let SwapOffer {
            id            : v2,
            offerer       : v3,
            offered_kiosk : v4,
            offered_nft   : _,
            requested_nft : v6,
            purchase_cap  : v7,
            status        : v8,
            fee_bps       : v9,
            fee_coin_type : v10,
            expires_at_ms : v11,
            created_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg6);
        let v13 = v2;
        assert!(v0 != v3, 13);
        assert!(v8 == 0, 2);
        assert!(v1 <= v11, 10);
        assert!(arg4 == v6, 4);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == v4, 3);
        assert!(v10 == 0x1::type_name::get<T2>(), 15);
        assert!(0x2::kiosk::has_item(arg2, arg4), 4);
        assert!(0x2::kiosk::owner(arg2) == v0, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 7);
        assert!(0x2::kiosk::has_access(arg7, arg8), 7);
        0x2::object::delete(v13);
        let v14 = if (v9 > 0) {
            1000000 * (v9 as u64) / 10000
        } else {
            0
        };
        let v15 = if (v14 > 0) {
            assert!(0x2::coin::value<T2>(&arg10) >= v14, 6);
            if (0x2::coin::value<T2>(&arg10) > v14) {
                if (0x1::type_name::get<T2>() == 0x1::type_name::get<0x2::sui::SUI>()) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut arg10, v14, arg12)), arg12), 0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::get_owner(arg1));
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut arg10, v14, arg12), 0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::get_owner(arg1));
                };
                arg10
            } else {
                if (0x1::type_name::get<T2>() == 0x1::type_name::get<0x2::sui::SUI>()) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::coin::into_balance<T2>(arg10), arg12), 0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::get_owner(arg1));
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg10, 0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::get_owner(arg1));
                };
                0x2::coin::zero<T2>(arg12)
            }
        } else {
            arg10
        };
        let (v16, v17) = 0x2::kiosk::purchase_with_cap<T0>(arg5, v7, 0x2::coin::zero<0x2::sui::SUI>(arg12));
        let v18 = CompletedSwap<T1>{
            id               : 0x2::object::new(arg12),
            original_offerer : v3,
            received_nft_id  : arg4,
            purchase_cap     : 0x2::kiosk::list_with_purchase_cap<T1>(arg2, arg3, arg4, 0, arg12),
            completed_at_ms  : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, CompletedSwap<T1>>(&mut arg0.id, 0x2::object::id<CompletedSwap<T1>>(&v18), v18);
        0x2::kiosk::lock<T0>(arg7, arg8, arg9, v16);
        let v19 = SwapCompleted{
            swap_id       : 0x2::object::uid_to_inner(&v13),
            offerer       : v3,
            accepter      : v0,
            offered_nft   : arg6,
            received_nft  : arg4,
            fee_paid      : v14,
            fee_coin_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<SwapCompleted>(v19);
        (v17, v15)
    }

    public entry fun accept_swap_offer_with_new_kiosk<T0: store + key, T1: store + key, T2>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::AuctionHouse, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg11);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let (v5, v6) = accept_swap_offer<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4, &v2, arg7, arg8, arg10, arg11);
        let v7 = v6;
        let v8 = v5;
        if (0x2::coin::value<T2>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, 0x2::tx_context::sender(arg11));
        } else {
            0x2::coin::destroy_zero<T2>(v7);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg7, &mut v8, arg9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v8, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg7, v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg11), arg11);
    }

    public fun cancel_swap_offer<T0: store + key, T1: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg2), 5);
        let SwapOffer {
            id            : v0,
            offerer       : v1,
            offered_kiosk : v2,
            offered_nft   : _,
            requested_nft : v4,
            purchase_cap  : v5,
            status        : v6,
            fee_bps       : _,
            fee_coin_type : _,
            expires_at_ms : v9,
            created_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg2);
        let v11 = v0;
        assert!(0x2::tx_context::sender(arg4) == v1, 1);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 3);
        0x2::object::delete(v11);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
        let v12 = SwapOfferCancelled{
            swap_id       : 0x2::object::uid_to_inner(&v11),
            offerer       : v1,
            offered_nft   : arg2,
            requested_nft : v4,
            was_expired   : 0x2::clock::timestamp_ms(arg3) > v9,
        };
        0x2::event::emit<SwapOfferCancelled>(v12);
    }

    public fun claim_received_nft<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedSwap<T0>>(&arg0.id, arg1), 5);
        let CompletedSwap {
            id               : v1,
            original_offerer : v2,
            received_nft_id  : v3,
            purchase_cap     : v4,
            completed_at_ms  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, CompletedSwap<T0>>(&mut arg0.id, arg1);
        assert!(v0 == v2, 1);
        assert!(0x2::kiosk::owner(arg2) == v0, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 7);
        0x2::object::delete(v1);
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v8 = NftClaimed{
            swap_id       : arg1,
            claimer       : v0,
            nft_id        : v3,
            claimed_at_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<NftClaimed>(v8);
        (v6, v7)
    }

    public entry fun claim_received_nft_to_new_kiosk<T0: store + key>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let (v5, v6) = claim_received_nft<T0>(arg0, arg1, v4, &v2, arg2, arg4, arg5);
        let v7 = v6;
        0x2::kiosk::lock<T0>(&mut v3, &v2, arg2, v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v7, arg3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v7, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg5), arg5);
    }

    public entry fun create_and_share_kiosk_auctionhouse_store(arg0: &0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Auctionhouse_Store>(create_kiosk_auctionhouse(arg0, arg1));
    }

    public fun create_kiosk_auctionhouse(arg0: &0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Auctionhouse_Store {
        assert!(0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::is_admin(arg0, 0x2::tx_context::sender(arg1)), 1);
        Kiosk_Auctionhouse_Store{
            id            : 0x2::object::new(arg1),
            auction_house : 0x2::object::id<0x22842583da32b3db7cb127aaaa91087d71d5d54e98b0e1cd287cb8b21a64c7ce::auctionhouse::AuctionHouse>(arg0),
        }
    }

    public entry fun create_personal_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg0), arg0);
    }

    public fun create_swap_offer_days<T0: store + key, T1: store + key, T2>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u16, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_swap_offer_with_duration<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, days_to_ms(arg6), arg7, arg8);
    }

    public fun create_swap_offer_hours<T0: store + key, T1: store + key, T2>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u16, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_swap_offer_with_duration<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, hours_to_ms(arg6), arg7, arg8);
    }

    public fun create_swap_offer_with_duration<T0: store + key, T1: store + key, T2>(arg0: &mut Kiosk_Auctionhouse_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u16, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg5 <= 1000, 8);
        validate_duration(arg6);
        assert!(arg3 != arg4, 13);
        assert!(!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg3), 9);
        assert!(0x2::kiosk::has_item(arg1, arg3), 4);
        assert!(0x2::kiosk::owner(arg1) == v0, 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 7);
        let v2 = v1 + arg6;
        let v3 = SwapOffer<T0, T1>{
            id            : 0x2::object::new(arg8),
            offerer       : v0,
            offered_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offered_nft   : arg3,
            requested_nft : arg4,
            purchase_cap  : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg8),
            status        : 0,
            fee_bps       : arg5,
            fee_coin_type : 0x1::type_name::get<T2>(),
            expires_at_ms : v2,
            created_at_ms : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg3, v3);
        let v4 = SwapOfferCreated{
            swap_id        : 0x2::object::id<SwapOffer<T0, T1>>(&v3),
            offerer        : v0,
            offered_kiosk  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offered_nft    : arg3,
            requested_nft  : arg4,
            fee_bps        : arg5,
            fee_coin_type  : 0x1::type_name::get<T2>(),
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

    public fun get_duration_limits() : (u64, u64, u64, u64) {
        (3600000, 2592000000, get_min_duration_hours(), get_max_duration_days())
    }

    public fun get_max_duration_days() : u64 {
        2592000000 / 86400000
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

    public fun get_swap_expiration_info<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64, u64, bool) {
        let v0 = get_remaining_time_ms<T0, T1>(arg0, arg1, arg2);
        (v0, v0 / 3600000, v0 / 86400000, v0 == 0)
    }

    public fun get_swap_info_with_time<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (address, 0x2::object::ID, u16, 0x1::type_name::TypeName, u64, bool) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1);
        (v0.offerer, v0.requested_nft, v0.fee_bps, v0.fee_coin_type, get_remaining_time_ms<T0, T1>(arg0, arg1, arg2), 0x2::clock::timestamp_ms(arg2) > v0.expires_at_ms)
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
        arg0 >= 3600000 && arg0 <= 2592000000
    }

    public fun minutes_to_ms(arg0: u64) : u64 {
        let v0 = arg0 * 60000;
        validate_duration(v0);
        v0
    }

    public fun swap_offer_exists<T0: store + key, T1: store + key>(arg0: &Kiosk_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1)
    }

    public fun validate_duration(arg0: u64) {
        assert!(arg0 >= 3600000, 11);
        assert!(arg0 <= 2592000000, 12);
    }

    // decompiled from Move bytecode v6
}

