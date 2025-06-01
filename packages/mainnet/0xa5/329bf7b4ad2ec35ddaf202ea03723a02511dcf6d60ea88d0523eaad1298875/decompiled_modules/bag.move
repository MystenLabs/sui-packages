module 0xa5329bf7b4ad2ec35ddaf202ea03723a02511dcf6d60ea88d0523eaad1298875::bag {
    struct BAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAG>(arg0, 6, b"BAG", b"CAT WIF BAG", b"CATWIFBAG  the SUI cat, while other blockchains have their own WIF, we redefine with the SUI identity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaw57allaxvdtdkwt74ovxxjm2v7lvlveork3ctpwnnz3tbkz7t4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

