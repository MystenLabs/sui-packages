module 0x6ddde15a09a805c1096c8d11cb676c57ba827a2b4a94bee514e88b1f1d0bb2cb::b_lols2 {
    struct B_LOLS2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LOLS2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LOLS2>(arg0, 9, b"bLOLS2", b"bToken LOLS2", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LOLS2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LOLS2>>(v1);
    }

    // decompiled from Move bytecode v6
}

