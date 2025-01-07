module 0x9566ddc04ea77c6a002518999f0ec0e9c0a693b99e786210f8c6d86481afea0c::mefwends {
    struct MEFWENDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEFWENDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEFWENDS>(arg0, 6, b"MEFWENDS", b"BLUE MEFWENDS", b"CAN WE BE FWENDS ??? PUSH TO BILLION MC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3760_1b7a2b1e09.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEFWENDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEFWENDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

