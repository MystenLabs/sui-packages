module 0x4fd9c8074d438badf90bfae5503b10e7664ef8fa6aa852f6813b9cb0d653e63a::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING>(arg0, 9, b"Testing", b"Testing", b"Testing snuper protection max buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTING>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v2, @0xd2420ad33ab5e422becf2fa0e607e1dde978197905b87d070da9ffab819071d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTING>>(v1);
    }

    // decompiled from Move bytecode v6
}

