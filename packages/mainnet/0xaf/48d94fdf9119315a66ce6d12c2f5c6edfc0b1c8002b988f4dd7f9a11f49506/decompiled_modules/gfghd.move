module 0xaf48d94fdf9119315a66ce6d12c2f5c6edfc0b1c8002b988f4dd7f9a11f49506::gfghd {
    struct GFGHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFGHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFGHD>(arg0, 9, b"GFGHD", b"ADFADAS", b"FNFGBFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3402c81b-0880-4b86-9f0f-c481b5f27c1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFGHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFGHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

