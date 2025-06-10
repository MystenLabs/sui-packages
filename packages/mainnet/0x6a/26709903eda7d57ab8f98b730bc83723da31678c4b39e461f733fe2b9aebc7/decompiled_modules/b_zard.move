module 0x6a26709903eda7d57ab8f98b730bc83723da31678c4b39e461f733fe2b9aebc7::b_zard {
    struct B_ZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZARD>(arg0, 9, b"bZARD", b"bToken ZARD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

