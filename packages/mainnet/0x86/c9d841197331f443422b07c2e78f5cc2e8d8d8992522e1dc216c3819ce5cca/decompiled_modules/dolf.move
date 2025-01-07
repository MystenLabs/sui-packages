module 0x86c9d841197331f443422b07c2e78f5cc2e8d8d8992522e1dc216c3819ce5cca::dolf {
    struct DOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLF>(arg0, 9, b"DOLF", b"Dollfin", b"Ocean seafood dollfin meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83a26d37-5cd7-4405-b85f-492df7faa3f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

