module 0x35a30e6da5a71460832fe11b815fbfd12c2b40f1f93557f5abb87ec13f089e13::fffff {
    struct FFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFFF>(arg0, 6, b"FFFFF", b"sdasa", b"DFSSFSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih2bpa7elpul3dld6sfkr4uc32o72cf437lbkmmt2oy6uf5p7gl2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FFFFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

