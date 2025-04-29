module 0xab2fc0759a66750ee3905d2df637c4beb9d7f46e1b0ac0083c6a5983ca81e860::b_xzcv {
    struct B_XZCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_XZCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_XZCV>(arg0, 9, b"bXZCV", b"bToken XZCV", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_XZCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_XZCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

