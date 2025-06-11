module 0x16c4afb3d4f36b68d13224f216a0c8b1c5132d8108e46b5ecea65a3b242819d3::b_mew {
    struct B_MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MEW>(arg0, 9, b"bMEW", b"bToken MEW", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

