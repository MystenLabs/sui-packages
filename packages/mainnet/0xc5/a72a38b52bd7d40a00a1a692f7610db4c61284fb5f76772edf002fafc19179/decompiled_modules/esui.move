module 0xc5a72a38b52bd7d40a00a1a692f7610db4c61284fb5f76772edf002fafc19179::esui {
    struct ESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESUI>(arg0, 6, b"ESUI", b"ETHERNAL SUI", b"Ethernal sui has coming.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidnmpg7fe5xmtq6o2iynkrf2parsj4hced3eoo5urvs73d5e7nfgm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ESUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

