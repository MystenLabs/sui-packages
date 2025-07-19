module 0x32c1de96ae2495c072497f07951a75c7837175e83c0598d0f795761f7dd02dab::glk {
    struct GLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GLK>(arg0, 6, b"GLK", b"GLK ", b"GLOBAL WARMING WILL HAVE MORE POWER THAN AI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000148519_a1357c7ced.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

