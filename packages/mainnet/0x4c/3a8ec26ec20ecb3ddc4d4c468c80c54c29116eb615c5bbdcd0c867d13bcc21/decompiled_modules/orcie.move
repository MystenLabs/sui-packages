module 0x4c3a8ec26ec20ecb3ddc4d4c468c80c54c29116eb615c5bbdcd0c867d13bcc21::orcie {
    struct ORCIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCIE>(arg0, 6, b"ORCIE", b"SUI ORCIE", x"436f6d65207269646520746865207761766573206f66205355492077697468204f524349452e0a41696d696e6720666f722074686520746f7020616e64206e6f7468696e67206c6573732e20546f676574686572206173206120636f6d6d756e6974792077652063616e2067726f7720616e64206c61756768206174206f72636965206d656d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986291451.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

