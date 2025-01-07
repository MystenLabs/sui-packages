module 0xde7d01b8f9c45494c12cff2a1aca845fdd0403d2eeaa94e3f867ff7a437f0de7::meme_09_05_2024_03 {
    struct MEME_09_05_2024_03 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_09_05_2024_03, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_09_05_2024_03>(arg0, 6, b"MEME_09_05_2024_03", b"meme0905202403", b"09 May 2024 first third", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_09_05_2024_03>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_09_05_2024_03>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_09_05_2024_03>>(v1);
    }

    // decompiled from Move bytecode v6
}

