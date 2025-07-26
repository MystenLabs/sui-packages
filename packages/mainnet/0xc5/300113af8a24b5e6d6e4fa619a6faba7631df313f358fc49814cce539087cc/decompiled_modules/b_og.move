module 0xc5300113af8a24b5e6d6e4fa619a6faba7631df313f358fc49814cce539087cc::b_og {
    struct B_OG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OG>(arg0, 9, b"bOG", b"bToken OG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OG>>(v1);
    }

    // decompiled from Move bytecode v6
}

