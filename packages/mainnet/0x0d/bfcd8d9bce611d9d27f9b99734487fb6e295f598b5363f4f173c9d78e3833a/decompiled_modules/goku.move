module 0xdbfcd8d9bce611d9d27f9b99734487fb6e295f598b5363f4f173c9d78e3833a::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"GOKU", b"SUINGOKU", b"The wait is OVER! Suingoku is here to take the meme coin world by STORM on the powerful Sui Network!  With unstoppable community power and heroic ambition, Suingoku isnt just a meme coin  its a movement! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_14_45_04_28a2c8f5bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

