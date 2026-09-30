module 0xa3ccfdd3c8759b59d8831e5f0d5eb666c4dd98176761a9c8b00729b0daf33220::now2 {
    struct NOW2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOW2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOW2>(arg0, 9, b"now2", b"now2", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOW2>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOW2>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

