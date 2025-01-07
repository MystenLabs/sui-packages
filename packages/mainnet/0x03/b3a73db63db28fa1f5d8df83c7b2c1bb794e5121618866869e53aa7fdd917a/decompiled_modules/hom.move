module 0x3b3a73db63db28fa1f5d8df83c7b2c1bb794e5121618866869e53aa7fdd917a::hom {
    struct HOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOM>(arg0, 6, b"HOM", b"Hapalochlaen maculosa", b"Extremely poisonous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_c_601054421_e_e_c_c_e_a_e_e_ae_ae_ae_a_ae_ae_c_a_ae_6a4c98c41b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

