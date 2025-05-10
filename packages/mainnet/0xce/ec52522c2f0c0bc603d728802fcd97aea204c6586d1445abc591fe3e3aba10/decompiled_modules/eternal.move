module 0xceec52522c2f0c0bc603d728802fcd97aea204c6586d1445abc591fe3e3aba10::eternal {
    struct ETERNAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETERNAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETERNAL>(arg0, 6, b"ETERNAL", b"Enhanced Tokenized Engine for Recursive Neural Algorithmic Learning", b"Nobody is eternal, not even the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighxhbye2t44yeq33secdfhppakyxlhnualc52ptp454hosogvnre")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETERNAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ETERNAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

