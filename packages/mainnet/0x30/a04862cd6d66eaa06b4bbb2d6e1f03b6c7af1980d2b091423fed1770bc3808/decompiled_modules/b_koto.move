module 0x30a04862cd6d66eaa06b4bbb2d6e1f03b6c7af1980d2b091423fed1770bc3808::b_koto {
    struct B_KOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KOTO>(arg0, 9, b"bKOTO", b"bToken KOTO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

