module 0x32563540781dde5e6b7bddab84e8c9bb6b7693a282fbbe9a448b28170282bc::token_factory {
    struct TOKEN_FACTORY has drop {
        dummy_field: bool,
    }

    struct TokenMetadata has store, key {
        id: 0x2::object::UID,
        symbol: vector<u8>,
        name: vector<u8>,
        description: vector<u8>,
        icon_url: 0x1::ascii::String,
        decimals: u8,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN_FACTORY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_FACTORY>>(0x2::coin::mint<TOKEN_FACTORY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TOKEN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_FACTORY>(arg0, 6, b"TOKEN", b"Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_FACTORY>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN_FACTORY>>(v1, v2);
    }

    public entry fun set_metadata(arg0: &0x2::package::UpgradeCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::ascii::String, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::upgrade_policy(arg0) == 0, 0);
        let v0 = TokenMetadata{
            id          : 0x2::object::new(arg6),
            symbol      : arg1,
            name        : arg2,
            description : arg3,
            icon_url    : arg4,
            decimals    : arg5,
        };
        0x2::transfer::public_transfer<TokenMetadata>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

