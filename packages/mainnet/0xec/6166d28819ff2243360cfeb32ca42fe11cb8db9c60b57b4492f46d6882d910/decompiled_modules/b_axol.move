module 0xec6166d28819ff2243360cfeb32ca42fe11cb8db9c60b57b4492f46d6882d910::b_axol {
    struct B_AXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_AXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_AXOL>(arg0, 9, b"bAXOL", b"bToken AXOL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_AXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_AXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

