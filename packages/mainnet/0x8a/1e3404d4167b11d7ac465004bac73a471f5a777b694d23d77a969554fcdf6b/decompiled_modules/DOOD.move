module 0x8a1e3404d4167b11d7ac465004bac73a471f5a777b694d23d77a969554fcdf6b::DOOD {
    struct DOOD has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"DOOD", b"the revolution has begun", b"DOOD doing DOOD things", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: DOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<DOOD>(arg0, arg1);
        0x2::coin::mint_and_transfer<DOOD>(&mut v0, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

