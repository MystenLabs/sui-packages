module 0x732fe9997b52cf690a714e20333169b591185e79cf740ded7e7755fe474d7ac9::b_new {
    struct B_NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NEW>(arg0, 9, b"bNEW", b"bToken NEW", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

