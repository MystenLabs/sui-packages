module 0xa8b32d766337a380a8a187f4d3e73395a2c3bf5c830e1d5b5d2b4d2f286d2515::b__cone {
    struct B__CONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B__CONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B__CONE>(arg0, 9, b"b$CONE", b"bToken $CONE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B__CONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B__CONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

