module 0xfebea33f77c7e546662f9c8585dc951e545adbd0f71bf4c09d91932a4db4d3d5::bcdf {
    struct BCDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCDF>(arg0, 9, b"BCDF", b"Bvcd", b" Xxc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e7e8ed0-af35-44e8-b760-7203e27de319.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

