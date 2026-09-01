module 0xdbf1881fc01293b8e70557aca671c91d2f13a6ca6334964984b27caa6acc30e9::suminator {
    struct SUMINATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMINATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMINATOR>(arg0, 6, b"SUMINATOR", b"SUIMINATOR", b"SUIminator is here to revive meme coins on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1788221538616.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUMINATOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMINATOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

