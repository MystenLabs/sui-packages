module 0x6fbeef7129fd4dea6c66333998803af3c364ed971d3454fe22a2fe8347e8c818::kensb {
    struct KENSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENSB>(arg0, 9, b"KENSB", b"jsosk", b"sjnen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6ec9362-748b-49b2-b19d-bd900e45da96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

