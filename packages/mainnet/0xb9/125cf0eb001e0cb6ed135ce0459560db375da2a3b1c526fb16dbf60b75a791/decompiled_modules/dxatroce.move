module 0xb9125cf0eb001e0cb6ed135ce0459560db375da2a3b1c526fb16dbf60b75a791::dxatroce {
    struct DXATROCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXATROCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXATROCE>(arg0, 6, b"Dxatroce", b"Ladx", b"yes lets go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/siege_gamer_dxracer_formula_08_series_gc_f08_nr_h1_59a4988353.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXATROCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DXATROCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

