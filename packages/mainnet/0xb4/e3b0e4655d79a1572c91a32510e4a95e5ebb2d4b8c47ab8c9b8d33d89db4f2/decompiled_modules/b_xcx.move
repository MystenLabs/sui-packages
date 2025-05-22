module 0xb4e3b0e4655d79a1572c91a32510e4a95e5ebb2d4b8c47ab8c9b8d33d89db4f2::b_xcx {
    struct B_XCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_XCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_XCX>(arg0, 9, b"bXCX", b"bToken XCX", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_XCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_XCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

