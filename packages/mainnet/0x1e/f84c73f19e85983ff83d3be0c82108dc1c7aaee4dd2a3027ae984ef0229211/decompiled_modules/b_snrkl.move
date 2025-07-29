module 0x1ef84c73f19e85983ff83d3be0c82108dc1c7aaee4dd2a3027ae984ef0229211::b_snrkl {
    struct B_SNRKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SNRKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SNRKL>(arg0, 9, b"bSNRKL", b"bToken SNRKL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SNRKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SNRKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

