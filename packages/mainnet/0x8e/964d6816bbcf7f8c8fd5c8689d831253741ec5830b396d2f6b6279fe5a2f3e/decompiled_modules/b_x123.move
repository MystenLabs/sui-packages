module 0x8e964d6816bbcf7f8c8fd5c8689d831253741ec5830b396d2f6b6279fe5a2f3e::b_x123 {
    struct B_X123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_X123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_X123>(arg0, 9, b"bX123", b"bToken X123", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_X123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_X123>>(v1);
    }

    // decompiled from Move bytecode v6
}

