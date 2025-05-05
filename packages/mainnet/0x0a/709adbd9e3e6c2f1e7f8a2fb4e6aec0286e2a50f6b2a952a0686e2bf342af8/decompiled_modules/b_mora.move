module 0xa709adbd9e3e6c2f1e7f8a2fb4e6aec0286e2a50f6b2a952a0686e2bf342af8::b_mora {
    struct B_MORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MORA>(arg0, 9, b"bMORA", b"bToken MORA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

