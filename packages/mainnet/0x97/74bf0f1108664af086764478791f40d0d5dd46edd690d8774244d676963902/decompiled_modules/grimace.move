module 0x9774bf0f1108664af086764478791f40d0d5dd46edd690d8774244d676963902::grimace {
    struct GRIMACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIMACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIMACE>(arg0, 6, b"GRIMACE", b"GRIMACE ON SUI", b"Grimace back on sui, million mission.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3856_a55f56218c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIMACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIMACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

