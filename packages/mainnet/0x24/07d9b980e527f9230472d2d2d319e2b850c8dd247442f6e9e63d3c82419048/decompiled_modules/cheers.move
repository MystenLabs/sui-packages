module 0x2407d9b980e527f9230472d2d2d319e2b850c8dd247442f6e9e63d3c82419048::cheers {
    struct CHEERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEERS>(arg0, 6, b"CHEERS", b"Cheers to Sui", b"A token celebrating the hard work of the sui network team.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5807_4cc0d29569.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

