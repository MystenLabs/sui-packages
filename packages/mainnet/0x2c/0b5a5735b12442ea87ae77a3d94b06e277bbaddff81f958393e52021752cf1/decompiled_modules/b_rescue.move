module 0x2c0b5a5735b12442ea87ae77a3d94b06e277bbaddff81f958393e52021752cf1::b_rescue {
    struct B_RESCUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_RESCUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_RESCUE>(arg0, 9, b"bRESCUE", b"bToken RESCUE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_RESCUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_RESCUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

