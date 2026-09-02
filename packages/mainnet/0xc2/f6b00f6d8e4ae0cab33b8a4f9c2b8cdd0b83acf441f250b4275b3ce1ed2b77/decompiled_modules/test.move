module 0xc2f6b00f6d8e4ae0cab33b8a4f9c2b8cdd0b83acf441f250b4275b3ce1ed2b77::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"-";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"-"))
        };
        let (v2, v3) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"Test", x"54657374e2808b", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::mint<TEST>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

