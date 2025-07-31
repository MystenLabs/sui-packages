module 0x8fb9dc88853cc9ba3010f69b91aebb0fab957bb061bc5fba52610f12a2455bb0::s3nd {
    struct S3ND has drop {
        dummy_field: bool,
    }

    fun init(arg0: S3ND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S3ND>(arg0, 9, b"S3ND", b"s3nd", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<S3ND>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S3ND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

