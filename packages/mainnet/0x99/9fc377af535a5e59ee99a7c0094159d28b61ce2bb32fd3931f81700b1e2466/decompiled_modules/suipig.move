module 0x999fc377af535a5e59ee99a7c0094159d28b61ce2bb32fd3931f81700b1e2466::suipig {
    struct SUIPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIG>(arg0, 6, b"SUIPig", b"SUIPIG", b"SUIPIG is a high-yield frictionless farming token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729940907080_845a541166.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

