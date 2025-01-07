module 0xf7f94abc238713d7e226879cce54eaee9ebb44494d47c8082eae8910ecafdb0::zoom {
    struct ZOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOOM>(arg0, 9, b"ZOOM", b"ZoomerCoin", b"ZoomerCoin is a meme token designed specifically for the younger generation, especially the energetic and dynamic Gen Z. With a modern internet meme theme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70ca2791-9211-4c04-ab69-e027235ce8fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

