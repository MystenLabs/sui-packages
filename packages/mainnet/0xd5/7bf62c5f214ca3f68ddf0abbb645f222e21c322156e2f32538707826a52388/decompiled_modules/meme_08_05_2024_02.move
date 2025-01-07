module 0xd57bf62c5f214ca3f68ddf0abbb645f222e21c322156e2f32538707826a52388::meme_08_05_2024_02 {
    struct MEME_08_05_2024_02 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_08_05_2024_02, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_08_05_2024_02>(arg0, 6, b"MEME_08_05_2024_02", b"meme0805202402", b"08 May 2024 second", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_08_05_2024_02>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_08_05_2024_02>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_08_05_2024_02>>(v1);
    }

    // decompiled from Move bytecode v6
}

