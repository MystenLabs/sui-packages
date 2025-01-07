module 0x98d3a6d00baab8c220e11abc03c4b26088ef0f87a0bdce6522a5802549a40c67::hom {
    struct HOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOM>(arg0, 6, b"HoM", b"Hapalochlaen maculosa", b"Extremely poisonous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_c_601054421_e_e_c_c_e_a_e_e_ae_ae_ae_a_ae_ae_c_a_ae_8f8626ccaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

