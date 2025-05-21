module 0x7dfb17d469cdba6e1fe80840076481f44c2d1ba431236b1204f581a1760c52d4::kurosu {
    struct KUROSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUROSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUROSU>(arg0, 6, b"KuroSu", b"Kuromi Hugs Sui", b"KuroSui isnt just a token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihmokmvuow5527kc4zrik2s3o2l7z4ia7w2cptharirk5pzsbpz7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUROSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KUROSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

