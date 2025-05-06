module 0xbcb1158fd36e7a1c5c4eb1414f656af51601d712137602bef419f01f5dbed7e1::test5 {
    struct TEST5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST5>(arg0, 6, b"TEST5", b"TEST TOKEN 5", b"DON'T BUY THIS COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicx4uq7ytxobg2hhi7wrod5pztvf5ve3hpeniyuvft6rslucvgwde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST5>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

