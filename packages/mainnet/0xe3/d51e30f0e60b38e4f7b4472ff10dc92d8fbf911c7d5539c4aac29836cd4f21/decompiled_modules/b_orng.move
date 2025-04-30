module 0xe3d51e30f0e60b38e4f7b4472ff10dc92d8fbf911c7d5539c4aac29836cd4f21::b_orng {
    struct B_ORNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ORNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ORNG>(arg0, 9, b"bORNG", b"bToken ORNG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ORNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ORNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

