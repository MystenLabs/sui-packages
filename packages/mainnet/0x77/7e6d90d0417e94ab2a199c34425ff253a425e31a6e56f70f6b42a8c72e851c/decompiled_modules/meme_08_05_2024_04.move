module 0x777e6d90d0417e94ab2a199c34425ff253a425e31a6e56f70f6b42a8c72e851c::meme_08_05_2024_04 {
    struct MEME_08_05_2024_04 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_08_05_2024_04, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_08_05_2024_04>(arg0, 6, b"MEME_08_05_2024_04", b"meme0805202404", b"08 May 2024 fourth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_08_05_2024_04>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_08_05_2024_04>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_08_05_2024_04>>(v1);
    }

    // decompiled from Move bytecode v6
}

