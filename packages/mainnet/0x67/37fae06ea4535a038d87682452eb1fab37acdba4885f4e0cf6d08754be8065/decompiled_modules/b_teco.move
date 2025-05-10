module 0x6737fae06ea4535a038d87682452eb1fab37acdba4885f4e0cf6d08754be8065::b_teco {
    struct B_TECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TECO>(arg0, 9, b"bTECO", b"bToken TECO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

