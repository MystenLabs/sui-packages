module 0x76bf4329c6d79387570ab42efbd0394157d4d9c06c556d937474349b1b050381::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 18, b"HYPE", b"Wrapped Hype", b"ZO Finance Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HYPE>>(v0);
    }

    // decompiled from Move bytecode v6
}

