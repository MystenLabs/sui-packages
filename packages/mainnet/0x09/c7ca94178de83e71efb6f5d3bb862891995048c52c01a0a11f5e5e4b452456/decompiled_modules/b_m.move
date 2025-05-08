module 0x9c7ca94178de83e71efb6f5d3bb862891995048c52c01a0a11f5e5e4b452456::b_m {
    struct B_M has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_M>(arg0, 9, b"bM", b"bToken M", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_M>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_M>>(v1);
    }

    // decompiled from Move bytecode v6
}

