module 0x7b2f126152bc5c931fee0a7a2beb4feb6c75b876677447a7e97eca25cd712005::bmog {
    struct BMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOG>(arg0, 6, b"BMOG", b"BabyMOG", b"$BMOG is a next-gen meme machine: cuter, funnier, and just wild enough to make waves across the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia6klxhkqpmh7rvvargb25ah26g2ca3bcqxqbz7uij72hznymdesy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BMOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

