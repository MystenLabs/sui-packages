module 0xea7aad0a47e9a0114077766479945fba6595be713d52cf62f8d26863fac94ed::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 9, b"love", b"love", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOVE>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

