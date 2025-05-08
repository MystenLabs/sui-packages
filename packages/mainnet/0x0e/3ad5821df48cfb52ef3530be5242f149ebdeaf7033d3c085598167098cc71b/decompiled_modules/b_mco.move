module 0xe3ad5821df48cfb52ef3530be5242f149ebdeaf7033d3c085598167098cc71b::b_mco {
    struct B_MCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MCO>(arg0, 9, b"bMCO", b"bToken MCO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

