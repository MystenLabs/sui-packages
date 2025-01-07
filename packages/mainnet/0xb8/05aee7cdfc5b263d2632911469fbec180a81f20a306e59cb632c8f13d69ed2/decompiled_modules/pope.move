module 0xb805aee7cdfc5b263d2632911469fbec180a81f20a306e59cb632c8f13d69ed2::pope {
    struct POPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPE>(arg0, 6, b"Pope", b"PopPepe", x"506f7063617420616e64205065706520636f6c6c69646520696e206120776869726c77696e64206f66206d656d65206d61646e6573732e2045787065637420657069632068696a696e6b732c206c6567656e64617279206c61756768732c20616e6420746865206d6f7374206368616f746963206d656d65206d61676963206576657220636f6e6365697665642e204469766520696e20696620796f75206461726521220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pope_35672546bd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

