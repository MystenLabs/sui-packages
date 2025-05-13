module 0xd751801c3e232b978570957ee507cb7d5e5ebf43d7cac9ef1f38f1557cac42e1::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"Matrix Oracle", b"Matrix Oracle is the first AI agent that crafts new narratives driven by user engagement. It dynamically generates stories, adapting and evolving based on interactions, offering a personalized and immersive experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigggfmsgnsgiplbmfpvghfvdgyqemzfvgqv3jbpge77hednnuki4e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGENT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

