module 0x57d9ac8a74b5917811b8b9943c954f5cec3fcd33bc7ed2b20629b8b578b48eb6::magm {
    struct MAGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGM, arg1: &mut 0x2::tx_context::TxContext) {
        0xfab804e980fbb981fad4f62f55027cc3587bdb9b1c7daa438a7751faef0c6375::mtoken::create_coin<MAGM>(arg0, 9, b"MAGM", b"Matrixdock Silver", b"Matrixdock Silver (MAGM) is ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xagm/xagm-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

