module 0x40b267706e97defcc8b818dd037af52dd36aaa3533d0c69211322f65d6ea43e6::flex {
    struct FLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLEX>(arg0, 6, b"FLEX", b"FLEXING DEGEN", x"536f6d65206772696e642c20736f6d6520687573746c652c20736f6d65206c6f736520736c656570206f766572206368617274732e205765206a7573742077696e2e0a5374726174656769632043727970746f20526573657276653f20546f6f206561737920746f20666c6578210a0a5768617420646f20776520646f3f20576520736974206261636b2c207369702061206472696e6b2c20616e64206c6574206e756d62657220676f20757021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiczb5x6rve33xhge7mc2x4cnqkqtoqo6kdqag6e5v672qv4lu5agy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

