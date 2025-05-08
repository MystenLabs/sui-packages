module 0x3c97b2b3ee2a32057b8e8adcf00d65e4428b46e8c1dff7a4af44ce8890e43efe::bsquirtle {
    struct BSQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSQUIRTLE>(arg0, 6, b"BSQUIRTLE", b"BABY SQUIRTLE", b"Baby  launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid246dzwd3ltczu7q3fznzecsl4xz67xma77ngnqsfse27eghhzdi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSQUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BSQUIRTLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

