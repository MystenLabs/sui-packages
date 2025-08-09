module 0x813e20b10bff05aa86b13f3a8c6c7b2759ef725a08fe96a74c26eea44da6153d::b_imyu {
    struct B_IMYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_IMYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_IMYU>(arg0, 9, b"bIMYU", b"bToken IMYU", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_IMYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_IMYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

