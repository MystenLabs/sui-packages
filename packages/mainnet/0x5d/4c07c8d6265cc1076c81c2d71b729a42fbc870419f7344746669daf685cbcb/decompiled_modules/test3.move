module 0x5d4c07c8d6265cc1076c81c2d71b729a42fbc870419f7344746669daf685cbcb::test3 {
    struct TEST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST3>(arg0, 9, b"TEST3", b"TEST3", b"TEST3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TEST3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST3>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST3>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST3>>(v2);
    }

    // decompiled from Move bytecode v6
}

