module 0xdedd75a8f2d2d1c7cae89479ed9f84a1e77ed2a1d6aa2c00067df7532ecc81ba::iisdflfwef {
    struct IISDFLFWEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: IISDFLFWEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IISDFLFWEF>(arg0, 6, b"Iisdflfwef", b"petvwrtv", b"Nigeria123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730942817970.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IISDFLFWEF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IISDFLFWEF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

