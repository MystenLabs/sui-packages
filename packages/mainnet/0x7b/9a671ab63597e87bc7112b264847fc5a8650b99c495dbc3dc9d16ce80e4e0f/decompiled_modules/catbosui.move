module 0x7b9a671ab63597e87bc7112b264847fc5a8650b99c495dbc3dc9d16ce80e4e0f::catbosui {
    struct CATBOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOSUI>(arg0, 6, b"CATBOSUI", b"CATBOSU", b"CATBOSU, is the incarnation of KABOSU, VIRAL SHIBA INU BEHIND 'DOGE' MEMES return from heaven as a CAT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_01_30_19_6c38c62885.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

