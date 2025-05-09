module 0xb707cc02354d285f3f11ab97e5a71d5767549c32e691bfdd10464c5ca21a05ce::b_mmm {
    struct B_MMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MMM>(arg0, 9, b"bMMM", b"bToken MMM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

