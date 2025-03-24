module 0xcb8b698e8974f6bff8b9a924df167a5c74a4aaed0a4fd0af736c90a90bcc9e0f::b_kdx {
    struct B_KDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KDX>(arg0, 9, b"bKDX", b"bToken KDX", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KDX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KDX>>(v1);
    }

    // decompiled from Move bytecode v6
}

