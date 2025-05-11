module 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::kiosk_bidding_house {
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
    }

    struct Bid has store, key {
        id: 0x2::object::UID,
        bidder: address,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
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
    }

    struct BidPlaced has copy, drop {
        listing_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        timestamp: u64,
    }

    struct BidReadyForClaim has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        bidder: address,
        amount: u64,
        nft_id: 0x2::object::ID,
        timestamp: u64,
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
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
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

    public fun accept_bid<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg2), 25);
        let NftListing {
            id             : v0,
            seller         : v1,
            kiosk_id       : v2,
            nft_id         : v3,
            purchase_cap   : v4,
            buyout_price   : _,
            highest_bid    : v6,
            highest_bidder : v7,
            status         : v8,
            fee_bps        : v9,
            created_at     : _,
            expires_at     : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
        let v12 = v7;
        assert!(0x2::tx_context::sender(arg5) == v1, 23);
        assert!(v8 == 0, 21);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v2, 30);
        assert!(0x1::option::is_some<address>(&v12), 26);
        let v13 = 0x1::option::extract<address>(&mut v12);
        assert!(0x2::dynamic_object_field::exists_with_type<address, Bid>(&arg0.id, v13), 26);
        let Bid {
            id        : v14,
            bidder    : _,
            amount    : v16,
            timestamp : _,
        } = 0x2::dynamic_object_field::remove<address, Bid>(&mut arg0.id, v13);
        let v18 = v16;
        0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::add_fee(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v18, 0x2::balance::value<0x2::sui::SUI>(&v18) * (v9 as u64) / 10000));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v18, arg5), v1);
        let (v19, v20) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v4, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v20);
        let v24 = 0x2::tx_context::epoch(arg5);
        let v25 = AcceptedBid<T0>{
            id         : 0x2::object::new(arg5),
            listing_id : arg2,
            bidder     : v13,
            nft        : v19,
            timestamp  : v24,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, AcceptedBid<T0>>(&mut arg0.id, arg2, v25);
        0x2::object::delete(v0);
        0x2::object::delete(v14);
        let v26 = BidReadyForClaim{
            listing_id : arg2,
            seller     : v1,
            bidder     : v13,
            amount     : v6,
            nft_id     : v3,
            timestamp  : v24,
        };
        0x2::event::emit<BidReadyForClaim>(v26);
    }

    public entry fun accept_bid_entry<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        accept_bid<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun accepted_bid_exists<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptedBid<T0>>(&arg0.id, arg1)
    }

    public entry fun buy_nft<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_nft_with_request<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v1);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun buy_nft_to_existing_kiosk<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg4, arg5), 29);
        let (v0, v1) = buy_nft_with_request<T0>(arg0, arg1, arg2, arg3, arg6, arg7, arg9);
        let v2 = v1;
        0x2::kiosk::lock<T0>(arg4, arg5, arg6, v0);
        if (0x2::coin::value<0x2::sui::SUI>(&arg8) > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v2, arg8);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg8);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v2, arg4);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v2);
    }

    public entry fun buy_nft_to_new_kiosk<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg7);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = buy_nft_with_request<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v6 = v5;
        0x2::kiosk::lock<T0>(&mut v3, &v2, arg4, v4);
        if (0x2::coin::value<0x2::sui::SUI>(&arg6) > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v6, arg6);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg6);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg7), arg7);
    }

    public fun buy_nft_with_request<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg2), 25);
        let NftListing {
            id             : v0,
            seller         : v1,
            kiosk_id       : v2,
            nft_id         : v3,
            purchase_cap   : v4,
            buyout_price   : v5,
            highest_bid    : _,
            highest_bidder : v7,
            status         : v8,
            fee_bps        : v9,
            created_at     : _,
            expires_at     : v11,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
        let v12 = v7;
        assert!(v8 == 0, 21);
        assert!(0x2::tx_context::epoch(arg6) <= v11, 35);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v2, 30);
        let v13 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v13 >= v5, 31);
        if (0x1::option::is_some<address>(&v12)) {
            let v14 = 0x1::option::extract<address>(&mut v12);
            if (0x2::dynamic_object_field::exists_with_type<address, Bid>(&arg0.id, v14)) {
                let Bid {
                    id        : v15,
                    bidder    : _,
                    amount    : v17,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<address, Bid>(&mut arg0.id, v14);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v17, arg6), v14);
                0x2::object::delete(v15);
            };
        };
        0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v13 * (v9 as u64) / 10000, arg6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v1);
        let (v19, v20) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::object::delete(v0);
        let v21 = NftBoughtOut{
            listing_id : arg2,
            seller     : v1,
            buyer      : 0x2::tx_context::sender(arg6),
            amount     : v5,
            nft_id     : v3,
        };
        0x2::event::emit<NftBoughtOut>(v21);
        (v19, v20)
    }

    public fun cancel_listing<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let NftListing {
            id             : v0,
            seller         : v1,
            kiosk_id       : v2,
            nft_id         : v3,
            purchase_cap   : v4,
            buyout_price   : _,
            highest_bid    : _,
            highest_bidder : v7,
            status         : v8,
            fee_bps        : _,
            created_at     : _,
            expires_at     : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg1);
        let v12 = v7;
        assert!(0x2::tx_context::sender(arg3) == v1, 23);
        assert!(v8 == 0, 21);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v2, 30);
        if (0x1::option::is_some<address>(&v12)) {
            let v13 = 0x1::option::extract<address>(&mut v12);
            if (0x2::dynamic_object_field::exists_with_type<address, Bid>(&arg0.id, v13)) {
                let Bid {
                    id        : v14,
                    bidder    : _,
                    amount    : v16,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<address, Bid>(&mut arg0.id, v13);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v16, arg3), v13);
                0x2::object::delete(v14);
            };
        };
        0x2::kiosk::return_purchase_cap<T0>(arg2, v4);
        0x2::object::delete(v0);
        let v18 = ListingCancelled{
            listing_id : arg1,
            seller     : v1,
            nft_id     : v3,
        };
        0x2::event::emit<ListingCancelled>(v18);
    }

    public entry fun cancel_listing_entry<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        cancel_listing<T0>(arg0, arg1, arg2, arg3);
    }

    public fun claim_accepted_bid<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptedBid<T0>>(&arg0.id, arg1), 39);
        let AcceptedBid {
            id         : v0,
            listing_id : v1,
            bidder     : v2,
            nft        : v3,
            timestamp  : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, AcceptedBid<T0>>(&mut arg0.id, arg1);
        let v5 = v3;
        assert!(0x2::tx_context::sender(arg2) == v2, 38);
        0x2::object::delete(v0);
        let v6 = BidClaimed{
            listing_id : v1,
            bidder     : v2,
            nft_id     : 0x2::object::id<T0>(&v5),
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<BidClaimed>(v6);
        v5
    }

    public entry fun claim_accepted_bid_entry<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_accepted_bid<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_accepted_bid_to_existing_kiosk<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg2, arg3), 29);
        let v0 = claim_accepted_bid<T0>(arg0, arg1, arg6);
        0x2::kiosk::lock<T0>(arg2, arg3, arg4, v0);
        let v1 = 0x2::transfer_policy::new_request<T0>(0x2::object::id<T0>(&v0), 0, 0x2::object::id<0x2::kiosk::Kiosk>(arg2));
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v1, arg5);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v1, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v1);
    }

    public entry fun claim_accepted_bid_to_new_kiosk<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = claim_accepted_bid<T0>(arg0, arg1, arg4);
        0x2::kiosk::lock<T0>(&mut v3, &v2, arg2, v4);
        let v5 = 0x2::transfer_policy::new_request<T0>(0x2::object::id<T0>(&v4), 0, 0x2::object::id<0x2::kiosk::Kiosk>(&v3));
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v5, arg3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v5, &v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg4), arg4);
    }

    public entry fun create_and_share_kiosk_bidding_house_store(arg0: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Bidding_Store>(create_kiosk_bidding_house(arg0, arg1));
    }

    public fun create_kiosk_bidding_house(arg0: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Bidding_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg0, v0), 33);
        let v1 = 0x2::object::new(arg1);
        let v2 = Kiosk_Bidding_Store{
            id            : v1,
            auction_house : 0x2::object::id<0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse>(arg0),
            orphaned_caps : 0x2::object::new(arg1),
        };
        let v3 = BiddingStoreCreated{
            store_id      : 0x2::object::uid_to_inner(&v1),
            auction_house : 0x2::object::id<0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse>(arg0),
            creator       : v0,
        };
        0x2::event::emit<BiddingStoreCreated>(v3);
        v2
    }

    public fun create_nft_listing<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::kiosk::has_item(arg1, arg3), 28);
        assert!(0x2::kiosk::has_access(arg1, arg2), 29);
        assert!(arg4 > 0, 27);
        assert!(arg6 > 0, 37);
        let v0 = 0x2::tx_context::epoch(arg7);
        let v1 = v0 + arg6;
        let v2 = 0x2::object::new(arg7);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = NftListing<T0>{
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
        };
        0x2::dynamic_object_field::add<0x2::object::ID, NftListing<T0>>(&mut arg0.id, v3, v4);
        let v5 = NftListingCreated{
            seller       : 0x2::tx_context::sender(arg7),
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id       : arg3,
            buyout_price : arg4,
            fee_bps      : arg5,
            listing_id   : v3,
            expires_at   : v1,
        };
        0x2::event::emit<NftListingCreated>(v5);
        v3
    }

    public entry fun create_nft_listing_entry<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        create_nft_listing<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 604800, arg6);
    }

    public entry fun create_nft_listing_with_duration<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        create_nft_listing<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
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

    public entry fun emergency_reset_accepted_bid<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 33);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptedBid<T0>>(&arg0.id, arg2)) {
            let AcceptedBid {
                id         : v0,
                listing_id : v1,
                bidder     : v2,
                nft        : v3,
                timestamp  : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, AcceptedBid<T0>>(&mut arg0.id, arg2);
            let v5 = v3;
            0x2::transfer::public_transfer<T0>(v5, v2);
            0x2::object::delete(v0);
            let v6 = BidClaimed{
                listing_id : v1,
                bidder     : v2,
                nft_id     : 0x2::object::id<T0>(&v5),
                timestamp  : 0x2::tx_context::epoch(arg3),
            };
            0x2::event::emit<BidClaimed>(v6);
        };
    }

    public entry fun emergency_reset_listing<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 33);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg2)) {
            let NftListing {
                id             : v0,
                seller         : v1,
                kiosk_id       : v2,
                nft_id         : v3,
                purchase_cap   : v4,
                buyout_price   : _,
                highest_bid    : _,
                highest_bidder : v7,
                status         : _,
                fee_bps        : _,
                created_at     : _,
                expires_at     : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
            let v12 = v7;
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
            if (0x1::option::is_some<address>(&v12)) {
                let v15 = 0x1::option::extract<address>(&mut v12);
                if (0x2::dynamic_object_field::exists_with_type<address, Bid>(&arg0.id, v15)) {
                    let Bid {
                        id        : v16,
                        bidder    : _,
                        amount    : v18,
                        timestamp : _,
                    } = 0x2::dynamic_object_field::remove<address, Bid>(&mut arg0.id, v15);
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v18, arg3), v15);
                    0x2::object::delete(v16);
                };
            };
            0x2::object::delete(v0);
            let v20 = ListingCancelled{
                listing_id : arg2,
                seller     : v1,
                nft_id     : v3,
            };
            0x2::event::emit<ListingCancelled>(v20);
        };
    }

    public fun get_accepted_bid_bidder<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : address {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptedBid<T0>>(&arg0.id, arg1), 39);
        0x2::dynamic_object_field::borrow<0x2::object::ID, AcceptedBid<T0>>(&arg0.id, arg1).bidder
    }

    public fun get_accepted_bid_timestamp<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptedBid<T0>>(&arg0.id, arg1), 39);
        0x2::dynamic_object_field::borrow<0x2::object::ID, AcceptedBid<T0>>(&arg0.id, arg1).timestamp
    }

    public fun get_buyout_price<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).buyout_price
    }

    public fun get_highest_bid<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).highest_bid
    }

    public fun get_highest_bidder<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : 0x1::option::Option<address> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).highest_bidder
    }

    public fun get_listing_expiration<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).expires_at
    }

    public fun get_listing_status<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : u8 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).status
    }

    public fun get_nft_id<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).nft_id
    }

    public fun get_seller<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : address {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).seller
    }

    public fun is_listing_expired<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::tx_context::epoch(arg2) > 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).expires_at
    }

    public fun listing_exists<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1)
    }

    public fun place_bid<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::tx_context::epoch(arg3);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        assert!(v3.status == 0, 21);
        assert!(v2 <= v3.expires_at, 35);
        assert!(v0 > v3.highest_bid, 22);
        assert!(v0 > 0, 20);
        let v4 = 0x1::option::none<address>();
        let v5 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg1);
        if (0x1::option::is_some<address>(&v5.highest_bidder)) {
            v4 = 0x1::option::some<address>(*0x1::option::borrow<address>(&v5.highest_bidder));
            0x1::option::extract<address>(&mut v5.highest_bidder);
        };
        v5.highest_bid = v0;
        v5.highest_bidder = 0x1::option::some<address>(v1);
        if (0x1::option::is_some<address>(&v4)) {
            let v6 = 0x1::option::extract<address>(&mut v4);
            if (0x2::dynamic_object_field::exists_with_type<address, Bid>(&arg0.id, v6)) {
                let Bid {
                    id        : v7,
                    bidder    : _,
                    amount    : v9,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<address, Bid>(&mut arg0.id, v6);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v9, arg3), v6);
                0x2::object::delete(v7);
            };
        };
        let v11 = Bid{
            id        : 0x2::object::new(arg3),
            bidder    : v1,
            amount    : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            timestamp : v2,
        };
        0x2::dynamic_object_field::add<address, Bid>(&mut arg0.id, v1, v11);
        let v12 = BidPlaced{
            listing_id : arg1,
            bidder     : v1,
            amount     : v0,
            timestamp  : v2,
        };
        0x2::event::emit<BidPlaced>(v12);
    }

    public entry fun place_bid_entry<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        place_bid<T0>(arg0, arg1, arg2, arg3);
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

