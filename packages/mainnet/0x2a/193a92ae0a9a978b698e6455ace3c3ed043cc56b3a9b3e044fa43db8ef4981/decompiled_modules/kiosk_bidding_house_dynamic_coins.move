module 0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::kiosk_bidding_house_dynamic_coins {
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
        created_at: u64,
        expires_at: u64,
        coin_type: 0x1::type_name::TypeName,
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

    struct BidKey has copy, drop, store {
        listing_id: 0x2::object::ID,
        bidder: address,
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
        listing_id: 0x2::object::ID,
        expires_at: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct BidPlaced has copy, drop {
        listing_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
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

    struct BidRefunded has copy, drop {
        listing_id: 0x2::object::ID,
        bidder: address,
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

    public fun accept_bid<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_listing_is_active_and_not_expired_for_modification<T0>(arg0, arg2, arg5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg2);
        assert!(0x2::tx_context::sender(arg5) == v0.seller, 23);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v0.kiosk_id, 30);
        assert!(0x1::option::is_some<address>(&v0.highest_bidder), 26);
        let v1 = v0.coin_type;
        assert!(v1 == 0x1::type_name::get<T1>(), 42);
        assert!(0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, create_bid_key(arg2, *0x1::option::borrow<address>(&v0.highest_bidder))), 26);
        let NftListing {
            id             : v2,
            seller         : v3,
            kiosk_id       : _,
            nft_id         : v5,
            purchase_cap   : v6,
            buyout_price   : _,
            highest_bid    : v8,
            highest_bidder : v9,
            status         : _,
            fee_bps        : v11,
            created_at     : _,
            expires_at     : _,
            coin_type      : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
        let v15 = v9;
        let v16 = 0x1::option::extract<address>(&mut v15);
        let Bid {
            id        : v17,
            bidder    : _,
            amount    : v19,
            timestamp : _,
        } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, create_bid_key(arg2, v16));
        let v21 = v19;
        assert!(0x2::kiosk::has_item(arg3, v5), 28);
        let (v22, v23) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v6, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v23);
        let v27 = 0x2::tx_context::epoch(arg5);
        let v28 = AcceptedBid<T0>{
            id         : 0x2::object::new(arg5),
            listing_id : arg2,
            bidder     : v16,
            nft        : v22,
            timestamp  : v27,
            coin_type  : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, AcceptedBid<T0>>(&mut arg0.id, arg2, v28);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v21, 0x2::balance::value<T1>(&v21) * (v11 as u64) / 10000), arg5), 0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::get_owner(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v21, arg5), v3);
        0x2::object::delete(v2);
        0x2::object::delete(v17);
        let v29 = BidReadyForClaim{
            listing_id : arg2,
            seller     : v3,
            bidder     : v16,
            amount     : v8,
            nft_id     : v5,
            timestamp  : v27,
            coin_type  : v1,
        };
        0x2::event::emit<BidReadyForClaim>(v29);
    }

    public entry fun accept_bid_entry<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        accept_bid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun batch_clean_expired_listings<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v0);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, v1)) {
                let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, v1);
                if (is_safely_expired(v2.expires_at, arg3) && v2.kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg2)) {
                    if (v2.coin_type == 0x1::type_name::get<T1>()) {
                        clean_expired_listing<T0, T1>(arg0, v1, arg2, arg3);
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun bid_exists<T0>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::tx_context::TxContext) : bool {
        let v0 = UtilityFunctionCalled{
            function_name : b"bid_exists",
            caller        : 0x2::tx_context::sender(arg3),
            timestamp     : 0x2::tx_context::epoch(arg3),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T0>>(&arg0.id, create_bid_key(arg1, arg2))
    }

    public fun buy_nft_with_request<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        ensure_listing_is_active_and_not_expired_for_modification<T0>(arg0, arg2, arg6);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg2);
        let v1 = v0.coin_type;
        assert!(v1 == 0x1::type_name::get<T1>(), 42);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v0.kiosk_id, 30);
        let v2 = v0.buyout_price;
        assert!(0x2::coin::value<T1>(&arg5) >= v2, 31);
        let v3 = v0.seller;
        let v4 = v0.nft_id;
        let v5 = v0.fee_bps;
        let v6 = 0x1::option::is_some<address>(&v0.highest_bidder);
        let NftListing {
            id             : v7,
            seller         : _,
            kiosk_id       : _,
            nft_id         : _,
            purchase_cap   : v11,
            buyout_price   : _,
            highest_bid    : _,
            highest_bidder : v14,
            status         : _,
            fee_bps        : _,
            created_at     : _,
            expires_at     : _,
            coin_type      : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
        let v20 = v14;
        if (v6) {
            let v21 = 0x1::option::extract<address>(&mut v20);
            let v22 = create_bid_key(arg2, v21);
            if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v22)) {
                let Bid {
                    id        : v23,
                    bidder    : _,
                    amount    : v25,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v22);
                let v27 = v25;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v27, arg6), v21);
                let v28 = BidRefunded{
                    listing_id : arg2,
                    bidder     : v21,
                    amount     : 0x2::balance::value<T1>(&v27),
                    timestamp  : 0x2::tx_context::epoch(arg6),
                    coin_type  : v1,
                };
                0x2::event::emit<BidRefunded>(v28);
                0x2::object::delete(v23);
            };
        };
        assert!(0x2::kiosk::has_item(arg3, v4), 28);
        let (v29, v30) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v11, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::object::delete(v7);
        let v31 = NftBoughtOut{
            listing_id : arg2,
            seller     : v3,
            buyer      : 0x2::tx_context::sender(arg6),
            amount     : v2,
            nft_id     : v4,
            coin_type  : v1,
        };
        0x2::event::emit<NftBoughtOut>(v31);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg5, 0x2::coin::value<T1>(&arg5) * (v5 as u64) / 10000, arg6), 0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::get_owner(arg1));
        (v29, v30)
    }

    public entry fun buy_nft_with_token<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
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
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        let v1 = v0.coin_type;
        assert!(v1 == 0x1::type_name::get<T1>(), 42);
        let v2 = v0.seller;
        assert!(0x2::tx_context::sender(arg3) == v2, 23);
        assert!(v0.status == 0, 21);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v0.kiosk_id, 30);
        let v3 = 0x1::option::is_some<address>(&v0.highest_bidder);
        let v4 = v0.nft_id;
        let NftListing {
            id             : v5,
            seller         : _,
            kiosk_id       : _,
            nft_id         : _,
            purchase_cap   : v9,
            buyout_price   : _,
            highest_bid    : _,
            highest_bidder : v12,
            status         : _,
            fee_bps        : _,
            created_at     : _,
            expires_at     : _,
            coin_type      : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg1);
        let v18 = v12;
        if (v3) {
            let v19 = 0x1::option::extract<address>(&mut v18);
            let v20 = create_bid_key(arg1, v19);
            if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v20)) {
                let Bid {
                    id        : v21,
                    bidder    : _,
                    amount    : v23,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v20);
                let v25 = v23;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v25, arg3), v19);
                let v26 = BidRefunded{
                    listing_id : arg1,
                    bidder     : v19,
                    amount     : 0x2::balance::value<T1>(&v25),
                    timestamp  : 0x2::tx_context::epoch(arg3),
                    coin_type  : v1,
                };
                0x2::event::emit<BidRefunded>(v26);
                0x2::object::delete(v21);
            };
        };
        0x2::kiosk::return_purchase_cap<T0>(arg2, v9);
        0x2::object::delete(v5);
        let v27 = ListingCancelled{
            listing_id : arg1,
            seller     : v2,
            nft_id     : v4,
            coin_type  : v1,
        };
        0x2::event::emit<ListingCancelled>(v27);
    }

    public entry fun cancel_offer<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        cancel_listing<T0, T1>(arg0, arg1, arg2, arg3);
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

    public entry fun clean_expired_listing<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        assert!(is_safely_expired(v0.expires_at, arg3), 44);
        let v1 = 0x1::option::is_some<address>(&v0.highest_bidder);
        let v2 = v0.highest_bid;
        let v3 = v0.coin_type;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v0.kiosk_id, 30);
        assert!(v3 == 0x1::type_name::get<T1>(), 42);
        let NftListing {
            id             : v4,
            seller         : _,
            kiosk_id       : _,
            nft_id         : _,
            purchase_cap   : v8,
            buyout_price   : _,
            highest_bid    : _,
            highest_bidder : v11,
            status         : v12,
            fee_bps        : _,
            created_at     : _,
            expires_at     : _,
            coin_type      : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg1);
        let v17 = v11;
        assert!(v12 == 0, 21);
        let v18 = 0x1::option::none<address>();
        if (v1) {
            let v19 = 0x1::option::extract<address>(&mut v17);
            0x1::option::fill<address>(&mut v18, v19);
            let v20 = create_bid_key(arg1, v19);
            if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v20)) {
                let Bid {
                    id        : v21,
                    bidder    : _,
                    amount    : v23,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v20);
                let v25 = v23;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v25, arg3), v19);
                let v26 = BidRefunded{
                    listing_id : arg1,
                    bidder     : v19,
                    amount     : 0x2::balance::value<T1>(&v25),
                    timestamp  : 0x2::tx_context::epoch(arg3),
                    coin_type  : v3,
                };
                0x2::event::emit<BidRefunded>(v26);
                0x2::object::delete(v21);
            };
        };
        0x2::kiosk::return_purchase_cap<T0>(arg2, v8);
        0x2::object::delete(v4);
        let v27 = ListingExpiredAndCleaned{
            listing_id     : arg1,
            seller         : v0.seller,
            nft_id         : v0.nft_id,
            highest_bidder : v18,
            highest_bid    : v2,
            cleaner        : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::tx_context::epoch(arg3),
            coin_type      : v3,
        };
        0x2::event::emit<ListingExpiredAndCleaned>(v27);
    }

    public entry fun create_and_share_kiosk_bidding_house_store(arg0: &0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Bidding_Store>(create_kiosk_bidding_house(arg0, arg1));
    }

    fun create_bid_key(arg0: 0x2::object::ID, arg1: address) : BidKey {
        BidKey{
            listing_id : arg0,
            bidder     : arg1,
        }
    }

    public fun create_kiosk_bidding_house(arg0: &0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Bidding_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::is_admin(arg0, v0), 33);
        let v1 = 0x2::object::new(arg1);
        let v2 = Kiosk_Bidding_Store{
            id            : v1,
            auction_house : 0x2::object::id<0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse>(arg0),
            orphaned_caps : 0x2::object::new(arg1),
        };
        let v3 = BiddingStoreCreated{
            store_id      : 0x2::object::uid_to_inner(&v1),
            auction_house : 0x2::object::id<0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse>(arg0),
            creator       : v0,
        };
        0x2::event::emit<BiddingStoreCreated>(v3);
        v2
    }

    public fun create_nft_listing<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg5 <= 10000, 40);
        assert!(0x2::kiosk::has_item(arg1, arg3), 28);
        assert!(0x2::kiosk::has_access(arg1, arg2), 29);
        assert!(arg4 > 0, 27);
        assert!(arg6 > 0, 37);
        let v0 = 0x2::tx_context::epoch(arg7);
        let v1 = v0 + arg6;
        let v2 = 0x2::object::new(arg7);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x1::type_name::get<T1>();
        let v5 = NftListing<T0>{
            id             : v2,
            seller         : 0x2::tx_context::sender(arg7),
            kiosk_id       : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id         : arg3,
            purchase_cap   : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg7),
            buyout_price   : arg4,
            highest_bid    : 0,
            highest_bidder : 0x1::option::none<address>(),
            status         : 0,
            fee_bps        : arg5,
            created_at     : v0,
            expires_at     : v1,
            coin_type      : v4,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, NftListing<T0>>(&mut arg0.id, v3, v5);
        let v6 = NftListingCreated{
            seller       : 0x2::tx_context::sender(arg7),
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id       : arg3,
            buyout_price : arg4,
            fee_bps      : arg5,
            listing_id   : v3,
            expires_at   : v1,
            coin_type    : v4,
        };
        0x2::event::emit<NftListingCreated>(v6);
        v3
    }

    public entry fun create_nft_listing_with_duration<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        create_nft_listing<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun create_offer_nft_to_token<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        create_nft_listing<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 2592000, arg6);
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

    public entry fun emergency_reset_accepted_bid<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 33);
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
            0x2::transfer::public_transfer<T0>(v6, v2);
            0x2::object::delete(v0);
            let v7 = BidClaimed{
                listing_id : v1,
                bidder     : v2,
                nft_id     : 0x2::object::id<T0>(&v6),
                timestamp  : 0x2::tx_context::epoch(arg3),
            };
            0x2::event::emit<BidClaimed>(v7);
        };
    }

    public entry fun emergency_reset_listing<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2a193a92ae0a9a978b698e6455ace3c3ed043cc56b3a9b3e044fa43db8ef4981::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 33);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg2)) {
            let NftListing {
                id             : v0,
                seller         : v1,
                kiosk_id       : v2,
                nft_id         : v3,
                purchase_cap   : v4,
                buyout_price   : _,
                highest_bid    : _,
                highest_bidder : _,
                status         : _,
                fee_bps        : _,
                created_at     : _,
                expires_at     : _,
                coin_type      : v12,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
            let v13 = OrphanedPurchaseCap<T0>{
                id          : 0x2::object::new(arg3),
                cap         : v4,
                kiosk_id    : v2,
                orphaned_at : 0x2::tx_context::epoch(arg3),
            };
            0x2::dynamic_object_field::add<0x2::object::ID, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_caps, v3, v13);
            let v14 = PurchaseCapOrphaned{
                nft_id    : v3,
                kiosk_id  : v2,
                timestamp : 0x2::tx_context::epoch(arg3),
            };
            0x2::event::emit<PurchaseCapOrphaned>(v14);
            0x2::object::delete(v0);
            let v15 = ListingCancelled{
                listing_id : arg2,
                seller     : v1,
                nft_id     : v3,
                coin_type  : v12,
            };
            0x2::event::emit<ListingCancelled>(v15);
        };
    }

    fun ensure_listing_is_active_and_not_expired_for_modification<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        if (is_safely_expired(v0.expires_at, arg2)) {
            let v1 = ListingExpired{
                listing_id : arg1,
                seller     : v0.seller,
                nft_id     : v0.nft_id,
                timestamp  : 0x2::tx_context::epoch(arg2),
                coin_type  : v0.coin_type,
            };
            0x2::event::emit<ListingExpired>(v1);
            abort 35
        };
        assert!(v0.status == 0, 21);
    }

    public fun get_buyout_price<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = UtilityFunctionCalled{
            function_name : b"get_buyout_price",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::tx_context::epoch(arg2),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).buyout_price
    }

    public fun get_coin_type<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : 0x1::type_name::TypeName {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = UtilityFunctionCalled{
            function_name : b"get_coin_type",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::tx_context::epoch(arg2),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).coin_type
    }

    public fun get_highest_bid<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        if (is_safely_expired(v0.expires_at, arg2)) {
            let v1 = ListingExpired{
                listing_id : arg1,
                seller     : v0.seller,
                nft_id     : v0.nft_id,
                timestamp  : 0x2::tx_context::epoch(arg2),
                coin_type  : v0.coin_type,
            };
            0x2::event::emit<ListingExpired>(v1);
        };
        let v2 = UtilityFunctionCalled{
            function_name : b"get_highest_bid",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::tx_context::epoch(arg2),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v2);
        v0.highest_bid
    }

    public fun get_highest_bidder<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : 0x1::option::Option<address> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        if (is_safely_expired(v0.expires_at, arg2)) {
            let v1 = ListingExpired{
                listing_id : arg1,
                seller     : v0.seller,
                nft_id     : v0.nft_id,
                timestamp  : 0x2::tx_context::epoch(arg2),
                coin_type  : v0.coin_type,
            };
            0x2::event::emit<ListingExpired>(v1);
        };
        let v2 = UtilityFunctionCalled{
            function_name : b"get_highest_bidder",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::tx_context::epoch(arg2),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v2);
        v0.highest_bidder
    }

    public fun get_listing_expiration<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = UtilityFunctionCalled{
            function_name : b"get_listing_expiration",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::tx_context::epoch(arg2),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).expires_at
    }

    public fun get_listing_status<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : u8 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = UtilityFunctionCalled{
            function_name : b"get_listing_status",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::tx_context::epoch(arg2),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).status
    }

    public fun get_listings_by_coin_type<T0>(arg0: &Kiosk_Bidding_Store, arg1: &0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = UtilityFunctionCalled{
            function_name : b"get_listings_by_coin_type",
            caller        : 0x2::tx_context::sender(arg1),
            timestamp     : 0x2::tx_context::epoch(arg1),
            params        : 0x1::vector::empty<u8>(),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x1::vector::empty<0x2::object::ID>()
    }

    public fun get_listings_by_nft_type<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: &0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = UtilityFunctionCalled{
            function_name : b"get_listings_by_nft_type",
            caller        : 0x2::tx_context::sender(arg1),
            timestamp     : 0x2::tx_context::epoch(arg1),
            params        : 0x1::vector::empty<u8>(),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x1::vector::empty<0x2::object::ID>()
    }

    public fun get_nft_id<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = UtilityFunctionCalled{
            function_name : b"get_nft_id",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::tx_context::epoch(arg2),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).nft_id
    }

    public fun get_seller<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : address {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = UtilityFunctionCalled{
            function_name : b"get_seller",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::tx_context::epoch(arg2),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).seller
    }

    public fun is_listing_active_and_not_expired<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        if (!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1)) {
            let v0 = UtilityFunctionCalled{
                function_name : b"is_listing_active_and_not_expired",
                caller        : 0x2::tx_context::sender(arg2),
                timestamp     : 0x2::tx_context::epoch(arg2),
                params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
            };
            0x2::event::emit<UtilityFunctionCalled>(v0);
            return false
        };
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        let v3 = is_safely_expired(v2.expires_at, arg2);
        if (v3) {
            let v4 = ListingExpired{
                listing_id : arg1,
                seller     : v2.seller,
                nft_id     : v2.nft_id,
                timestamp  : v1,
                coin_type  : v2.coin_type,
            };
            0x2::event::emit<ListingExpired>(v4);
        };
        let v5 = UtilityFunctionCalled{
            function_name : b"is_listing_active_and_not_expired",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : v1,
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v5);
        v2.status == 0 && !v3
    }

    public fun is_listing_expired<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = is_safely_expired(v0.expires_at, arg2);
        if (v2) {
            let v3 = ListingExpired{
                listing_id : arg1,
                seller     : v0.seller,
                nft_id     : v0.nft_id,
                timestamp  : v1,
                coin_type  : v0.coin_type,
            };
            0x2::event::emit<ListingExpired>(v3);
        };
        let v4 = UtilityFunctionCalled{
            function_name : b"is_listing_expired",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : v1,
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v4);
        v2
    }

    public fun is_listing_expired_by_id<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        if (!0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1)) {
            let v0 = UtilityFunctionCalled{
                function_name : b"is_listing_expired_by_id",
                caller        : 0x2::tx_context::sender(arg2),
                timestamp     : 0x2::tx_context::epoch(arg2),
                params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
            };
            0x2::event::emit<UtilityFunctionCalled>(v0);
            return false
        };
        is_listing_expired<T0>(arg0, arg1, arg2)
    }

    public fun is_safely_expired(arg0: u64, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) + 5 > arg0
    }

    public fun listing_exists<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        let v0 = UtilityFunctionCalled{
            function_name : b"listing_exists",
            caller        : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::tx_context::epoch(arg2),
            params        : 0x2::bcs::to_bytes<0x2::object::ID>(&arg1),
        };
        0x2::event::emit<UtilityFunctionCalled>(v0);
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1)
    }

    public fun place_bid<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_listing_is_active_and_not_expired_for_modification<T0>(arg0, arg1, arg3);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::tx_context::epoch(arg3);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        let v4 = v3.coin_type;
        assert!(v4 == 0x1::type_name::get<T1>(), 42);
        assert!(v0 > 0, 20);
        let v5 = if (v3.highest_bid == 0) {
            1
        } else {
            v3.highest_bid + v3.highest_bid * (100 as u64) / 10000
        };
        assert!(v0 >= v5, 22);
        let v6 = 0x1::option::none<address>();
        let v7 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg1);
        if (0x1::option::is_some<address>(&v7.highest_bidder)) {
            v6 = 0x1::option::some<address>(*0x1::option::borrow<address>(&v7.highest_bidder));
            0x1::option::extract<address>(&mut v7.highest_bidder);
        };
        v7.highest_bid = v0;
        v7.highest_bidder = 0x1::option::some<address>(v1);
        if (0x1::option::is_some<address>(&v6)) {
            let v8 = 0x1::option::extract<address>(&mut v6);
            let v9 = create_bid_key(arg1, v8);
            if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v9)) {
                let Bid {
                    id        : v10,
                    bidder    : _,
                    amount    : v12,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v9);
                let v14 = v12;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v14, arg3), v8);
                let v15 = BidRefunded{
                    listing_id : arg1,
                    bidder     : v8,
                    amount     : 0x2::balance::value<T1>(&v14),
                    timestamp  : 0x2::tx_context::epoch(arg3),
                    coin_type  : v4,
                };
                0x2::event::emit<BidRefunded>(v15);
                0x2::object::delete(v10);
            };
        };
        let v16 = Bid<T1>{
            id        : 0x2::object::new(arg3),
            bidder    : v1,
            amount    : 0x2::coin::into_balance<T1>(arg2),
            timestamp : v2,
        };
        0x2::dynamic_object_field::add<BidKey, Bid<T1>>(&mut arg0.id, create_bid_key(arg1, v1), v16);
        let v17 = BidPlaced{
            listing_id : arg1,
            bidder     : v1,
            amount     : v0,
            timestamp  : v2,
            coin_type  : v4,
        };
        0x2::event::emit<BidPlaced>(v17);
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

    // decompiled from Move bytecode v6
}

