module 0x45bd9ccf23eb030477b1195205596f449dfd5399ad47c93c1d54eabe10bf0f14::sfrog {
    struct SFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROG>(arg0, 6, b"Sfrog", b"suifrog", b"aquarium pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fj_F_Gx_X36q_X_8_c11b4ef5d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

