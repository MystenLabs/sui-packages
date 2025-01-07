module 0x44bfbbb24ec64752872c4d7a66e01957ce96566c99b44675769510cd6f7be95::milky {
    struct MILKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILKY>(arg0, 6, b"MILKY", b"Milky", x"4d696c6b7920697320616c6c207765206e65656420746f2072656761696e20656e657267790a616e6420636f6e74696e75652074726164696e67206c696b6520610a70726f66657373696f6e616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_67146e86f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

