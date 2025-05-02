module 0xdd21b881cd9665114b7307eaed0c35d619d65e28c8a49031cf4aa354681ab800::b_alh {
    struct B_ALH has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ALH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ALH>(arg0, 9, b"bALH", b"bToken ALH", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ALH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ALH>>(v1);
    }

    // decompiled from Move bytecode v6
}

