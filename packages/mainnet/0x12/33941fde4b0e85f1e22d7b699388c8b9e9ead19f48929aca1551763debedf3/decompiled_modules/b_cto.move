module 0x1233941fde4b0e85f1e22d7b699388c8b9e9ead19f48929aca1551763debedf3::b_cto {
    struct B_CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CTO>(arg0, 9, b"bCTO", b"bToken CTO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

