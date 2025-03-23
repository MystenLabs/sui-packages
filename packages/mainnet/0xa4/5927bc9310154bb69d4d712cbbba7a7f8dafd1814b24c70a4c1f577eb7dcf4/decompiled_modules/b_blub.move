module 0xa45927bc9310154bb69d4d712cbbba7a7f8dafd1814b24c70a4c1f577eb7dcf4::b_blub {
    struct B_BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BLUB>(arg0, 9, b"bBLUB", b"bToken BLUB", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

