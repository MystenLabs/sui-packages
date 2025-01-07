module 0x232bcf980b826ab7bba1629c807b756e7fc507d0e84f009bfdd31caffa175365::meme_08_05_2024_06 {
    struct MEME_08_05_2024_06 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_08_05_2024_06, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_08_05_2024_06>(arg0, 6, b"MEME_08_05_2024_06", b"meme0805202406", b"08 May 2024 six", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_08_05_2024_06>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_08_05_2024_06>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_08_05_2024_06>>(v1);
    }

    // decompiled from Move bytecode v6
}

