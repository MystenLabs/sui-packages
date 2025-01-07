module 0x34d1fc6f44297c3bd7ff90ca3f2991b066cdd0db4a1d8b8e9e46306faf871aad::ocnn {
    struct OCNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCNN>(arg0, 9, b"OCNN", b"OCEAN", b"ocean1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8402bd4d-7f29-47c5-a1a2-894e6046226f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

