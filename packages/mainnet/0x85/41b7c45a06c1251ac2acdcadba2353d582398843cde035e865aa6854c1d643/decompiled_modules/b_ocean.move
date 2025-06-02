module 0x8541b7c45a06c1251ac2acdcadba2353d582398843cde035e865aa6854c1d643::b_ocean {
    struct B_OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OCEAN>(arg0, 9, b"bOCEAN", b"bToken OCEAN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

