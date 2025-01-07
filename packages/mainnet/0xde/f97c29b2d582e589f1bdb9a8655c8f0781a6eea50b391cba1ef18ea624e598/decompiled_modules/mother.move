module 0xdef97c29b2d582e589f1bdb9a8655c8f0781a6eea50b391cba1ef18ea624e598::mother {
    struct MOTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTHER>(arg0, 6, b"MOTHER", b"Mother Iggy", b"BUY $MOTHER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_07_13_22_17_7ca08193fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

