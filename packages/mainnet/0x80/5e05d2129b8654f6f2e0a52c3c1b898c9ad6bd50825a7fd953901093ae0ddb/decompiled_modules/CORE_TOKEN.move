module 0x805e05d2129b8654f6f2e0a52c3c1b898c9ad6bd50825a7fd953901093ae0ddb::CORE_TOKEN {
    struct CORE_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenConfig has key {
        id: 0x2::object::UID,
        admin: address,
        total_supply: u64,
    }

    struct TokenCreated has copy, drop {
        total_supply: u64,
        admin: address,
    }

    fun init(arg0: CORE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE_TOKEN>(arg0, 6, b"CORE", b"CORE Token", b"Simple token with 1M supply", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://docs.coredao.org/img/core.png")), arg1);
        let v2 = v0;
        let v3 = TokenConfig{
            id           : 0x2::object::new(arg1),
            admin        : 0x2::tx_context::sender(arg1),
            total_supply : 1000000000000,
        };
        let v4 = TokenCreated{
            total_supply : 1000000000000,
            admin        : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TokenCreated>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORE_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE_TOKEN>>(0x2::coin::mint<CORE_TOKEN>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TokenConfig>(v3);
    }

    // decompiled from Move bytecode v6
}

