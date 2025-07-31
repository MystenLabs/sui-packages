module 0x31c1a9e12624e9a8b470ebc81de41476b98d0fb1ec838ddcba046dc72e95f6cc::company {
    struct COMPANY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMPANY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMPANY>(arg0, 6, b"COMPANY", b"Invest in this Company", b"This is a long term project called company.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibjkalediqhmxemulywgd62aql6rcumuijqlp5msg4vm54ujp2umm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMPANY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COMPANY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

