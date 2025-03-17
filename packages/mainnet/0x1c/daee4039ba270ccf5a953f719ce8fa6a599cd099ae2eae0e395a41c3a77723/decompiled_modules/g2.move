module 0x1cdaee4039ba270ccf5a953f719ce8fa6a599cd099ae2eae0e395a41c3a77723::g2 {
    struct G2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: G2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742205588863.jpeg"));
        let (v1, v2) = 0x2::coin::create_currency<G2>(arg0, 6, b"g2", b"g2", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<G2>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<G2>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<G2>>(arg0);
    }

    // decompiled from Move bytecode v6
}

