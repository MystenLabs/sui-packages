module 0x504f9defd00aaf0be12c0e0184385d12ec8e31ff5229c7a2fed0312064c58795::newyear {
    struct NEWYEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWYEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWYEAR>(arg0, 6, b"NewYear", b"Happy 2025 New Year", b"Happy new year sui community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_12_31_225748_1_5e473ea05f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWYEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEWYEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

