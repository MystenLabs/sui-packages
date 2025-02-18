module 0x5b8956e72329445e72fe0115c1b03222179f9cf1d7a2a4160a91f66fc7e95917::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 9, b"test2", b"test3", b"test4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"test5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST1>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST1>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST1>>(v2);
    }

    // decompiled from Move bytecode v6
}

