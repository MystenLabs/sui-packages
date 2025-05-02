module 0x55974b2c76b9944cf5e1146f8e3ecab526ab1cdbe8059c8560fbc8644f91e15c::b_frst {
    struct B_FRST has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FRST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FRST>(arg0, 9, b"bFRST", b"bToken FRST", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FRST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FRST>>(v1);
    }

    // decompiled from Move bytecode v6
}

