module 0x5afeaba92b6cbaa91efae6b5d286810f84b9a7b41215b3b6104886d9a4da2801::azul {
    struct AZUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZUL>(arg0, 6, b"AZUL", b"Azul Blue The Bear", b"This cute azul bear is here to win heart and unite the strong sui community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_23_34_58_b510401604.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

