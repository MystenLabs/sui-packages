module 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::kiosk_bidding_house_dynamic_coins {
    struct Kiosk_Bidding_Store has store, key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
        orphaned_caps: 0x2::object::UID,
    }

    struct NftListing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        buyout_price: u64,
        highest_bid: u64,
        highest_bidder: 0x1::option::Option<address>,
        status: u8,
        fee_bps: u16,
        min_bid_increment_bps: u16,
        created_at: u64,
        expires_at: u64,
        coin_type: 0x1::type_name::TypeName,
        extensions_enabled: bool,
        royalty_override_bps: 0x1::option::Option<u16>,
    }

    struct Bid<phantom T0> has store, key {
        id: 0x2::object::UID,
        bidder: address,
        amount: 0x2::balance::Balance<T0>,
        timestamp: u64,
    }

    struct OrphanedPurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        kiosk_id: 0x2::object::ID,
        orphaned_at: u64,
    }

    struct AcceptedBid<T0: store + key> has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        bidder: address,
        nft: T0,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PendingRefund<phantom T0> has store, key {
        id: 0x2::object::UID,
        recipient: address,
        amount: 0x2::balance::Balance<T0>,
        listing_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct BidKey has copy, drop, store {
        listing_id: 0x2::object::ID,
        bidder: address,
    }

    struct RefundKey has copy, drop, store {
        listing_id: 0x2::object::ID,
        recipient: address,
    }

    struct BiddingStoreCreated has copy, drop {
        store_id: 0x2::object::ID,
        auction_house: 0x2::object::ID,
        creator: address,
    }

    struct NftListingCreated has copy, drop {
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyout_price: u64,
        fee_bps: u16,
        min_bid_increment_bps: u16,
        listing_id: 0x2::object::ID,
        expires_at: u64,
        coin_type: 0x1::type_name::TypeName,
        extensions_enabled: bool,
        royalty_override_bps: 0x1::option::Option<u16>,
    }

    struct BidPlaced has copy, drop {
        listing_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct ListingExtended has copy, drop {
        listing_id: 0x2::object::ID,
        old_expiry: u64,
        new_expiry: u64,
        bidder: address,
        timestamp: u64,
    }

    struct BidReadyForClaim has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        bidder: address,
        amount: u64,
        nft_id: 0x2::object::ID,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct BidClaimed has copy, drop {
        listing_id: 0x2::object::ID,
        bidder: address,
        nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct NftBoughtOut has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        amount: u64,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PurchaseCapOrphaned has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct OrphanedCapRecovered has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        recoverer: address,
        timestamp: u64,
    }

    struct RefundCreated has copy, drop {
        listing_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct RefundClaimed has copy, drop {
        listing_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct ListingExpired has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct ListingExpiredAndCleaned has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
        highest_bidder: 0x1::option::Option<address>,
        highest_bid: u64,
        cleaner: address,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct UtilityFunctionCalled has copy, drop {
        function_name: vector<u8>,
        caller: address,
        timestamp: u64,
        params: vector<u8>,
    }

    public fun accept_bid<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(check_listing_active_and_not_expired<T0>(arg0, arg2, arg5), 21);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg2);
        let v1 = v0.seller;
        assert!(0x2::tx_context::sender(arg5) == v1, 23);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v0.kiosk_id, 30);
        assert!(0x1::option::is_some<address>(&v0.highest_bidder), 26);
        let v2 = *0x1::option::borrow<address>(&v0.highest_bidder);
        let v3 = v0.coin_type;
        let v4 = v0.nft_id;
        let v5 = v0.highest_bid;
        let v6 = v0.fee_bps;
        assert!(v3 == 0x1::type_name::get<T1>(), 42);
        assert!(0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, create_bid_key(arg2, v2)), 26);
        assert!(0x2::kiosk::has_item(arg3, v4), 28);
        let NftListing {
            id                    : v7,
            seller                : _,
            kiosk_id              : _,
            nft_id                : _,
            purchase_cap          : v11,
            buyout_price          : _,
            highest_bid           : _,
            highest_bidder        : _,
            status                : _,
            fee_bps               : _,
            min_bid_increment_bps : _,
            created_at            : _,
            expires_at            : _,
            coin_type             : _,
            extensions_enabled    : _,
            royalty_override_bps  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
        let Bid {
            id        : v23,
            bidder    : _,
            amount    : v25,
            timestamp : _,
        } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, create_bid_key(arg2, v2));
        let v27 = v25;
        let (v28, v29) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v11, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v29);
        let v33 = 0x2::tx_context::epoch(arg5);
        let v34 = AcceptedBid<T0>{
            id         : 0x2::object::new(arg5),
            listing_id : arg2,
            bidder     : v2,
            nft        : v28,
            timestamp  : v33,
            coin_type  : v3,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, AcceptedBid<T0>>(&mut arg0.id, arg2, v34);
        0x2::object::delete(v7);
        0x2::object::delete(v23);
        let v35 = BidReadyForClaim{
            listing_id : arg2,
            seller     : v1,
            bidder     : v2,
            amount     : v5,
            nft_id     : v4,
            timestamp  : v33,
            coin_type  : v3,
        };
        0x2::event::emit<BidReadyForClaim>(v35);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v27, 0x2::balance::value<T1>(&v27) * (v6 as u64) / 10000), arg5), 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::get_owner(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v27, arg5), v1);
    }

    public entry fun accept_bid_entry<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        accept_bid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun batch_clean_expired_listings<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::tx_context::epoch(arg3);
        let v2 = 0x1::type_name::get<T1>();
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v0);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, v3)) {
                let v4 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, v3);
                let v5 = if (is_safely_expired(v4.expires_at, arg3)) {
                    if (v4.kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg2)) {
                        if (v4.status == 0) {
                            v4.coin_type == v2
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v5) {
                    let v6 = 0x1::option::is_some<address>(&v4.highest_bidder);
                    let v7 = v4.highest_bid;
                    let v8 = 0x1::vector::empty<address>();
                    if (v6) {
                        0x1::vector::push_back<address>(&mut v8, *0x1::option::borrow<address>(&v4.highest_bidder));
                    };
                    let NftListing {
                        id                    : v9,
                        seller                : _,
                        kiosk_id              : _,
                        nft_id                : _,
                        purchase_cap          : v13,
                        buyout_price          : _,
                        highest_bid           : _,
                        highest_bidder        : _,
                        status                : _,
                        fee_bps               : _,
                        min_bid_increment_bps : _,
                        created_at            : _,
                        expires_at            : _,
                        coin_type             : _,
                        extensions_enabled    : _,
                        royalty_override_bps  : _,
                    } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, v3);
                    let v25 = 0x1::option::none<address>();
                    if (v6) {
                        let v26 = 0;
                        while (v26 < 0x1::vector::length<address>(&v8)) {
                            let v27 = *0x1::vector::borrow<address>(&v8, v26);
                            0x1::option::fill<address>(&mut v25, v27);
                            let v28 = create_bid_key(v3, v27);
                            if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v28)) {
                                let Bid {
                                    id        : v29,
                                    bidder    : _,
                                    amount    : v31,
                                    timestamp : _,
                                } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v28);
                                let v33 = v31;
                                let v34 = PendingRefund<T1>{
                                    id         : 0x2::object::new(arg3),
                                    recipient  : v27,
                                    amount     : v33,
                                    listing_id : v3,
                                    timestamp  : v1,
                                };
                                0x2::dynamic_object_field::add<RefundKey, PendingRefund<T1>>(&mut arg0.id, create_refund_key(v3, v27), v34);
                                let v35 = RefundCreated{
                                    listing_id : v3,
                                    recipient  : v27,
                                    amount     : 0x2::balance::value<T1>(&v33),
                                    timestamp  : v1,
                                    coin_type  : v2,
                                };
                                0x2::event::emit<RefundCreated>(v35);
                                0x2::object::delete(v29);
                            };
                            v26 = v26 + 1;
                        };
                    };
                    0x2::kiosk::return_purchase_cap<T0>(arg2, v13);
                    0x2::object::delete(v9);
                    let v36 = ListingExpiredAndCleaned{
                        listing_id     : v3,
                        seller         : v4.seller,
                        nft_id         : v4.nft_id,
                        highest_bidder : v25,
                        highest_bid    : v7,
                        cleaner        : 0x2::tx_context::sender(arg3),
                        timestamp      : v1,
                        coin_type      : v2,
                    };
                    0x2::event::emit<ListingExpiredAndCleaned>(v36);
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun bid_exists<T0>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::tx_context::TxContext) : bool {
        0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T0>>(&arg0.id, create_bid_key(arg1, arg2))
    }

    public fun buy_nft_with_request<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(check_listing_active_and_not_expired<T0>(arg0, arg2, arg6), 21);
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg2);
        let v2 = v1.coin_type;
        assert!(v2 == 0x1::type_name::get<T1>(), 42);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v1.kiosk_id, 30);
        let v3 = v1.buyout_price;
        assert!(0x2::coin::value<T1>(&arg5) >= v3, 31);
        let v4 = v1.seller;
        let v5 = v1.nft_id;
        let v6 = v1.fee_bps;
        let v7 = 0x1::option::is_some<address>(&v1.highest_bidder);
        if (v7) {
            0x1::vector::push_back<address>(&mut v0, *0x1::option::borrow<address>(&v1.highest_bidder));
        };
        assert!(0x2::kiosk::has_item(arg3, v5), 28);
        let NftListing {
            id                    : v8,
            seller                : _,
            kiosk_id              : _,
            nft_id                : _,
            purchase_cap          : v12,
            buyout_price          : _,
            highest_bid           : _,
            highest_bidder        : _,
            status                : _,
            fee_bps               : _,
            min_bid_increment_bps : _,
            created_at            : _,
            expires_at            : _,
            coin_type             : _,
            extensions_enabled    : _,
            royalty_override_bps  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
        let v24 = 0x2::tx_context::epoch(arg6);
        if (v7) {
            let v25 = 0;
            while (v25 < 0x1::vector::length<address>(&v0)) {
                let v26 = *0x1::vector::borrow<address>(&v0, v25);
                let v27 = create_bid_key(arg2, v26);
                if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v27)) {
                    let Bid {
                        id        : v28,
                        bidder    : _,
                        amount    : v30,
                        timestamp : _,
                    } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v27);
                    let v32 = v30;
                    let v33 = PendingRefund<T1>{
                        id         : 0x2::object::new(arg6),
                        recipient  : v26,
                        amount     : v32,
                        listing_id : arg2,
                        timestamp  : v24,
                    };
                    0x2::dynamic_object_field::add<RefundKey, PendingRefund<T1>>(&mut arg0.id, create_refund_key(arg2, v26), v33);
                    let v34 = RefundCreated{
                        listing_id : arg2,
                        recipient  : v26,
                        amount     : 0x2::balance::value<T1>(&v32),
                        timestamp  : v24,
                        coin_type  : v2,
                    };
                    0x2::event::emit<RefundCreated>(v34);
                    0x2::object::delete(v28);
                };
                v25 = v25 + 1;
            };
        };
        let (v35, v36) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v12, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::object::delete(v8);
        let v37 = NftBoughtOut{
            listing_id : arg2,
            seller     : v4,
            buyer      : 0x2::tx_context::sender(arg6),
            amount     : v3,
            nft_id     : v5,
            coin_type  : v2,
        };
        0x2::event::emit<NftBoughtOut>(v37);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg5, 0x2::coin::value<T1>(&arg5) * (v6 as u64) / 10000, arg6), 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::get_owner(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v4);
        (v35, v36)
    }

    public entry fun buy_nft_with_token<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg7);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = buy_nft_with_request<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v6 = v5;
        0x2::kiosk::lock<T0>(&mut v3, &v2, arg4, v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v6, arg6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg7), arg7);
    }

    public fun cancel_listing<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        let v2 = v1.coin_type;
        assert!(v2 == 0x1::type_name::get<T1>(), 42);
        let v3 = v1.seller;
        assert!(0x2::tx_context::sender(arg3) == v3, 23);
        assert!(v1.status == 0, 21);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v1.kiosk_id, 30);
        let v4 = 0x1::option::is_some<address>(&v1.highest_bidder);
        if (v4) {
            0x1::vector::push_back<address>(&mut v0, *0x1::option::borrow<address>(&v1.highest_bidder));
        };
        let v5 = v1.nft_id;
        let NftListing {
            id                    : v6,
            seller                : _,
            kiosk_id              : _,
            nft_id                : _,
            purchase_cap          : v10,
            buyout_price          : _,
            highest_bid           : _,
            highest_bidder        : _,
            status                : _,
            fee_bps               : _,
            min_bid_increment_bps : _,
            created_at            : _,
            expires_at            : _,
            coin_type             : _,
            extensions_enabled    : _,
            royalty_override_bps  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg1);
        let v22 = 0x2::tx_context::epoch(arg3);
        if (v4) {
            let v23 = 0;
            while (v23 < 0x1::vector::length<address>(&v0)) {
                let v24 = *0x1::vector::borrow<address>(&v0, v23);
                let v25 = create_bid_key(arg1, v24);
                if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v25)) {
                    let Bid {
                        id        : v26,
                        bidder    : _,
                        amount    : v28,
                        timestamp : _,
                    } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v25);
                    let v30 = v28;
                    let v31 = PendingRefund<T1>{
                        id         : 0x2::object::new(arg3),
                        recipient  : v24,
                        amount     : v30,
                        listing_id : arg1,
                        timestamp  : v22,
                    };
                    0x2::dynamic_object_field::add<RefundKey, PendingRefund<T1>>(&mut arg0.id, create_refund_key(arg1, v24), v31);
                    let v32 = RefundCreated{
                        listing_id : arg1,
                        recipient  : v24,
                        amount     : 0x2::balance::value<T1>(&v30),
                        timestamp  : v22,
                        coin_type  : v2,
                    };
                    0x2::event::emit<RefundCreated>(v32);
                    0x2::object::delete(v26);
                };
                v23 = v23 + 1;
            };
        };
        0x2::kiosk::return_purchase_cap<T0>(arg2, v10);
        0x2::object::delete(v6);
        let v33 = ListingCancelled{
            listing_id : arg1,
            seller     : v3,
            nft_id     : v5,
            coin_type  : v2,
        };
        0x2::event::emit<ListingCancelled>(v33);
    }

    public entry fun cancel_offer<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        cancel_listing<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun check_listing_active_and_not_expired<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        if (!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1)) {
            return false
        };
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        if (v0.status != 0) {
            return false
        };
        if (is_safely_expired(v0.expires_at, arg2)) {
            let v1 = ListingExpired{
                listing_id : arg1,
                seller     : v0.seller,
                nft_id     : v0.nft_id,
                timestamp  : 0x2::tx_context::epoch(arg2),
                coin_type  : v0.coin_type,
            };
            0x2::event::emit<ListingExpired>(v1);
            return false
        };
        true
    }

    public fun claim_accepted_bid<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptedBid<T0>>(&arg0.id, arg1), 39);
        let AcceptedBid {
            id         : v0,
            listing_id : v1,
            bidder     : v2,
            nft        : v3,
            timestamp  : _,
            coin_type  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, AcceptedBid<T0>>(&mut arg0.id, arg1);
        let v6 = v3;
        assert!(0x2::tx_context::sender(arg2) == v2, 38);
        0x2::object::delete(v0);
        let v7 = BidClaimed{
            listing_id : v1,
            bidder     : v2,
            nft_id     : 0x2::object::id<T0>(&v6),
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<BidClaimed>(v7);
        v6
    }

    public entry fun claim_accepted_bid_entry<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_accepted_bid<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_accepted_bid_offer<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = claim_accepted_bid<T0>(arg0, arg1, arg4);
        0x2::kiosk::lock<T0>(&mut v3, &v2, arg2, v4);
        let v5 = 0x2::transfer_policy::new_request<T0>(0x2::object::id<T0>(&v4), 0, 0x2::object::id<0x2::kiosk::Kiosk>(&v3));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v5, arg3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg4), arg4);
    }

    public entry fun claim_refund<T0>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = create_refund_key(arg1, v0);
        assert!(0x2::dynamic_object_field::exists_with_type<RefundKey, PendingRefund<T0>>(&arg0.id, v1), 52);
        let PendingRefund {
            id         : v2,
            recipient  : _,
            amount     : v4,
            listing_id : _,
            timestamp  : _,
        } = 0x2::dynamic_object_field::remove<RefundKey, PendingRefund<T0>>(&mut arg0.id, v1);
        let v7 = v4;
        0x2::object::delete(v2);
        let v8 = RefundClaimed{
            listing_id : arg1,
            recipient  : v0,
            amount     : 0x2::balance::value<T0>(&v7),
            timestamp  : 0x2::tx_context::epoch(arg2),
            coin_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RefundClaimed>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg2), v0);
    }

    public entry fun clean_expired_listing<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        assert!(is_safely_expired(v1.expires_at, arg3), 44);
        let v2 = v1.highest_bid;
        let v3 = v1.coin_type;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v1.kiosk_id, 30);
        assert!(v3 == 0x1::type_name::get<T1>(), 42);
        let v4 = 0x1::option::is_some<address>(&v1.highest_bidder);
        if (v4) {
            0x1::vector::push_back<address>(&mut v0, *0x1::option::borrow<address>(&v1.highest_bidder));
        };
        assert!(v1.status == 0, 21);
        let NftListing {
            id                    : v5,
            seller                : _,
            kiosk_id              : _,
            nft_id                : _,
            purchase_cap          : v9,
            buyout_price          : _,
            highest_bid           : _,
            highest_bidder        : _,
            status                : _,
            fee_bps               : _,
            min_bid_increment_bps : _,
            created_at            : _,
            expires_at            : _,
            coin_type             : _,
            extensions_enabled    : _,
            royalty_override_bps  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg1);
        let v21 = 0x2::tx_context::epoch(arg3);
        let v22 = 0x1::option::none<address>();
        if (v4) {
            let v23 = 0;
            while (v23 < 0x1::vector::length<address>(&v0)) {
                let v24 = *0x1::vector::borrow<address>(&v0, v23);
                0x1::option::fill<address>(&mut v22, v24);
                let v25 = create_bid_key(arg1, v24);
                if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v25)) {
                    let Bid {
                        id        : v26,
                        bidder    : _,
                        amount    : v28,
                        timestamp : _,
                    } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v25);
                    let v30 = v28;
                    let v31 = PendingRefund<T1>{
                        id         : 0x2::object::new(arg3),
                        recipient  : v24,
                        amount     : v30,
                        listing_id : arg1,
                        timestamp  : v21,
                    };
                    0x2::dynamic_object_field::add<RefundKey, PendingRefund<T1>>(&mut arg0.id, create_refund_key(arg1, v24), v31);
                    let v32 = RefundCreated{
                        listing_id : arg1,
                        recipient  : v24,
                        amount     : 0x2::balance::value<T1>(&v30),
                        timestamp  : v21,
                        coin_type  : v3,
                    };
                    0x2::event::emit<RefundCreated>(v32);
                    0x2::object::delete(v26);
                };
                v23 = v23 + 1;
            };
        };
        0x2::kiosk::return_purchase_cap<T0>(arg2, v9);
        0x2::object::delete(v5);
        let v33 = ListingExpiredAndCleaned{
            listing_id     : arg1,
            seller         : v1.seller,
            nft_id         : v1.nft_id,
            highest_bidder : v22,
            highest_bid    : v2,
            cleaner        : 0x2::tx_context::sender(arg3),
            timestamp      : v21,
            coin_type      : v3,
        };
        0x2::event::emit<ListingExpiredAndCleaned>(v33);
    }

    public entry fun create_and_share_kiosk_bidding_house_store(arg0: &0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Bidding_Store>(create_kiosk_bidding_house(arg0, arg1));
    }

    fun create_bid_key(arg0: 0x2::object::ID, arg1: address) : BidKey {
        BidKey{
            listing_id : arg0,
            bidder     : arg1,
        }
    }

    public fun create_kiosk_bidding_house(arg0: &0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Bidding_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::is_admin(arg0, v0), 33);
        let v1 = 0x2::object::new(arg1);
        let v2 = Kiosk_Bidding_Store{
            id            : v1,
            auction_house : 0x2::object::id<0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse>(arg0),
            orphaned_caps : 0x2::object::new(arg1),
        };
        let v3 = BiddingStoreCreated{
            store_id      : 0x2::object::uid_to_inner(&v1),
            auction_house : 0x2::object::id<0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse>(arg0),
            creator       : v0,
        };
        0x2::event::emit<BiddingStoreCreated>(v3);
        v2
    }

    public fun create_nft_listing<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u16, arg7: u64, arg8: bool, arg9: 0x1::option::Option<u16>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg5 <= 10000, 40);
        assert!(arg6 > 0 && arg6 <= 5000, 51);
        if (0x1::option::is_some<u16>(&arg9)) {
            assert!(*0x1::option::borrow<u16>(&arg9) <= 5000, 50);
        };
        assert!(0x2::kiosk::has_item(arg1, arg3), 28);
        assert!(0x2::kiosk::has_access(arg1, arg2), 29);
        assert!(arg4 > 0, 27);
        assert!(arg7 > 0, 37);
        let v0 = 0x2::tx_context::epoch(arg10);
        let v1 = v0 + arg7;
        let v2 = 0x2::object::new(arg10);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x1::type_name::get<T1>();
        let v5 = NftListing<T0>{
            id                    : v2,
            seller                : 0x2::tx_context::sender(arg10),
            kiosk_id              : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id                : arg3,
            purchase_cap          : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg10),
            buyout_price          : arg4,
            highest_bid           : 0,
            highest_bidder        : 0x1::option::none<address>(),
            status                : 0,
            fee_bps               : arg5,
            min_bid_increment_bps : arg6,
            created_at            : v0,
            expires_at            : v1,
            coin_type             : v4,
            extensions_enabled    : arg8,
            royalty_override_bps  : arg9,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, NftListing<T0>>(&mut arg0.id, v3, v5);
        let v6 = NftListingCreated{
            seller                : 0x2::tx_context::sender(arg10),
            kiosk_id              : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id                : arg3,
            buyout_price          : arg4,
            fee_bps               : arg5,
            min_bid_increment_bps : arg6,
            listing_id            : v3,
            expires_at            : v1,
            coin_type             : v4,
            extensions_enabled    : arg8,
            royalty_override_bps  : arg9,
        };
        0x2::event::emit<NftListingCreated>(v6);
        v3
    }

    public entry fun create_nft_listing_with_params<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u16, arg7: u64, arg8: bool, arg9: u16, arg10: &mut 0x2::tx_context::TxContext) {
        create_nft_listing<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::some<u16>(arg9), arg10);
    }

    public entry fun create_offer_nft_to_token<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        create_nft_listing<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 100, 7776000, true, 0x1::option::none<u16>(), arg6);
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

    fun create_refund_key(arg0: 0x2::object::ID, arg1: address) : RefundKey {
        RefundKey{
            listing_id : arg0,
            recipient  : arg1,
        }
    }

    public entry fun emergency_reset_accepted_bid<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 33);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptedBid<T0>>(&arg0.id, arg2)) {
            let AcceptedBid {
                id         : v0,
                listing_id : v1,
                bidder     : v2,
                nft        : v3,
                timestamp  : _,
                coin_type  : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, AcceptedBid<T0>>(&mut arg0.id, arg2);
            let v6 = v3;
            0x2::object::delete(v0);
            let v7 = BidClaimed{
                listing_id : v1,
                bidder     : v2,
                nft_id     : 0x2::object::id<T0>(&v6),
                timestamp  : 0x2::tx_context::epoch(arg3),
            };
            0x2::event::emit<BidClaimed>(v7);
            0x2::transfer::public_transfer<T0>(v6, v2);
        };
    }

    public entry fun emergency_reset_listing<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x3836a23db29080cba7f68da685d18c1cff036a81db3e6e05f3e68bda265e0480::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 33);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg2)) {
            let NftListing {
                id                    : v0,
                seller                : v1,
                kiosk_id              : v2,
                nft_id                : v3,
                purchase_cap          : v4,
                buyout_price          : _,
                highest_bid           : _,
                highest_bidder        : _,
                status                : _,
                fee_bps               : _,
                min_bid_increment_bps : _,
                created_at            : _,
                expires_at            : _,
                coin_type             : v13,
                extensions_enabled    : _,
                royalty_override_bps  : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
            let v16 = OrphanedPurchaseCap<T0>{
                id          : 0x2::object::new(arg3),
                cap         : v4,
                kiosk_id    : v2,
                orphaned_at : 0x2::tx_context::epoch(arg3),
            };
            0x2::dynamic_object_field::add<0x2::object::ID, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_caps, v3, v16);
            let v17 = PurchaseCapOrphaned{
                nft_id    : v3,
                kiosk_id  : v2,
                timestamp : 0x2::tx_context::epoch(arg3),
            };
            0x2::event::emit<PurchaseCapOrphaned>(v17);
            0x2::object::delete(v0);
            let v18 = ListingCancelled{
                listing_id : arg2,
                seller     : v1,
                nft_id     : v3,
                coin_type  : v13,
            };
            0x2::event::emit<ListingCancelled>(v18);
        };
    }

    public fun get_buyout_price<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).buyout_price
    }

    public fun get_coin_type<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : 0x1::type_name::TypeName {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).coin_type
    }

    public fun get_highest_bid<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).highest_bid
    }

    public fun get_highest_bidder<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : 0x1::option::Option<address> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).highest_bidder
    }

    public fun get_listing_expiration<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).expires_at
    }

    public fun get_listing_status<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : u8 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).status
    }

    public fun get_nft_id<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).nft_id
    }

    public fun get_seller<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : address {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).seller
    }

    public fun is_listing_active_and_not_expired<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        check_listing_active_and_not_expired<T0>(arg0, arg1, arg2)
    }

    public fun is_listing_expired<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        is_safely_expired(0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).expires_at, arg2)
    }

    public fun is_listing_expired_by_id<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        if (!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1)) {
            return false
        };
        is_listing_expired<T0>(arg0, arg1, arg2)
    }

    public fun is_safely_expired(arg0: u64, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) + 5 > arg0
    }

    public fun listing_exists<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1)
    }

    public fun place_bid<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(check_listing_active_and_not_expired<T0>(arg0, arg1, arg3), 21);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::tx_context::epoch(arg3);
        let v3 = 0x1::option::none<address>();
        let v4 = false;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        let v8 = v7.coin_type;
        assert!(v8 == 0x1::type_name::get<T1>(), 42);
        assert!(v0 > 0, 20);
        let v9 = if (v7.highest_bid == 0) {
            1
        } else {
            v7.highest_bid + v7.highest_bid * (v7.min_bid_increment_bps as u64) / 10000
        };
        assert!(v0 >= v9, 22);
        if (v7.extensions_enabled) {
            if (v7.expires_at - v2 < 600) {
                v4 = true;
                v6 = v7.expires_at;
                v5 = v7.expires_at + 300;
            };
        };
        let v10 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg1);
        if (0x1::option::is_some<address>(&v10.highest_bidder)) {
            v3 = 0x1::option::some<address>(*0x1::option::borrow<address>(&v10.highest_bidder));
        };
        v10.highest_bid = v0;
        v10.highest_bidder = 0x1::option::some<address>(v1);
        if (v4) {
            v10.expires_at = v5;
        };
        let v11 = Bid<T1>{
            id        : 0x2::object::new(arg3),
            bidder    : v1,
            amount    : 0x2::coin::into_balance<T1>(arg2),
            timestamp : v2,
        };
        0x2::dynamic_object_field::add<BidKey, Bid<T1>>(&mut arg0.id, create_bid_key(arg1, v1), v11);
        if (0x1::option::is_some<address>(&v3)) {
            let v12 = 0x1::option::extract<address>(&mut v3);
            let v13 = create_bid_key(arg1, v12);
            if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v13)) {
                let Bid {
                    id        : v14,
                    bidder    : _,
                    amount    : v16,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v13);
                let v18 = v16;
                let v19 = PendingRefund<T1>{
                    id         : 0x2::object::new(arg3),
                    recipient  : v12,
                    amount     : v18,
                    listing_id : arg1,
                    timestamp  : v2,
                };
                0x2::dynamic_object_field::add<RefundKey, PendingRefund<T1>>(&mut arg0.id, create_refund_key(arg1, v12), v19);
                let v20 = RefundCreated{
                    listing_id : arg1,
                    recipient  : v12,
                    amount     : 0x2::balance::value<T1>(&v18),
                    timestamp  : v2,
                    coin_type  : v8,
                };
                0x2::event::emit<RefundCreated>(v20);
                0x2::object::delete(v14);
            };
        };
        let v21 = BidPlaced{
            listing_id : arg1,
            bidder     : v1,
            amount     : v0,
            timestamp  : v2,
            coin_type  : v8,
        };
        0x2::event::emit<BidPlaced>(v21);
        if (v4) {
            let v22 = ListingExtended{
                listing_id : arg1,
                old_expiry : v6,
                new_expiry : v5,
                bidder     : v1,
                timestamp  : v2,
            };
            0x2::event::emit<ListingExtended>(v22);
        };
    }

    public entry fun place_bid_entry<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        place_bid<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun recover_orphaned_cap<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg1, arg2), 29);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, OrphanedPurchaseCap<T0>>(&arg0.orphaned_caps, arg3), 36);
        let OrphanedPurchaseCap {
            id          : v0,
            cap         : v1,
            kiosk_id    : v2,
            orphaned_at : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_caps, arg3);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 30);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v1);
        0x2::object::delete(v0);
        let v4 = OrphanedCapRecovered{
            nft_id    : arg3,
            kiosk_id  : v2,
            recoverer : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<OrphanedCapRecovered>(v4);
    }

    public fun refund_exists<T0>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::tx_context::TxContext) : bool {
        0x2::dynamic_object_field::exists_with_type<RefundKey, PendingRefund<T0>>(&arg0.id, create_refund_key(arg1, arg2))
    }

    // decompiled from Move bytecode v6
}

