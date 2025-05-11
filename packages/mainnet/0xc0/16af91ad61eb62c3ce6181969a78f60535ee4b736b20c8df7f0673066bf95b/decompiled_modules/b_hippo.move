module 0xc016af91ad61eb62c3ce6181969a78f60535ee4b736b20c8df7f0673066bf95b::b_hippo {
    struct B_HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HIPPO>(arg0, 9, b"bHIPPO", b"bToken HIPPO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

