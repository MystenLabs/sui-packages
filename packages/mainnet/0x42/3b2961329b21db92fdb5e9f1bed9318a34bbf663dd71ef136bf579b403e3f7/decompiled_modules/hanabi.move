module 0x423b2961329b21db92fdb5e9f1bed9318a34bbf663dd71ef136bf579b403e3f7::hanabi {
    struct HANABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANABI>(arg0, 9, b"Hanabi", b"Hanabi-chan", b"Hanabi-chan adopted by the iconic Kabosu Mama and sibling of Doge, is here to make waves in the world of meme coins. A true legend in the making, this unstoppable force has now arrived on the Ethereum blockchain, ready to carve its own place in crypto history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x67e610a7b7e7ab766e06301c676f84590e5256a7.png?size=lg&key=f45166")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HANABI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANABI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

