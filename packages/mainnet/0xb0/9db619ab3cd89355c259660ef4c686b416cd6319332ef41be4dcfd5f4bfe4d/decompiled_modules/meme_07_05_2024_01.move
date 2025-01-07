module 0xb09db619ab3cd89355c259660ef4c686b416cd6319332ef41be4dcfd5f4bfe4d::meme_07_05_2024_01 {
    struct MEME_07_05_2024_01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_07_05_2024_01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_07_05_2024_01>(arg0, 6, b"MEME_07_05_2024_01", b"meme0705202401", b"07 May 2024 first", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_07_05_2024_01>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_07_05_2024_01>>(v2, @0x9636ead2159f25e1f269223d53d51f0065915a5255fecab0ff1485ab8c64eeec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_07_05_2024_01>>(v1);
    }

    // decompiled from Move bytecode v6
}

