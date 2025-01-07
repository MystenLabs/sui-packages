module 0x44cad3a66ba2fa0278eaa80e8d7a0c57a7d2dca2346b971fa958130efd7e3187::DARAM {
    struct DARAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARAM>(arg0, 2, b"Daram-CTO", b"DARAM", b"100% fairness, anyone can only get tokens through free mint. Absolute dispersion. This is the most perfect meme coin ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F670937486fe782eefa2ae2d1_1728657225_672c7ebf90.png&w=640&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DARAM>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DARAM>(&mut v2, 50000000001, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::coin::mint_and_transfer<DARAM>(&mut v2, 50000000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARAM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

