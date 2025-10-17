module 0x95a1e686e4c1f20fa2172b2bf3c500faf468fa18ea9709df5f7622fef9304dd5::ttr {
    struct TTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTR>(arg0, 6, b"TTR", b"Test1111", b"test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigmxzxtpahvoc45chbre3rq46xpni5zscueewlsydr2cbkfeovy5i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

