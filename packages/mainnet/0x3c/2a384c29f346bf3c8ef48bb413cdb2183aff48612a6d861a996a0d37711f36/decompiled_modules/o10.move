module 0x3c2a384c29f346bf3c8ef48bb413cdb2183aff48612a6d861a996a0d37711f36::o10 {
    struct O10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: O10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<O10>(arg0, 6, b"O10", b"Only10$", b"This is a live experiment. No team. No hype. No liquidity (except $10). Watch what happens when people FOMO into honesty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiapgbikt5julqijgr33tptn3vzm3jus2zjagfqyrjg6id7icoo65q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<O10>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<O10>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

