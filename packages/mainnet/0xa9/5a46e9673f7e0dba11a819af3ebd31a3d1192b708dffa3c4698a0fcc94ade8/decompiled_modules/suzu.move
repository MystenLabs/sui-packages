module 0xa95a46e9673f7e0dba11a819af3ebd31a3d1192b708dffa3c4698a0fcc94ade8::suzu {
    struct SUZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZU>(arg0, 6, b"Suzu", b"suzu", x"2473757a7520707574732074686520737520696e20247375690a0a54686520536869626120646f67206f662074686520537569204e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0426_ac8eec3a62.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

