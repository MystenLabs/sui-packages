module 0xe84bbffb2060260384ccd2009e25acbd59d9f4fa32d43ed0f230bcf52483f1d7::will {
    struct WILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL>(arg0, 6, b"WILL", b"WILLIE", x"57494c4c4945206973206120636f6d6d756e6974792d64726976656e206d656d65206e617469766520746f205375690a57494c4c4945206973206865726520746f2077696e20697420616c6c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_05_02_30_04_a24c59d993.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

