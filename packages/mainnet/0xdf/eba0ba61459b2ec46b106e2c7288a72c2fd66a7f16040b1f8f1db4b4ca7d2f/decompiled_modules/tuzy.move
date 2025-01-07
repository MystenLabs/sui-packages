module 0xdfeba0ba61459b2ec46b106e2c7288a72c2fd66a7f16040b1f8f1db4b4ca7d2f::tuzy {
    struct TUZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUZY>(arg0, 6, b"Tuzy", b"Tuzy sui chain", b"Tuzy is the new meta on sui chain, we are project billion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_14_232338_3c03358054.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

