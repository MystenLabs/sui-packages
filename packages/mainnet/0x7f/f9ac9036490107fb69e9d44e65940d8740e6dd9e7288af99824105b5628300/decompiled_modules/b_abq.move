module 0x7ff9ac9036490107fb69e9d44e65940d8740e6dd9e7288af99824105b5628300::b_abq {
    struct B_ABQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ABQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ABQ>(arg0, 9, b"bABQ", b"bToken ABQ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ABQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ABQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

