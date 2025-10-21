module 0xaea7c0d1b7767f9425e77f0594800761565c3f725ce0710c6a97c7c393c7d5c1::b_bluai {
    struct B_BLUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BLUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BLUAI>(arg0, 9, b"bBLUAI", b"bToken BLUAI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BLUAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BLUAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

