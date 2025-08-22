module 0xbe8401078e7035ac70f4bd0b0a5cf97f9459f4d2c8872ebc5971cdc30deb41ed::BATTLE_TOKEN {
    struct BATTLE_TOKEN has drop {
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

    fun init(arg0: BATTLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATTLE_TOKEN>(arg0, 9, b"BATTLE", b"BATTLE Token", b"Verse BATTLE Token with 1M supply", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://verse-tokens.b-cdn.net/battle.png")), arg1);
        let v2 = v0;
        let v3 = TokenConfig{
            id           : 0x2::object::new(arg1),
            admin        : 0x2::tx_context::sender(arg1),
            total_supply : 1000000000000000,
        };
        let v4 = TokenCreated{
            total_supply : 1000000000000000,
            admin        : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TokenCreated>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BATTLE_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATTLE_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<BATTLE_TOKEN>>(0x2::coin::mint<BATTLE_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TokenConfig>(v3);
    }

    // decompiled from Move bytecode v6
}

