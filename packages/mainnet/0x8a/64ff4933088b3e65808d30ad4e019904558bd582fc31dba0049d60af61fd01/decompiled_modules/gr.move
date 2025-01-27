module 0x8a64ff4933088b3e65808d30ad4e019904558bd582fc31dba0049d60af61fd01::gr {
    struct GR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GR>(arg0, 9, b"GR", b"GRAY", b"Just a color", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/854c6a0f-6571-4720-aca1-bf20fd67f3c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GR>>(v1);
    }

    // decompiled from Move bytecode v6
}

