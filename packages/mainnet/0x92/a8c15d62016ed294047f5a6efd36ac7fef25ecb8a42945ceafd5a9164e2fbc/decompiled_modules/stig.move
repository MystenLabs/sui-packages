module 0x92a8c15d62016ed294047f5a6efd36ac7fef25ecb8a42945ceafd5a9164e2fbc::stig {
    struct STIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STIG>(arg0, 6, b"STIG", b"SUI Tiger", b"The Sui Tiger is ready to attack...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiawdvh4m27ehwuu4bq4gfvojd5i4rag7hkwquxvc2r52ctghennzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

