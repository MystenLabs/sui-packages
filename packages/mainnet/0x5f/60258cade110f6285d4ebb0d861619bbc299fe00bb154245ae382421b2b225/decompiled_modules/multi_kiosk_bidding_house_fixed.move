module 0x5f60258cade110f6285d4ebb0d861619bbc299fe00bb154245ae382421b2b225::multi_kiosk_bidding_house_fixed {
    struct Multi_Kiosk_Auctionhouse has store, key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        nft_to_bundled_nft: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        bundled_nft_to_bundle: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Bundle<phantom T0> has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        status: u8,
        fee_bps: u16,
        expires_at_ms: u64,
        coin_type: 0x1::type_name::TypeName,
        buyer: 0x1::option::Option<address>,
        bundled_nfts: vector<0x2::object::ID>,
        created_at_ms: u64,
        nfts_being_cancelled: vector<0x2::object::ID>,
    }

    struct BundledNft<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        bundle_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        display_value: u64,
    }

    struct NftDetail has copy, drop {
        nft_id: 0x2::object::ID,
        bundled_nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        display_value: u64,
    }

    struct BundleSummary has copy, drop {
        seller: address,
        price: u64,
        status: u8,
        nft_count: u64,
        remaining_ms: u64,
        is_expired: bool,
        fee_bps: u64,
    }

    struct BundleCreated has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        price: u64,
        coin_type: 0x1::type_name::TypeName,
        expires_at_ms: u64,
        duration_hours: u64,
        duration_days: u64,
        fee_bps: u16,
    }

    struct NftAdded has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        bundled_nft_id: 0x2::object::ID,
        display_value: u64,
        total_nfts: u64,
    }

    struct BundleSold has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        coin_type: 0x1::type_name::TypeName,
        fee_amount: u64,
        seller_amount: u64,
    }

    struct NftClaimed has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        bundled_nft_id: 0x2::object::ID,
        buyer: address,
    }

    struct BundleCancelled has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        nfts_count: u64,
        was_expired: bool,
        timestamp_ms: u64,
    }

    struct NftReturnedToSeller has copy, drop {
        bundle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        bundled_nft_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct StateValidationPassed has copy, drop {
        bundle_id: 0x2::object::ID,
        table_entries: u64,
        vector_entries: u64,
        timestamp_ms: u64,
    }

    public fun add_nft<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1), 4);
        assert!(0x2::kiosk::has_item(arg2, arg4), 10);
        assert!(0x2::kiosk::has_access(arg2, arg3), 11);
        assert!(0x2::kiosk::owner(arg2) == 0x2::tx_context::sender(arg7), 20);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundled_nft, arg4), 10);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1);
        let v1 = 0x1::vector::length<0x2::object::ID>(&v0.bundled_nfts);
        assert!(v0.seller == 0x2::tx_context::sender(arg7), 3);
        assert!(v0.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg6) <= v0.expires_at_ms, 5);
        assert!(v1 < 10, 7);
        let v2 = BundledNft<T0>{
            id            : 0x2::object::new(arg7),
            bundle_id     : arg1,
            kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id        : arg4,
            purchase_cap  : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, 0, arg7),
            display_value : arg5,
        };
        let v3 = 0x2::object::id<BundledNft<T0>>(&v2);
        0x2::dynamic_object_field::add<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, v3, v2);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_to_bundled_nft, arg4, v3);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.bundled_nft_to_bundle, v3, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T1>>(&mut arg0.id, arg1).bundled_nfts, v3);
        let v4 = NftAdded{
            bundle_id      : arg1,
            nft_id         : arg4,
            bundled_nft_id : v3,
            display_value  : arg5,
            total_nfts     : v1 + 1,
        };
        0x2::event::emit<NftAdded>(v4);
        validate_bundle_state<T1>(arg0, arg1, 0x2::clock::timestamp_ms(arg6));
    }

    public entry fun batch_remove_all_nfts<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_all_nft_ids_in_bundle<T0, T1>(arg0, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            remove_nft_from_bundle<T0, T1>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&v0, v1), arg2, arg3, arg4);
            v1 = v1 + 1;
        };
        cancel_bundle<T1>(arg0, arg1, arg3, arg4);
    }

    public fun bundle_exists<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1)
    }

    public fun buy_bundle<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: &mut 0x5f60258cade110f6285d4ebb0d861619bbc299fe00bb154245ae382421b2b225::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T0>>(&arg0.id, arg2), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T0>>(&mut arg0.id, arg2);
        assert!(v0.coin_type == 0x1::type_name::get<T0>(), 12);
        assert!(v0.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg4) <= v0.expires_at_ms, 5);
        assert!(v0.seller != 0x2::tx_context::sender(arg5), 8);
        assert!(0x2::coin::value<T0>(&arg3) >= v0.price, 9);
        v0.status = 1;
        v0.buyer = 0x1::option::some<address>(0x2::tx_context::sender(arg5));
        let v1 = v0.seller;
        let v2 = v0.price;
        let v3 = v2 * (v0.fee_bps as u64) / 10000;
        let v4 = v2 - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v4, arg5), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg5), 0x5f60258cade110f6285d4ebb0d861619bbc299fe00bb154245ae382421b2b225::auctionhouse::get_owner(arg1));
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        let v5 = BundleSold{
            bundle_id     : arg2,
            seller        : v1,
            buyer         : 0x2::tx_context::sender(arg5),
            price         : v2,
            coin_type     : 0x1::type_name::get<T0>(),
            fee_amount    : v3,
            seller_amount : v4,
        };
        0x2::event::emit<BundleSold>(v5);
    }

    public fun can_batch_cancel<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) : bool {
        if (!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1)) {
            return false
        };
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        if (v0.seller == arg2) {
            if (v0.status == 0) {
                0x1::vector::length<0x2::object::ID>(&v0.bundled_nfts) > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun can_batch_claim<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: address) : bool {
        if (!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1)) {
            return false
        };
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        if (v0.status == 1) {
            if (0x1::option::contains<address>(&v0.buyer, &arg2)) {
                0x1::vector::length<0x2::object::ID>(&v0.bundled_nfts) > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun cancel_bundle<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1), 4);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        let v3 = 0x1::vector::length<0x2::object::ID>(&v2.bundled_nfts);
        assert!(v0 == v2.seller, 16);
        assert!(v2.status == 0, 2);
        assert!(v3 == 0, 25);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T0>>(&mut arg0.id, arg1).status = 2;
        let v4 = BundleCancelled{
            bundle_id    : arg1,
            seller       : v0,
            nfts_count   : v3,
            was_expired  : v1 > v2.expires_at_ms,
            timestamp_ms : v1,
        };
        0x2::event::emit<BundleCancelled>(v4);
    }

    public entry fun cancel_bundle_entry<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        cancel_bundle<T0>(arg0, arg1, arg2, arg3);
    }

    public fun claim_nft<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1);
        assert!(v0.status == 1, 2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0x1::option::contains<address>(&v0.buyer, &v1), 6);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundled_nft, arg2), 18);
        let v2 = *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundled_nft, arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.bundled_nft_to_bundle, v2), 24);
        assert!(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.bundled_nft_to_bundle, v2) == arg1, 24);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, BundledNft<T0>>(&arg0.id, v2), 24);
        let (v3, _) = 0x1::vector::index_of<0x2::object::ID>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1).bundled_nfts, &v2);
        assert!(v3, 24);
        let BundledNft {
            id            : v5,
            bundle_id     : _,
            kiosk_id      : _,
            nft_id        : _,
            purchase_cap  : v9,
            display_value : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, v2);
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_to_bundled_nft, arg2);
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.bundled_nft_to_bundle, v2);
        let v11 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T1>>(&mut arg0.id, arg1);
        let (v12, v13) = 0x1::vector::index_of<0x2::object::ID>(&v11.bundled_nfts, &v2);
        assert!(v12, 24);
        0x1::vector::remove<0x2::object::ID>(&mut v11.bundled_nfts, v13);
        0x2::object::delete(v5);
        let (v14, v15) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v9, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v16 = NftClaimed{
            bundle_id      : arg1,
            nft_id         : arg2,
            bundled_nft_id : v2,
            buyer          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<NftClaimed>(v16);
        (v14, v15)
    }

    public entry fun claim_nft_to_new_kiosk<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg6);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = claim_nft<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        let v6 = v5;
        0x2::kiosk::lock<T0>(&mut v3, &v2, arg4, v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v6, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg6), arg6);
    }

    public fun create_bundle_days<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: u64, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_bundle_with_duration<T0>(arg0, arg1, arg2, days_to_ms(arg3), arg4, arg5)
    }

    public fun create_bundle_hours<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: u64, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_bundle_with_duration<T0>(arg0, arg1, arg2, hours_to_ms(arg3), arg4, arg5)
    }

    public fun create_bundle_with_duration<T0>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: u64, arg2: u16, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 > 0, 1);
        assert!(arg2 <= 1000, 21);
        validate_duration(arg3);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = safe_add_u64(v2, arg3);
        let v4 = Bundle<T0>{
            id                   : v0,
            seller               : 0x2::tx_context::sender(arg5),
            price                : arg1,
            status               : 0,
            fee_bps              : arg2,
            expires_at_ms        : v3,
            coin_type            : 0x1::type_name::get<T0>(),
            buyer                : 0x1::option::none<address>(),
            bundled_nfts         : 0x1::vector::empty<0x2::object::ID>(),
            created_at_ms        : v2,
            nfts_being_cancelled : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Bundle<T0>>(&mut arg0.id, v1, v4);
        let v5 = BundleCreated{
            bundle_id      : v1,
            seller         : 0x2::tx_context::sender(arg5),
            price          : arg1,
            coin_type      : 0x1::type_name::get<T0>(),
            expires_at_ms  : v3,
            duration_hours : arg3 / 3600000,
            duration_days  : arg3 / 86400000,
            fee_bps        : arg2,
        };
        0x2::event::emit<BundleCreated>(v5);
        v1
    }

    public entry fun create_shared_store(arg0: &0x5f60258cade110f6285d4ebb0d861619bbc299fe00bb154245ae382421b2b225::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Multi_Kiosk_Auctionhouse>(create_store(arg0, arg1));
    }

    public fun create_store(arg0: &0x5f60258cade110f6285d4ebb0d861619bbc299fe00bb154245ae382421b2b225::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Multi_Kiosk_Auctionhouse {
        assert!(0x5f60258cade110f6285d4ebb0d861619bbc299fe00bb154245ae382421b2b225::auctionhouse::is_admin(arg0, 0x2::tx_context::sender(arg1)), 999);
        Multi_Kiosk_Auctionhouse{
            id                    : 0x2::object::new(arg1),
            auction_house         : 0x2::object::id<0x5f60258cade110f6285d4ebb0d861619bbc299fe00bb154245ae382421b2b225::auctionhouse::AuctionHouse>(arg0),
            nft_to_bundled_nft    : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            bundled_nft_to_bundle : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
        }
    }

    public fun days_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 86400000);
        validate_duration(v0);
        v0
    }

    public fun get_all_bundled_nft_ids<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1).bundled_nfts
    }

    public fun get_all_nft_ids_in_bundle<T0: store + key, T1>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0.bundled_nfts)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0.bundled_nfts, v2);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, BundledNft<T0>>(&arg0.id, v3)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::dynamic_object_field::borrow<0x2::object::ID, BundledNft<T0>>(&arg0.id, v3).nft_id);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_bundle_info<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : (address, u64, u8, u64, 0x1::type_name::TypeName, 0x1::option::Option<address>) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        (v0.seller, v0.price, v0.status, v0.expires_at_ms, v0.coin_type, v0.buyer)
    }

    public fun get_bundle_info_with_time<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u8, u64, 0x1::type_name::TypeName, u64, bool) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        (v0.price, v0.status, 0x1::vector::length<0x2::object::ID>(&v0.bundled_nfts), v0.coin_type, get_remaining_time_ms<T0>(arg0, arg1, arg2), 0x2::clock::timestamp_ms(arg2) > v0.expires_at_ms)
    }

    public fun get_bundle_nft_details<T0: store + key, T1>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : vector<NftDetail> {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1);
        let v1 = 0x1::vector::empty<NftDetail>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0.bundled_nfts)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0.bundled_nfts, v2);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, BundledNft<T0>>(&arg0.id, v3)) {
                let v4 = 0x2::dynamic_object_field::borrow<0x2::object::ID, BundledNft<T0>>(&arg0.id, v3);
                let v5 = NftDetail{
                    nft_id         : v4.nft_id,
                    bundled_nft_id : v3,
                    kiosk_id       : v4.kiosk_id,
                    display_value  : v4.display_value,
                };
                0x1::vector::push_back<NftDetail>(&mut v1, v5);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_bundle_summary<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : BundleSummary {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        BundleSummary{
            seller       : v0.seller,
            price        : v0.price,
            status       : v0.status,
            nft_count    : 0x1::vector::length<0x2::object::ID>(&v0.bundled_nfts),
            remaining_ms : get_remaining_time_ms<T0>(arg0, arg1, arg2),
            is_expired   : 0x2::clock::timestamp_ms(arg2) > v0.expires_at_ms,
            fee_bps      : (v0.fee_bps as u64),
        }
    }

    public fun get_bundled_nft_id(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundled_nft, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundled_nft, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_max_duration_days() : u64 {
        31536000000 / 86400000
    }

    public fun get_max_duration_ms() : u64 {
        31536000000
    }

    public fun get_min_duration_hours() : u64 {
        3600000 / 3600000
    }

    public fun get_min_duration_ms() : u64 {
        3600000
    }

    public fun get_nft_bundle_id(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundled_nft, arg1)) {
            let v1 = *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundled_nft, arg1);
            if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.bundled_nft_to_bundle, v1)) {
                0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.bundled_nft_to_bundle, v1))
            } else {
                0x1::option::none<0x2::object::ID>()
            }
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_remaining_bundled_nfts<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1).bundled_nfts
    }

    public fun get_remaining_time_ms<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 >= v0.expires_at_ms) {
            0
        } else {
            v0.expires_at_ms - v1
        }
    }

    public fun hours_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 3600000);
        validate_duration(v0);
        v0
    }

    public fun is_bundle_expired<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg2) > 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1).expires_at_ms
    }

    public fun is_valid_duration(arg0: u64) : bool {
        arg0 >= 3600000 && arg0 <= 31536000000
    }

    public fun minutes_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 60000);
        validate_duration(v0);
        v0
    }

    public fun remove_nft_from_bundle<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1), 4);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundled_nft, arg2), 18);
        let v2 = *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.nft_to_bundled_nft, arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.bundled_nft_to_bundle, v2), 24);
        assert!(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.bundled_nft_to_bundle, v2) == arg1, 24);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, BundledNft<T0>>(&arg0.id, v2), 24);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1);
        assert!(v0 == v3.seller, 16);
        assert!(v3.status == 0, 2);
        let (v4, _) = 0x1::vector::index_of<0x2::object::ID>(&v3.bundled_nfts, &v2);
        assert!(v4, 24);
        let (v6, v7) = 0x1::vector::index_of<0x2::object::ID>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T1>>(&arg0.id, arg1).bundled_nfts, &v2);
        assert!(v6, 24);
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_to_bundled_nft, arg2);
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.bundled_nft_to_bundle, v2);
        0x1::vector::remove<0x2::object::ID>(&mut 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bundle<T1>>(&mut arg0.id, arg1).bundled_nfts, v7);
        let BundledNft {
            id            : v8,
            bundle_id     : _,
            kiosk_id      : v10,
            nft_id        : _,
            purchase_cap  : v12,
            display_value : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, BundledNft<T0>>(&mut arg0.id, v2);
        0x2::kiosk::return_purchase_cap<T0>(arg3, v12);
        0x2::object::delete(v8);
        let v14 = NftReturnedToSeller{
            bundle_id      : arg1,
            nft_id         : arg2,
            bundled_nft_id : v2,
            seller         : v0,
            kiosk_id       : v10,
            timestamp_ms   : v1,
        };
        0x2::event::emit<NftReturnedToSeller>(v14);
        validate_bundle_state<T1>(arg0, arg1, v1);
    }

    public entry fun remove_nft_from_bundle_entry<T0: store + key, T1>(arg0: &mut Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        remove_nft_from_bundle<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 19);
        arg0 + arg1
    }

    fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 19);
        arg0 * arg1
    }

    fun validate_bundle_state<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Bundle<T0>>(&arg0.id, arg1);
        let v1 = 0x1::vector::length<0x2::object::ID>(&v0.bundled_nfts);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0.bundled_nfts, v2);
            assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, v3), 26);
            assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.bundled_nft_to_bundle, v3), 26);
            assert!(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.bundled_nft_to_bundle, v3) == arg1, 26);
            v2 = v2 + 1;
        };
        let v4 = StateValidationPassed{
            bundle_id      : arg1,
            table_entries  : 0x2::table::length<0x2::object::ID, 0x2::object::ID>(&arg0.bundled_nft_to_bundle),
            vector_entries : v1,
            timestamp_ms   : arg2,
        };
        0x2::event::emit<StateValidationPassed>(v4);
    }

    public entry fun validate_bundle_state_entry<T0>(arg0: &Multi_Kiosk_Auctionhouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        validate_bundle_state<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun validate_duration(arg0: u64) {
        assert!(arg0 >= 3600000, 14);
        assert!(arg0 <= 31536000000, 15);
    }

    public fun weeks_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 604800000);
        validate_duration(v0);
        v0
    }

    // decompiled from Move bytecode v6
}

