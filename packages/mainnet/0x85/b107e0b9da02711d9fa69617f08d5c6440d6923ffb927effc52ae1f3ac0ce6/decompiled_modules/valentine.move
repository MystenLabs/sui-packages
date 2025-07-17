module 0x85b107e0b9da02711d9fa69617f08d5c6440d6923ffb927effc52ae1f3ac0ce6::valentine {
    struct VALENTINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VALENTINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VALENTINE>(arg0, 6, b"Valentine", b"Valentine Grok Companion", b"Groks 3rd companion, lets make history together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihm2lbf33qd6prgujwedkzcgq4cva2ks6dv2kbrawkpu3qbhgnt7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VALENTINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VALENTINE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

