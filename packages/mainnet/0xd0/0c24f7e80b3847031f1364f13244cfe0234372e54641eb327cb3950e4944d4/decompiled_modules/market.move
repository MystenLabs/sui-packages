module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::market {
    struct Bid has store {
        bidder: address,
        offer: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Listing has store {
        nft: 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling,
        seller: address,
        price: u64,
        card_id: 0x1::string::String,
        bids: vector<Bid>,
    }

    struct Market has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bp: u64,
        paused: bool,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
        count: u64,
    }

    struct Listed has copy, drop {
        nft_id: 0x2::object::ID,
        card_id: 0x1::string::String,
        seller: address,
        price: u64,
        serial: u64,
    }

    struct Delisted has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
    }

    struct Bought has copy, drop {
        nft_id: 0x2::object::ID,
        card_id: 0x1::string::String,
        seller: address,
        buyer: address,
        price: u64,
        fee: u64,
        via_bid: bool,
    }

    struct BidPlaced has copy, drop {
        nft_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct BidCancelled has copy, drop {
        nft_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct BidRefunded has copy, drop {
        nft_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    public fun accept_bid(arg0: &mut Market, arg1: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::revenue::Vault, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 0);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg2), 3);
        let Listing {
            nft     : v0,
            seller  : v1,
            price   : _,
            card_id : v3,
            bids    : v4,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg2);
        let v5 = v4;
        assert!(v1 == 0x2::tx_context::sender(arg4), 1);
        arg0.count = arg0.count - 1;
        let v6 = 0x1::vector::length<Bid>(&v5);
        let v7 = false;
        let v8 = 0;
        while (v8 < v6) {
            if (0x1::vector::borrow<Bid>(&v5, v8).bidder == arg3) {
                v7 = true;
                v8 = v6;
                continue
            };
            v8 = v8 + 1;
        };
        assert!(v7, 7);
        let Bid {
            bidder : v9,
            offer  : v10,
        } = 0x1::vector::remove<Bid>(&mut v5, 0);
        let v11 = v10;
        let v12 = 0x2::coin::from_balance<0x2::sui::SUI>(v11, arg4);
        let v13 = settle(arg0.fee_bp, arg1, v12, v1, arg4);
        refund_all(arg2, v5, arg4);
        0x2::transfer::public_transfer<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(v0, v9);
        let v14 = Bought{
            nft_id  : arg2,
            card_id : v3,
            seller  : v1,
            buyer   : v9,
            price   : 0x2::balance::value<0x2::sui::SUI>(&v11),
            fee     : v13,
            via_bid : true,
        };
        0x2::event::emit<Bought>(v14);
    }

    public fun bid(arg0: &mut Market, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 0);
        assert!(!arg0.paused, 6);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0 >= v2.price / 20, 10);
        assert!(0x1::vector::length<Bid>(&v2.bids) < 20, 5);
        let v3 = 0;
        while (v3 < 0x1::vector::length<Bid>(&v2.bids)) {
            assert!(0x1::vector::borrow<Bid>(&v2.bids, v3).bidder != v1, 8);
            v3 = v3 + 1;
        };
        let v4 = Bid{
            bidder : v1,
            offer  : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
        };
        0x1::vector::push_back<Bid>(&mut v2.bids, v4);
        let v5 = BidPlaced{
            nft_id : arg1,
            bidder : v1,
            amount : v0,
        };
        0x2::event::emit<BidPlaced>(v5);
    }

    public fun buy(arg0: &mut Market, arg1: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::revenue::Vault, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 0);
        assert!(!arg0.paused, 6);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg2), 3);
        let Listing {
            nft     : v0,
            seller  : v1,
            price   : v2,
            card_id : v3,
            bids    : v4,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v2, 2);
        arg0.count = arg0.count - 1;
        let v5 = 0x2::tx_context::sender(arg4);
        let v6 = settle(arg0.fee_bp, arg1, arg3, v1, arg4);
        refund_all(arg2, v4, arg4);
        0x2::transfer::public_transfer<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(v0, v5);
        let v7 = Bought{
            nft_id  : arg2,
            card_id : v3,
            seller  : v1,
            buyer   : v5,
            price   : v2,
            fee     : v6,
            via_bid : false,
        };
        0x2::event::emit<Bought>(v7);
    }

    public fun cancel_bid(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 0);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Bid>(&v0.bids)) {
            if (0x1::vector::borrow<Bid>(&v0.bids, v1).bidder == 0x2::tx_context::sender(arg2)) {
                let Bid {
                    bidder : v2,
                    offer  : v3,
                } = 0x1::vector::remove<Bid>(&mut v0.bids, v1);
                let v4 = v3;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg2), v2);
                let v5 = BidCancelled{
                    nft_id : arg1,
                    bidder : v2,
                    amount : 0x2::balance::value<0x2::sui::SUI>(&v4),
                };
                0x2::event::emit<BidCancelled>(v5);
                return
            };
            v1 = v1 + 1;
        };
        abort 7
    }

    public fun create(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 1000, 9);
        let v0 = Market{
            id       : 0x2::object::new(arg2),
            version  : 2,
            fee_bp   : arg1,
            paused   : false,
            listings : 0x2::table::new<0x2::object::ID, Listing>(arg2),
            count    : 0,
        };
        0x2::transfer::share_object<Market>(v0);
    }

    public fun delist(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 0);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 3);
        let Listing {
            nft     : v0,
            seller  : v1,
            price   : _,
            card_id : _,
            bids    : v4,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v1 == 0x2::tx_context::sender(arg2), 1);
        arg0.count = arg0.count - 1;
        refund_all(arg1, v4, arg2);
        0x2::transfer::public_transfer<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(v0, v1);
        let v5 = Delisted{
            nft_id : arg1,
            seller : v1,
        };
        0x2::event::emit<Delisted>(v5);
    }

    public fun fee_bp(arg0: &Market) : u64 {
        arg0.fee_bp
    }

    public fun list(arg0: &mut Market, arg1: 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 0);
        assert!(!arg0.paused, 6);
        assert!(arg2 > 0, 4);
        let v0 = 0x2::object::id<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(&arg1);
        let v1 = *0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::card_id(&arg1);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = Listing{
            nft     : arg1,
            seller  : v2,
            price   : arg2,
            card_id : v1,
            bids    : 0x1::vector::empty<Bid>(),
        };
        0x2::table::add<0x2::object::ID, Listing>(&mut arg0.listings, v0, v3);
        arg0.count = arg0.count + 1;
        let v4 = Listed{
            nft_id  : v0,
            card_id : v1,
            seller  : v2,
            price   : arg2,
            serial  : 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::serial(&arg1),
        };
        0x2::event::emit<Listed>(v4);
    }

    public fun listing_count(arg0: &Market) : u64 {
        arg0.count
    }

    public fun migrate(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut Market) {
        assert!(arg1.version < 2, 0);
        arg1.version = 2;
    }

    fun refund_all(arg0: 0x2::object::ID, arg1: vector<Bid>, arg2: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<Bid>(&arg1)) {
            let Bid {
                bidder : v0,
                offer  : v1,
            } = 0x1::vector::pop_back<Bid>(&mut arg1);
            let v2 = v1;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg2), v0);
            let v3 = BidRefunded{
                nft_id : arg0,
                bidder : v0,
                amount : 0x2::balance::value<0x2::sui::SUI>(&v2),
            };
            0x2::event::emit<BidRefunded>(v3);
        };
        0x1::vector::destroy_empty<Bid>(arg1);
    }

    public fun set_fee(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut Market, arg2: u64) {
        assert!(arg1.version == 2, 0);
        assert!(arg2 <= 1000, 9);
        arg1.fee_bp = arg2;
    }

    public fun set_paused(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut Market, arg2: bool) {
        assert!(arg1.version == 2, 0);
        arg1.paused = arg2;
    }

    public fun set_price(arg0: &mut Market, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 0);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 3);
        assert!(arg2 > 0, 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.seller == 0x2::tx_context::sender(arg3), 1);
        v0.price = arg2;
        let v1 = Listed{
            nft_id  : arg1,
            card_id : v0.card_id,
            seller  : v0.seller,
            price   : arg2,
            serial  : 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::serial(&v0.nft),
        };
        0x2::event::emit<Listed>(v1);
    }

    fun settle(arg0: u64, arg1: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::revenue::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = (((0x2::coin::value<0x2::sui::SUI>(&arg2) as u128) * (arg0 as u128) / 10000) as u64);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (v0 > 0) {
            0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::revenue::deposit(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v0), arg4));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4), arg3);
        v0
    }

    // decompiled from Move bytecode v7
}

