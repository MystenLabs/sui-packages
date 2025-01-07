module 0xc2cf3246df97e3d7079c9fe94b421a4b5fb8711fb02c9a9af1240caa11a1b59::turbosmusk {
    struct TURBOSMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSMUSK>(arg0, 6, b"TurbosMusk", b"TurbosXElonMusk", b"To tribute to Elon Musk with a super Turbos in celebration of Donald Trump's presidential race victory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973419644.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSMUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSMUSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

