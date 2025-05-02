module 0xa9cc2b003c971df2a0914dcba1a6edc74f8a10edd875743fac0f7e4351e3379d::b_grll {
    struct B_GRLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GRLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GRLL>(arg0, 9, b"bGRLL", b"bToken GRLL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GRLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_GRLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

