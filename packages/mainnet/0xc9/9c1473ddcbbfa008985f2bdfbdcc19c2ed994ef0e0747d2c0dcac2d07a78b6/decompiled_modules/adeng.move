module 0xc99c1473ddcbbfa008985f2bdfbdcc19c2ed994ef0e0747d2c0dcac2d07a78b6::adeng {
    struct ADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENG>(arg0, 6, b"ADENG", b"AAA Deng", x"43616e27742073746f702c20776f6e27742073746f70202874616c6b696e672061626f757420537569292e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_791aedba99_c8b2bd9147.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

