module 0xde5087f4440d7800cb15624e0174602ac676a44dac197471938dd9cc68cd0c42::cybrsefrd {
    struct CYBRSEFRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBRSEFRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBRSEFRD>(arg0, 9, b"CYBRSEFRD", b"CYBR SEFRD", b"A meme coin based on futuristic German Shepherd in Cyber City, symbolizing intelligence, loyalty, adaptability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73a8bb57-6245-4031-9751-6431e598046e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBRSEFRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBRSEFRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

