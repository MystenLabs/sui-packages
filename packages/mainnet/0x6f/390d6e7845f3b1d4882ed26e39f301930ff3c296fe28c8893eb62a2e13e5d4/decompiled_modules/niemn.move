module 0x6f390d6e7845f3b1d4882ed26e39f301930ff3c296fe28c8893eb62a2e13e5d4::niemn {
    struct NIEMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIEMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIEMN>(arg0, 9, b"NIEMN", b"jeoek", b"ndjann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e71d5ef8-ce43-4574-adb2-30d316cad1c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIEMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIEMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

