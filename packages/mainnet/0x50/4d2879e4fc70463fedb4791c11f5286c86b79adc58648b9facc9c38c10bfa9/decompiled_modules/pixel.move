module 0x504d2879e4fc70463fedb4791c11f5286c86b79adc58648b9facc9c38c10bfa9::pixel {
    struct PIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXEL>(arg0, 9, b"PIXEL", b"Pixel girl", b"Pixel punk girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/883b1e12-217d-4b0a-a8b7-7e9114613cfd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

