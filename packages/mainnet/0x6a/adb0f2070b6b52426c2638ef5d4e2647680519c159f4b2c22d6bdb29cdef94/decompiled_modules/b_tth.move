module 0x6aadb0f2070b6b52426c2638ef5d4e2647680519c159f4b2c22d6bdb29cdef94::b_tth {
    struct B_TTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TTH>(arg0, 9, b"bTTH", b"bToken TTH", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

