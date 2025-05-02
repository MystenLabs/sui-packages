module 0x33023aa2492a752ecc5c5948e38e5cefc1bc5d43c9712f07c36a88d4c1adb762::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 9, b"one", b"one", b"just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

