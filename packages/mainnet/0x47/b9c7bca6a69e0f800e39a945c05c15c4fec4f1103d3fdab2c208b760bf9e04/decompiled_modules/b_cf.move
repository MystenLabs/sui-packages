module 0x47b9c7bca6a69e0f800e39a945c05c15c4fec4f1103d3fdab2c208b760bf9e04::b_cf {
    struct B_CF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CF>(arg0, 9, b"bCF", b"bToken CF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CF>>(v1);
    }

    // decompiled from Move bytecode v6
}

