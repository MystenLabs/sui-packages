module 0x6e1f2b350dfbdf8b92ab7dc532388d247e7dfb3c33d315713f8cbefb2729753e::b_balanced_dollar {
    struct B_BALANCED_DOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BALANCED_DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BALANCED_DOLLAR>(arg0, 9, b"bbnUSD", b"bToken bnUSD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BALANCED_DOLLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BALANCED_DOLLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

