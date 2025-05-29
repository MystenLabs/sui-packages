module 0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::kiosk_bidding_house_dynamic_royalty {
    struct Kiosk_Bidding_Store has key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        royalty_registry: 0x2::table::Table<0x1::string::String, CollectionRoyalty>,
    }

    struct CollectionRoyalty has copy, drop, store {
        collection_owner: address,
        royalty_bps: u16,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct NftListing<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        buyout_price: u64,
        current_bid_amount: u64,
        current_bidder: 0x1::option::Option<address>,
        min_bid_increment_bps: u16,
        status: u8,
        fee_bps: u16,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    struct Bid<phantom T0> has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        bidder: address,
        amount: 0x2::balance::Balance<T0>,
        timestamp_ms: u64,
    }

    struct PendingRefund<phantom T0> has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        recipient: address,
        amount: 0x2::balance::Balance<T0>,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    struct CompletedListing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        winner: address,
        nft_id: 0x2::object::ID,
        final_price: u64,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        seller_kiosk_id: 0x2::object::ID,
        completed_at_ms: u64,
        claim_expires_at_ms: u64,
    }

    struct BiddingStoreCreated has copy, drop {
        store_id: 0x2::object::ID,
        auction_house: 0x2::object::ID,
        creator: address,
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
        listing_id: 0x2::object::ID,
        collection_type: 0x1::string::String,
        collection_owner: address,
        royalty_amount: u64,
        royalty_bps: u16,
        sale_price: u64,
        timestamp_ms: u64,
    }

    struct NftListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyout_price: u64,
        min_bid_increment_bps: u16,
        fee_bps: u16,
        expires_at_ms: u64,
        duration_hours: u64,
    }

    struct BidPlaced has copy, drop {
        listing_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        previous_bidder: 0x1::option::Option<address>,
        previous_amount: u64,
        timestamp_ms: u64,
    }

    struct ListingCompleted has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        winner: address,
        final_price: u64,
        fee_amount: u64,
        royalty_amount: u64,
        nft_id: 0x2::object::ID,
        completion_type: u8,
        timestamp_ms: u64,
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
        refund_created: bool,
        timestamp_ms: u64,
    }

    struct RefundCreated has copy, drop {
        listing_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        expires_at_ms: u64,
        timestamp_ms: u64,
    }

    struct RefundClaimed has copy, drop {
        listing_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct NftClaimed has copy, drop {
        listing_id: 0x2::object::ID,
        winner: address,
        nft_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct EmergencyRecovery has copy, drop {
        completed_id: 0x2::object::ID,
        original_winner: address,
        admin: address,
        reason: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ClaimExpiredRecovered has copy, drop {
        listing_id: 0x2::object::ID,
        original_winner: address,
        seller: address,
        nft_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun accept_bid<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::object::id<0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg2), 5);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg2);
        assert!(v2.status == 0, 2);
        assert!(v0 == v2.seller, 1);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v2.kiosk_id, 3);
        assert!(0x1::option::is_some<address>(&v2.current_bidder), 14);
        let v3 = *0x1::option::borrow<address>(&v2.current_bidder);
        let v4 = v2.current_bid_amount;
        let v5 = v2.nft_id;
        let v6 = v2.fee_bps;
        let v7 = get_collection_type<T0>();
        let (v8, v9, v10) = if (0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v7)) {
            let v11 = 0x2::table::borrow<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v7);
            (true, calculate_royalty(v4, v11.royalty_bps), v11.collection_owner)
        } else {
            (false, 0, @0x0)
        };
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftListing<T0, T1>>(&mut arg0.id, arg2).status = 1;
        let NftListing {
            id                    : v12,
            seller                : _,
            kiosk_id              : v14,
            nft_id                : _,
            purchase_cap          : v16,
            buyout_price          : _,
            current_bid_amount    : _,
            current_bidder        : _,
            min_bid_increment_bps : _,
            status                : _,
            fee_bps               : _,
            expires_at_ms         : _,
            created_at_ms         : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0, T1>>(&mut arg0.id, arg2);
        let Bid {
            id           : v25,
            listing_id   : _,
            bidder       : _,
            amount       : v28,
            timestamp_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Bid<T1>>(&mut arg0.id, arg2);
        let v30 = v28;
        let v31 = calculate_fee(0x2::balance::value<T1>(&v30), v6);
        let v32 = if (v8 && v9 > 0) {
            0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v30, v9), arg6)
        } else {
            0x2::coin::zero<T1>(arg6)
        };
        let v33 = CompletedListing<T0>{
            id                  : 0x2::object::new(arg6),
            listing_id          : arg2,
            winner              : v3,
            nft_id              : v5,
            final_price         : v4,
            purchase_cap        : v16,
            seller_kiosk_id     : v14,
            completed_at_ms     : v1,
            claim_expires_at_ms : safe_add_u64(v1, 2592000000),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, CompletedListing<T0>>(&mut arg0.id, 0x2::object::id<CompletedListing<T0>>(&v33), v33);
        0x2::object::delete(v12);
        0x2::object::delete(v25);
        if (v8 && v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v32, v10);
            let v34 = CustomRoyaltyPaid{
                listing_id       : arg2,
                collection_type  : v7,
                collection_owner : v10,
                royalty_amount   : v9,
                royalty_bps      : 0x2::table::borrow<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v7).royalty_bps,
                sale_price       : v4,
                timestamp_ms     : v1,
            };
            0x2::event::emit<CustomRoyaltyPaid>(v34);
        } else {
            0x2::coin::destroy_zero<T1>(v32);
        };
        let v35 = ListingCompleted{
            listing_id      : arg2,
            seller          : v0,
            winner          : v3,
            final_price     : v4,
            fee_amount      : v31,
            royalty_amount  : v9,
            nft_id          : v5,
            completion_type : 0,
            timestamp_ms    : v1,
        };
        0x2::event::emit<ListingCompleted>(v35);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v30, v31), arg6), 0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::get_owner(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v30, arg6), v0);
    }

    public entry fun accept_bid_entry<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        accept_bid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun add_collection_royalty<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg2: address, arg3: u16, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::object::id<0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::get_owner(arg1) == v0, 1);
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

    public entry fun buyout_nft_entry<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg8);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = buyout_nft_with_custom_royalty<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v6 = v5;
        0x2::kiosk::lock<T0>(&mut v3, &v2, arg4, v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg8), arg8);
    }

    public fun buyout_nft_with_custom_royalty<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x2::object::id<0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg2), 5);
        let v2 = 0x2::coin::value<T1>(&arg5);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg2);
        assert!(v3.status == 0, 2);
        assert!(!is_listing_expired(v3.expires_at_ms, arg7), 10);
        assert!(v2 >= v3.buyout_price, 6);
        let v4 = 0x1::option::is_some<address>(&v3.current_bidder);
        let v5 = if (v4) {
            0x1::option::some<address>(*0x1::option::borrow<address>(&v3.current_bidder))
        } else {
            0x1::option::none<address>()
        };
        let v6 = v3.buyout_price;
        let v7 = v3.fee_bps;
        let v8 = v3.nft_id;
        let v9 = v3.seller;
        let v10 = v5;
        let v11 = get_collection_type<T0>();
        let (v12, v13, v14) = if (0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v11)) {
            let v15 = 0x2::table::borrow<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v11);
            (true, calculate_royalty(v6, v15.royalty_bps), v15.collection_owner)
        } else {
            (false, 0, @0x0)
        };
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftListing<T0, T1>>(&mut arg0.id, arg2).status = 1;
        if (v4 && 0x1::option::is_some<address>(&v10)) {
            let v16 = *0x1::option::borrow<address>(&v10);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bid<T1>>(&arg0.id, arg2)) {
                let Bid {
                    id           : v17,
                    listing_id   : _,
                    bidder       : _,
                    amount       : v20,
                    timestamp_ms : _,
                } = 0x2::dynamic_object_field::remove<0x2::object::ID, Bid<T1>>(&mut arg0.id, arg2);
                let v22 = v20;
                let v23 = safe_add_u64(v1, 604800000);
                let v24 = PendingRefund<T1>{
                    id            : 0x2::object::new(arg8),
                    listing_id    : arg2,
                    recipient     : v16,
                    amount        : v22,
                    expires_at_ms : v23,
                    created_at_ms : v1,
                };
                0x2::dynamic_object_field::add<0x2::object::ID, PendingRefund<T1>>(&mut arg0.id, 0x2::object::id<PendingRefund<T1>>(&v24), v24);
                0x2::object::delete(v17);
                let v25 = RefundCreated{
                    listing_id    : arg2,
                    recipient     : v16,
                    amount        : 0x2::balance::value<T1>(&v22),
                    expires_at_ms : v23,
                    timestamp_ms  : v1,
                };
                0x2::event::emit<RefundCreated>(v25);
            };
        };
        let NftListing {
            id                    : v26,
            seller                : _,
            kiosk_id              : _,
            nft_id                : _,
            purchase_cap          : v30,
            buyout_price          : _,
            current_bid_amount    : _,
            current_bidder        : _,
            min_bid_increment_bps : _,
            status                : _,
            fee_bps               : _,
            expires_at_ms         : _,
            created_at_ms         : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0, T1>>(&mut arg0.id, arg2);
        let v39 = v2 - v6;
        if (v39 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg5, v39, arg8), v0);
        };
        let v40 = calculate_fee(v6, v7);
        let v41 = if (v12 && v13 > 0) {
            0x2::coin::split<T1>(&mut arg5, v13, arg8)
        } else {
            0x2::coin::zero<T1>(arg8)
        };
        let (v42, v43) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v30, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v44 = v43;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v44, arg6);
        0x2::object::delete(v26);
        if (v12 && v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v41, v14);
            let v45 = CustomRoyaltyPaid{
                listing_id       : arg2,
                collection_type  : v11,
                collection_owner : v14,
                royalty_amount   : v13,
                royalty_bps      : 0x2::table::borrow<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, v11).royalty_bps,
                sale_price       : v6,
                timestamp_ms     : v1,
            };
            0x2::event::emit<CustomRoyaltyPaid>(v45);
        } else {
            0x2::coin::destroy_zero<T1>(v41);
        };
        let v46 = ListingCompleted{
            listing_id      : arg2,
            seller          : v9,
            winner          : v0,
            final_price     : v6,
            fee_amount      : v40,
            royalty_amount  : v13,
            nft_id          : v8,
            completion_type : 1,
            timestamp_ms    : v1,
        };
        0x2::event::emit<ListingCompleted>(v46);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg5, v40, arg8), 0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::get_owner(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v9);
        (v42, v44)
    }

    public fun calculate_fee(arg0: u64, arg1: u16) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 100000000000000000, 23);
        assert!(arg1 <= 1000, 24);
        safe_div_u64(safe_mul_u64(arg0, (arg1 as u64)), 10000)
    }

    public fun calculate_fee_amount(arg0: u64, arg1: u16) : u64 {
        calculate_fee(arg0, arg1)
    }

    public fun calculate_min_bid(arg0: u64, arg1: u16) : u64 {
        if (arg0 == 0) {
            return 10000000
        };
        let v0 = (arg1 as u64);
        assert!(arg0 <= safe_div_u64(18446744073709551615, v0), 22);
        let v1 = safe_add_u64(arg0, safe_div_u64(safe_mul_u64(arg0, v0), 10000));
        if (v1 < 10000000) {
            10000000
        } else {
            v1
        }
    }

    public fun calculate_purchase_breakdown<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: u64, arg2: u16) : (u64, u64, u64, u64) {
        let v0 = calculate_fee(arg1, arg2);
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

    public fun cancel_listing<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1), 5);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1);
        assert!(v0 == v2.seller, 1);
        assert!(v2.status == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v2.kiosk_id, 3);
        let v3 = 0x1::option::is_some<address>(&v2.current_bidder);
        let v4 = if (v3) {
            0x1::option::some<address>(*0x1::option::borrow<address>(&v2.current_bidder))
        } else {
            0x1::option::none<address>()
        };
        let v5 = v2.nft_id;
        let v6 = v2.current_bid_amount;
        let v7 = v4;
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftListing<T0, T1>>(&mut arg0.id, arg1).status = 2;
        let v8 = false;
        if (v3) {
            let v9 = *0x1::option::borrow<address>(&v7);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bid<T1>>(&arg0.id, arg1)) {
                let Bid {
                    id           : v10,
                    listing_id   : _,
                    bidder       : _,
                    amount       : v13,
                    timestamp_ms : _,
                } = 0x2::dynamic_object_field::remove<0x2::object::ID, Bid<T1>>(&mut arg0.id, arg1);
                let v15 = safe_add_u64(v1, 604800000);
                let v16 = PendingRefund<T1>{
                    id            : 0x2::object::new(arg4),
                    listing_id    : arg1,
                    recipient     : v9,
                    amount        : v13,
                    expires_at_ms : v15,
                    created_at_ms : v1,
                };
                0x2::dynamic_object_field::add<0x2::object::ID, PendingRefund<T1>>(&mut arg0.id, 0x2::object::id<PendingRefund<T1>>(&v16), v16);
                0x2::object::delete(v10);
                v8 = true;
                let v17 = RefundCreated{
                    listing_id    : arg1,
                    recipient     : v9,
                    amount        : v6,
                    expires_at_ms : v15,
                    timestamp_ms  : v1,
                };
                0x2::event::emit<RefundCreated>(v17);
            };
        };
        let NftListing {
            id                    : v18,
            seller                : _,
            kiosk_id              : _,
            nft_id                : _,
            purchase_cap          : v22,
            buyout_price          : _,
            current_bid_amount    : _,
            current_bidder        : _,
            min_bid_increment_bps : _,
            status                : _,
            fee_bps               : _,
            expires_at_ms         : _,
            created_at_ms         : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0, T1>>(&mut arg0.id, arg1);
        0x2::kiosk::return_purchase_cap<T0>(arg2, v22);
        0x2::object::delete(v18);
        let v31 = ListingCancelled{
            listing_id     : arg1,
            seller         : v0,
            nft_id         : v5,
            refund_created : v8,
            timestamp_ms   : v1,
        };
        0x2::event::emit<ListingCancelled>(v31);
    }

    public entry fun cancel_listing_entry<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        cancel_listing<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim_nft_to_new_kiosk<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg1), 5);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg1);
        assert!(v0 == v2.winner, 1);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v2.seller_kiosk_id, 3);
        assert!(v1 <= v2.claim_expires_at_ms, 30);
        let v3 = v2.listing_id;
        let CompletedListing {
            id                  : v4,
            listing_id          : _,
            winner              : _,
            nft_id              : _,
            final_price         : _,
            purchase_cap        : v9,
            seller_kiosk_id     : _,
            completed_at_ms     : _,
            claim_expires_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, CompletedListing<T0>>(&mut arg0.id, arg1);
        let (v13, v14) = 0x2::kiosk::new(arg6);
        let v15 = v14;
        let v16 = v13;
        let (v17, v18) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v9, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v19 = v18;
        0x2::kiosk::lock<T0>(&mut v16, &v15, arg3, v17);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v19, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v19, &v16);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v19);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v16);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v16, v15, arg6), arg6);
        0x2::object::delete(v4);
        let v23 = NftClaimed{
            listing_id   : v3,
            winner       : v0,
            nft_id       : v2.nft_id,
            timestamp_ms : v1,
        };
        0x2::event::emit<NftClaimed>(v23);
    }

    public entry fun claim_refund<T0>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, PendingRefund<T0>>(&arg0.id, arg1), 19);
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, PendingRefund<T0>>(&arg0.id, arg1);
        assert!(v0 == v1.recipient, 1);
        assert!(!is_listing_expired(v1.expires_at_ms, arg2), 20);
        let v2 = 0x2::balance::value<T0>(&v1.amount);
        let PendingRefund {
            id            : v3,
            listing_id    : _,
            recipient     : _,
            amount        : v6,
            expires_at_ms : _,
            created_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, PendingRefund<T0>>(&mut arg0.id, arg1);
        0x2::object::delete(v3);
        let v9 = RefundClaimed{
            listing_id   : v1.listing_id,
            recipient    : v0,
            amount       : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RefundClaimed>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg3), v0);
    }

    public fun completed_listing_exists<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg1)
    }

    public entry fun create_and_share_kiosk_bidding_store(arg0: &0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Bidding_Store>(create_kiosk_bidding_store(arg0, arg1));
    }

    public fun create_kiosk_bidding_store(arg0: &0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Bidding_Store {
        let v0 = 0x2::object::new(arg1);
        let v1 = Kiosk_Bidding_Store{
            id               : v0,
            auction_house    : 0x2::object::id<0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse>(arg0),
            royalty_registry : 0x2::table::new<0x1::string::String, CollectionRoyalty>(arg1),
        };
        let v2 = BiddingStoreCreated{
            store_id      : 0x2::object::uid_to_inner(&v0),
            auction_house : 0x2::object::id<0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse>(arg0),
            creator       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<BiddingStoreCreated>(v2);
        v1
    }

    public entry fun create_listing<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_nft_listing<T0, T1>(arg0, arg1, arg2, arg3, arg4, 100, arg5, hours_to_ms(arg6), arg7, arg8);
    }

    public fun create_nft_listing<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u16, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg4 > 0, 21);
        assert!(arg4 >= 10000000, 23);
        assert!(arg4 <= 100000000000000000, 22);
        validate_fee_bps(arg6);
        validate_bid_increment(arg5);
        validate_duration(arg7);
        assert!(0x2::kiosk::has_item(arg1, arg3), 4);
        assert!(0x2::kiosk::owner(arg1) == v0, 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 7);
        let v2 = safe_add_u64(v1, arg7);
        let v3 = NftListing<T0, T1>{
            id                    : 0x2::object::new(arg9),
            seller                : v0,
            kiosk_id              : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id                : arg3,
            purchase_cap          : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg9),
            buyout_price          : arg4,
            current_bid_amount    : 0,
            current_bidder        : 0x1::option::none<address>(),
            min_bid_increment_bps : arg5,
            status                : 0,
            fee_bps               : arg6,
            expires_at_ms         : v2,
            created_at_ms         : v1,
        };
        let v4 = 0x2::object::id<NftListing<T0, T1>>(&v3);
        0x2::dynamic_object_field::add<0x2::object::ID, NftListing<T0, T1>>(&mut arg0.id, v4, v3);
        let v5 = NftListingCreated{
            listing_id            : v4,
            seller                : v0,
            kiosk_id              : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id                : arg3,
            buyout_price          : arg4,
            min_bid_increment_bps : arg5,
            fee_bps               : arg6,
            expires_at_ms         : v2,
            duration_hours        : safe_div_u64(arg7, 3600000),
        };
        0x2::event::emit<NftListingCreated>(v5);
        v4
    }

    public fun days_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 86400000);
        validate_duration(v0);
        v0
    }

    public entry fun emergency_recover_nft<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::get_owner(arg1) == v0, 1);
        assert!(0x2::object::id<0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg2), 5);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v2.seller_kiosk_id, 3);
        assert!(v1 >= v2.completed_at_ms + 7776000000, 29);
        let v3 = v2.winner;
        let CompletedListing {
            id                  : v4,
            listing_id          : _,
            winner              : _,
            nft_id              : _,
            final_price         : _,
            purchase_cap        : v9,
            seller_kiosk_id     : _,
            completed_at_ms     : _,
            claim_expires_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, CompletedListing<T0>>(&mut arg0.id, arg2);
        let (v13, v14) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v9, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v15 = v14;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v15, arg5);
        let (v16, v17) = 0x2::kiosk::new(arg8);
        let v18 = v17;
        let v19 = v16;
        0x2::kiosk::lock<T0>(&mut v19, &v18, arg4, v13);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v15, &v19);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v15);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v19);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v18, v3);
        0x2::object::delete(v4);
        let v23 = EmergencyRecovery{
            completed_id    : arg2,
            original_winner : v3,
            admin           : v0,
            reason          : arg6,
            timestamp_ms    : v1,
        };
        0x2::event::emit<EmergencyRecovery>(v23);
    }

    public fun get_auction_house_id(arg0: &Kiosk_Bidding_Store) : 0x2::object::ID {
        arg0.auction_house
    }

    public fun get_collection_royalty<T0: store + key>(arg0: &Kiosk_Bidding_Store) : (address, u16, u64, u64) {
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

    public fun get_completed_listing_info<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : (0x2::object::ID, address, 0x2::object::ID, u64, 0x2::object::ID, u64, u64) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg1);
        (v0.listing_id, v0.winner, v0.nft_id, v0.final_price, v0.seller_kiosk_id, v0.completed_at_ms, v0.claim_expires_at_ms)
    }

    public fun get_current_bid<T0: store + key, T1>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : (u64, 0x1::option::Option<address>) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1);
        (v0.current_bid_amount, v0.current_bidder)
    }

    public fun get_listing_info<T0: store + key, T1>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (address, 0x2::object::ID, u64, u64, 0x1::option::Option<address>, u8, u16, u64, bool) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1);
        (v0.seller, v0.nft_id, v0.buyout_price, v0.current_bid_amount, v0.current_bidder, v0.status, v0.fee_bps, v0.expires_at_ms, is_listing_expired(v0.expires_at_ms, arg2))
    }

    public fun get_min_bid<T0: store + key, T1>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1);
        calculate_min_bid(v0.current_bid_amount, v0.min_bid_increment_bps)
    }

    public fun get_system_limits() : (u64, u64, u16, u16, u16, u64, u64) {
        (31536000000, 10000000, 1000, 2500, 2500, 604800000, 100000000000000000)
    }

    public fun has_collection_royalty<T0: store + key>(arg0: &Kiosk_Bidding_Store) : bool {
        0x2::table::contains<0x1::string::String, CollectionRoyalty>(&arg0.royalty_registry, get_collection_type<T0>())
    }

    public fun hours_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 3600000);
        validate_duration(v0);
        v0
    }

    public fun is_claim_expired<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg1), 5);
        0x2::clock::timestamp_ms(arg2) > 0x2::dynamic_object_field::borrow<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg1).claim_expires_at_ms
    }

    public fun is_listing_expired(arg0: u64, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0
    }

    public fun listing_exists<T0: store + key, T1>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1)
    }

    public fun percentage_to_bps(arg0: u64, arg1: u64) : u16 {
        let v0 = safe_add_u64(safe_mul_u64(arg0, 100), arg1);
        assert!(v0 <= (1000 as u64), 24);
        (v0 as u16)
    }

    public fun place_bid<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v2 >= 10000000, 23);
        assert!(v2 <= 100000000000000000, 22);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1), 5);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0, T1>>(&arg0.id, arg1);
        assert!(v3.status == 0, 2);
        assert!(!is_listing_expired(v3.expires_at_ms, arg3), 10);
        assert!(v0 != v3.seller, 13);
        assert!(v2 >= calculate_min_bid(v3.current_bid_amount, v3.min_bid_increment_bps), 16);
        let v4 = v3.current_bidder;
        let v5 = v3.current_bid_amount;
        let v4 = v4;
        if (0x1::option::is_some<address>(&v4)) {
            let v6 = *0x1::option::borrow<address>(&v4);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bid<T1>>(&arg0.id, arg1)) {
                let Bid {
                    id           : v7,
                    listing_id   : _,
                    bidder       : _,
                    amount       : v10,
                    timestamp_ms : _,
                } = 0x2::dynamic_object_field::remove<0x2::object::ID, Bid<T1>>(&mut arg0.id, arg1);
                let v12 = safe_add_u64(v1, 604800000);
                let v13 = PendingRefund<T1>{
                    id            : 0x2::object::new(arg4),
                    listing_id    : arg1,
                    recipient     : v6,
                    amount        : v10,
                    expires_at_ms : v12,
                    created_at_ms : v1,
                };
                0x2::dynamic_object_field::add<0x2::object::ID, PendingRefund<T1>>(&mut arg0.id, 0x2::object::id<PendingRefund<T1>>(&v13), v13);
                0x2::object::delete(v7);
                let v14 = RefundCreated{
                    listing_id    : arg1,
                    recipient     : v6,
                    amount        : v5,
                    expires_at_ms : v12,
                    timestamp_ms  : v1,
                };
                0x2::event::emit<RefundCreated>(v14);
            };
        };
        let v15 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftListing<T0, T1>>(&mut arg0.id, arg1);
        v15.current_bid_amount = v2;
        v15.current_bidder = 0x1::option::some<address>(v0);
        let v16 = Bid<T1>{
            id           : 0x2::object::new(arg4),
            listing_id   : arg1,
            bidder       : v0,
            amount       : 0x2::coin::into_balance<T1>(arg2),
            timestamp_ms : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Bid<T1>>(&mut arg0.id, arg1, v16);
        let v17 = BidPlaced{
            listing_id      : arg1,
            bidder          : v0,
            amount          : v2,
            previous_bidder : v4,
            previous_amount : v5,
            timestamp_ms    : v1,
        };
        0x2::event::emit<BidPlaced>(v17);
    }

    public entry fun place_bid_entry<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        place_bid<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun recover_expired_claim<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg1), 5);
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, CompletedListing<T0>>(&arg0.id, arg1);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v1.seller_kiosk_id, 3);
        assert!(v0 > v1.claim_expires_at_ms, 29);
        let CompletedListing {
            id                  : v2,
            listing_id          : v3,
            winner              : v4,
            nft_id              : v5,
            final_price         : _,
            purchase_cap        : v7,
            seller_kiosk_id     : _,
            completed_at_ms     : _,
            claim_expires_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, CompletedListing<T0>>(&mut arg0.id, arg1);
        0x2::kiosk::return_purchase_cap<T0>(arg2, v7);
        0x2::object::delete(v2);
        let v11 = ClaimExpiredRecovered{
            listing_id      : v3,
            original_winner : v4,
            seller          : 0x2::tx_context::sender(arg4),
            nft_id          : v5,
            timestamp_ms    : v0,
        };
        0x2::event::emit<ClaimExpiredRecovered>(v11);
    }

    public fun refund_exists<T0>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, PendingRefund<T0>>(&arg0.id, arg1)
    }

    public entry fun remove_collection_royalty<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::object::id<0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::get_owner(arg1) == v0, 1);
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

    public entry fun update_collection_royalty<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse, arg2: address, arg3: u16, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::object::id<0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(0xad0df1417420d4e0bf4466963959e59c30043750b83a2fb7537bf8e6c37a0cdd::auctionhouse::get_owner(arg1) == v0, 1);
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

    public fun validate_bid_increment(arg0: u16) {
        assert!(arg0 >= 50, 17);
        assert!(arg0 <= 2500, 17);
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

