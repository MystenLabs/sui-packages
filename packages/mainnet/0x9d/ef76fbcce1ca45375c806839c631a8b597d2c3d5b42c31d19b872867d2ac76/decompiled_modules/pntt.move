module 0x9def76fbcce1ca45375c806839c631a8b597d2c3d5b42c31d19b872867d2ac76::pntt {
    struct PNTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNTT>(arg0, 6, b"PNTT", b"PEANUT", b"RIP Peanut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949243442.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

