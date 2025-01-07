module 0x30fd3d8154ceba6662419b92dbb5fd068c46d17d97d2e695a35f981ef2875c74::bome {
    struct BOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME>(arg0, 6, b"BOME", b"BOOK OF MEME", b"BOOK OF MEME now comes to SUI chain to expand it's investors! Don't miss your opportunity to get in early! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/2024_09_24_14_11_27_2476737ae3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

