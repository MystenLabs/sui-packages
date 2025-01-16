module 0x5c537c38197468ccd4591e5845861300019a1b3b4ab97218e79e86e60cf45501::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAA>(arg0, 6, b"AAA", b"aaa cat by SuiAI", b"Can't stop won't stop (thinking about Suai)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aaa_02f8354480.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

