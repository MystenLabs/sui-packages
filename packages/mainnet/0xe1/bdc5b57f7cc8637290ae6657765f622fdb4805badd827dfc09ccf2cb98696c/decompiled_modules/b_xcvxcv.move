module 0xe1bdc5b57f7cc8637290ae6657765f622fdb4805badd827dfc09ccf2cb98696c::b_xcvxcv {
    struct B_XCVXCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_XCVXCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_XCVXCV>(arg0, 9, b"bXCVXCV", b"bToken XCVXCV", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_XCVXCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_XCVXCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

