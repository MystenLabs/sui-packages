module 0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::kiosk_nft_offers {
    struct Kiosk_Offers_Store has key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        royalty_registry: 0x2::table::Table<0x1::string::String, CollectionRoyalty>,
        global_fee_bps: u16,
        total_offers: u64,
        active_offers: u64,
    }

    struct CollectionRoyalty has copy, drop, store {
        collection_owner: address,
        royalty_bps: u16,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct NftOffer<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        nft_owner: address,
        nft_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        offer_amount: 0x2::balance::Balance<T1>,
        status: u8,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    struct CompletedOffer<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        offer_id: 0x2::object::ID,
        offerer: address,
        nft_owner: address,
        nft_id: 0x2::object::ID,
        final_amount: u64,
        completed_at_ms: u64,
    }

    struct OffersStoreCreated has copy, drop {
        store_id: 0x2::object::ID,
        auction_house: 0x2::object::ID,
        creator: address,
        global_fee_bps: u16,
    }

    struct RoyaltyAdded has copy, drop {
        collection_type: 0x1::string::String,
        collection_owner: address,
        royalty_bps: u16,
        auction_house_owner: address,
        timestamp_ms: u64,
    }

    struct RoyaltyUpdated has copy, drop {
        collection_type: 0x1::string::String,
        old_owner: address,
        new_owner: address,
        old_royalty_bps: u16,
        new_royalty_bps: u16,
        auction_house_owner: address,
        timestamp_ms: u64,
    }

    struct RoyaltyRemoved has copy, drop {
        collection_type: 0x1::string::String,
        collection_owner: address,
        royalty_bps: u16,
        auction_house_owner: address,
        timestamp_ms: u64,
    }

    struct CustomRoyaltyPaid has copy, drop {
        offer_id: 0x2::object::ID,
        collection_type: 0x1::string::String,
        collection_owner: address,
        royalty_amount: u64,
        royalty_bps: u16,
        sale_price: u64,
        timestamp_ms: u64,
    }

    struct NftOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        nft_owner: address,
        nft_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        offer_amount: u64,
        expires_at_ms: u64,
        duration_hours: u64,
    }

    struct OfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        nft_owner: address,
        nft_id: 0x2::object::ID,
        final_amount: u64,
        fee_amount: u64,
        royalty_amount: u64,
        timestamp_ms: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        nft_id: 0x2::object::ID,
        refund_amount: u64,
        timestamp_ms: u64,
    }

    struct OfferExpired has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        nft_id: 0x2::object::ID,
        refund_amount: u64,
        timestamp_ms: u64,
    }

    struct GlobalFeeUpdated has copy, drop {
        old_fee_bps: u16,
        new_fee_bps: u16,
        auction_house_owner: address,
        timestamp_ms: u64,
    }

    struct NftTransferredToNewKiosk has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        nft_id: 0x2::object::ID,
        new_kiosk_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun get_owner(arg0: &0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse) : address {
        0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::get_owner(arg0)
    }

    public fun accept_nft_offer<T0: store + key, T1>(arg0: &mut Kiosk_Offers_Store, arg1: &mut 0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x2::object::id<0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftOffer<T0, T1>>(&arg0.id, arg2), 5);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftOffer<T0, T1>>(&arg0.id, arg2);
        assert!(v2.status == 0, 2);
        assert!(!is_offer_expired(v2.expires_at_ms, arg7), 10);
        assert!(0x2::kiosk::has_item(arg3, v2.nft_id), 4);
        assert!(0x2::kiosk::has_access(arg3, arg4), 7);
        let v3 = v2.offerer;
        let v4 = v2.nft_id;
        let v5 = 0x2::balance::value<T1>(&v2.offer_amount);
        let v6 = get_collection_type<T0>();
        let (v7, v8, v9) = if (0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v6)) {
            let v10 = 0x2::table::borrow<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v6);
            (true, calculate_royalty(v5, v10.royalty_bps), v10.collection_owner)
        } else {
            (false, 0, @0x0)
        };
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftOffer<T0, T1>>(&mut arg0.id, arg2).status = 1;
        let NftOffer {
            id            : v11,
            offerer       : _,
            nft_owner     : _,
            nft_kiosk_id  : _,
            nft_id        : _,
            offer_amount  : v16,
            status        : _,
            expires_at_ms : _,
            created_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftOffer<T0, T1>>(&mut arg0.id, arg2);
        let v20 = v16;
        let v21 = calculate_fee(0x2::balance::value<T1>(&v20), arg0.global_fee_bps);
        let v22 = if (v7 && v8 > 0) {
            0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v20, v8), arg8)
        } else {
            0x2::coin::zero<T1>(arg8)
        };
        let (v23, v24) = 0x2::kiosk::purchase_with_cap<T0>(arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg3, arg4, v4, 0, arg8), 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v25 = v24;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v25, arg6);
        let (v26, v27) = 0x2::kiosk::new(arg8);
        let v28 = v27;
        let v29 = v26;
        0x2::kiosk::lock<T0>(&mut v29, &v28, arg5, v23);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v25, &v29);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v25);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v29);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v28, v3);
        let v33 = CompletedOffer<T0, T1>{
            id              : 0x2::object::new(arg8),
            offer_id        : arg2,
            offerer         : v3,
            nft_owner       : v0,
            nft_id          : v4,
            final_amount    : v5,
            completed_at_ms : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, CompletedOffer<T0, T1>>(&mut arg0.id, 0x2::object::id<CompletedOffer<T0, T1>>(&v33), v33);
        arg0.active_offers = arg0.active_offers - 1;
        0x2::object::delete(v11);
        if (v7 && v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v22, v9);
            let v34 = CustomRoyaltyPaid{
                offer_id         : arg2,
                collection_type  : v6,
                collection_owner : v9,
                royalty_amount   : v8,
                royalty_bps      : 0x2::table::borrow<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v6).royalty_bps,
                sale_price       : v5,
                timestamp_ms     : v1,
            };
            0x2::event::emit<CustomRoyaltyPaid>(v34);
        } else {
            0x2::coin::destroy_zero<T1>(v22);
        };
        let v35 = OfferAccepted{
            offer_id       : arg2,
            offerer        : v3,
            nft_owner      : v0,
            nft_id         : v4,
            final_amount   : v5,
            fee_amount     : v21,
            royalty_amount : v8,
            timestamp_ms   : v1,
        };
        0x2::event::emit<OfferAccepted>(v35);
        let v36 = NftTransferredToNewKiosk{
            offer_id     : arg2,
            offerer      : v3,
            nft_id       : v4,
            new_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v29),
            timestamp_ms : v1,
        };
        0x2::event::emit<NftTransferredToNewKiosk>(v36);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v20, v21), arg8), get_owner(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v20, arg8), v0);
    }

    public entry fun accept_offer_entry<T0: store + key, T1>(arg0: &mut Kiosk_Offers_Store, arg1: &mut 0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        accept_nft_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun add_collection_royalty<T0: store + key>(arg0: &mut Kiosk_Offers_Store, arg1: &0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse, arg2: address, arg3: u16, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::object::id<0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(get_owner(arg1) == v0, 1);
        validate_royalty_bps(arg3);
        let v2 = get_collection_type<T0>();
        assert!(!0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v2), 26);
        let v3 = CollectionRoyalty{
            collection_owner : arg2,
            royalty_bps      : arg3,
            created_at_ms    : v1,
            updated_at_ms    : v1,
        };
        0x2::table::add<0x1::string::String, CollectionRoyalty>(&mut arg0.royalty_registry, v2, v3);
        let v4 = RoyaltyAdded{
            collection_type     : v2,
            collection_owner    : arg2,
            royalty_bps         : arg3,
            auction_house_owner : v0,
            timestamp_ms        : v1,
        };
        0x2::event::emit<RoyaltyAdded>(v4);
    }

    public fun bps_to_percentage(arg0: u16) : (u64, u64) {
        ((arg0 as u64) / 100, (arg0 as u64) % 100)
    }

    public fun calculate_fee(arg0: u64, arg1: u16) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 100000000000000000, 23);
        assert!(arg1 <= 1000, 24);
        safe_div_u64(safe_mul_u64(arg0, (arg1 as u64)), 10000)
    }

    public fun calculate_offer_breakdown<T0: store + key>(arg0: &Kiosk_Offers_Store, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = calculate_fee(arg1, arg0.global_fee_bps);
        let v1 = get_collection_type<T0>();
        let v2 = if (0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v1)) {
            calculate_royalty(arg1, 0x2::table::borrow<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v1).royalty_bps)
        } else {
            0
        };
        let v3 = v0 + v2;
        (v0, v2, v3, arg1 - v3)
    }

    public fun calculate_royalty(arg0: u64, arg1: u16) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 100000000000000000, 23);
        assert!(arg1 <= 2500, 28);
        safe_div_u64(safe_mul_u64(arg0, (arg1 as u64)), 10000)
    }

    public fun cancel_nft_offer<T0: store + key, T1>(arg0: &mut Kiosk_Offers_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftOffer<T0, T1>>(&arg0.id, arg1), 5);
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftOffer<T0, T1>>(&arg0.id, arg1);
        assert!(v0 == v1.offerer, 1);
        assert!(v1.status == 0, 2);
        let v2 = 0x2::balance::value<T1>(&v1.offer_amount);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftOffer<T0, T1>>(&mut arg0.id, arg1).status = 2;
        let NftOffer {
            id            : v3,
            offerer       : _,
            nft_owner     : _,
            nft_kiosk_id  : _,
            nft_id        : _,
            offer_amount  : v8,
            status        : _,
            expires_at_ms : _,
            created_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftOffer<T0, T1>>(&mut arg0.id, arg1);
        arg0.active_offers = arg0.active_offers - 1;
        0x2::object::delete(v3);
        let v12 = OfferCancelled{
            offer_id      : arg1,
            offerer       : v0,
            nft_id        : v1.nft_id,
            refund_amount : v2,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OfferCancelled>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg3), v0);
    }

    public entry fun cancel_offer_entry<T0: store + key, T1>(arg0: &mut Kiosk_Offers_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        cancel_nft_offer<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_expired_offer<T0: store + key, T1>(arg0: &mut Kiosk_Offers_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftOffer<T0, T1>>(&arg0.id, arg1), 5);
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftOffer<T0, T1>>(&arg0.id, arg1);
        assert!(v0 == v1.offerer, 1);
        assert!(v1.status == 0, 2);
        assert!(is_offer_expired(v1.expires_at_ms, arg2), 10);
        let v2 = 0x2::balance::value<T1>(&v1.offer_amount);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftOffer<T0, T1>>(&mut arg0.id, arg1).status = 3;
        let NftOffer {
            id            : v3,
            offerer       : _,
            nft_owner     : _,
            nft_kiosk_id  : _,
            nft_id        : _,
            offer_amount  : v8,
            status        : _,
            expires_at_ms : _,
            created_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftOffer<T0, T1>>(&mut arg0.id, arg1);
        arg0.active_offers = arg0.active_offers - 1;
        0x2::object::delete(v3);
        let v12 = OfferExpired{
            offer_id      : arg1,
            offerer       : v0,
            nft_id        : v1.nft_id,
            refund_amount : v2,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OfferExpired>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg3), v0);
    }

    public entry fun create_and_share_kiosk_offers_store(arg0: &0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Offers_Store>(create_kiosk_offers_store(arg0, arg1, arg2));
    }

    public fun create_kiosk_offers_store(arg0: &0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : Kiosk_Offers_Store {
        validate_fee_bps(arg1);
        let v0 = 0x2::object::new(arg2);
        let v1 = Kiosk_Offers_Store{
            id               : v0,
            auction_house    : 0x2::object::id<0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse>(arg0),
            royalty_registry : 0x2::table::new<0x1::string::String, CollectionRoyalty>(arg2),
            global_fee_bps   : arg1,
            total_offers     : 0,
            active_offers    : 0,
        };
        let v2 = OffersStoreCreated{
            store_id       : 0x2::object::uid_to_inner(&v0),
            auction_house  : 0x2::object::id<0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse>(arg0),
            creator        : 0x2::tx_context::sender(arg2),
            global_fee_bps : arg1,
        };
        0x2::event::emit<OffersStoreCreated>(v2);
        v1
    }

    public fun create_nft_offer<T0: store + key, T1>(arg0: &mut Kiosk_Offers_Store, arg1: &0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::coin::value<T1>(&arg3);
        assert!(v2 >= 1000000, 23);
        assert!(v2 <= 100000000000000000, 22);
        validate_duration(arg4);
        assert!(0x2::kiosk::has_item(arg1, arg2), 4);
        let v3 = 0x2::kiosk::owner(arg1);
        assert!(v0 != v3, 13);
        let v4 = safe_add_u64(v1, arg4);
        let v5 = NftOffer<T0, T1>{
            id            : 0x2::object::new(arg6),
            offerer       : v0,
            nft_owner     : v3,
            nft_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id        : arg2,
            offer_amount  : 0x2::coin::into_balance<T1>(arg3),
            status        : 0,
            expires_at_ms : v4,
            created_at_ms : v1,
        };
        let v6 = 0x2::object::id<NftOffer<T0, T1>>(&v5);
        0x2::dynamic_object_field::add<0x2::object::ID, NftOffer<T0, T1>>(&mut arg0.id, v6, v5);
        arg0.total_offers = arg0.total_offers + 1;
        arg0.active_offers = arg0.active_offers + 1;
        let v7 = NftOfferCreated{
            offer_id       : v6,
            offerer        : v0,
            nft_owner      : v3,
            nft_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id         : arg2,
            offer_amount   : v2,
            expires_at_ms  : v4,
            duration_hours : safe_div_u64(arg4, 3600000),
        };
        0x2::event::emit<NftOfferCreated>(v7);
        v6
    }

    public entry fun create_offer<T0: store + key, T1>(arg0: &mut Kiosk_Offers_Store, arg1: &0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        create_nft_offer<T0, T1>(arg0, arg1, arg2, arg3, hours_to_ms(arg4), arg5, arg6);
    }

    public fun days_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 86400000);
        validate_duration(v0);
        v0
    }

    public fun get_auction_house_id(arg0: &Kiosk_Offers_Store) : 0x2::object::ID {
        arg0.auction_house
    }

    public fun get_collection_royalty<T0: store + key>(arg0: &Kiosk_Offers_Store) : (address, u16, u64, u64) {
        let v0 = get_collection_type<T0>();
        assert!(0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v0), 27);
        let v1 = 0x2::table::borrow<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v0);
        (v1.collection_owner, v1.royalty_bps, v1.created_at_ms, v1.updated_at_ms)
    }

    fun get_collection_type<T0: store + key>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_collection_type_string<T0: store + key>() : 0x1::string::String {
        get_collection_type<T0>()
    }

    public fun get_global_fee_bps(arg0: &Kiosk_Offers_Store) : u16 {
        arg0.global_fee_bps
    }

    public fun get_offer_info<T0: store + key, T1>(arg0: &Kiosk_Offers_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (address, address, 0x2::object::ID, 0x2::object::ID, u64, u8, u64, bool) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftOffer<T0, T1>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftOffer<T0, T1>>(&arg0.id, arg1);
        (v0.offerer, v0.nft_owner, v0.nft_kiosk_id, v0.nft_id, 0x2::balance::value<T1>(&v0.offer_amount), v0.status, v0.expires_at_ms, is_offer_expired(v0.expires_at_ms, arg2))
    }

    public fun get_store_stats(arg0: &Kiosk_Offers_Store) : (u64, u64, u16) {
        (arg0.total_offers, arg0.active_offers, arg0.global_fee_bps)
    }

    public fun get_system_limits() : (u64, u64, u16, u16, u64, u64) {
        (31536000000, 1000000, 1000, 2500, 2592000000, 100000000000000000)
    }

    public fun has_collection_royalty<T0: store + key>(arg0: &Kiosk_Offers_Store) : bool {
        0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, get_collection_type<T0>())
    }

    public fun hours_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 3600000);
        validate_duration(v0);
        v0
    }

    public fun is_offer_expired(arg0: u64, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0
    }

    public fun offer_exists<T0: store + key, T1>(arg0: &Kiosk_Offers_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftOffer<T0, T1>>(&arg0.id, arg1)
    }

    public fun percentage_to_bps(arg0: u64, arg1: u64) : u16 {
        let v0 = safe_add_u64(safe_mul_u64(arg0, 100), arg1);
        assert!(v0 <= (1000 as u64), 24);
        (v0 as u16)
    }

    public entry fun remove_collection_royalty<T0: store + key>(arg0: &mut Kiosk_Offers_Store, arg1: &0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::object::id<0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(get_owner(arg1) == v0, 1);
        let v1 = get_collection_type<T0>();
        assert!(0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v1), 27);
        let v2 = 0x2::table::remove<0x1::string::String, CollectionRoyalty>(&mut arg0.royalty_registry, v1);
        let v3 = RoyaltyRemoved{
            collection_type     : v1,
            collection_owner    : v2.collection_owner,
            royalty_bps         : v2.royalty_bps,
            auction_house_owner : v0,
            timestamp_ms        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RoyaltyRemoved>(v3);
    }

    fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 22);
        arg0 + arg1
    }

    fun safe_div_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 22);
        arg0 / arg1
    }

    fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 22);
        arg0 * arg1
    }

    public entry fun update_collection_royalty<T0: store + key>(arg0: &mut Kiosk_Offers_Store, arg1: &0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse, arg2: address, arg3: u16, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::object::id<0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(get_owner(arg1) == v0, 1);
        validate_royalty_bps(arg3);
        let v2 = get_collection_type<T0>();
        assert!(0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v2), 27);
        let v3 = *0x2::table::borrow<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v2);
        let v4 = CollectionRoyalty{
            collection_owner : arg2,
            royalty_bps      : arg3,
            created_at_ms    : v3.created_at_ms,
            updated_at_ms    : v1,
        };
        *0x2::table::borrow_mut<0x1::string::String, CollectionRoyalty>(&mut arg0.royalty_registry, v2) = v4;
        let v5 = RoyaltyUpdated{
            collection_type     : v2,
            old_owner           : v3.collection_owner,
            new_owner           : arg2,
            old_royalty_bps     : v3.royalty_bps,
            new_royalty_bps     : arg3,
            auction_house_owner : v0,
            timestamp_ms        : v1,
        };
        0x2::event::emit<RoyaltyUpdated>(v5);
    }

    public entry fun update_global_fee(arg0: &mut Kiosk_Offers_Store, arg1: &0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse, arg2: u16, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::object::id<0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(get_owner(arg1) == v0, 1);
        validate_fee_bps(arg2);
        arg0.global_fee_bps = arg2;
        let v1 = GlobalFeeUpdated{
            old_fee_bps         : arg0.global_fee_bps,
            new_fee_bps         : arg2,
            auction_house_owner : v0,
            timestamp_ms        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<GlobalFeeUpdated>(v1);
    }

    public fun validate_duration(arg0: u64) {
        assert!(arg0 >= 3600000, 11);
        assert!(arg0 <= 31536000000, 12);
    }

    public fun validate_fee_bps(arg0: u16) {
        assert!(arg0 >= 0, 15);
        assert!(arg0 <= 1000, 8);
    }

    public fun validate_royalty_bps(arg0: u16) {
        assert!(arg0 >= 0, 28);
        assert!(arg0 <= 2500, 25);
    }

    // decompiled from Move bytecode v6
}

