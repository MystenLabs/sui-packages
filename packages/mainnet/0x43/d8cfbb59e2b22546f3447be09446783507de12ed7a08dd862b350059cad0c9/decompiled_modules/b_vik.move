module 0x43d8cfbb59e2b22546f3447be09446783507de12ed7a08dd862b350059cad0c9::b_vik {
    struct B_VIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_VIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_VIK>(arg0, 9, b"bVIK", b"bToken VIK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_VIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_VIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

