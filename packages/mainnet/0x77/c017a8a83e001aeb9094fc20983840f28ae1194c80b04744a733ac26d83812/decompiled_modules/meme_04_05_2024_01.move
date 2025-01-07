module 0x77c017a8a83e001aeb9094fc20983840f28ae1194c80b04744a733ac26d83812::meme_04_05_2024_01 {
    struct MEME_04_05_2024_01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_04_05_2024_01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_04_05_2024_01>(arg0, 6, b"MEME_04_05_2024_01", b"meme0405202401", b"04 May 2024 first", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_04_05_2024_01>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_04_05_2024_01>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_04_05_2024_01>>(v1);
    }

    // decompiled from Move bytecode v6
}

