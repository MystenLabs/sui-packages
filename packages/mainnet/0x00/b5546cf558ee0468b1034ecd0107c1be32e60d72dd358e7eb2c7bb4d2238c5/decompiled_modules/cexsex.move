module 0xb5546cf558ee0468b1034ecd0107c1be32e60d72dd358e7eb2c7bb4d2238c5::cexsex {
    struct CEXSEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEXSEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEXSEX>(arg0, 5, b"CEXSEX", b"NoCexNoS3x", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://twitter.com/CEX4SEX/photo")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CEXSEX>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEXSEX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEXSEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

