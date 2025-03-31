module 0x589f2c5efeb2ef5e442ac0669f6719a3a1a38922748b124b0f5d078ca9c6858a::wolly {
    struct WOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLLY>(arg0, 6, b"WOLLY", b"Wolly", b"Wolly is the walrus wall on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052433_a43abae651.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

