module 0x3b903ee670624e1724c26adac1b3c80c1b993c0d376571c85f48d877728b165e::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-205602358a68450eb9bf79d0af983032.r2.dev/icons/61efc0e155f45c5695e7f36a60b6acee.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

