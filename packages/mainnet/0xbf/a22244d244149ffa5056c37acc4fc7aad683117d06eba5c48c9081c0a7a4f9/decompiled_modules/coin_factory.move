module 0xbfa22244d244149ffa5056c37acc4fc7aad683117d06eba5c48c9081c0a7a4f9::coin_factory {
    struct TokenFactory has key {
        id: 0x2::object::UID,
        created_tokens: u64,
    }

    struct TokenMetadata has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        creator: address,
        decimals: u8,
        total_supply: u64,
    }

    struct TokenCreated has copy, drop {
        token_type: 0x1::string::String,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        treasury_cap_id: address,
        metadata_id: address,
    }

    struct COIN_FACTORY has drop {
        dummy_field: bool,
    }

    struct TokenWitness has drop {
        dummy_field: bool,
    }

    public entry fun create_token(arg0: &mut TokenFactory, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 18, 1);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 3);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 4);
        assert!(arg6 > 0, 2);
        let v0 = 0x1::string::utf8(arg2);
        let v1 = 0x1::string::utf8(arg3);
        let v2 = if (0x1::vector::length<u8>(&arg5) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg5))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v3 = TokenWitness{dummy_field: false};
        let (v4, v5) = 0x2::coin::create_currency<TokenWitness>(v3, arg1, arg2, arg3, arg4, v2, arg7);
        let v6 = v4;
        let v7 = TokenMetadata{
            id           : 0x2::object::new(arg7),
            name         : v1,
            symbol       : v0,
            description  : 0x1::string::utf8(arg4),
            icon_url     : v2,
            creator      : 0x2::tx_context::sender(arg7),
            decimals     : arg1,
            total_supply : arg6,
        };
        arg0.created_tokens = arg0.created_tokens + 1;
        let v8 = 0x2::object::id<0x2::coin::TreasuryCap<TokenWitness>>(&v6);
        let v9 = 0x2::object::id<TokenMetadata>(&v7);
        let v10 = TokenCreated{
            token_type      : 0x1::string::utf8(b"Custom Token"),
            creator         : 0x2::tx_context::sender(arg7),
            name            : v1,
            symbol          : v0,
            decimals        : arg1,
            treasury_cap_id : 0x2::object::id_to_address(&v8),
            metadata_id     : 0x2::object::id_to_address(&v9),
        };
        0x2::event::emit<TokenCreated>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<TokenWitness>>(0x2::coin::mint<TokenWitness>(&mut v6, arg6, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TokenWitness>>(v6, 0x2::tx_context::sender(arg7));
        0x2::transfer::share_object<TokenMetadata>(v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TokenWitness>>(v5);
    }

    public fun get_factory_stats(arg0: &TokenFactory) : u64 {
        arg0.created_tokens
    }

    public fun get_metadata(arg0: &TokenMetadata) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, u8, u64) {
        (arg0.name, arg0.symbol, arg0.description, arg0.creator, arg0.decimals, arg0.total_supply)
    }

    fun init(arg0: COIN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenFactory{
            id             : 0x2::object::new(arg1),
            created_tokens : 0,
        };
        0x2::transfer::share_object<TokenFactory>(v0);
    }

    public entry fun mint_tokens<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

