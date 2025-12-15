module 0x51ab8ea1a6fc7559d44ef80d90ebf0bec79f993acaaa7d0ff716b7d2c4c4105f::bonded_nft_dex {
    struct BONDED_NFT_DEX has drop {
        dummy_field: bool,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        owner: address,
        platform_treasury: address,
    }

    struct RewardToken has drop {
        dummy_field: bool,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        token_name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        token_per_nft: u64,
        max_supply: u64,
        base_price: u64,
        price_increment: u64,
        total_minted: u64,
        cumulative_mints: u64,
        asset_type: u8,
        is_unlimited: bool,
        ft_total_supply: u64,
        creator: address,
        allowed_payment_tokens: vector<0x1::ascii::String>,
        liquidity_reserves: 0x2::bag::Bag,
        total_liquidity: 0x2::table::Table<0x1::ascii::String, u64>,
        lp_shares: 0x2::table::Table<0x1::ascii::String, 0x2::bag::Bag>,
    }

    struct BoundNft has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        token_amount: u64,
        creator_info: 0x1::string::String,
    }

    struct CollectionPublisher has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct PlatformConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        owner: address,
        platform_treasury: address,
    }

    struct PlatformTreasuryUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_treasury: address,
        new_treasury: address,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        max_supply: u64,
        base_price: u64,
        platform_fee_paid: u64,
        asset_type: u8,
        is_unlimited: bool,
    }

    struct NftMinted has copy, drop {
        collection_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
        price_paid: u64,
        token_type: 0x1::string::String,
        total_minted: u64,
        cumulative_mints: u64,
    }

    struct NftSold has copy, drop {
        collection_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price_received: u64,
        token_type: 0x1::string::String,
        total_minted: u64,
        cumulative_mints: u64,
    }

    struct LiquidityAdded has copy, drop {
        collection_id: 0x2::object::ID,
        provider: address,
        amount: u64,
        token_type: 0x1::string::String,
        shares_minted: u64,
    }

    struct FtMinted has copy, drop {
        collection_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        price_paid: u64,
        token_type: 0x1::string::String,
        ft_total_supply: u64,
    }

    struct FtSold has copy, drop {
        collection_id: 0x2::object::ID,
        seller: address,
        amount: u64,
        price_received: u64,
        token_type: 0x1::string::String,
        ft_total_supply: u64,
    }

    public fun add_allowed_token(arg0: &mut Collection, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg0.allowed_payment_tokens, 0x1::ascii::string(arg1));
    }

    public fun add_liquidity<T0>(arg0: &mut Collection, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 8);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        assert!(0x1::vector::contains<0x1::ascii::String>(&arg0.allowed_payment_tokens, &v2), 6);
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.liquidity_reserves, v2)) {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.liquidity_reserves, v2, 0x2::balance::zero<T0>());
        };
        if (!0x2::table::contains<0x1::ascii::String, u64>(&arg0.total_liquidity, v2)) {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg0.total_liquidity, v2, 0);
        };
        if (!0x2::table::contains<0x1::ascii::String, 0x2::bag::Bag>(&arg0.lp_shares, v2)) {
            0x2::table::add<0x1::ascii::String, 0x2::bag::Bag>(&mut arg0.lp_shares, v2, 0x2::bag::new(arg2));
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.liquidity_reserves, v2), 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.total_liquidity, v2);
        *v3 = *v3 + v0;
        let v4 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::bag::Bag>(&mut arg0.lp_shares, v2);
        if (0x2::bag::contains<address>(v4, v1)) {
            let v5 = 0x2::bag::borrow_mut<address, u64>(v4, v1);
            *v5 = *v5 + v0;
        } else {
            0x2::bag::add<address, u64>(v4, v1, v0);
        };
        let v6 = LiquidityAdded{
            collection_id : 0x2::object::id<Collection>(arg0),
            provider      : v1,
            amount        : v0,
            token_type    : 0x1::string::utf8(*0x1::ascii::as_bytes(&v2)),
            shares_minted : v0,
        };
        0x2::event::emit<LiquidityAdded>(v6);
    }

    fun address_to_string(arg0: address) : 0x1::string::String {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 48);
        0x1::vector::push_back<u8>(&mut v1, 120);
        let v2 = 0;
        while (v2 < 8 && v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            let v4 = v3 / 16;
            let v5 = v3 % 16;
            let v6 = if (v4 < 10) {
                v4 + 48
            } else {
                v4 + 87
            };
            0x1::vector::push_back<u8>(&mut v1, v6);
            let v7 = if (v5 < 10) {
                v5 + 48
            } else {
                v5 + 87
            };
            0x1::vector::push_back<u8>(&mut v1, v7);
            v2 = v2 + 1;
        };
        0x1::vector::push_back<u8>(&mut v1, 46);
        0x1::vector::push_back<u8>(&mut v1, 46);
        0x1::vector::push_back<u8>(&mut v1, 46);
        0x1::string::utf8(v1)
    }

    public fun calculate_base_price(arg0: &Collection) : u64 {
        arg0.base_price + arg0.total_minted * arg0.price_increment
    }

    public fun calculate_ft_mint_price(arg0: &Collection, arg1: u64) : u64 {
        let v0 = calculate_ft_mint_price_internal(arg0, arg1);
        v0 + v0 * 500 / 10000 + v0 * 250 / 10000
    }

    fun calculate_ft_mint_price_internal(arg0: &Collection, arg1: u64) : u64 {
        arg0.base_price * arg1 + arg0.price_increment * (arg0.ft_total_supply * arg1 + arg1 * (arg1 - 1) / 2)
    }

    public fun calculate_ft_sell_price(arg0: &Collection, arg1: u64) : u64 {
        calculate_ft_sell_price_internal(arg0, arg1)
    }

    fun calculate_ft_sell_price_internal(arg0: &Collection, arg1: u64) : u64 {
        if (arg0.ft_total_supply < arg1) {
            return 0
        };
        arg0.base_price * arg1 + arg0.price_increment * ((arg0.ft_total_supply - arg1) * arg1 + arg1 * (arg1 - 1) / 2)
    }

    public fun calculate_mint_price(arg0: &Collection) : u64 {
        let v0 = calculate_base_price(arg0);
        v0 + v0 * 500 / 10000 + v0 * 250 / 10000
    }

    public fun calculate_sell_price(arg0: &Collection) : u64 {
        if (arg0.total_minted == 0) {
            return 0
        };
        arg0.base_price + (arg0.total_minted - 1) * arg0.price_increment
    }

    public fun create_collection(arg0: &PlatformConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.platform_treasury);
        assert!(arg11 == 0 || arg11 == 1, 11);
        let v1 = arg8 == 0;
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x2::sui::SUI>()));
        let v3 = Collection{
            id                     : 0x2::object::new(arg12),
            name                   : 0x1::string::utf8(arg2),
            description            : 0x1::string::utf8(arg3),
            image_url              : 0x1::string::utf8(arg4),
            token_name             : 0x1::string::utf8(arg5),
            token_symbol           : 0x1::string::utf8(arg6),
            token_per_nft          : arg7,
            max_supply             : arg8,
            base_price             : arg9,
            price_increment        : arg10,
            total_minted           : 0,
            cumulative_mints       : 0,
            asset_type             : arg11,
            is_unlimited           : v1,
            ft_total_supply        : 0,
            creator                : v0,
            allowed_payment_tokens : v2,
            liquidity_reserves     : 0x2::bag::new(arg12),
            total_liquidity        : 0x2::table::new<0x1::ascii::String, u64>(arg12),
            lp_shares              : 0x2::table::new<0x1::ascii::String, 0x2::bag::Bag>(arg12),
        };
        let v4 = CollectionCreated{
            collection_id     : 0x2::object::id<Collection>(&v3),
            creator           : v0,
            name              : 0x1::string::utf8(arg2),
            token_symbol      : 0x1::string::utf8(arg6),
            max_supply        : arg8,
            base_price        : arg9,
            platform_fee_paid : 100000000,
            asset_type        : arg11,
            is_unlimited      : v1,
        };
        0x2::event::emit<CollectionCreated>(v4);
        0x2::transfer::share_object<Collection>(v3);
    }

    public fun create_nft_display(arg0: &CollectionPublisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<BoundNft>(&arg0.publisher, arg1);
        0x2::display::add<BoundNft>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BoundNft>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<BoundNft>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<BoundNft>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://nft.cato.asia"));
        0x2::display::add<BoundNft>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator_info}"));
        0x2::display::update_version<BoundNft>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<BoundNft>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_transfer_policy(arg0: &CollectionPublisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<BoundNft>(&arg0.publisher, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BoundNft>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BoundNft>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun get_collection_info(arg0: &Collection) : (0x1::string::String, 0x1::string::String, u64, u64, u64, u64) {
        (arg0.name, arg0.token_symbol, arg0.max_supply, arg0.total_minted, calculate_mint_price(arg0), calculate_sell_price(arg0))
    }

    public fun get_nft_info(arg0: &BoundNft) : (0x1::string::String, 0x1::string::String, u64, 0x1::string::String) {
        (arg0.name, arg0.description, arg0.token_amount, arg0.creator_info)
    }

    public fun get_price_breakdown(arg0: &Collection) : (u64, u64, u64, u64) {
        let v0 = calculate_base_price(arg0);
        let v1 = v0 * 500 / 10000;
        let v2 = v0 * 250 / 10000;
        (v0, v1, v2, v0 + v1 + v2)
    }

    fun init(arg0: BONDED_NFT_DEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = CollectionPublisher{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<BONDED_NFT_DEX>(arg0, arg1),
        };
        0x2::transfer::share_object<CollectionPublisher>(v1);
        let v2 = PlatformConfig{
            id                : 0x2::object::new(arg1),
            owner             : v0,
            platform_treasury : v0,
        };
        let v3 = PlatformConfigCreated{
            config_id         : 0x2::object::id<PlatformConfig>(&v2),
            owner             : v0,
            platform_treasury : v0,
        };
        0x2::event::emit<PlatformConfigCreated>(v3);
        0x2::transfer::share_object<PlatformConfig>(v2);
    }

    public fun mint_ft<T0>(arg0: &PlatformConfig, arg1: &mut Collection, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg1.asset_type == 1, 11);
        assert!(arg2 > 0, 8);
        if (!arg1.is_unlimited) {
            assert!(arg1.ft_total_supply + arg2 <= arg1.max_supply, 3);
        };
        let v0 = calculate_ft_mint_price(arg1, arg2);
        assert!(0x2::coin::value<T0>(&arg3) >= v0, 4);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        assert!(0x1::vector::contains<0x1::ascii::String>(&arg1.allowed_payment_tokens, &v1), 6);
        if (!0x2::bag::contains<0x1::ascii::String>(&arg1.liquidity_reserves, v1)) {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.liquidity_reserves, v1, 0x2::balance::zero<T0>());
        };
        let v2 = calculate_ft_mint_price_internal(arg1, arg2);
        let v3 = 0x2::coin::into_balance<T0>(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2 * 500 / 10000), arg4), arg1.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2 * 250 / 10000), arg4), arg0.platform_treasury);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.liquidity_reserves, v1), 0x2::balance::split<T0>(&mut v3, v2));
        arg1.ft_total_supply = arg1.ft_total_supply + arg2;
        let v4 = FtMinted{
            collection_id   : 0x2::object::id<Collection>(arg1),
            buyer           : 0x2::tx_context::sender(arg4),
            amount          : arg2,
            price_paid      : v0,
            token_type      : 0x1::string::utf8(*0x1::ascii::as_bytes(&v1)),
            ft_total_supply : arg1.ft_total_supply,
        };
        0x2::event::emit<FtMinted>(v4);
        v3
    }

    public fun mint_nft<T0>(arg0: &PlatformConfig, arg1: &mut Collection, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.asset_type == 0, 11);
        if (!arg1.is_unlimited) {
            assert!(arg1.total_minted < arg1.max_supply, 3);
        };
        let v0 = calculate_base_price(arg1);
        let v1 = calculate_mint_price(arg1);
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 4);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        assert!(0x1::vector::contains<0x1::ascii::String>(&arg1.allowed_payment_tokens, &v2), 6);
        let v3 = 0x2::tx_context::sender(arg3);
        if (!0x2::bag::contains<0x1::ascii::String>(&arg1.liquidity_reserves, v2)) {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.liquidity_reserves, v2, 0x2::balance::zero<T0>());
        };
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v0 * 500 / 10000), arg3), arg1.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v0 * 250 / 10000), arg3), arg0.platform_treasury);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.liquidity_reserves, v2), 0x2::balance::split<T0>(&mut v4, v0));
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg3), v3);
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        let v5 = arg1.name;
        0x1::string::append(&mut v5, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v5, u64_to_string(arg1.total_minted + 1));
        let v6 = 0x1::string::utf8(b"BondedNFT DEX - ");
        0x1::string::append(&mut v6, address_to_string(arg1.creator));
        let v7 = BoundNft{
            id            : 0x2::object::new(arg3),
            collection_id : 0x2::object::id<Collection>(arg1),
            name          : v5,
            description   : arg1.description,
            image_url     : arg1.image_url,
            token_amount  : arg1.token_per_nft,
            creator_info  : v6,
        };
        arg1.total_minted = arg1.total_minted + 1;
        arg1.cumulative_mints = arg1.cumulative_mints + 1;
        let v8 = NftMinted{
            collection_id    : 0x2::object::id<Collection>(arg1),
            nft_id           : 0x2::object::id<BoundNft>(&v7),
            buyer            : v3,
            price_paid       : v1,
            token_type       : 0x1::string::utf8(*0x1::ascii::as_bytes(&v2)),
            total_minted     : arg1.total_minted,
            cumulative_mints : arg1.cumulative_mints,
        };
        0x2::event::emit<NftMinted>(v8);
        0x2::transfer::public_transfer<BoundNft>(v7, v3);
    }

    public fun sell_ft<T0>(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.asset_type == 1, 11);
        assert!(arg1 > 0, 8);
        assert!(arg0.ft_total_supply >= arg1, 12);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        let v1 = calculate_ft_sell_price(arg0, arg1);
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.liquidity_reserves, v0), 7);
        let v2 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.liquidity_reserves, v0);
        assert!(0x2::balance::value<T0>(v2) >= v1, 7);
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, v1), arg2);
        arg0.ft_total_supply = arg0.ft_total_supply - arg1;
        let v4 = FtSold{
            collection_id   : 0x2::object::id<Collection>(arg0),
            seller          : 0x2::tx_context::sender(arg2),
            amount          : arg1,
            price_received  : v1,
            token_type      : 0x1::string::utf8(*0x1::ascii::as_bytes(&v0)),
            ft_total_supply : arg0.ft_total_supply,
        };
        0x2::event::emit<FtSold>(v4);
        v3
    }

    public fun sell_nft<T0>(arg0: &mut Collection, arg1: BoundNft, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == 0x2::object::id<Collection>(arg0), 5);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        let v2 = calculate_sell_price(arg0);
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.liquidity_reserves, v1), 7);
        let v3 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.liquidity_reserves, v1);
        assert!(0x2::balance::value<T0>(v3) >= v2, 7);
        let v4 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v3, v2), arg2);
        let BoundNft {
            id            : v5,
            collection_id : _,
            name          : _,
            description   : _,
            image_url     : _,
            token_amount  : _,
            creator_info  : _,
        } = arg1;
        let v12 = v5;
        0x2::object::delete(v12);
        arg0.total_minted = arg0.total_minted - 1;
        let v13 = NftSold{
            collection_id    : 0x2::object::id<Collection>(arg0),
            nft_id           : 0x2::object::uid_to_inner(&v12),
            seller           : v0,
            price_received   : v2,
            token_type       : 0x1::string::utf8(*0x1::ascii::as_bytes(&v1)),
            total_minted     : arg0.total_minted,
            cumulative_mints : arg0.cumulative_mints,
        };
        0x2::event::emit<NftSold>(v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun update_platform_treasury(arg0: &mut PlatformConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 10);
        arg0.platform_treasury = arg1;
        let v0 = PlatformTreasuryUpdated{
            config_id    : 0x2::object::id<PlatformConfig>(arg0),
            old_treasury : arg0.platform_treasury,
            new_treasury : arg1,
        };
        0x2::event::emit<PlatformTreasuryUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

