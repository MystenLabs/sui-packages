module 0x9e3fcbdd9040ca2e2ed12ab08c9e3eb2832dd932f89c8fa21cc09ada11b79eb0::marketplace {
    struct MarketPlaceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Creators has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        item_count: u64,
        market_place_owner: address,
        auction_finisher: address,
        transfer_count: 0x2::table::Table<0x2::object::ID, u64>,
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
        sender: address,
        price: u64,
        target_price: u64,
        auction_expire_datetime: u64,
    }

    struct Listing has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Creator has copy, drop, store {
        creator_address: address,
        creator_share: u64,
    }

    struct NFTUnlistedEvent has copy, drop {
        object_id: 0x2::object::ID,
        sender: address,
    }

    struct NFTBoughtEvent has copy, drop {
        object_id: 0x2::object::ID,
        sender: address,
        price: u64,
    }

    struct NFTBiddedEvent has copy, drop {
        object_id: 0x2::object::ID,
        sender: address,
        price: u64,
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

    public entry fun bid<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_listed(arg0, arg1), 2);
        let v0 = Listing{id: arg1};
        let v1 = 0x2::dynamic_field::borrow<Listing, List>(&arg0.id, v0);
        assert!(v1.auction_expire_datetime > 0, 3);
        assert!(0x2::tx_context::sender(arg4) != v1.seller, 4);
        assert!(arg2 >= v1.price, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v1.price, 8);
        if (v1.target_price > 0 && arg2 >= v1.target_price) {
            let v2 = 0x2::tx_context::sender(arg4);
            buy_internal<T0>(arg0, arg1, arg3, v1.target_price, v2, arg4);
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
                    update_new_highest_bid(arg3, arg2, v7, arg1, arg4);
                } else {
                    let v12 = Bid{
                        bidder : v9,
                        price  : v10,
                        bal    : v11,
                    };
                    add_bid(v7, arg1, v12);
                };
            } else {
                update_new_highest_bid(arg3, arg2, v7, arg1, arg4);
            };
        };
        let v13 = NFTBiddedEvent{
            object_id : arg1,
            sender    : 0x2::tx_context::sender(arg4),
            price     : arg2,
        };
        0x2::event::emit<NFTBiddedEvent>(v13);
    }

    fun bid_exists(arg0: &Bids, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public entry fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        buy_internal<T0>(arg0, arg1, arg2, 0, v0, arg3);
    }

    fun buy_internal<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_listed(arg0, arg1), 2);
        let v0 = Item{id: arg1};
        let v1 = Listing{id: arg1};
        let List {
            id                      : v2,
            seller                  : v3,
            price                   : v4,
            referal                 : v5,
            royalty_address         : v6,
            target_price            : _,
            auction_expire_datetime : _,
            creators                : v9,
        } = 0x2::dynamic_field::remove<Listing, List>(&mut arg0.id, v1);
        let v10 = v9;
        let v11 = v4;
        assert!(arg4 != v3, 1);
        if (arg3 > 0) {
            v11 = arg3;
        };
        let v12 = 0;
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.transfer_count, arg1)) {
            v12 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.transfer_count, arg1);
        };
        if (v12 == 0) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.transfer_count, arg1, 1);
            let v13 = 180 * v11 / 10000;
            let v14 = 20 * v11 / 10000;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v13, arg5), arg0.market_place_owner);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v14, arg5), v5);
            let v15 = 0;
            while (v15 < 0x1::vector::length<Creator>(&v10)) {
                let v16 = 0x1::vector::borrow<Creator>(&v10, v15);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, (v11 - v13 - v14) * v16.creator_share / 10000, arg5), v16.creator_address);
                v15 = v15 + 1;
            };
        } else {
            let v17 = 200 * v11 / 10000;
            let v18 = 100 * v11 / 10000;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v17, arg5), arg0.market_place_owner);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v18, arg5), v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v11 - v17 - v18, arg5), v3);
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.transfer_count, arg1) = v12 + 1;
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<Item, T0>(&mut arg0.id, v0), arg4);
        0x2::object::delete(v2);
        arg0.item_count = arg0.item_count - 1;
        let v19 = NFTBoughtEvent{
            object_id : arg1,
            sender    : arg4,
            price     : v11,
        };
        0x2::event::emit<NFTBoughtEvent>(v19);
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
            transfer_count     : 0x2::table::new<0x2::object::ID, u64>(arg3),
        };
        let v1 = Bids{id: 0x2::object::new(arg3)};
        0x2::dynamic_object_field::add<vector<u8>, Bids>(&mut v0.id, b"bids", v1);
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public entry fun finish_auction<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
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
            buy_internal<T0>(arg0, arg1, arg2, v5, v4, arg3);
        } else {
            unlist<T0>(arg0, arg1, arg3);
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

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: vector<address>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
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
        place<T0>(arg0, arg1);
        let v5 = Listing{id: v0};
        0x2::dynamic_field::add<Listing, List>(&mut arg0.id, v5, v4);
        let v6 = NFTListedEvent{
            object_id               : v0,
            sender                  : 0x2::tx_context::sender(arg9),
            price                   : arg2,
            target_price            : arg5,
            auction_expire_datetime : arg6,
        };
        0x2::event::emit<NFTListedEvent>(v6);
    }

    fun place<T0: store + key>(arg0: &mut Marketplace, arg1: T0) {
        arg0.item_count = arg0.item_count + 1;
        let v0 = Item{id: 0x2::object::id<T0>(&arg1)};
        0x2::dynamic_object_field::add<Item, T0>(&mut arg0.id, v0, arg1);
    }

    public entry fun unlist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!bid_exists(0x2::dynamic_object_field::borrow<vector<u8>, Bids>(&arg0.id, b"bids"), arg1), 13);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Item{id: arg1};
        let v2 = Listing{id: arg1};
        let List {
            id                      : v3,
            seller                  : v4,
            price                   : _,
            referal                 : _,
            royalty_address         : _,
            target_price            : _,
            auction_expire_datetime : _,
            creators                : _,
        } = 0x2::dynamic_field::remove<Listing, List>(&mut arg0.id, v2);
        let v11 = NFTUnlistedEvent{
            object_id : arg1,
            sender    : v4,
        };
        0x2::event::emit<NFTUnlistedEvent>(v11);
        assert!(v0 == arg0.market_place_owner || v0 == arg0.auction_finisher || v0 == v4, 10);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<Item, T0>(&mut arg0.id, v1), v4);
        0x2::object::delete(v3);
        arg0.item_count = arg0.item_count - 1;
    }

    fun update_new_highest_bid(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut Bids, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Bid{
            bidder : 0x2::tx_context::sender(arg4),
            price  : arg1,
            bal    : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg4)),
        };
        add_bid(arg2, arg3, v0);
    }

    // decompiled from Move bytecode v6
}

