module 0x152b4b929dccd265a26699c9c6e5c08c8e04969a9cc843f58166d62300e1dc4b::b_pegz {
    struct B_PEGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PEGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PEGZ>(arg0, 9, b"bPEGZ", b"bToken PEGZ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PEGZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PEGZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

