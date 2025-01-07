module 0x71f6bef8744229daf0b944573c976374ecc26370d4aadc52ae04133e4f6298bd::tema {
    struct TEMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMA>(arg0, 9, b"TEMA", b"Tema on SUI", b"Tema has 2,700,000 followers on tiktok, 1,700,000 on Youtube and 314,000 followers on IG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPgzimWXh4xZeTMkLHSJ97kgCtT2NCS9BbGr1dmhSJdi5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

