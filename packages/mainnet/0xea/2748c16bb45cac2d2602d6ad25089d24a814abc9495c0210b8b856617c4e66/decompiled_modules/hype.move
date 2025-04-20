module 0xea2748c16bb45cac2d2602d6ad25089d24a814abc9495c0210b8b856617c4e66::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 8, b"HYPE", b"Wrapped Hype", b"ZO Finance Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HYPE>>(v0);
    }

    // decompiled from Move bytecode v6
}

