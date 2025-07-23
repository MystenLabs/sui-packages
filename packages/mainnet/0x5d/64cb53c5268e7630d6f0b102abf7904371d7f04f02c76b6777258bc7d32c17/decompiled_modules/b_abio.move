module 0x5d64cb53c5268e7630d6f0b102abf7904371d7f04f02c76b6777258bc7d32c17::b_abio {
    struct B_ABIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ABIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ABIO>(arg0, 9, b"bABIO", b"bToken ABIO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ABIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ABIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

