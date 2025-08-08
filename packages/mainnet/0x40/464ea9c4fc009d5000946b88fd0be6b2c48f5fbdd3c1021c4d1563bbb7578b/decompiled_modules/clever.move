module 0x40464ea9c4fc009d5000946b88fd0be6b2c48f5fbdd3c1021c4d1563bbb7578b::clever {
    struct CLEVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLEVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLEVER>(arg0, 6, b"CLEVER", b"Clever Deck", b"CleverDeck uses spaced repetition algorithms to make learning much more efficient and longer-lasting. Tell the app whether or not you remember something by swiping cards right or left. CleverDeck schedules your reviews for you, while giving you new cards each day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibiddzsqpxdh2ux7cwle3qk6en4f7d3wypbt7lzbwarazuz4565du")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLEVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLEVER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

