module 0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::marketplace {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        fee_rate: u64,
        total_volume: u64,
        total_sales: u64,
        is_frozen: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        listed_at: u64,
    }

    struct MarketplaceCreated has copy, drop {
        marketplace_id: 0x2::object::ID,
        admin: address,
        fee_rate: u64,
    }

    struct NFTListed has copy, drop {
        marketplace_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct NFTSold has copy, drop {
        marketplace_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        marketplace_fee: u64,
        creator_royalty: u64,
    }

    struct NFTDelisted has copy, drop {
        marketplace_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
    }

    struct FeeUpdated has copy, drop {
        marketplace_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    public entry fun buy_nft(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 4);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 3);
        let v0 = 0x2::tx_context::sender(arg3);
        let Listing {
            id        : v1,
            nft_id    : _,
            seller    : v3,
            price     : v4,
            listed_at : _,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        let v6 = v1;
        let v7 = 0x2::dynamic_field::remove<vector<u8>, 0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::RWAToken>(&mut v6, b"nft");
        assert!(!0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::is_nft_frozen(&v7), 8);
        let (v8, v9) = 0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::get_creator_info(&v7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v4, 2);
        assert!(v9 + arg0.fee_rate <= 10000, 10);
        let v10 = v4 * arg0.fee_rate / 10000;
        let v11 = v4 * v9 / 10000;
        let v12 = v4 - v10 - v11;
        let v13 = if (v10 > 0) {
            0x2::coin::split<0x2::sui::SUI>(&mut arg2, v10, arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v14 = v13;
        let v15 = if (v11 > 0) {
            0x2::coin::split<0x2::sui::SUI>(&mut arg2, v11, arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v16 = v15;
        let v17 = if (v12 > 0) {
            0x2::coin::split<0x2::sui::SUI>(&mut arg2, v12, arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v18 = v17;
        if (0x2::coin::value<0x2::sui::SUI>(&v14) > 0) {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v14);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v14);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v16, v8);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v16);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v18) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v18, v3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v18);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        0x2::transfer::public_transfer<0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::RWAToken>(v7, v0);
        arg0.total_volume = arg0.total_volume + v4;
        arg0.total_sales = arg0.total_sales + 1;
        0x2::object::delete(v6);
        let v19 = NFTSold{
            marketplace_id  : 0x2::object::uid_to_inner(&arg0.id),
            listing_id      : 0x2::object::uid_to_inner(&v6),
            nft_id          : arg1,
            seller          : v3,
            buyer           : v0,
            price           : v4,
            marketplace_fee : v10,
            creator_royalty : v11,
        };
        0x2::event::emit<NFTSold>(v19);
    }

    public entry fun create_default_marketplace(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        create_marketplace(arg0, arg1);
    }

    public entry fun create_marketplace(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 100;
        let v1 = 0x2::object::new(arg1);
        let v2 = Marketplace{
            id           : v1,
            fee_rate     : v0,
            total_volume : 0,
            total_sales  : 0,
            is_frozen    : false,
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            listings     : 0x2::table::new<0x2::object::ID, Listing>(arg1),
        };
        let v3 = MarketplaceCreated{
            marketplace_id : 0x2::object::uid_to_inner(&v1),
            admin          : 0x2::tx_context::sender(arg1),
            fee_rate       : v0,
        };
        0x2::event::emit<MarketplaceCreated>(v3);
        0x2::transfer::share_object<Marketplace>(v2);
    }

    public entry fun delist_nft(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 4);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 3);
        assert!(0x2::tx_context::sender(arg2) == @0x4bd10c9fd9e03b5c529871bb83cd055a9a591ce3679fa0c4887836671376424f, 9);
        let v0 = 0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1).seller;
        let Listing {
            id        : v1,
            nft_id    : _,
            seller    : _,
            price     : _,
            listed_at : _,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        let v6 = v1;
        0x2::transfer::public_transfer<0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::RWAToken>(0x2::dynamic_field::remove<vector<u8>, 0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::RWAToken>(&mut v6, b"nft"), v0);
        let v7 = NFTDelisted{
            marketplace_id : 0x2::object::uid_to_inner(&arg0.id),
            listing_id     : 0x2::object::uid_to_inner(&v6),
            nft_id         : arg1,
            seller         : v0,
        };
        0x2::event::emit<NFTDelisted>(v7);
        0x2::object::delete(v6);
    }

    public fun get_listing_info(arg0: &Marketplace, arg1: 0x2::object::ID) : (bool, address, u64, u64) {
        if (0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1)) {
            let v4 = 0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1);
            (true, v4.seller, v4.price, v4.listed_at)
        } else {
            (false, @0x0, 0, 0)
        }
    }

    public fun get_marketplace_balance(arg0: &Marketplace) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_marketplace_info(arg0: &Marketplace) : (u64, u64, u64, bool) {
        (arg0.fee_rate, arg0.total_volume, arg0.total_sales, arg0.is_frozen)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_authorized_lister(arg0: address) : bool {
        arg0 == @0x4bd10c9fd9e03b5c529871bb83cd055a9a591ce3679fa0c4887836671376424f
    }

    public fun is_listed(arg0: &Marketplace, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1)
    }

    public entry fun list_nft(arg0: &mut Marketplace, arg1: 0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::RWAToken, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == @0x4bd10c9fd9e03b5c529871bb83cd055a9a591ce3679fa0c4887836671376424f, 9);
        assert!(!0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::is_nft_frozen(&arg1), 8);
        let v1 = 0x2::object::id<0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::RWAToken>(&arg1);
        assert!(!0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, v1), 6);
        let v2 = 0x2::object::new(arg3);
        let v3 = Listing{
            id        : v2,
            nft_id    : v1,
            seller    : v0,
            price     : arg2,
            listed_at : 0x2::tx_context::epoch(arg3),
        };
        0x2::dynamic_field::add<vector<u8>, 0x40c82099aa577e355ecb311c6c1ef903131258e48bfaa47c13731dfe1d45a9ce::nft::RWAToken>(&mut v3.id, b"nft", arg1);
        0x2::table::add<0x2::object::ID, Listing>(&mut arg0.listings, v1, v3);
        let v4 = NFTListed{
            marketplace_id : 0x2::object::uid_to_inner(&arg0.id),
            listing_id     : 0x2::object::uid_to_inner(&v2),
            nft_id         : v1,
            seller         : v0,
            price          : arg2,
        };
        0x2::event::emit<NFTListed>(v4);
    }

    public entry fun set_marketplace_frozen(arg0: &AdminCap, arg1: &mut Marketplace, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_frozen = arg2;
    }

    public entry fun update_fee_rate(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 5);
        arg1.fee_rate = arg2;
        let v0 = FeeUpdated{
            marketplace_id : 0x2::object::uid_to_inner(&arg1.id),
            old_fee_rate   : arg1.fee_rate,
            new_fee_rate   : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

