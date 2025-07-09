module 0xa17c86d4a189d6cc4bbbe32d3785406ea5e473e1518a75947c2a8a011b96b558::b_xbtc {
    struct B_XBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_XBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_XBTC>(arg0, 9, b"bxBTC", b"bToken xBTC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_XBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_XBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

