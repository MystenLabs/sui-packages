module 0x2dff8424c0aba01cbe626013d498986637fc2cf748968de42f9d21fdbf611337::b_robo {
    struct B_ROBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ROBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ROBO>(arg0, 9, b"bROBO", b"bToken ROBO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ROBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ROBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

