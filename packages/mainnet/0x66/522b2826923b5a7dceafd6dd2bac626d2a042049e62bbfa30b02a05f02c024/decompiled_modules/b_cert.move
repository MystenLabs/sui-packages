module 0x66522b2826923b5a7dceafd6dd2bac626d2a042049e62bbfa30b02a05f02c024::b_cert {
    struct B_CERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CERT>(arg0, 9, b"bvSUI", b"bToken vSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

