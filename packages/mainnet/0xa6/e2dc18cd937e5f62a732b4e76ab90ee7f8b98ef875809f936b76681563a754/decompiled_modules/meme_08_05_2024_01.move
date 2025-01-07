module 0xa6e2dc18cd937e5f62a732b4e76ab90ee7f8b98ef875809f936b76681563a754::meme_08_05_2024_01 {
    struct MEME_08_05_2024_01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_08_05_2024_01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_08_05_2024_01>(arg0, 6, b"MEME_08_05_2024_01", b"meme0805202401", b"08 May 2024 first", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_08_05_2024_01>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_08_05_2024_01>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_08_05_2024_01>>(v1);
    }

    // decompiled from Move bytecode v6
}

