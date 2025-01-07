module 0xd6133353ed06cad52d11e80b4b3dcbb2140f944b55d9acb8e5fd707b3137233b::seed_nft {
    struct MarketPlaceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SeedNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        nft_url: 0x2::url::Url,
    }

    struct Creators has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        item_count: u64,
        market_place_owner: address,
        auction_finisher: address,
    }

    struct Item has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct List has store {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        referal: address,
        royalty_address: address,
        target_price: u64,
        auction_expire_datetime: u64,
        creators: vector<Creator>,
    }

    struct NFTListedEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        price: u64,
    }

    struct NFTUnListedEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct Listing has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Creator has copy, drop, store {
        creator_address: address,
        creator_share: u64,
    }

    struct NFTMintedEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NFTUnlistedEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct Bids has store, key {
        id: 0x2::object::UID,
    }

    struct Bid has store {
        bidder: address,
        price: u64,
        bal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    fun add_bid(arg0: &mut Bids, arg1: 0x2::object::ID, arg2: Bid) {
        0x2::dynamic_field::add<0x2::object::ID, Bid>(&mut arg0.id, arg1, arg2);
    }

    public entry fun bid(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_listed(arg0, arg1), 2);
        let v0 = Listing{id: arg1};
        let v1 = 0x2::dynamic_field::borrow<Listing, List>(&arg0.id, v0);
        assert!(v1.auction_expire_datetime > 0, 3);
        assert!(0x2::tx_context::sender(arg4) != v1.seller, 4);
        assert!(arg2 >= v1.price, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v1.price, 8);
        if (v1.target_price > 0 && arg2 >= v1.target_price) {
            let v2 = 0x2::tx_context::sender(arg4);
            buy_internal(arg0, arg1, arg3, v1.target_price, v2, arg4);
            let v3 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Bids>(&mut arg0.id, b"bids");
            if (bid_exists(v3, arg1)) {
                let Bid {
                    bidder : v4,
                    price  : _,
                    bal    : v6,
                } = get_and_remove_bid(v3, arg1);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4), v4);
            };
        } else {
            let v7 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Bids>(&mut arg0.id, b"bids");
            if (bid_exists(v7, arg1)) {
                let v8 = get_and_remove_bid(v7, arg1);
                let Bid {
                    bidder : v9,
                    price  : v10,
                    bal    : v11,
                } = v8;
                assert!(arg2 > v10, 7);
                if (arg2 > v10) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg4), v9);
                    let v12 = Bid{
                        bidder : 0x2::tx_context::sender(arg4),
                        price  : arg2,
                        bal    : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, arg2, arg4)),
                    };
                    add_bid(v7, arg1, v12);
                } else {
                    let v13 = Bid{
                        bidder : v9,
                        price  : v10,
                        bal    : v11,
                    };
                    add_bid(v7, arg1, v13);
                };
            } else {
                let v14 = Bid{
                    bidder : 0x2::tx_context::sender(arg4),
                    price  : arg2,
                    bal    : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, arg2, arg4)),
                };
                add_bid(v7, arg1, v14);
            };
        };
    }

    fun bid_exists(arg0: &Bids, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public entry fun buy(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        buy_internal(arg0, arg1, arg2, 0, v0, arg3);
    }

    fun buy_internal(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_listed(arg0, arg1), 2);
        let v0 = Item{id: arg1};
        let v1 = 0x2::dynamic_object_field::remove<Item, SeedNFT>(&mut arg0.id, v0);
        let v2 = Listing{id: arg1};
        let List {
            id                      : v3,
            seller                  : v4,
            price                   : v5,
            referal                 : v6,
            royalty_address         : v7,
            target_price            : _,
            auction_expire_datetime : _,
            creators                : v10,
        } = 0x2::dynamic_field::remove<Listing, List>(&mut arg0.id, v2);
        let v11 = v10;
        let v12 = v5;
        assert!(arg4 != v4, 1);
        if (arg3 > 0) {
            v12 = arg3;
        };
        let v13 = *0x2::dynamic_field::borrow<0x1::string::String, u64>(&v1.id, 0x1::string::utf8(b"transfer_count"));
        if (v13 == 0) {
            let v14 = 180 * v12 / 10000;
            let v15 = 20 * v12 / 10000;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v14, arg5), arg0.market_place_owner);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v15, arg5), v6);
            let v16 = 0;
            while (v16 < 0x1::vector::length<Creator>(&v11)) {
                let v17 = 0x1::vector::borrow<Creator>(&v11, v16);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, (v12 - v14 - v15) * v17.creator_share / 10000, arg5), v17.creator_address);
                v16 = v16 + 1;
            };
        } else {
            let v18 = 200 * v12 / 10000;
            let v19 = 100 * v12 / 10000;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v18, arg5), arg0.market_place_owner);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v19, arg5), v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v12 - v18 - v19, arg5), v4);
        };
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut v1.id, 0x1::string::utf8(b"transfer_count")) = 1 + v13;
        0x2::transfer::public_transfer<SeedNFT>(v1, arg4);
        0x2::object::delete(v3);
        arg0.item_count = arg0.item_count - 1;
    }

    public entry fun change_auction_finisher(arg0: &mut Marketplace, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.market_place_owner, 11);
        arg0.auction_finisher = arg1;
    }

    public entry fun change_marketplace_owner(arg0: &mut Marketplace, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.market_place_owner, 11);
        arg0.market_place_owner = arg1;
    }

    public entry fun create_marketplace(arg0: &MarketPlaceAdminCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id                 : 0x2::object::new(arg3),
            item_count         : 0,
            market_place_owner : arg1,
            auction_finisher   : arg2,
        };
        let v1 = Bids{id: 0x2::object::new(arg3)};
        0x2::dynamic_object_field::add<vector<u8>, Bids>(&mut v0.id, b"bids", v1);
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun finish_auction(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_listed(arg0, arg1), 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Listing{id: arg1};
        let v2 = 0x2::dynamic_field::borrow<Listing, List>(&arg0.id, v1);
        assert!(v0 == arg0.market_place_owner || v0 == arg0.auction_finisher || v0 == v2.seller, 9);
        let v3 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Bids>(&mut arg0.id, b"bids");
        if (bid_exists(v3, arg1)) {
            let Bid {
                bidder : v4,
                price  : v5,
                bal    : v6,
            } = get_and_remove_bid(v3, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg3), 0x2::tx_context::sender(arg3));
            buy_internal(arg0, arg1, arg2, v5, v4, arg3);
        } else {
            unlist(arg0, arg1, arg3);
        };
    }

    fun get_and_remove_bid(arg0: &mut Bids, arg1: 0x2::object::ID) : Bid {
        0x2::dynamic_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketPlaceAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MarketPlaceAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_listed(arg0: &Marketplace, arg1: 0x2::object::ID) : bool {
        let v0 = Listing{id: arg1};
        0x2::dynamic_field::exists_<Listing>(&arg0.id, v0)
    }

    public entry fun list(arg0: &mut Marketplace, arg1: SeedNFT, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: vector<address>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<SeedNFT>(&arg1);
        assert!(arg2 > 0, 12);
        assert!(0x1::vector::length<address>(&arg7) == 0x1::vector::length<u64>(&arg8), 2001);
        let v1 = 0x1::vector::empty<Creator>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg7)) {
            let v3 = Creator{
                creator_address : *0x1::vector::borrow<address>(&arg7, v2),
                creator_share   : *0x1::vector::borrow<u64>(&arg8, v2),
            };
            0x1::vector::push_back<Creator>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = List{
            id                      : 0x2::object::new(arg9),
            seller                  : 0x2::tx_context::sender(arg9),
            price                   : arg2,
            referal                 : arg3,
            royalty_address         : arg4,
            target_price            : arg5,
            auction_expire_datetime : arg6,
            creators                : v1,
        };
        place(arg0, arg1);
        let v5 = Listing{id: v0};
        0x2::dynamic_field::add<Listing, List>(&mut arg0.id, v5, v4);
        let v6 = NFTListedEvent{
            object_id : v0,
            creator   : 0x2::tx_context::sender(arg9),
            price     : arg2,
        };
        0x2::event::emit<NFTListedEvent>(v6);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = SeedNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            nft_url     : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v1.id, 0x1::string::utf8(b"transfer_count"), 0);
        let v2 = NFTMintedEvent{
            object_id : 0x2::object::id<SeedNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMintedEvent>(v2);
        0x2::transfer::public_transfer<SeedNFT>(v1, v0);
    }

    fun place(arg0: &mut Marketplace, arg1: SeedNFT) {
        arg0.item_count = arg0.item_count + 1;
        let v0 = Item{id: 0x2::object::id<SeedNFT>(&arg1)};
        0x2::dynamic_object_field::add<Item, SeedNFT>(&mut arg0.id, v0, arg1);
    }

    public entry fun unlist(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_listed(arg0, arg1), 13);
        let v0 = NFTUnlistedEvent{object_id: arg1};
        0x2::event::emit<NFTUnlistedEvent>(v0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = Item{id: arg1};
        let v3 = Listing{id: arg1};
        let List {
            id                      : v4,
            seller                  : v5,
            price                   : _,
            referal                 : _,
            royalty_address         : _,
            target_price            : _,
            auction_expire_datetime : _,
            creators                : _,
        } = 0x2::dynamic_field::remove<Listing, List>(&mut arg0.id, v3);
        assert!(v1 == arg0.market_place_owner || v1 == v5, 10);
        0x2::transfer::public_transfer<SeedNFT>(0x2::dynamic_object_field::remove<Item, SeedNFT>(&mut arg0.id, v2), v5);
        0x2::object::delete(v4);
        arg0.item_count = arg0.item_count - 1;
    }

    // decompiled from Move bytecode v6
}

