module 0x33ee492aa1b0cdb397c0fe2ec744aa224079cdced3143391af2b8e5411ce7751::catbosui {
    struct CATBOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOSUI>(arg0, 6, b"CATBOSUI", b"CATBOSU", b"CATBOSU, is the incarnation of KABOSU, VIRAL SHIBA INU BEHIND 'DOGE' MEMES return from heaven as a CAT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_06_37_03_c1248d09cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

