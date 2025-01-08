module 0x3a5913d8e8d3ba81298c9911094eca7ab95123add92b03ef40426d2bea13f8d2::mocktokenone {
    struct MOCKTOKENONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCKTOKENONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCKTOKENONE>(arg0, 9, b"MOCKTOKENONE", b"MOCKKK", b"SA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOCKTOKENONE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCKTOKENONE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCKTOKENONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

