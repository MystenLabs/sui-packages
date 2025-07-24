module 0xe3ea37aeec6f48f45c2295a355d9bcef52264ef5d0388e068e1d6c6334b3910::b_atoo {
    struct B_ATOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ATOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ATOO>(arg0, 9, b"bATOO", b"bToken ATOO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ATOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ATOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

