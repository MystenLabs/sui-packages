module 0x2a47a5eb64b2dcbb54fe5f467d55d03da87a62ff2969bb239df210133874ef4e::suipig {
    struct SUIPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIG>(arg0, 6, b"SUIpig", b"SUIPIG", b"SUIPIG is a high-yield frictionless farming token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729940907080_41beaf7ee8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

