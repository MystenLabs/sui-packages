module 0x6f5e89d8bdf3f6e5b0d5396cd3347f113dd675ad43b5d1ef07c2a6d08d3b5017::yield {
    struct YIELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIELD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIELD>(arg0, 6, b"YIELD", b"Yield hounds", b"Bunch of yield hounds ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735864697675.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YIELD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIELD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

