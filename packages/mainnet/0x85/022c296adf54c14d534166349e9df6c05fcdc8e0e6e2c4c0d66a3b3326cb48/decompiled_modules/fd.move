module 0x85022c296adf54c14d534166349e9df6c05fcdc8e0e6e2c4c0d66a3b3326cb48::fd {
    struct FD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FD>(arg0, 6, b"FD", b"ddf", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FD>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FD>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

