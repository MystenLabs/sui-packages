module 0xd9b69c9b02c49aac20b4a71c93b1682960e31dd1b7e1d247213407c27b83a107::b_bluai {
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

