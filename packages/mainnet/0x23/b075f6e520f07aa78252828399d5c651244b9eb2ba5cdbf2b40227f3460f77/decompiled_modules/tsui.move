module 0x23b075f6e520f07aa78252828399d5c651244b9eb2ba5cdbf2b40227f3460f77::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"TSUI", b"Tsuinami", x"43616e27742073746f7020776f6e27742073746f7020547375696e616d6920566f6c756d65206f6e2053554920287468696e6b696e672061626f757420537569290a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_23_16_58_bde6cb5a80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

