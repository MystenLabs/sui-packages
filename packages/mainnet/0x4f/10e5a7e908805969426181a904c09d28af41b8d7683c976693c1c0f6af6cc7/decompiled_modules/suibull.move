module 0x4f10e5a7e908805969426181a904c09d28af41b8d7683c976693c1c0f6af6cc7::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULL>(arg0, 6, b"SUIBULL", b"SUI BULL", x"2442756c6c27697368206f6e2074686520537569204e6574776f726b200a68747470733a2f2f782e636f6d2f53756942756c6c4d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3574_f9f57ff32b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

