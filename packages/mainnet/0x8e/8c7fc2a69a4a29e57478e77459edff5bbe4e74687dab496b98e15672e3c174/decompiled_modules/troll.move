module 0x8e8c7fc2a69a4a29e57478e77459edff5bbe4e74687dab496b98e15672e3c174::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 6, b"TROLL", b"Baby Troll", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TROLL>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TROLL>>(v2);
    }

    // decompiled from Move bytecode v6
}

