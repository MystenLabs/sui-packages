module 0x55b2f23861500a09c29dc833bb1ee8cbe1b64ee175aba22bd979f08d9f7643bd::b_osho {
    struct B_OSHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OSHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OSHO>(arg0, 9, b"bOSHO", b"bToken OSHO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OSHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OSHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

