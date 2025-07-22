module 0x96ae56fdec6b96980ef47de4f26e0d3f24650ab5257ad0390efa4b951340dd87::b_cctoo {
    struct B_CCTOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CCTOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CCTOO>(arg0, 9, b"bCCTOO", b"bToken CCTOO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CCTOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CCTOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

