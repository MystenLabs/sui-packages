module 0x91c1d52e4d70a0e592f92af28554ce49e0c6681690821b1dfa830a39d32adb65::glk {
    struct GLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLK>(arg0, 6, b"GLK", b"GLONK", b"I m ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3529_5a1266c8a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

