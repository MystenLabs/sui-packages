module 0xaf8c86aba8b39e0810207ddf276c58902b37c601ba57b30c1d9be5093d9f86b4::b_lofi {
    struct B_LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LOFI>(arg0, 9, b"bLOFI", b"bToken LOFI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

