module 0xc2b80adca2fcc6048d487a430c57f4af245201837db73c702e81d8bd3091bd11::sib {
    struct SIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIB>(arg0, 6, b"SIB", b"Sui Is Back", b"Sui is back, the cycle resets, doubters fade and $SIB stands", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwwatfb2vnqyn5nz64qf6hovdddpeprsrofi2xscihxlamapt22a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

