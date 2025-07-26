module 0x6f2b0de80de9434a0eb1a5e6b429606e3b7e363351d52ad6d3edab8a562da0a9::b_bella {
    struct B_BELLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BELLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BELLA>(arg0, 9, b"bBELLA", b"bToken BELLA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BELLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BELLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

