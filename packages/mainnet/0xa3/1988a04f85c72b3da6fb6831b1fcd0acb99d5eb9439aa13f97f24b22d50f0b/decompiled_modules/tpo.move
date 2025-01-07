module 0xa31988a04f85c72b3da6fb6831b1fcd0acb99d5eb9439aa13f97f24b22d50f0b::tpo {
    struct TPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPO>(arg0, 9, b"TPO", b"TRUMPO", b"Its", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/036c8a99-dd3a-4c23-a147-7ffcf732285a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

