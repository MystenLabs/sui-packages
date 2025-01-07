module 0xc9afa2b3b89835c8673c135b97edac058df82147d63ba1982101654d744619c8::crptsh1t {
    struct CRPTSH1T has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRPTSH1T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRPTSH1T>(arg0, 9, b"CRPTSH1T", b"CryptoSh1t", b"Just memTocen & full crypto funky sh1t ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f6fdb4e-56de-4750-b30b-7c5f36f42e39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRPTSH1T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRPTSH1T>>(v1);
    }

    // decompiled from Move bytecode v6
}

