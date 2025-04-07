module 0x848e81364f342dc6b2e7add517109082fbd6b8bb9d28ee6a623b7f98af0c6ae::ninja_store {
    struct TradableNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
    }

    struct NFTTypeInfo has copy, drop, store {
        type_name: 0x1::string::String,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        owner: address,
        listing_type: u8,
        price: u64,
        nft_id: 0x2::object::ID,
        nft_type: NFTTypeInfo,
        status: u8,
        start_time: u64,
        end_time: u64,
        highest_bid: u64,
        highest_bidder: address,
        is_kiosk_listing: bool,
        kiosk_id: 0x2::object::ID,
    }

    struct SwapListing has key {
        id: 0x2::object::UID,
        creator: address,
        swap_type: u8,
        offered_nft_id: 0x2::object::ID,
        offered_nft_type: NFTTypeInfo,
        requested_nft_id: 0x2::object::ID,
        requested_nft_type: NFTTypeInfo,
        requested_sui_amount: u64,
        offered_sui_amount: u64,
        status: u8,
        is_kiosk_swap: bool,
        kiosk_id: 0x2::object::ID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        owner: address,
        fee_bps: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_volume: u64,
        total_fees: u64,
        active_listings: u64,
        completed_trades: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        owner: address,
        nft_id: 0x2::object::ID,
        price: u64,
        listing_type: u8,
        is_kiosk_listing: bool,
    }

    struct ListingSold has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        nft_id: 0x2::object::ID,
        price: u64,
        fee_amount: u64,
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        owner: address,
        nft_id: 0x2::object::ID,
    }

    struct BidPlaced has copy, drop {
        listing_id: 0x2::object::ID,
        bidder: address,
        bid_amount: u64,
    }

    struct AuctionEnded has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        winner: address,
        nft_id: 0x2::object::ID,
        final_price: u64,
        fee_amount: u64,
    }

    struct SwapCreated has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
        swap_type: u8,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        requested_sui_amount: u64,
        offered_sui_amount: u64,
        is_kiosk_swap: bool,
    }

    struct SwapCompleted has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
        acceptor: address,
        swap_type: u8,
    }

    struct SwapCancelled has copy, drop {
        swap_id: 0x2::object::ID,
        creator: address,
        swap_type: u8,
    }

    struct FeeUpdated has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct FeeWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct NINJA_STORE has drop {
        dummy_field: bool,
    }

    public entry fun accept_nft_to_nft_swap<T0: store + key, T1: store + key>(arg0: &mut SwapListing, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 11);
        assert!(arg0.swap_type == 0, 10);
        assert!(!arg0.is_kiosk_swap, 16);
        get_type_name<T1>();
        arg0.status = 1;
        let v0 = SwapCompleted{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            acceptor  : 0x2::tx_context::sender(arg2),
            swap_type : 0,
        };
        0x2::event::emit<SwapCompleted>(v0);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<T1>(arg1, arg0.creator);
    }

    public entry fun accept_nft_to_sui_swap<T0: store + key>(arg0: &mut SwapListing, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 11);
        assert!(arg0.swap_type == 1, 10);
        assert!(!arg0.is_kiosk_swap, 16);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.requested_sui_amount, 3);
        arg0.status = 1;
        let v0 = SwapCompleted{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            acceptor  : 0x2::tx_context::sender(arg2),
            swap_type : 1,
        };
        0x2::event::emit<SwapCompleted>(v0);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.creator);
    }

    public entry fun accept_sui_to_nft_swap<T0: store + key>(arg0: &mut SwapListing, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 11);
        assert!(arg0.swap_type == 2, 10);
        assert!(!arg0.is_kiosk_swap, 16);
        let v0 = get_type_name<T0>();
        assert!(0x1::string::as_bytes(&v0) == 0x1::string::as_bytes(&arg0.requested_nft_type.type_name), 9);
        arg0.status = 1;
        let v1 = SwapCompleted{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            acceptor  : 0x2::tx_context::sender(arg2),
            swap_type : 2,
        };
        0x2::event::emit<SwapCompleted>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, b"payment"), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<T0>(arg1, arg0.creator);
    }

    public entry fun buy_listing<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Listing, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 4);
        assert!(arg1.listing_type == 0, 14);
        assert!(!arg1.is_kiosk_listing, 15);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.price, 3);
        let v0 = arg1.price * arg0.fee_bps / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg1.price - v0, arg3), arg1.owner);
        arg1.status = 1;
        arg0.active_listings = arg0.active_listings - 1;
        arg0.completed_trades = arg0.completed_trades + 1;
        arg0.total_volume = arg0.total_volume + arg1.price;
        arg0.total_fees = arg0.total_fees + v0;
        let v1 = ListingSold{
            listing_id : 0x2::object::id<Listing>(arg1),
            seller     : arg1.owner,
            buyer      : 0x2::tx_context::sender(arg3),
            nft_id     : arg1.nft_id,
            price      : arg1.price,
            fee_amount : v0,
        };
        0x2::event::emit<ListingSold>(v1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg1.nft_id), 0x2::tx_context::sender(arg3));
    }

    public entry fun cancel_kiosk_listing<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Listing, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 1);
        assert!(arg1.status == 0, 4);
        assert!(arg1.is_kiosk_listing, 15);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg1.kiosk_id, 13);
        0x2::kiosk::delist<T0>(arg2, arg3, arg1.nft_id);
        arg1.status = 2;
        arg0.active_listings = arg0.active_listings - 1;
        let v0 = ListingCancelled{
            listing_id : 0x2::object::id<Listing>(arg1),
            owner      : arg1.owner,
            nft_id     : arg1.nft_id,
        };
        0x2::event::emit<ListingCancelled>(v0);
    }

    public entry fun cancel_listing<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Listing, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 1);
        assert!(arg1.status == 0, 4);
        assert!(!arg1.is_kiosk_listing, 15);
        arg1.status = 2;
        arg0.active_listings = arg0.active_listings - 1;
        let v0 = ListingCancelled{
            listing_id : 0x2::object::id<Listing>(arg1),
            owner      : arg1.owner,
            nft_id     : arg1.nft_id,
        };
        0x2::event::emit<ListingCancelled>(v0);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg1.nft_id), arg1.owner);
    }

    public entry fun cancel_swap<T0: store + key>(arg0: &mut SwapListing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(arg0.status == 0, 11);
        assert!(!arg0.is_kiosk_swap, 16);
        arg0.status = 2;
        let v0 = SwapCancelled{
            swap_id   : 0x2::object::id<SwapListing>(arg0),
            creator   : arg0.creator,
            swap_type : arg0.swap_type,
        };
        0x2::event::emit<SwapCancelled>(v0);
        if (arg0.swap_type == 0 || arg0.swap_type == 1) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg0.offered_nft_id), arg0.creator);
        } else if (arg0.swap_type == 2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, b"payment"), arg0.creator);
        };
    }

    public entry fun create_auction<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = NFTTypeInfo{type_name: get_type_name<T0>()};
        let v3 = Listing{
            id               : 0x2::object::new(arg4),
            owner            : 0x2::tx_context::sender(arg4),
            listing_type     : 1,
            price            : arg2,
            nft_id           : v0,
            nft_type         : v2,
            status           : 0,
            start_time       : v1,
            end_time         : v1 + arg3,
            highest_bid      : 0,
            highest_bidder   : @0x0,
            is_kiosk_listing : false,
            kiosk_id         : 0x2::object::id_from_address(@0x0),
        };
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v3.id, v0, arg1);
        arg0.active_listings = arg0.active_listings + 1;
        let v4 = ListingCreated{
            listing_id       : 0x2::object::id<Listing>(&v3),
            owner            : 0x2::tx_context::sender(arg4),
            nft_id           : v0,
            price            : arg2,
            listing_type     : 1,
            is_kiosk_listing : false,
        };
        0x2::event::emit<ListingCreated>(v4);
        0x2::transfer::share_object<Listing>(v3);
    }

    public entry fun create_kiosk_listing<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 0);
        assert!(0x2::kiosk::owner(arg1) == 0x2::tx_context::sender(arg6), 1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 9);
        0x2::kiosk::list<T0>(arg1, arg2, arg3, arg5);
        let v0 = NFTTypeInfo{type_name: 0x1::string::utf8(arg4)};
        let v1 = Listing{
            id               : 0x2::object::new(arg6),
            owner            : 0x2::tx_context::sender(arg6),
            listing_type     : 0,
            price            : arg5,
            nft_id           : arg3,
            nft_type         : v0,
            status           : 0,
            start_time       : 0x2::tx_context::epoch(arg6),
            end_time         : 0,
            highest_bid      : 0,
            highest_bidder   : @0x0,
            is_kiosk_listing : true,
            kiosk_id         : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        arg0.active_listings = arg0.active_listings + 1;
        let v2 = ListingCreated{
            listing_id       : 0x2::object::id<Listing>(&v1),
            owner            : 0x2::tx_context::sender(arg6),
            nft_id           : arg3,
            price            : arg5,
            listing_type     : 0,
            is_kiosk_listing : true,
        };
        0x2::event::emit<ListingCreated>(v2);
        0x2::transfer::share_object<Listing>(v1);
    }

    public entry fun create_listing<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = NFTTypeInfo{type_name: get_type_name<T0>()};
        let v2 = Listing{
            id               : 0x2::object::new(arg3),
            owner            : 0x2::tx_context::sender(arg3),
            listing_type     : 0,
            price            : arg2,
            nft_id           : v0,
            nft_type         : v1,
            status           : 0,
            start_time       : 0x2::tx_context::epoch(arg3),
            end_time         : 0,
            highest_bid      : 0,
            highest_bidder   : @0x0,
            is_kiosk_listing : false,
            kiosk_id         : 0x2::object::id_from_address(@0x0),
        };
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v2.id, v0, arg1);
        arg0.active_listings = arg0.active_listings + 1;
        let v3 = ListingCreated{
            listing_id       : 0x2::object::id<Listing>(&v2),
            owner            : 0x2::tx_context::sender(arg3),
            nft_id           : v0,
            price            : arg2,
            listing_type     : 0,
            is_kiosk_listing : false,
        };
        0x2::event::emit<ListingCreated>(v3);
        0x2::transfer::share_object<Listing>(v2);
    }

    public entry fun create_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TradableNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
            creator     : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::transfer<TradableNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun create_nft_to_nft_swap<T0: store + key>(arg0: T0, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg0);
        let v1 = NFTTypeInfo{type_name: get_type_name<T0>()};
        let v2 = NFTTypeInfo{type_name: 0x1::string::utf8(arg1)};
        let v3 = SwapListing{
            id                   : 0x2::object::new(arg2),
            creator              : 0x2::tx_context::sender(arg2),
            swap_type            : 0,
            offered_nft_id       : v0,
            offered_nft_type     : v1,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_nft_type   : v2,
            requested_sui_amount : 0,
            offered_sui_amount   : 0,
            status               : 0,
            is_kiosk_swap        : false,
            kiosk_id             : 0x2::object::id_from_address(@0x0),
        };
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v3.id, v0, arg0);
        let v4 = SwapCreated{
            swap_id              : 0x2::object::id<SwapListing>(&v3),
            creator              : 0x2::tx_context::sender(arg2),
            swap_type            : 0,
            offered_nft_id       : v0,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_sui_amount : 0,
            offered_sui_amount   : 0,
            is_kiosk_swap        : false,
        };
        0x2::event::emit<SwapCreated>(v4);
        0x2::transfer::share_object<SwapListing>(v3);
    }

    public entry fun create_nft_to_sui_swap<T0: store + key>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        let v0 = 0x2::object::id<T0>(&arg0);
        let v1 = NFTTypeInfo{type_name: get_type_name<T0>()};
        let v2 = NFTTypeInfo{type_name: 0x1::string::utf8(b"")};
        let v3 = SwapListing{
            id                   : 0x2::object::new(arg2),
            creator              : 0x2::tx_context::sender(arg2),
            swap_type            : 1,
            offered_nft_id       : v0,
            offered_nft_type     : v1,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_nft_type   : v2,
            requested_sui_amount : arg1,
            offered_sui_amount   : 0,
            status               : 0,
            is_kiosk_swap        : false,
            kiosk_id             : 0x2::object::id_from_address(@0x0),
        };
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v3.id, v0, arg0);
        let v4 = SwapCreated{
            swap_id              : 0x2::object::id<SwapListing>(&v3),
            creator              : 0x2::tx_context::sender(arg2),
            swap_type            : 1,
            offered_nft_id       : v0,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_sui_amount : arg1,
            offered_sui_amount   : 0,
            is_kiosk_swap        : false,
        };
        0x2::event::emit<SwapCreated>(v4);
        0x2::transfer::share_object<SwapListing>(v3);
    }

    public entry fun create_sui_to_nft_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3);
        let v1 = NFTTypeInfo{type_name: 0x1::string::utf8(b"")};
        let v2 = NFTTypeInfo{type_name: 0x1::string::utf8(arg1)};
        let v3 = SwapListing{
            id                   : 0x2::object::new(arg2),
            creator              : 0x2::tx_context::sender(arg2),
            swap_type            : 2,
            offered_nft_id       : 0x2::object::id_from_address(@0x0),
            offered_nft_type     : v1,
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_nft_type   : v2,
            requested_sui_amount : 0,
            offered_sui_amount   : v0,
            status               : 0,
            is_kiosk_swap        : false,
            kiosk_id             : 0x2::object::id_from_address(@0x0),
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v3.id, b"payment", arg0);
        let v4 = SwapCreated{
            swap_id              : 0x2::object::id<SwapListing>(&v3),
            creator              : 0x2::tx_context::sender(arg2),
            swap_type            : 2,
            offered_nft_id       : 0x2::object::id_from_address(@0x0),
            requested_nft_id     : 0x2::object::id_from_address(@0x0),
            requested_sui_amount : 0,
            offered_sui_amount   : v0,
            is_kiosk_swap        : false,
        };
        0x2::event::emit<SwapCreated>(v4);
        0x2::transfer::share_object<SwapListing>(v3);
    }

    public entry fun end_auction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Listing, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 4);
        assert!(arg1.listing_type == 1, 14);
        assert!(0x2::tx_context::epoch(arg2) >= arg1.end_time, 5);
        arg1.status = 1;
        arg0.active_listings = arg0.active_listings - 1;
        arg0.completed_trades = arg0.completed_trades + 1;
        if (arg1.highest_bid == 0 || arg1.highest_bidder == @0x0) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg1.nft_id), arg1.owner);
            return
        };
        let v0 = 0x2::dynamic_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, b"current_bid");
        let v1 = arg1.highest_bid * arg0.fee_bps / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1, arg2)));
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1.highest_bid - v1, arg2), arg1.owner);
        arg0.total_volume = arg0.total_volume + arg1.highest_bid;
        arg0.total_fees = arg0.total_fees + v1;
        let v2 = AuctionEnded{
            listing_id  : 0x2::object::id<Listing>(arg1),
            seller      : arg1.owner,
            winner      : arg1.highest_bidder,
            nft_id      : arg1.nft_id,
            final_price : arg1.highest_bid,
            fee_amount  : v1,
        };
        0x2::event::emit<AuctionEnded>(v2);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg1.nft_id), arg1.highest_bidder);
    }

    public fun get_active_listings(arg0: &Marketplace) : u64 {
        arg0.active_listings
    }

    public fun get_completed_trades(arg0: &Marketplace) : u64 {
        arg0.completed_trades
    }

    public fun get_fee(arg0: &Marketplace) : u64 {
        arg0.fee_bps
    }

    public fun get_listing_nft_id(arg0: &Listing) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun get_listing_owner(arg0: &Listing) : address {
        arg0.owner
    }

    public fun get_listing_price(arg0: &Listing) : u64 {
        arg0.price
    }

    public fun get_listing_status(arg0: &Listing) : u8 {
        arg0.status
    }

    public fun get_listing_type(arg0: &Listing) : u8 {
        arg0.listing_type
    }

    public fun get_swap_creator(arg0: &SwapListing) : address {
        arg0.creator
    }

    public fun get_swap_status(arg0: &SwapListing) : u8 {
        arg0.status
    }

    public fun get_swap_type(arg0: &SwapListing) : u8 {
        arg0.swap_type
    }

    public fun get_total_fees(arg0: &Marketplace) : u64 {
        arg0.total_fees
    }

    public fun get_total_volume(arg0: &Marketplace) : u64 {
        arg0.total_volume
    }

    public fun get_treasury_balance(arg0: &Marketplace) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    fun get_type_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    fun init(arg0: NINJA_STORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NINJA_STORE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<TradableNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<TradableNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<TradableNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = Marketplace{
            id               : 0x2::object::new(arg1),
            owner            : 0x2::tx_context::sender(arg1),
            fee_bps          : 250,
            treasury         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_volume     : 0,
            total_fees       : 0,
            active_listings  : 0,
            completed_trades : 0,
        };
        0x2::transfer::share_object<Marketplace>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun place_bid(arg0: &mut Listing, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        assert!(arg0.listing_type == 1, 14);
        assert!(0x2::tx_context::epoch(arg2) < arg0.end_time, 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        if (arg0.highest_bid > 0) {
            assert!(v0 > arg0.highest_bid, 7);
        } else {
            assert!(v0 >= arg0.price, 7);
        };
        if (arg0.highest_bid > 0 && arg0.highest_bidder != @0x0) {
            if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"current_bid")) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, b"current_bid"), arg0.highest_bidder);
            };
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, b"current_bid", arg1);
        arg0.highest_bid = v0;
        arg0.highest_bidder = 0x2::tx_context::sender(arg2);
        let v1 = BidPlaced{
            listing_id : 0x2::object::id<Listing>(arg0),
            bidder     : 0x2::tx_context::sender(arg2),
            bid_amount : v0,
        };
        0x2::event::emit<BidPlaced>(v1);
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 12);
        arg1.fee_bps = arg2;
        let v0 = FeeUpdated{
            old_fee_bps : arg1.fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury) >= arg2, 3);
        let v0 = FeeWithdrawn{
            amount    : arg2,
            recipient : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

