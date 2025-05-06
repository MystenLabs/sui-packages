module 0xef43fc98ddda89b1eb4e81516e56660442f32f5031ae1c813ef024c9b154c5b9::b_neon {
    struct B_NEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NEON>(arg0, 9, b"bNEON", b"bToken NEON", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

