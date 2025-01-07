module 0x21c9190a5296e7ccb0a091009b58d67ec9ca9c7529c570f6a9837ca089bde5a5::suikeke {
    struct SUIKEKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEKE>(arg0, 6, b"SUIKEKE", b"KEKE", x"74686520616e6369656e74206368616f7320676f64207475726e6564206469676974616c206c6567656e642c20766962657320686172642077697468206d656d65206d6167696320616e64206461726b206e6574206d797374697175652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3525_e1b439aab2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

