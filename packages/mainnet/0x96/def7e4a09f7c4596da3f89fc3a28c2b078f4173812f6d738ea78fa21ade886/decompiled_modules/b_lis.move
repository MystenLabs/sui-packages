module 0x96def7e4a09f7c4596da3f89fc3a28c2b078f4173812f6d738ea78fa21ade886::b_lis {
    struct B_LIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LIS>(arg0, 9, b"bLIS", b"bToken LIS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

