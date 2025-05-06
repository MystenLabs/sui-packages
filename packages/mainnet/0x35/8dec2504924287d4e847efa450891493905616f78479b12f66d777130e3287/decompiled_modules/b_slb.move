module 0x358dec2504924287d4e847efa450891493905616f78479b12f66d777130e3287::b_slb {
    struct B_SLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SLB>(arg0, 9, b"bSLB", b"bToken SLB", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

