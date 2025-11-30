module 0x271f7facd86c4d18a5f52ca16b0b6b9654006191bbab2e14bc1a784ea35069b7::nft_factory {
    struct NFT_FACTORY has drop {
        dummy_field: bool,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        admin: address,
        platform_fee_bps: u64,
        collection_creation_fee: u64,
        mint_fee: u64,
        treasury: address,
        fees_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_fees_collected: u128,
        total_nfts_minted: u128,
        total_collections: u64,
        is_paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        symbol: 0x1::string::String,
        creator: address,
        royalty_bps: u64,
        royalty_recipient: address,
        max_supply: u64,
        current_supply: u64,
        base_uri: 0x1::string::String,
        image_url: 0x1::string::String,
        external_url: 0x1::string::String,
        mint_price: u64,
        mint_start: u64,
        mint_end: u64,
        max_per_wallet: u64,
        mints_per_wallet: 0x2::table::Table<address, u64>,
        is_active: bool,
        is_paused: bool,
        authorized_minters: vector<address>,
        created_at: u64,
        total_volume: u128,
    }

    struct CollectionCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        collection_id: 0x2::object::ID,
        token_id: u64,
        attributes: vector<Attribute>,
        creator: address,
        created_at: u64,
        royalty_bps: u64,
    }

    struct Attribute has copy, drop, store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        collection_id: 0x2::object::ID,
        created_at: u64,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
        total_volume: u128,
        total_sales: u64,
        platform_config_id: 0x2::object::ID,
    }

    struct PlatformInitialized has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        treasury: address,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        creator: address,
        max_supply: u64,
        royalty_bps: u64,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        token_id: u64,
        name: 0x1::string::String,
        minter: address,
        recipient: address,
    }

    struct NFTBatchMinted has copy, drop {
        collection_id: 0x2::object::ID,
        start_token_id: u64,
        count: u64,
        minter: address,
        recipient: address,
    }

    struct NFTListed has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct NFTSold has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        royalty_paid: u64,
        platform_fee_paid: u64,
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
    }

    struct FeesUpdated has copy, drop {
        platform_fee_bps: u64,
        collection_creation_fee: u64,
        mint_fee: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct CollectionUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        field: 0x1::string::String,
    }

    struct MinterAuthorized has copy, drop {
        collection_id: 0x2::object::ID,
        minter: address,
    }

    struct MinterRevoked has copy, drop {
        collection_id: 0x2::object::ID,
        minter: address,
    }

    public entry fun authorize_minter(arg0: &CollectionCap, arg1: &mut Collection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 0);
        if (!0x1::vector::contains<address>(&arg1.authorized_minters, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.authorized_minters, arg2);
        };
        let v0 = MinterCap{
            id            : 0x2::object::new(arg3),
            collection_id : 0x2::object::id<Collection>(arg1),
        };
        let v1 = MinterAuthorized{
            collection_id : 0x2::object::id<Collection>(arg1),
            minter        : arg2,
        };
        0x2::event::emit<MinterAuthorized>(v1);
        0x2::transfer::public_transfer<MinterCap>(v0, arg2);
    }

    public entry fun batch_mint(arg0: &CollectionCap, arg1: &mut PlatformConfig, arg2: &mut Collection, arg3: vector<address>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 18);
        assert!(!arg2.is_paused, 18);
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg2), 0);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0 && v0 <= 100, 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg4), 10);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg5), 10);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg6), 10);
        if (arg2.max_supply > 0) {
            assert!(arg2.current_supply + v0 <= arg2.max_supply, 2);
        };
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = arg2.current_supply + 1;
            arg2.current_supply = v3;
            0x2::transfer::public_transfer<NFT>(create_nft_internal(arg2, *0x1::vector::borrow<vector<u8>>(&arg4, v2), *0x1::vector::borrow<vector<u8>>(&arg5, v2), *0x1::vector::borrow<vector<u8>>(&arg6, v2), 0x1::vector::empty<vector<u8>>(), 0x1::vector::empty<vector<u8>>(), v3, v1, 0x2::clock::timestamp_ms(arg7), arg8), *0x1::vector::borrow<address>(&arg3, v2));
            v2 = v2 + 1;
        };
        arg1.total_nfts_minted = safe_add_u128(arg1.total_nfts_minted, (v0 as u128));
        let v4 = NFTBatchMinted{
            collection_id  : 0x2::object::id<Collection>(arg2),
            start_token_id : arg2.current_supply + 1,
            count          : v0,
            minter         : v1,
            recipient      : *0x1::vector::borrow<address>(&arg3, 0),
        };
        0x2::event::emit<NFTBatchMinted>(v4);
    }

    public entry fun buy_nft(arg0: &mut PlatformConfig, arg1: &mut Marketplace, arg2: &mut Collection, arg3: NFT, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<NFT>(&arg3);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg1.listings, v0), 13);
        let Listing {
            id            : v1,
            nft_id        : _,
            seller        : v3,
            price         : v4,
            collection_id : _,
            created_at    : _,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg1.listings, v0);
        0x2::object::delete(v1);
        let v7 = 0x2::tx_context::sender(arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v4, 3);
        let v8 = (v4 as u128);
        let v9 = ((v8 * (arg0.platform_fee_bps as u128) / (10000 as u128)) as u64);
        let v10 = ((v8 * (arg2.royalty_bps as u128) / (10000 as u128)) as u64);
        let v11 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        if (v9 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v11, v9));
            arg0.total_fees_collected = safe_add_u128(arg0.total_fees_collected, (v9 as u128));
        };
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v11, v10), arg5), arg2.royalty_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v11, v4 - v9 - v10), arg5), v3);
        if (0x2::balance::value<0x2::sui::SUI>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg5), v7);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
        };
        arg1.total_volume = safe_add_u128(arg1.total_volume, v8);
        arg1.total_sales = arg1.total_sales + 1;
        arg2.total_volume = safe_add_u128(arg2.total_volume, v8);
        let v12 = NFTSold{
            nft_id            : v0,
            seller            : v3,
            buyer             : v7,
            price             : v4,
            royalty_paid      : v10,
            platform_fee_paid : v9,
        };
        0x2::event::emit<NFTSold>(v12);
        0x2::transfer::public_transfer<NFT>(arg3, v7);
    }

    public fun can_mint(arg0: &Collection, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!arg0.is_active || arg0.is_paused) {
            return false
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.mint_start > 0 && v0 < arg0.mint_start) {
            return false
        };
        if (arg0.mint_end > 0 && v0 > arg0.mint_end) {
            return false
        };
        if (arg0.max_supply > 0 && arg0.current_supply >= arg0.max_supply) {
            return false
        };
        if (arg0.max_per_wallet > 0) {
            if (get_mints_for_wallet(arg0, arg1) >= arg0.max_per_wallet) {
                return false
            };
        };
        true
    }

    public entry fun cancel_listing(arg0: &mut Marketplace, arg1: NFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<NFT>(&arg1);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, v0), 13);
        let v1 = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, v0);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(v1.seller == v2, 14);
        let Listing {
            id            : v3,
            nft_id        : v4,
            seller        : v5,
            price         : _,
            collection_id : _,
            created_at    : _,
        } = v1;
        0x2::object::delete(v3);
        let v9 = ListingCancelled{
            listing_id : 0x2::object::id<Listing>(&v1),
            nft_id     : v4,
            seller     : v5,
        };
        0x2::event::emit<ListingCancelled>(v9);
        0x2::transfer::public_transfer<NFT>(arg1, v2);
    }

    public entry fun create_collection(arg0: &mut PlatformConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 18);
        assert!(arg7 <= 1000, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg13) >= arg0.collection_creation_fee, 3);
        let v0 = 0x2::tx_context::sender(arg15);
        if (arg0.collection_creation_fee > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg13));
            arg0.total_fees_collected = safe_add_u128(arg0.total_fees_collected, (arg0.collection_creation_fee as u128));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg13, v0);
        };
        let v1 = Collection{
            id                 : 0x2::object::new(arg15),
            name               : 0x1::string::utf8(arg1),
            description        : 0x1::string::utf8(arg2),
            symbol             : 0x1::string::utf8(arg3),
            creator            : v0,
            royalty_bps        : arg7,
            royalty_recipient  : v0,
            max_supply         : arg8,
            current_supply     : 0,
            base_uri           : 0x1::string::utf8(arg6),
            image_url          : 0x1::string::utf8(arg4),
            external_url       : 0x1::string::utf8(arg5),
            mint_price         : arg9,
            mint_start         : arg10,
            mint_end           : arg11,
            max_per_wallet     : arg12,
            mints_per_wallet   : 0x2::table::new<address, u64>(arg15),
            is_active          : true,
            is_paused          : false,
            authorized_minters : 0x1::vector::empty<address>(),
            created_at         : 0x2::clock::timestamp_ms(arg14),
            total_volume       : 0,
        };
        let v2 = 0x2::object::id<Collection>(&v1);
        let v3 = CollectionCap{
            id            : 0x2::object::new(arg15),
            collection_id : v2,
        };
        arg0.total_collections = arg0.total_collections + 1;
        let v4 = CollectionCreated{
            collection_id : v2,
            name          : 0x1::string::utf8(arg1),
            symbol        : 0x1::string::utf8(arg3),
            creator       : v0,
            max_supply    : arg8,
            royalty_bps   : arg7,
        };
        0x2::event::emit<CollectionCreated>(v4);
        0x2::transfer::share_object<Collection>(v1);
        0x2::transfer::public_transfer<CollectionCap>(v3, v0);
    }

    fun create_nft_internal(arg0: &Collection, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: u64, arg7: address, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x1::vector::empty<Attribute>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg4)) {
            let v2 = Attribute{
                trait_type : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v1)),
                value      : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg5, v1)),
            };
            0x1::vector::push_back<Attribute>(&mut v0, v2);
            v1 = v1 + 1;
        };
        NFT{
            id            : 0x2::object::new(arg9),
            name          : 0x1::string::utf8(arg1),
            description   : 0x1::string::utf8(arg2),
            image_url     : 0x1::string::utf8(arg3),
            collection_id : 0x2::object::id<Collection>(arg0),
            token_id      : arg6,
            attributes    : v0,
            creator       : arg7,
            created_at    : arg8,
            royalty_bps   : arg0.royalty_bps,
        }
    }

    public entry fun create_transfer_policy(arg0: &CollectionCap, arg1: &Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 0);
        0x2::tx_context::sender(arg2);
        let v0 = CollectionUpdated{
            collection_id : 0x2::object::id<Collection>(arg1),
            field         : 0x1::string::utf8(b"transfer_policy_created"),
        };
        0x2::event::emit<CollectionUpdated>(v0);
    }

    public entry fun create_user_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun get_collection_info(arg0: &Collection) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, u64, u64, u64, u64, bool, u128) {
        (arg0.name, arg0.symbol, arg0.description, arg0.creator, arg0.royalty_bps, arg0.max_supply, arg0.current_supply, arg0.mint_price, arg0.is_active, arg0.total_volume)
    }

    public fun get_marketplace_stats(arg0: &Marketplace) : (u128, u64) {
        (arg0.total_volume, arg0.total_sales)
    }

    fun get_mints_for_wallet(arg0: &Collection, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.mints_per_wallet, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.mints_per_wallet, arg1)
        } else {
            0
        }
    }

    public fun get_nft_info(arg0: &NFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x2::object::ID, u64, address, u64) {
        (arg0.name, arg0.description, arg0.image_url, arg0.collection_id, arg0.token_id, arg0.creator, arg0.royalty_bps)
    }

    public fun get_platform_stats(arg0: &PlatformConfig) : (u64, u64, u64, u128, u128, u64) {
        (arg0.platform_fee_bps, arg0.collection_creation_fee, arg0.mint_fee, arg0.total_fees_collected, arg0.total_nfts_minted, arg0.total_collections)
    }

    fun increment_mints_for_wallet(arg0: &mut Collection, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.mints_per_wallet, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.mints_per_wallet, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.mints_per_wallet, arg1, 1);
        };
    }

    fun init(arg0: NFT_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = @0xcc1d481c102781f7796ff4ddb83b3122b06704338b194cf1b109544595061261;
        let v2 = PlatformConfig{
            id                      : 0x2::object::new(arg1),
            admin                   : v0,
            platform_fee_bps        : 200,
            collection_creation_fee : 1000000000,
            mint_fee                : 10000000,
            treasury                : v1,
            fees_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            total_fees_collected    : 0,
            total_nfts_minted       : 0,
            total_collections       : 0,
            is_paused               : false,
        };
        let v3 = 0x2::object::id<PlatformConfig>(&v2);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = Marketplace{
            id                 : 0x2::object::new(arg1),
            listings           : 0x2::table::new<0x2::object::ID, Listing>(arg1),
            total_volume       : 0,
            total_sales        : 0,
            platform_config_id : v3,
        };
        let v6 = 0x2::package::claim<NFT_FACTORY>(arg0, arg1);
        let v7 = 0x2::display::new<NFT>(&v6, arg1);
        0x2::display::add<NFT>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFT>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<NFT>(&mut v7, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<NFT>(&mut v7, 0x1::string::utf8(b"collection_id"), 0x1::string::utf8(b"{collection_id}"));
        0x2::display::add<NFT>(&mut v7, 0x1::string::utf8(b"token_id"), 0x1::string::utf8(b"{token_id}"));
        0x2::display::update_version<NFT>(&mut v7);
        let v8 = 0x2::display::new<Collection>(&v6, arg1);
        0x2::display::add<Collection>(&mut v8, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Collection>(&mut v8, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Collection>(&mut v8, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Collection>(&mut v8, 0x1::string::utf8(b"symbol"), 0x1::string::utf8(b"{symbol}"));
        0x2::display::add<Collection>(&mut v8, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"{external_url}"));
        0x2::display::update_version<Collection>(&mut v8);
        let v9 = PlatformInitialized{
            config_id : v3,
            admin     : v0,
            treasury  : v1,
        };
        0x2::event::emit<PlatformInitialized>(v9);
        0x2::transfer::share_object<PlatformConfig>(v2);
        0x2::transfer::share_object<Marketplace>(v5);
        0x2::transfer::public_transfer<AdminCap>(v4, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, v0);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v7, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Collection>>(v8, v0);
    }

    public entry fun kiosk_delist(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::delist<NFT>(arg0, arg1, arg2);
    }

    public entry fun kiosk_list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 12);
        0x2::kiosk::list<NFT>(arg0, arg1, arg2, arg3);
    }

    public entry fun kiosk_take(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(0x2::kiosk::take<NFT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    public entry fun list_nft(arg0: &mut Marketplace, arg1: NFT, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 12);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<NFT>(&arg1);
        let v2 = Listing{
            id            : 0x2::object::new(arg4),
            nft_id        : v1,
            seller        : v0,
            price         : arg2,
            collection_id : arg1.collection_id,
            created_at    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<0x2::object::ID, Listing>(&mut arg0.listings, v1, v2);
        let v3 = NFTListed{
            listing_id : 0x2::object::id<Listing>(&v2),
            nft_id     : v1,
            seller     : v0,
            price      : arg2,
        };
        0x2::event::emit<NFTListed>(v3);
        let v4 = 0x2::object::id<Marketplace>(arg0);
        0x2::transfer::public_transfer<NFT>(arg1, 0x2::object::id_to_address(&v4));
    }

    public entry fun mint_nft(arg0: &mut PlatformConfig, arg1: &mut Collection, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 18);
        assert!(!arg1.is_paused, 18);
        assert!(arg1.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        if (arg1.mint_start > 0) {
            assert!(v1 >= arg1.mint_start, 5);
        };
        if (arg1.mint_end > 0) {
            assert!(v1 <= arg1.mint_end, 6);
        };
        if (arg1.max_supply > 0) {
            assert!(arg1.current_supply < arg1.max_supply, 2);
        };
        if (arg1.max_per_wallet > 0) {
            assert!(get_mints_for_wallet(arg1, v0) < arg1.max_per_wallet, 7);
            increment_mints_for_wallet(arg1, v0, arg9);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= safe_add_u64(arg1.mint_price, arg0.mint_fee), 3);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg7);
        if (arg0.mint_fee > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, arg0.mint_fee));
            arg0.total_fees_collected = safe_add_u128(arg0.total_fees_collected, (arg0.mint_fee as u128));
        };
        if (arg1.mint_price > 0 && 0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg9), arg1.creator);
        } else if (0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg9), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        };
        let v3 = arg1.current_supply + 1;
        arg1.current_supply = v3;
        let v4 = create_nft_internal(arg1, arg2, arg3, arg4, arg5, arg6, v3, v0, v1, arg9);
        arg0.total_nfts_minted = safe_add_u128(arg0.total_nfts_minted, 1);
        let v5 = NFTMinted{
            nft_id        : 0x2::object::id<NFT>(&v4),
            collection_id : 0x2::object::id<Collection>(arg1),
            token_id      : v3,
            name          : 0x1::string::utf8(arg2),
            minter        : v0,
            recipient     : v0,
        };
        0x2::event::emit<NFTMinted>(v5);
        0x2::transfer::public_transfer<NFT>(v4, v0);
    }

    public entry fun mint_nft_authorized(arg0: &MinterCap, arg1: &mut PlatformConfig, arg2: &mut Collection, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 18);
        assert!(!arg2.is_paused, 18);
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg2), 17);
        assert!(arg2.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg10);
        if (arg2.max_supply > 0) {
            assert!(arg2.current_supply < arg2.max_supply, 2);
        };
        let v1 = arg2.current_supply + 1;
        arg2.current_supply = v1;
        let v2 = create_nft_internal(arg2, arg4, arg5, arg6, arg7, arg8, v1, v0, 0x2::clock::timestamp_ms(arg9), arg10);
        arg1.total_nfts_minted = safe_add_u128(arg1.total_nfts_minted, 1);
        let v3 = NFTMinted{
            nft_id        : 0x2::object::id<NFT>(&v2),
            collection_id : 0x2::object::id<Collection>(arg2),
            token_id      : v1,
            name          : 0x1::string::utf8(arg4),
            minter        : v0,
            recipient     : arg3,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<NFT>(v2, arg3);
    }

    public entry fun place_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: NFT, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::place<NFT>(arg0, arg1, arg2);
    }

    public entry fun revoke_minter(arg0: &CollectionCap, arg1: &mut Collection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.authorized_minters, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.authorized_minters, v1);
        };
        let v2 = MinterRevoked{
            collection_id : 0x2::object::id<Collection>(arg1),
            minter        : arg2,
        };
        0x2::event::emit<MinterRevoked>(v2);
    }

    fun safe_add_u128(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455 - arg1, 15);
        arg0 + arg1
    }

    fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 15);
        arg0 + arg1
    }

    public entry fun set_collection_paused(arg0: &CollectionCap, arg1: &mut Collection, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 0);
        arg1.is_paused = arg2;
    }

    public entry fun set_platform_paused(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_paused = arg2;
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: &mut PlatformConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 16);
        arg1.admin = arg2;
        0x2::transfer::public_transfer<AdminCap>(arg0, arg2);
    }

    public entry fun update_collection(arg0: &CollectionCap, arg1: &mut Collection, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 0);
        if (0x1::vector::length<u8>(&arg2) > 0) {
            arg1.description = 0x1::string::utf8(arg2);
        };
        if (0x1::vector::length<u8>(&arg3) > 0) {
            arg1.image_url = 0x1::string::utf8(arg3);
        };
        if (0x1::vector::length<u8>(&arg4) > 0) {
            arg1.external_url = 0x1::string::utf8(arg4);
        };
        arg1.mint_price = arg5;
        arg1.mint_start = arg6;
        arg1.mint_end = arg7;
        arg1.max_per_wallet = arg8;
        let v0 = CollectionUpdated{
            collection_id : 0x2::object::id<Collection>(arg1),
            field         : 0x1::string::utf8(b"settings"),
        };
        0x2::event::emit<CollectionUpdated>(v0);
    }

    public entry fun update_fees(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 500, 8);
        arg1.platform_fee_bps = arg2;
        arg1.collection_creation_fee = arg3;
        arg1.mint_fee = arg4;
        let v0 = FeesUpdated{
            platform_fee_bps        : arg2,
            collection_creation_fee : arg3,
            mint_fee                : arg4,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public entry fun update_listing_price(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 12);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 13);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.seller == 0x2::tx_context::sender(arg3), 14);
        v0.price = arg2;
    }

    public entry fun update_royalty(arg0: &CollectionCap, arg1: &mut Collection, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 0);
        assert!(arg2 <= 1000, 1);
        assert!(arg3 != @0x0, 16);
        arg1.royalty_bps = arg2;
        arg1.royalty_recipient = arg3;
        let v0 = CollectionUpdated{
            collection_id : 0x2::object::id<Collection>(arg1),
            field         : 0x1::string::utf8(b"royalty"),
        };
        0x2::event::emit<CollectionUpdated>(v0);
    }

    public entry fun update_treasury(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 16);
        arg1.treasury = arg2;
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.fees_balance);
        assert!(v0 > 0, 3);
        let v1 = FeesWithdrawn{
            amount    : v0,
            recipient : arg1.treasury,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.fees_balance), arg2), arg1.treasury);
    }

    // decompiled from Move bytecode v6
}

