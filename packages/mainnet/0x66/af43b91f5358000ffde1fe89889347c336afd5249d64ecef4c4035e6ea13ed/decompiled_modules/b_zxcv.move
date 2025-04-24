module 0x66af43b91f5358000ffde1fe89889347c336afd5249d64ecef4c4035e6ea13ed::b_zxcv {
    struct B_ZXCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZXCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZXCV>(arg0, 9, b"bZXCV", b"bToken ZXCV", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZXCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZXCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

