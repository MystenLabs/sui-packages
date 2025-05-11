module 0x188d18d32c75b2c37d60adfa1d498887384b2c0a0b0252bb4d41e6f7ded2d3a2::b_up {
    struct B_UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_UP>(arg0, 9, b"bUP", b"bToken UP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_UP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_UP>>(v1);
    }

    // decompiled from Move bytecode v6
}

