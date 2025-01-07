module 0xd2cea3f97f53e36b04be6129b4ec87360406dbde13b4bdf8354b33033bc57222::meme_26_2024 {
    struct MEME_26_2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_26_2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_26_2024>(arg0, 6, b"MEME_26_2024", b"meme262024", b"26 April 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_26_2024>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_26_2024>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_26_2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

