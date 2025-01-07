module 0x3a47e8937479f8d0b0f24499694c6fb81ccf8ccb11991da43b50959d7a2573b5::catty {
    struct CATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTY>(arg0, 9, b"CATTY", b"Cats", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32a0cad1-6163-4f9a-b63e-60d5b6042a0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

