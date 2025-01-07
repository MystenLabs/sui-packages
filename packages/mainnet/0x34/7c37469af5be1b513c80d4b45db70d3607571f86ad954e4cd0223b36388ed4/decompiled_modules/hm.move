module 0x347c37469af5be1b513c80d4b45db70d3607571f86ad954e4cd0223b36388ed4::hm {
    struct HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HM>(arg0, 6, b"HM", b"Hapalochlaen maculosa", b"Hapalochlaen maculosa on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_c_601054421_e_e_c_c_e_a_e_e_ae_ae_ae_a_ae_ae_c_a_ae_757e3253be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HM>>(v1);
    }

    // decompiled from Move bytecode v6
}

