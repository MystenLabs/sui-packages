module 0x1ab4b6189898c199fa7764444b6ed863a6f8763c9e8a203f8c8850a4e4250d35::buxter {
    struct BUXTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUXTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUXTER>(arg0, 6, b"BUXTER", b"Buxter cat", b"Buxter cat is the bravest cat when he is challenged and has his pride lowered", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042477_040e86430d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUXTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUXTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

