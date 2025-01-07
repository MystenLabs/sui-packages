module 0x9a2b0491f0fac576b8cb7871f016bf36ced270ae71220571ae18d0d4db6ad87c::catbosu {
    struct CATBOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOSU>(arg0, 6, b"CATBOSU", b"CATBOSUI", b"CATBOSU, is the incarnation of KABOSU, VIRAL SHIBA INU BEHIND 'DOGE' MEMES return from heaven as a CAT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_06_37_03_36beb5f29a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

