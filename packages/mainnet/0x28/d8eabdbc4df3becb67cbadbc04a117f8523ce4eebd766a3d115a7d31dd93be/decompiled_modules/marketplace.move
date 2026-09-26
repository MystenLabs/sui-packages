module 0x28d8eabdbc4df3becb67cbadbc04a117f8523ce4eebd766a3d115a7d31dd93be::marketplace {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketplaceConfig has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        treasury: address,
        total_listings: u64,
        active_listings: u64,
        total_sales: u64,
        total_volume: u64,
        total_fees: u64,
    }

    struct Listing has key {
        id: 0x2::object::UID,
        nft: 0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT,
        seller: address,
        price: u64,
        tier: u8,
        mint_number: u64,
        created_at: u64,
    }

    struct Listed has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        tier: u8,
        mint_number: u64,
        timestamp: u64,
    }

    struct Sold has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        fee: u64,
        seller_proceeds: u64,
        tier: u8,
        mint_number: u64,
        timestamp: u64,
    }

    struct Cancelled has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        timestamp: u64,
    }

    struct PriceUpdated has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        old_price: u64,
        new_price: u64,
        timestamp: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct TreasuryUpdated has copy, drop {
        old_treasury: address,
        new_treasury: address,
    }

    public fun buy<T0>(arg0: &mut MarketplaceConfig, arg1: Listing, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<T0>(&arg2) >= arg1.price, 2);
        let Listing {
            id          : v1,
            nft         : v2,
            seller      : v3,
            price       : v4,
            tier        : v5,
            mint_number : v6,
            created_at  : _,
        } = arg1;
        let v8 = v2;
        let v9 = v1;
        let v10 = v4 * arg0.fee_bps / 10000;
        let v11 = v4 - v10;
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v10, arg4), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v11, arg4), v3);
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        0x2::transfer::public_transfer<0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT>(v8, v0);
        if (arg0.active_listings > 0) {
            arg0.active_listings = arg0.active_listings - 1;
        };
        arg0.total_sales = arg0.total_sales + 1;
        arg0.total_volume = arg0.total_volume + v4;
        arg0.total_fees = arg0.total_fees + v10;
        let v12 = Sold{
            listing_id      : 0x2::object::uid_to_inner(&v9),
            nft_id          : 0x2::object::id<0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT>(&v8),
            seller          : v3,
            buyer           : v0,
            price           : v4,
            fee             : v10,
            seller_proceeds : v11,
            tier            : v5,
            mint_number     : v6,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Sold>(v12);
        0x2::object::delete(v9);
    }

    public fun cancel(arg0: &mut MarketplaceConfig, arg1: Listing, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.seller, 1);
        let Listing {
            id          : v0,
            nft         : v1,
            seller      : v2,
            price       : _,
            tier        : _,
            mint_number : _,
            created_at  : _,
        } = arg1;
        let v7 = v1;
        let v8 = v0;
        0x2::transfer::public_transfer<0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT>(v7, v2);
        if (arg0.active_listings > 0) {
            arg0.active_listings = arg0.active_listings - 1;
        };
        let v9 = Cancelled{
            listing_id : 0x2::object::uid_to_inner(&v8),
            nft_id     : 0x2::object::id<0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT>(&v7),
            seller     : v2,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Cancelled>(v9);
        0x2::object::delete(v8);
    }

    public fun fee_bps(arg0: &MarketplaceConfig) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceConfig{
            id              : 0x2::object::new(arg0),
            fee_bps         : 500,
            treasury        : 0x2::tx_context::sender(arg0),
            total_listings  : 0,
            active_listings : 0,
            total_sales     : 0,
            total_volume    : 0,
            total_fees      : 0,
        };
        0x2::transfer::share_object<MarketplaceConfig>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun list(arg0: &mut MarketplaceConfig, arg1: 0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        let v0 = 0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::get_tier(&arg1);
        let v1 = 0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::get_mint_number(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = Listing{
            id          : 0x2::object::new(arg4),
            nft         : arg1,
            seller      : 0x2::tx_context::sender(arg4),
            price       : arg2,
            tier        : v0,
            mint_number : v1,
            created_at  : v2,
        };
        arg0.total_listings = arg0.total_listings + 1;
        arg0.active_listings = arg0.active_listings + 1;
        let v4 = Listed{
            listing_id  : 0x2::object::id<Listing>(&v3),
            nft_id      : 0x2::object::id<0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT>(&arg1),
            seller      : 0x2::tx_context::sender(arg4),
            price       : arg2,
            tier        : v0,
            mint_number : v1,
            timestamp   : v2,
        };
        0x2::event::emit<Listed>(v4);
        0x2::transfer::share_object<Listing>(v3);
    }

    public fun listing_mint_number(arg0: &Listing) : u64 {
        arg0.mint_number
    }

    public fun listing_price(arg0: &Listing) : u64 {
        arg0.price
    }

    public fun listing_seller(arg0: &Listing) : address {
        arg0.seller
    }

    public fun listing_tier(arg0: &Listing) : u8 {
        arg0.tier
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut MarketplaceConfig, arg2: u64) {
        assert!(arg2 <= 2000, 4);
        arg1.fee_bps = arg2;
        let v0 = FeeUpdated{
            old_fee_bps : arg1.fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut MarketplaceConfig, arg2: address) {
        arg1.treasury = arg2;
        let v0 = TreasuryUpdated{
            old_treasury : arg1.treasury,
            new_treasury : arg2,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun stats(arg0: &MarketplaceConfig) : (u64, u64, u64, u64, u64, u64) {
        (arg0.total_listings, arg0.active_listings, arg0.total_sales, arg0.total_volume, arg0.total_fees, arg0.fee_bps)
    }

    public fun treasury(arg0: &MarketplaceConfig) : address {
        arg0.treasury
    }

    public fun update_price(arg0: &mut Listing, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 1);
        assert!(arg1 > 0, 3);
        arg0.price = arg1;
        let v0 = PriceUpdated{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : 0x2::object::id<0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT>(&arg0.nft),
            seller     : arg0.seller,
            old_price  : arg0.price,
            new_price  : arg1,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

