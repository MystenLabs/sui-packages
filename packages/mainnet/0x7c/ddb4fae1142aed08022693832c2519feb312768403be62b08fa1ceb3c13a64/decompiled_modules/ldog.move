module 0x7cddb4fae1142aed08022693832c2519feb312768403be62b08fa1ceb3c13a64::ldog {
    struct LDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDOG>(arg0, 6, b"LDOG", b"Lobster Dog", b"just a lobster dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734115871951.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

