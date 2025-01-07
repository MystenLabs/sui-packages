module 0x583c9645991f6930953455abd82be82564fe8feb10c01f62e1ac1ff3e446ccc9::hto {
    struct HTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTO>(arg0, 9, b"HTO", b"Hitori", b"Hitori is always fun and waifuble", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c14ee38e-65ed-4d84-a2d5-e579202319d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

