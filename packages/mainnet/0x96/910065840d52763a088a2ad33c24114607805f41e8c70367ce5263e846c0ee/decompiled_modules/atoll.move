module 0x96910065840d52763a088a2ad33c24114607805f41e8c70367ce5263e846c0ee::atoll {
    struct ATOLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATOLL>(arg0, 6, b"ATOLL", b"AMPHIBIAN ATOLL", b"the hallucinogenic amphibian riding the highs of crypto! Always deep in the degen grind, always seeing charts in psychedelic colors. Whether the market is up or down, this frog is vibing in another dimension. Hop in, trip out, and let $ATOLL take you on a wild ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig4ctczt3ifrzzreoelpopkg4erps3oy7ubzwgwy5t3hccettrygm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATOLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATOLL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

