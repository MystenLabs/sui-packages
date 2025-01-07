module 0xee2501ada34d56d2031e64340e2d8f55eac460a558d3894d8f4b3766f89ac3e5::sweaty {
    struct SWEATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEATY>(arg0, 6, b"Sweaty", b"Big Sweaty Nigga", b"He big He nigga He sweaty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730551775493.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEATY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEATY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

