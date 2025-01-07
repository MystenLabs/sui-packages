module 0xbe3daf95dc87033a6aff32925d17e96cc34f2d6925412f2ee32b729e7464187a::dffdsh {
    struct DFFDSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFFDSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFFDSH>(arg0, 9, b"DFFDSH", b"KJHJF", b"BBCDH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f2da5ea-b364-4810-bff8-70a28fd776b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFFDSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFFDSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

