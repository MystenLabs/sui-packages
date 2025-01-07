module 0x4c19f7fb71c3e8b5aa1ee8c77bd29e4d469ebba2163bd6226c9333f426e9670a::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"test", b"test", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

