module 0xe452e0679ff39d1fcf9f50584722cb0ac525216075b5c289f2bf9c37f49509d3::b_capy {
    struct B_CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CAPY>(arg0, 9, b"bCAPY", b"bToken CAPY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

