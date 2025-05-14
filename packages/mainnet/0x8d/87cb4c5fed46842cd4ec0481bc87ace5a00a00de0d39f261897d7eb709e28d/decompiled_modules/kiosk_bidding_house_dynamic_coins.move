module 0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::kiosk_bidding_house_dynamic_coins {
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

    public fun accept_bid<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
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
            coin_type      : v12,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
        let v13 = v7;
        assert!(0x2::tx_context::sender(arg5) == v1, 23);
        assert!(v8 == 0, 21);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v2, 30);
        assert!(0x1::option::is_some<address>(&v13), 26);
        let v14 = 0x1::option::extract<address>(&mut v13);
        let v15 = create_bid_key(arg2, v14);
        assert!(v12 == 0x1::type_name::get<T1>(), 42);
        assert!(0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v15), 26);
        let Bid {
            id        : v16,
            bidder    : _,
            amount    : v18,
            timestamp : _,
        } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v15);
        let v20 = v18;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v20, 0x2::balance::value<T1>(&v20) * (v9 as u64) / 10000), arg5), 0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::get_owner(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v20, arg5), v1);
        let (v21, v22) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v4, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v22);
        let v26 = 0x2::tx_context::epoch(arg5);
        let v27 = AcceptedBid<T0>{
            id         : 0x2::object::new(arg5),
            listing_id : arg2,
            bidder     : v14,
            nft        : v21,
            timestamp  : v26,
            coin_type  : v12,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, AcceptedBid<T0>>(&mut arg0.id, arg2, v27);
        0x2::object::delete(v0);
        0x2::object::delete(v16);
        let v28 = BidReadyForClaim{
            listing_id : arg2,
            seller     : v1,
            bidder     : v14,
            amount     : v6,
            nft_id     : v3,
            timestamp  : v26,
            coin_type  : v12,
        };
        0x2::event::emit<BidReadyForClaim>(v28);
    }

    public entry fun accept_bid_entry<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        accept_bid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun bid_exists<T0>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: address) : bool {
        0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T0>>(&arg0.id, create_bid_key(arg1, arg2))
    }

    public entry fun buy_nft<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_nft_with_request<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v1);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun buy_nft_with_request<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
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
            coin_type      : v12,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg2);
        let v13 = v7;
        assert!(v12 == 0x1::type_name::get<T1>(), 42);
        assert!(v8 == 0, 21);
        assert!(0x2::tx_context::epoch(arg6) <= v11, 35);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v2, 30);
        let v14 = 0x2::coin::value<T1>(&arg5);
        assert!(v14 >= v5, 31);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg5, v14 * (v9 as u64) / 10000, arg6), 0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::get_owner(arg1));
        if (0x1::option::is_some<address>(&v13)) {
            let v15 = 0x1::option::extract<address>(&mut v13);
            let v16 = create_bid_key(arg2, v15);
            if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v16)) {
                let Bid {
                    id        : v17,
                    bidder    : _,
                    amount    : v19,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v16);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v19, arg6), v15);
                0x2::object::delete(v17);
            };
        };
        let (v21, v22) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::object::delete(v0);
        let v23 = NftBoughtOut{
            listing_id : arg2,
            seller     : v1,
            buyer      : 0x2::tx_context::sender(arg6),
            amount     : v5,
            nft_id     : v3,
            coin_type  : v12,
        };
        0x2::event::emit<NftBoughtOut>(v23);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v1);
        (v21, v22)
    }

    public entry fun buy_nft_with_token<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: &mut 0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
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
            coin_type      : v12,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftListing<T0>>(&mut arg0.id, arg1);
        let v13 = v7;
        assert!(v12 == 0x1::type_name::get<T1>(), 42);
        assert!(0x2::tx_context::sender(arg3) == v1, 23);
        assert!(v8 == 0, 21);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v2, 30);
        if (0x1::option::is_some<address>(&v13)) {
            let v14 = 0x1::option::extract<address>(&mut v13);
            let v15 = create_bid_key(arg1, v14);
            if (0x2::dynamic_object_field::exists_with_type<BidKey, Bid<T1>>(&arg0.id, v15)) {
                let Bid {
                    id        : v16,
                    bidder    : _,
                    amount    : v18,
                    timestamp : _,
                } = 0x2::dynamic_object_field::remove<BidKey, Bid<T1>>(&mut arg0.id, v15);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v18, arg3), v14);
                0x2::object::delete(v16);
            };
        };
        0x2::kiosk::return_purchase_cap<T0>(arg2, v4);
        0x2::object::delete(v0);
        let v20 = ListingCancelled{
            listing_id : arg1,
            seller     : v1,
            nft_id     : v3,
            coin_type  : v12,
        };
        0x2::event::emit<ListingCancelled>(v20);
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

    public entry fun create_and_share_kiosk_bidding_house_store(arg0: &0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Kiosk_Bidding_Store>(create_kiosk_bidding_house(arg0, arg1));
    }

    fun create_bid_key(arg0: 0x2::object::ID, arg1: address) : BidKey {
        BidKey{
            listing_id : arg0,
            bidder     : arg1,
        }
    }

    public fun create_kiosk_bidding_house(arg0: &0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : Kiosk_Bidding_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::is_admin(arg0, v0), 33);
        let v1 = 0x2::object::new(arg1);
        let v2 = Kiosk_Bidding_Store{
            id            : v1,
            auction_house : 0x2::object::id<0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse>(arg0),
            orphaned_caps : 0x2::object::new(arg1),
        };
        let v3 = BiddingStoreCreated{
            store_id      : 0x2::object::uid_to_inner(&v1),
            auction_house : 0x2::object::id<0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse>(arg0),
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
        create_nft_listing<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 604800, arg6);
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

    public entry fun emergency_reset_accepted_bid<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 33);
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

    public entry fun emergency_reset_listing<T0: store + key>(arg0: &mut Kiosk_Bidding_Store, arg1: &0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8d87cb4c5fed46842cd4ec0481bc87ace5a00a00de0d39f261897d7eb709e28d::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 33);
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

    public fun get_buyout_price<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).buyout_price
    }

    public fun get_coin_type<T0: store + key>(arg0: &Kiosk_Bidding_Store, arg1: 0x2::object::ID) : 0x1::type_name::TypeName {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1).coin_type
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

    public fun get_listings_by_coin_type<T0>(arg0: &Kiosk_Bidding_Store) : vector<0x2::object::ID> {
        0x1::vector::empty<0x2::object::ID>()
    }

    public fun get_listings_by_nft_type<T0: store + key>(arg0: &Kiosk_Bidding_Store) : vector<0x2::object::ID> {
        0x1::vector::empty<0x2::object::ID>()
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

    public fun place_bid<T0: store + key, T1>(arg0: &mut Kiosk_Bidding_Store, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1), 25);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::tx_context::epoch(arg3);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, NftListing<T0>>(&arg0.id, arg1);
        assert!(v3.status == 0, 21);
        assert!(v2 <= v3.expires_at, 35);
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
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v12, arg3), v8);
                0x2::object::delete(v10);
            };
        };
        let v14 = Bid<T1>{
            id        : 0x2::object::new(arg3),
            bidder    : v1,
            amount    : 0x2::coin::into_balance<T1>(arg2),
            timestamp : v2,
        };
        0x2::dynamic_object_field::add<BidKey, Bid<T1>>(&mut arg0.id, create_bid_key(arg1, v1), v14);
        let v15 = BidPlaced{
            listing_id : arg1,
            bidder     : v1,
            amount     : v0,
            timestamp  : v2,
            coin_type  : v4,
        };
        0x2::event::emit<BidPlaced>(v15);
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

