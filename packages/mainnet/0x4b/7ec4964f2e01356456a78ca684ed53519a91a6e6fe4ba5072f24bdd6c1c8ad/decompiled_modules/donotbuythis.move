module 0x4b7ec4964f2e01356456a78ca684ed53519a91a6e6fe4ba5072f24bdd6c1c8ad::donotbuythis {
    struct DONOTBUYTHIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONOTBUYTHIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONOTBUYTHIS>(arg0, 6, b"DONOTBUYTHIS", b"DontBuy", b"Dont buy if u arent a bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidu5pn6lijvpkj2zisdnnf5rhbqqoysfuf5enqvwvge7bkbspmeb4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONOTBUYTHIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONOTBUYTHIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

