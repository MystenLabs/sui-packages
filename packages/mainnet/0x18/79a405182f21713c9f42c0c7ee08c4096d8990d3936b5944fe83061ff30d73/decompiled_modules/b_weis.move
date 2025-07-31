module 0x1879a405182f21713c9f42c0c7ee08c4096d8990d3936b5944fe83061ff30d73::b_weis {
    struct B_WEIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WEIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WEIS>(arg0, 9, b"bWEIS", b"bToken WEIS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WEIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WEIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

