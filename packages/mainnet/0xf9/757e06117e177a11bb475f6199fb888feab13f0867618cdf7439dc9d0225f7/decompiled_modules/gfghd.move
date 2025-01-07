module 0xf9757e06117e177a11bb475f6199fb888feab13f0867618cdf7439dc9d0225f7::gfghd {
    struct GFGHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFGHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFGHD>(arg0, 9, b"GFGHD", b"ADFADAS", b"FNFGBFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f789030-229e-4211-9360-62f6e8ded3cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFGHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFGHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

