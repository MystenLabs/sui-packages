module 0x53d41c45ee7049a2027731e09c9f93f3da206611d7ea9dd0936b98d53f0df930::b_rav {
    struct B_RAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_RAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_RAV>(arg0, 9, b"bRAV", b"bToken RAV", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_RAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_RAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

