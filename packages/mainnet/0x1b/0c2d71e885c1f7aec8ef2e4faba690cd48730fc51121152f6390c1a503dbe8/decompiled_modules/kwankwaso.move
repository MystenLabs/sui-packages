module 0x1b0c2d71e885c1f7aec8ef2e4faba690cd48730fc51121152f6390c1a503dbe8::kwankwaso {
    struct KWANKWASO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWANKWASO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWANKWASO>(arg0, 9, b"KWANKWASO", b"Jagora ", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d3089c5-0873-48f5-85c8-4a71ac28781e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWANKWASO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWANKWASO>>(v1);
    }

    // decompiled from Move bytecode v6
}

