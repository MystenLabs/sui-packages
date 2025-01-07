module 0x2493204fc061232ff4f5a7b03965646edefaee24e7cd35bd824ae21c1bb9176b::catbosu {
    struct CATBOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOSU>(arg0, 6, b"CATBOSU", b"CAT BO SUI", x"434154424f53550a0a434154424f53552c2069732074686520696e6361726e6174696f6e206f66204b41424f53552c20564952414c20534849424120494e5520424548494e442027444f474527204d454d45532072657475726e2066726f6d2068656176656e2061732061204341542e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_01_30_19_ba5b923380.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

