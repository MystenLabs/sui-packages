module 0xd9583ae19aa14c5e7b916caad41c9b429c48444d747e0129aede49f9485d3b65::b_oshi_sui {
    struct B_OSHI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OSHI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OSHI_SUI>(arg0, 9, b"boshiSUI", b"bToken oshiSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OSHI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OSHI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

