module 0x429a055a980eab330852519418d5b7def6694c7ed012e7feb44d86cea56a7b6a::nfts {
    struct OinkNFT has store, key {
        id: 0x2::object::UID,
        number: u64,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: Attributes,
    }

    struct Attributes has copy, drop, store {
        rarity: 0x1::string::String,
        background_color: 0x1::string::String,
    }

    struct OinkNFTMetadata has copy, drop, store {
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: Attributes,
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

    struct OTW has drop {
        dummy_field: bool,
    }

    public fun add_nft_metadata(arg0: &mut Config, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: Attributes, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg4) != arg0.admin) {
            return
        };
        let v0 = OinkNFTMetadata{
            description : arg1,
            image_url   : arg2,
            attributes  : arg3,
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

    public fun init_collection<T0: store>(arg0: OTW, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                   : 0x2::object::new(arg3),
            admin                : 0x2::tx_context::sender(arg3),
            mint_price           : arg1,
            max_mint_per_address : arg2,
            total_supply         : 0,
            whitelist_mint       : false,
            public_mint          : false,
            whitelist            : 0x1::vector::empty<address>(),
            nft_metadata         : 0x1::vector::empty<OinkNFTMetadata>(),
        };
        let v1 = Fee<T0>{
            id      : 0x2::object::new(arg3),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::public_transfer<Fee<T0>>(v1, 0x2::tx_context::sender(arg3));
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
            description : v0,
            image_url   : v1,
            attributes  : v2,
        } = arg2;
        let v3 = OinkNFT{
            id          : 0x2::object::new(arg3),
            number      : arg0.total_supply,
            description : v0,
            image_url   : v1,
            attributes  : v2,
        };
        arg0.total_supply = arg0.total_supply + 1;
        0x2::transfer::public_transfer<OinkNFT>(v3, arg1);
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

