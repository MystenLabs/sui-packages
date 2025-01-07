module 0xd37cc46f1c5103306a7e6ff08eb6c0e040e2ef6f06c2b8790021914e3ed13149::suipig {
    struct SUIPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIG>(arg0, 6, b"SUIPig", b"SUIPIG", b"SUIPIG is a high-yield frictionless farming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729940907080_0fa465e215.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

