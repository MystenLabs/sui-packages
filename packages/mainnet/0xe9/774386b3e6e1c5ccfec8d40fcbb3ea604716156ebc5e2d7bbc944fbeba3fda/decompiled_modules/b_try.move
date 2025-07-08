module 0xe9774386b3e6e1c5ccfec8d40fcbb3ea604716156ebc5e2d7bbc944fbeba3fda::b_try {
    struct B_TRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TRY>(arg0, 9, b"bTRY", b"bToken TRY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

