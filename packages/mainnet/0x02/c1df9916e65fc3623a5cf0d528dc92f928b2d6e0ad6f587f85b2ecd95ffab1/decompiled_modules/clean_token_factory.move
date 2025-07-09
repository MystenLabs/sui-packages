module 0x2c1df9916e65fc3623a5cf0d528dc92f928b2d6e0ad6f587f85b2ecd95ffab1::clean_token_factory {
    struct CLEAN_TOKEN_FACTORY has drop {
        dummy_field: bool,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        tokens: 0x2::table::Table<0x1::string::String, TokenInfo>,
        total_tokens_created: u64,
    }

    struct TokenInfo has store {
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        decimals: u8,
        max_supply: u64,
        created_at: u64,
    }

    struct TokenMetadata has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        decimals: u8,
        max_supply: u64,
        creator: address,
        created_at: u64,
    }

    struct TokenCreated has copy, drop {
        token_symbol: 0x1::string::String,
        token_name: 0x1::string::String,
        creator: address,
        max_supply: u64,
        metadata_id: 0x2::object::ID,
    }

    public fun create_token(arg0: &mut TokenRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::string::utf8(arg2);
        let v2 = 0x1::string::utf8(arg3);
        assert!(0x1::vector::length<u8>(&arg1) > 0 && 0x1::vector::length<u8>(&arg1) <= 10, 1);
        assert!(!0x2::table::contains<0x1::string::String, TokenInfo>(&arg0.tokens, v0), 0);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = 0x2::tx_context::epoch(arg7);
        let v5 = if (0x1::vector::length<u8>(&arg4) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg4))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v6 = TokenMetadata{
            id          : 0x2::object::new(arg7),
            symbol      : v0,
            name        : v1,
            description : v2,
            icon_url    : v5,
            decimals    : arg5,
            max_supply  : arg6,
            creator     : v3,
            created_at  : v4,
        };
        let v7 = if (0x1::vector::length<u8>(&arg4) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg4))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v8 = TokenInfo{
            creator     : v3,
            name        : v1,
            description : v2,
            icon_url    : v7,
            decimals    : arg5,
            max_supply  : arg6,
            created_at  : v4,
        };
        0x2::table::add<0x1::string::String, TokenInfo>(&mut arg0.tokens, v0, v8);
        arg0.total_tokens_created = arg0.total_tokens_created + 1;
        0x2::transfer::public_freeze_object<TokenMetadata>(v6);
        let v9 = TokenCreated{
            token_symbol : v0,
            token_name   : v1,
            creator      : v3,
            max_supply   : arg6,
            metadata_id  : 0x2::object::id<TokenMetadata>(&v6),
        };
        0x2::event::emit<TokenCreated>(v9);
    }

    public fun get_registry_stats(arg0: &TokenRegistry) : u64 {
        arg0.total_tokens_created
    }

    public fun get_token_info(arg0: &TokenRegistry, arg1: 0x1::string::String) : (address, 0x1::string::String, 0x1::string::String, u8, u64, u64) {
        let v0 = 0x2::table::borrow<0x1::string::String, TokenInfo>(&arg0.tokens, arg1);
        (v0.creator, v0.name, v0.description, v0.decimals, v0.max_supply, v0.created_at)
    }

    fun init(arg0: CLEAN_TOKEN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRegistry{
            id                   : 0x2::object::new(arg1),
            tokens               : 0x2::table::new<0x1::string::String, TokenInfo>(arg1),
            total_tokens_created : 0,
        };
        0x2::transfer::share_object<TokenRegistry>(v0);
        0x2::package::claim_and_keep<CLEAN_TOKEN_FACTORY>(arg0, arg1);
    }

    public fun token_exists(arg0: &TokenRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, TokenInfo>(&arg0.tokens, arg1)
    }

    // decompiled from Move bytecode v6
}

