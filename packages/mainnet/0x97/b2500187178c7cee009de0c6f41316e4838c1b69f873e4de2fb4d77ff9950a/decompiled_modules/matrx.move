module 0x97b2500187178c7cee009de0c6f41316e4838c1b69f873e4de2fb4d77ff9950a::matrx {
    struct MATRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATRX>(arg0, 6, b"MATRX", b"MATRIX", b"Choose your life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/matrix_a5b7aaeb31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

