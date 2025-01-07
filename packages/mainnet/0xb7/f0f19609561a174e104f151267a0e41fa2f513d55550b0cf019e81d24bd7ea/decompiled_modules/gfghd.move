module 0xb7f0f19609561a174e104f151267a0e41fa2f513d55550b0cf019e81d24bd7ea::gfghd {
    struct GFGHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFGHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFGHD>(arg0, 9, b"GFGHD", b"ADFADAS", b"FNFGBFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f75fb375-31be-4bea-a305-11d701dfd6df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFGHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFGHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

