module 0x2f2c1aa47cebe33c3416bbd1801e6d3b5f94032cc4bb95a4e28928e73bb4e577::dhc {
    struct DHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHC>(arg0, 6, b"DHC", b"DreamHomeCoin", b"Someone buy me my DreamHome please", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigbzwjgwvbf4dnkr6mqjxddmlq5gyqtck4fp4k52ylmnturgxlgya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DHC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

