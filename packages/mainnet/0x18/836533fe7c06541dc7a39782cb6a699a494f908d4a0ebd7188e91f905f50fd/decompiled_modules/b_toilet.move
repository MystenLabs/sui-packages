module 0x18836533fe7c06541dc7a39782cb6a699a494f908d4a0ebd7188e91f905f50fd::b_toilet {
    struct B_TOILET has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TOILET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TOILET>(arg0, 9, b"bToilet", b"bToken Toilet", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TOILET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TOILET>>(v1);
    }

    // decompiled from Move bytecode v6
}

