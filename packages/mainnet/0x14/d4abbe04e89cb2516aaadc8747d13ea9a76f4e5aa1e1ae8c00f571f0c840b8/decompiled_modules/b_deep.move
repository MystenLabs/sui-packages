module 0x14d4abbe04e89cb2516aaadc8747d13ea9a76f4e5aa1e1ae8c00f571f0c840b8::b_deep {
    struct B_DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DEEP>(arg0, 9, b"bDEEP", b"bToken DEEP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

