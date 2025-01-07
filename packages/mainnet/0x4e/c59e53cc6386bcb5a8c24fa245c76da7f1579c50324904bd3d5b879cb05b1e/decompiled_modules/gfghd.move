module 0x4ec59e53cc6386bcb5a8c24fa245c76da7f1579c50324904bd3d5b879cb05b1e::gfghd {
    struct GFGHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFGHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFGHD>(arg0, 9, b"GFGHD", b"ADFADAS", b"FNFGBFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfc4d872-6ae4-4069-a417-ead1b3da2035.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFGHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFGHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

