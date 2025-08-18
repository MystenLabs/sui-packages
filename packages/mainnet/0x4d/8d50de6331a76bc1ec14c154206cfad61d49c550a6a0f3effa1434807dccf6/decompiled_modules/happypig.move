module 0x4d8d50de6331a76bc1ec14c154206cfad61d49c550a6a0f3effa1434807dccf6::happypig {
    struct HAPPYPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPYPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPYPIG>(arg0, 9, b"HAPPYPIG", b"HappyPig", b"123123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://picsum.photos/200/300")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HAPPYPIG>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPPYPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

