module 0x2c1df9916e65fc3623a5cf0d528dc92f928b2d6e0ad6f587f85b2ecd95ffab1::token_factory {
    struct TOKEN_FACTORY has drop {
        dummy_field: bool,
    }

    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        tokens_created: u64,
    }

    struct TokenCreated has copy, drop {
        token_type: 0x1::string::String,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        total_supply: u64,
        treasury_cap_id: address,
        coin_id: address,
        metadata_id: address,
    }

    struct TokenInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        decimals: u8,
        total_supply: u64,
        creator: address,
    }

    public fun create_meme_coin(arg0: &mut TokenRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.tokens_created = arg0.tokens_created + 1;
        let v0 = TokenInfo{
            id           : 0x2::object::new(arg5),
            name         : 0x1::string::utf8(arg2),
            symbol       : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg3),
            icon_url     : 0x1::string::utf8(arg4),
            decimals     : 9,
            total_supply : 1000000000000000000,
            creator      : 0x2::tx_context::sender(arg5),
        };
        let v1 = 0x2::object::id_address<TokenInfo>(&v0);
        0x2::transfer::public_transfer<TokenInfo>(v0, 0x2::tx_context::sender(arg5));
        let v2 = TokenCreated{
            token_type      : 0x1::string::utf8(b"MEME_TOKEN"),
            creator         : 0x2::tx_context::sender(arg5),
            name            : 0x1::string::utf8(arg2),
            symbol          : 0x1::string::utf8(arg1),
            description     : 0x1::string::utf8(arg3),
            icon_url        : 0x1::string::utf8(arg4),
            total_supply    : 1000000000000000000,
            treasury_cap_id : v1,
            coin_id         : v1,
            metadata_id     : v1,
        };
        0x2::event::emit<TokenCreated>(v2);
    }

    public fun get_registry_stats(arg0: &TokenRegistry) : u64 {
        arg0.tokens_created
    }

    public fun get_token_info(arg0: &TokenInfo) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u8, u64, address) {
        (arg0.name, arg0.symbol, arg0.description, arg0.decimals, arg0.total_supply, arg0.creator)
    }

    fun init(arg0: TOKEN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRegistry{
            id             : 0x2::object::new(arg1),
            tokens_created : 0,
        };
        0x2::transfer::share_object<TokenRegistry>(v0);
        0x2::package::claim_and_keep<TOKEN_FACTORY>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

