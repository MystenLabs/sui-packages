module 0xabe9df8f2d0733e44962caa672c9a1abe6d890ee23deb3292c1a45bdf957d0fd::b_ardz {
    struct B_ARDZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ARDZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ARDZ>(arg0, 9, b"bARDZ", b"bToken ARDZ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ARDZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ARDZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

