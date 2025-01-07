module 0x6235b20f65d088926c1e91ed8cf8e601f389fe82b4ded0e58111d7d607eb4571::ahc {
    struct AHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHC>(arg0, 6, b"AHC", b"aaa Hapalochlaen maculosa", b"Hapalochlaen maculosa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_c_601054421_e_e_c_c_e_a_e_e_ae_ae_ae_a_ae_ae_c_a_ae_c929725213.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHC>>(v1);
    }

    // decompiled from Move bytecode v6
}

