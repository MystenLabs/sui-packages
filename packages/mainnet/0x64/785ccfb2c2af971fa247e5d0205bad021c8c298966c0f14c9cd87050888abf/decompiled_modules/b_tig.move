module 0x64785ccfb2c2af971fa247e5d0205bad021c8c298966c0f14c9cd87050888abf::b_tig {
    struct B_TIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TIG>(arg0, 9, b"bTIG", b"bToken TIG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

