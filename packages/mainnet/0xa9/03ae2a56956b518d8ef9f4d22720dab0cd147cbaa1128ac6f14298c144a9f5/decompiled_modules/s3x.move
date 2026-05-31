module 0xa903ae2a56956b518d8ef9f4d22720dab0cd147cbaa1128ac6f14298c144a9f5::s3x {
    struct S3X has drop {
        dummy_field: bool,
    }

    fun init(arg0: S3X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S3X>(arg0, 9, b"S3X", b"SUI3X", b"3x Long SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmNbTWkR5BynUB5mqfttx3QXApjv8bNGcjMUR37wMGGqAo")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S3X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<S3X>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

