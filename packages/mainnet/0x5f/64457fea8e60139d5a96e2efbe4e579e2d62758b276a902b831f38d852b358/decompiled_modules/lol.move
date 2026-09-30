module 0x5f64457fea8e60139d5a96e2efbe4e579e2d62758b276a902b831f38d852b358::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 9, b"lol", b"lol", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOL>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

