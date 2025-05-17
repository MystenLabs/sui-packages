module 0x65e48d3f0f1f76ccc9ec67a71c511990cd90e3cf79cee4116be422d5c65142e5::dhc {
    struct DHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHC>(arg0, 6, b"DHC", b"DreamHomeCoin", b"someone buy me a home please", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigbzwjgwvbf4dnkr6mqjxddmlq5gyqtck4fp4k52ylmnturgxlgya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DHC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

