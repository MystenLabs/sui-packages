module 0xb93a41b60750a7fd728140a9a0382ebf6d94c6e37ab01dc15649e81c4c96f0b2::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"test", b"test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

