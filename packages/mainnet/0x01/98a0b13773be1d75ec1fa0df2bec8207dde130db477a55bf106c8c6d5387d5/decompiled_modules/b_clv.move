module 0x198a0b13773be1d75ec1fa0df2bec8207dde130db477a55bf106c8c6d5387d5::b_clv {
    struct B_CLV has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CLV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CLV>(arg0, 9, b"bCLV", b"bToken CLV", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CLV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CLV>>(v1);
    }

    // decompiled from Move bytecode v6
}

