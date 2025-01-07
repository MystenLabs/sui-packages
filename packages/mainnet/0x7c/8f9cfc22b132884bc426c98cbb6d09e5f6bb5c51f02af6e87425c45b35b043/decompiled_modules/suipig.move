module 0x7c8f9cfc22b132884bc426c98cbb6d09e5f6bb5c51f02af6e87425c45b35b043::suipig {
    struct SUIPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIG>(arg0, 6, b"SUIPig", b"SUIPIG", b"SUIPIG is a high-yield frictionless farming token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729940907080_030e0475d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

