module 0x4b7e080c257d64fc83f19fcfaf17f220fd168c6b1de320df539fb141e6e51e72::bsquirtle {
    struct BSQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSQUIRTLE>(arg0, 6, b"BSQUIRTLE", b"BABY SQUIRTLE", b"Already launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid246dzwd3ltczu7q3fznzecsl4xz67xma77ngnqsfse27eghhzdi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSQUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BSQUIRTLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

