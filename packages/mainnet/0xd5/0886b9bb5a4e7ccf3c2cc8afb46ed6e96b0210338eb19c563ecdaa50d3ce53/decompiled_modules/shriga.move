module 0xd50886b9bb5a4e7ccf3c2cc8afb46ed6e96b0210338eb19c563ecdaa50d3ce53::shriga {
    struct SHRIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIGA>(arg0, 9, b"SHRIGA", b"SHRIGGA", b"shrigga is an innovative meme coin designed to symbolize unity and understanding between the tribes of Green Shrek and Black Shrek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53508b78-b956-475f-8414-a4d9a68f71e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

