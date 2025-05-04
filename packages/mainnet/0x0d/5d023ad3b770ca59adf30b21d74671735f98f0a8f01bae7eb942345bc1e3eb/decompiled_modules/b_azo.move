module 0xd5d023ad3b770ca59adf30b21d74671735f98f0a8f01bae7eb942345bc1e3eb::b_azo {
    struct B_AZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_AZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_AZO>(arg0, 9, b"bAZO", b"bToken AZO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_AZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_AZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

