module 0x6e2cd5224a414b78901b10bc78bdcd42de16c991866086aa96c621e4c1230578::belu {
    struct BELU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELU>(arg0, 6, b"Belu", b"Belugan", x"4c6574277320637265617465206f757220776f726c6420776974686f757420616e796f6e65277320696e746572666572656e63650a4c6574277320637265617465206120776f726c64206f662042656c75676120696e207468652066697665206f6365616e7320616e642073697820636f6e74696e656e7473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_1_719505fa0c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELU>>(v1);
    }

    // decompiled from Move bytecode v6
}

