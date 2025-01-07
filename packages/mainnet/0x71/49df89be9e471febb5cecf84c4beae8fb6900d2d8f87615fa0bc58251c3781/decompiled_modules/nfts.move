module 0x7149df89be9e471febb5cecf84c4beae8fb6900d2d8f87615fa0bc58251c3781::nfts {
    struct OinkNFT has store, key {
        id: 0x2::object::UID,
        number: u64,
        metadata: OinkNFTMetadata,
    }

    struct OinkNFTMetadata has copy, drop, store {
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
        background_color: 0x1::string::String,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        mint_price: u64,
        max_mint_per_address: u64,
        total_supply: u64,
        whitelist_mint: bool,
        public_mint: bool,
        whitelist: vector<address>,
        nft_metadata: vector<OinkNFTMetadata>,
    }

    struct Fee<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct NFTS has drop {
        dummy_field: bool,
    }

    public fun add_nft_metadata(arg0: &mut Config, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg4) != arg0.admin) {
            return
        };
        let v0 = OinkNFTMetadata{
            image_url        : arg1,
            rarity           : arg2,
            background_color : arg3,
        };
        0x1::vector::push_back<OinkNFTMetadata>(&mut arg0.nft_metadata, v0);
    }

    public fun add_to_whitelist(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        0x1::vector::push_back<address>(&mut arg0.whitelist, arg1);
    }

    public fun close_public_mint(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            return
        };
        arg0.public_mint = false;
    }

    public fun close_whitelist_mint(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            return
        };
        arg0.whitelist_mint = false;
    }

    public fun get_index(arg0: &Config, arg1: address) : u64 {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg1);
        if (!v0) {
            abort 2
        };
        v1
    }

    fun init(arg0: NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io/hero/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"f09f90bdf09fa4bf20546865206d6f737420616476656e7475726f75732070696720696e20535549204f6365616ef09f92a7"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.suioink.fun/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0x8fec6e2a179c8a4cba08b8e87c4c41b958ba6360400274e4ffbe072605c551a8"));
        let v4 = 0x2::package::claim<NFTS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<OinkNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<OinkNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OinkNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun init_collection<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                   : 0x2::object::new(arg2),
            admin                : 0x2::tx_context::sender(arg2),
            mint_price           : arg0,
            max_mint_per_address : arg1,
            total_supply         : 0,
            whitelist_mint       : false,
            public_mint          : false,
            whitelist            : 0x1::vector::empty<address>(),
            nft_metadata         : 0x1::vector::empty<OinkNFTMetadata>(),
        };
        let v1 = Fee<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::public_transfer<Fee<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun mint<T0>(arg0: &mut Config, arg1: &mut Fee<T0>, arg2: 0x2::coin::Coin<T0>, arg3: OinkNFTMetadata, arg4: &mut 0x2::tx_context::TxContext) {
        if (!arg0.public_mint && !arg0.whitelist_mint) {
            abort 0
        };
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        if (arg0.mint_price > 0x2::balance::value<T0>(&v0)) {
            abort 1
        };
        0x2::balance::join<T0>(&mut arg1.balance, v0);
        if (!arg0.public_mint) {
            get_index(arg0, 0x2::tx_context::sender(arg4));
        };
        let v1 = 0x2::tx_context::sender(arg4);
        mint_internal(arg0, v1, arg3, arg4);
    }

    fun mint_internal(arg0: &mut Config, arg1: address, arg2: OinkNFTMetadata, arg3: &mut 0x2::tx_context::TxContext) {
        let OinkNFTMetadata {
            image_url        : v0,
            rarity           : v1,
            background_color : v2,
        } = arg2;
        let v3 = OinkNFTMetadata{
            image_url        : v0,
            rarity           : v1,
            background_color : v2,
        };
        let v4 = OinkNFT{
            id       : 0x2::object::new(arg3),
            number   : arg0.total_supply,
            metadata : v3,
        };
        arg0.total_supply = arg0.total_supply + 1;
        0x2::transfer::public_transfer<OinkNFT>(v4, arg1);
    }

    public fun open_public_mint(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            return
        };
        arg0.public_mint = true;
    }

    public fun open_whitelist_mint(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            return
        };
        arg0.whitelist_mint = true;
    }

    entry fun pre_mint(arg0: &mut Config, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : OinkNFTMetadata {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        0x1::vector::swap_remove<OinkNFTMetadata>(&mut arg0.nft_metadata, 0x2::random::generate_u64(&mut v0) % 0x1::vector::length<OinkNFTMetadata>(&arg0.nft_metadata))
    }

    public fun remove_from_whitelist(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        0x1::vector::swap_remove<address>(&mut arg0.whitelist, arg1);
    }

    public fun renounce(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            return
        };
        arg0.admin = @0x0;
    }

    public fun update_max_mint_per_address(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        arg0.max_mint_per_address = arg1;
    }

    public fun update_mint_price(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        arg0.mint_price = arg1;
    }

    // decompiled from Move bytecode v6
}

