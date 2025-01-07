module 0xd7436c4c051caf789cc80901a22a97bb59c44fbd0f7f55e2470ac3dec375e8b0::meme_06_05_2024_02 {
    struct MEME_06_05_2024_02 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_06_05_2024_02, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_06_05_2024_02>(arg0, 6, b"MEME_06_05_2024_02", b"meme0605202402", b"06 May 2024 second", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_06_05_2024_02>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_06_05_2024_02>>(v2, @0x9636ead2159f25e1f269223d53d51f0065915a5255fecab0ff1485ab8c64eeec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_06_05_2024_02>>(v1);
    }

    // decompiled from Move bytecode v6
}

