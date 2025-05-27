module 0x3a815c4b84c5672dfc2a287b194ac51cca618c84e4b2e5fb67f1617cde7064c5::b_la_baguette {
    struct B_LA_BAGUETTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LA_BAGUETTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LA_BAGUETTE>(arg0, 9, b"bBAGUETTE", b"bToken BAGUETTE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LA_BAGUETTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LA_BAGUETTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

