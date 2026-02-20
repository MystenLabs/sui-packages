module 0xff8276ef3a22dbf0d8e4c1c1e0abc337124362fdcb5c16c95c14ca5926aac3e6::netstream_nfts {
    struct NETSTREAM_NFTS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        silver_holders: 0x2::table::Table<address, u64>,
        golden_holders: 0x2::table::Table<address, u64>,
        total_silver_minted: u64,
        total_golden_minted: u64,
        total_silver_holders: u64,
        total_golden_holders: u64,
        paused: bool,
        affiliate_registry_id: address,
        nft_counter_cap: 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::NftCounterCap,
    }

    struct SilverNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        minted_at: u64,
        owner: address,
    }

    struct GoldenNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        minted_at: u64,
        owner: address,
    }

    struct SilverNFTMinted has copy, drop {
        nft_id: address,
        owner: address,
        price_paid: u64,
        timestamp: u64,
    }

    struct GoldenNFTMinted has copy, drop {
        nft_id: address,
        owner: address,
        price_paid: u64,
        timestamp: u64,
    }

    struct AffiliateRegistrySet has copy, drop {
        registry_id: address,
    }

    struct PresaleConverted has copy, drop {
        presale_nft_id: 0x2::object::ID,
        converter: address,
        original_tier: u8,
        original_mint_number: u64,
        original_minter: address,
        timestamp: u64,
    }

    public entry fun convert_presale<T0>(arg0: &mut NFTRegistry<T0>, arg1: &mut 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>, arg2: 0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::get_tier(&arg2);
        0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::burn_nft(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        if (v0 == 1) {
            mint_golden_internal<T0>(arg0, v1, arg3);
            0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::increment_nft_count<T0>(&arg0.nft_counter_cap, arg1, v1, 1, arg3);
        } else {
            assert!(v0 == 2, 3);
            mint_silver_internal<T0>(arg0, v1, arg3);
            0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::increment_nft_count<T0>(&arg0.nft_counter_cap, arg1, v1, 0, arg3);
        };
        let v2 = PresaleConverted{
            presale_nft_id       : 0x2::object::id<0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::PresaleNFT>(&arg2),
            converter            : v1,
            original_tier        : v0,
            original_mint_number : 0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::get_mint_number(&arg2),
            original_minter      : 0x626d7cf7ca957240a2ea3d05a8cd9dcc91946c1a4a7e6a632e064d7b2331d5a9::presale_nft::get_minter(&arg2),
            timestamp            : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PresaleConverted>(v2);
    }

    public fun get_affiliate_registry_id<T0>(arg0: &NFTRegistry<T0>) : address {
        arg0.affiliate_registry_id
    }

    public fun get_golden_nft_count<T0>(arg0: &NFTRegistry<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.golden_holders, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.golden_holders, arg1)
        } else {
            0
        }
    }

    public fun get_silver_nft_count<T0>(arg0: &NFTRegistry<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.silver_holders, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.silver_holders, arg1)
        } else {
            0
        }
    }

    public fun get_total_golden_holders<T0>(arg0: &NFTRegistry<T0>) : u64 {
        arg0.total_golden_holders
    }

    public fun get_total_golden_minted<T0>(arg0: &NFTRegistry<T0>) : u64 {
        arg0.total_golden_minted
    }

    public fun get_total_silver_holders<T0>(arg0: &NFTRegistry<T0>) : u64 {
        arg0.total_silver_holders
    }

    public fun get_total_silver_minted<T0>(arg0: &NFTRegistry<T0>) : u64 {
        arg0.total_silver_minted
    }

    fun init(arg0: NETSTREAM_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_registry<T0>(arg0: 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::NftCounterCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTRegistry<T0>{
            id                    : 0x2::object::new(arg2),
            silver_holders        : 0x2::table::new<address, u64>(arg2),
            golden_holders        : 0x2::table::new<address, u64>(arg2),
            total_silver_minted   : 0,
            total_golden_minted   : 0,
            total_silver_holders  : 0,
            total_golden_holders  : 0,
            paused                : false,
            affiliate_registry_id : arg1,
            nft_counter_cap       : arg0,
        };
        0x2::transfer::share_object<NFTRegistry<T0>>(v0);
    }

    public fun is_paused<T0>(arg0: &NFTRegistry<T0>) : bool {
        arg0.paused
    }

    public entry fun mint_golden<T0>(arg0: &mut NFTRegistry<T0>, arg1: &mut 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(0x2::coin::value<T0>(&arg2) == 1500000000, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::deposit_funds<T0>(arg1, arg2, arg3);
        0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::payout_sale<T0>(arg1, 1500000000, v0, arg3);
        mint_golden_internal<T0>(arg0, v0, arg3);
        0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::increment_nft_count<T0>(&arg0.nft_counter_cap, arg1, v0, 1, arg3);
    }

    fun mint_golden_internal<T0>(arg0: &mut NFTRegistry<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = GoldenNFT{
            id          : v1,
            name        : 0x1::string::utf8(b"NETSTREAM Golden NFT"),
            description : 0x1::string::utf8(b"NETSTREAM Golden Membership NFT - Premium access to platform features and monthly rewards"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://netstream.io/nft/golden.png"),
            minted_at   : v0,
            owner       : arg1,
        };
        if (0x2::table::contains<address, u64>(&arg0.golden_holders, arg1)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.golden_holders, arg1);
            *v3 = *v3 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.golden_holders, arg1, 1);
            arg0.total_golden_holders = arg0.total_golden_holders + 1;
        };
        arg0.total_golden_minted = arg0.total_golden_minted + 1;
        let v4 = GoldenNFTMinted{
            nft_id     : 0x2::object::uid_to_address(&v1),
            owner      : arg1,
            price_paid : 1500000000,
            timestamp  : v0,
        };
        0x2::event::emit<GoldenNFTMinted>(v4);
        0x2::transfer::transfer<GoldenNFT>(v2, arg1);
    }

    public entry fun mint_silver<T0>(arg0: &mut NFTRegistry<T0>, arg1: &mut 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(0x2::coin::value<T0>(&arg2) == 500000000, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::deposit_funds<T0>(arg1, arg2, arg3);
        0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::payout_sale<T0>(arg1, 500000000, v0, arg3);
        mint_silver_internal<T0>(arg0, v0, arg3);
        0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::increment_nft_count<T0>(&arg0.nft_counter_cap, arg1, v0, 0, arg3);
    }

    fun mint_silver_internal<T0>(arg0: &mut NFTRegistry<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = SilverNFT{
            id          : v1,
            name        : 0x1::string::utf8(b"NETSTREAM Silver NFT"),
            description : 0x1::string::utf8(b"NETSTREAM Silver Membership NFT - Access to platform features and monthly rewards"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://netstream.io/nft/silver.png"),
            minted_at   : v0,
            owner       : arg1,
        };
        if (0x2::table::contains<address, u64>(&arg0.silver_holders, arg1)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.silver_holders, arg1);
            *v3 = *v3 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.silver_holders, arg1, 1);
            arg0.total_silver_holders = arg0.total_silver_holders + 1;
        };
        arg0.total_silver_minted = arg0.total_silver_minted + 1;
        let v4 = SilverNFTMinted{
            nft_id     : 0x2::object::uid_to_address(&v1),
            owner      : arg1,
            price_paid : 500000000,
            timestamp  : v0,
        };
        0x2::event::emit<SilverNFTMinted>(v4);
        0x2::transfer::transfer<SilverNFT>(v2, arg1);
    }

    public fun set_affiliate_registry<T0>(arg0: &AdminCap, arg1: &mut NFTRegistry<T0>, arg2: address) {
        arg1.affiliate_registry_id = arg2;
        let v0 = AffiliateRegistrySet{registry_id: arg2};
        0x2::event::emit<AffiliateRegistrySet>(v0);
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut NFTRegistry<T0>, arg2: bool) {
        arg1.paused = arg2;
    }

    // decompiled from Move bytecode v6
}

