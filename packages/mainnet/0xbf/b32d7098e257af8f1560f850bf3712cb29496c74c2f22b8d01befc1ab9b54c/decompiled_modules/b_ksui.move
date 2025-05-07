module 0xbfb32d7098e257af8f1560f850bf3712cb29496c74c2f22b8d01befc1ab9b54c::b_ksui {
    struct B_KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KSUI>(arg0, 9, b"bKSUI", b"bToken KSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

