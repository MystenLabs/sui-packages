module 0x57af959ffd69a6e6f8ce250a8bd58a1a4100f479e952b76d1d3cf2739316d2e6::b_mor {
    struct B_MOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MOR>(arg0, 9, b"bMOR", b"bToken MOR", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

