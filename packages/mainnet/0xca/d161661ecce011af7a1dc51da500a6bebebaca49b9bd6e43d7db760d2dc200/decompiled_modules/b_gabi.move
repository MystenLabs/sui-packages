module 0xcad161661ecce011af7a1dc51da500a6bebebaca49b9bd6e43d7db760d2dc200::b_gabi {
    struct B_GABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GABI>(arg0, 9, b"bGABI", b"bToken GABI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_GABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

