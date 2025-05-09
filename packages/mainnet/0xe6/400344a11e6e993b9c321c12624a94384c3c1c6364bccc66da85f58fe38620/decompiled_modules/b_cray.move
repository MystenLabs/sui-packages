module 0xe6400344a11e6e993b9c321c12624a94384c3c1c6364bccc66da85f58fe38620::b_cray {
    struct B_CRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CRAY>(arg0, 9, b"bCRAY", b"bToken CRAY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

