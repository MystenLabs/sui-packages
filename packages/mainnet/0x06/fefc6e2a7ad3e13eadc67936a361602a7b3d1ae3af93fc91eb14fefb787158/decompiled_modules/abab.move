module 0x6fefc6e2a7ad3e13eadc67936a361602a7b3d1ae3af93fc91eb14fefb787158::abab {
    struct ABAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABAB>(arg0, 9, b"abab", b"bab", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABAB>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABAB>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

