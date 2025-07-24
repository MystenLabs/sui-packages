module 0x6d08fad770935be060929dc257a6701baad37b9eb776f1a94712dfabcfe0c7a2::b_mdrag {
    struct B_MDRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MDRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MDRAG>(arg0, 9, b"bMDRAG", b"bToken MDRAG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MDRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MDRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

