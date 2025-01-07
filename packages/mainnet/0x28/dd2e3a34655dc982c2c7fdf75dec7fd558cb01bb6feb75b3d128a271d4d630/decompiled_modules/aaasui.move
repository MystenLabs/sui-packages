module 0x28dd2e3a34655dc982c2c7fdf75dec7fd558cb01bb6feb75b3d128a271d4d630::aaasui {
    struct AAASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASUI>(arg0, 6, b"AAASUI", b"aaasui", x"43616e27742073746f7020776f6e27742073746f70287468696e6b696e672061626f757420537569290a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa_1_0e37566459.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

