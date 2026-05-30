module 0x930bb20ce4e7fbbfede027ea1afd110f89c4d5e35013662d276913852d2025b5::token_factory {
    struct TOKEN_FACTORY has drop {
        dummy_field: bool,
    }

    struct FactoryAdmin has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TOKEN_FACTORY>,
    }

    struct TokenCreatedEvent has copy, drop {
        treasury_cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
        creator: address,
        symbol: 0x1::ascii::String,
    }

    public entry fun create_token(arg0: &mut FactoryAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_FACTORY>>(0x2::coin::mint<TOKEN_FACTORY>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    fun init(arg0: TOKEN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_FACTORY>(arg0, 9, b"FACTORY", b"Factory Management Token", b"Workshop Token Demo", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKEN_FACTORY>>(v1);
        let v2 = FactoryAdmin{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<FactoryAdmin>(v2);
    }

    // decompiled from Move bytecode v7
}

