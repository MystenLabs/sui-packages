module 0xa8f3964a94dd95c25e534873ab2bbaffbb1003d018f22e2c74ac5d5c3dacc4c0::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 9, b"test1", b"test1", b"do not buy this is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST1>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v2, @0xd2420ad33ab5e422becf2fa0e607e1dde978197905b87d070da9ffab819071d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST1>>(v1);
    }

    // decompiled from Move bytecode v6
}

