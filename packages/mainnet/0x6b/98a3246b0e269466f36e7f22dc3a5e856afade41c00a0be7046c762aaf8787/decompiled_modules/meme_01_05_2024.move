module 0x6b98a3246b0e269466f36e7f22dc3a5e856afade41c00a0be7046c762aaf8787::meme_01_05_2024 {
    struct MEME_01_05_2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_01_05_2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_01_05_2024>(arg0, 6, b"MEME_01_05_2024", b"meme01052024", b"01 May 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_01_05_2024>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_01_05_2024>>(v2, @0x9636ead2159f25e1f269223d53d51f0065915a5255fecab0ff1485ab8c64eeec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_01_05_2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

