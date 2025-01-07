module 0xba4da6416dd8c616267540e41931dfecc54547815292787c0692e7cdf344fb77::zilla {
    struct ZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZILLA>(arg0, 6, b"ZILLA", b"ROACHZILLA by SuiAI", b"Survivalist Data Scraper:.Collects and decentralizes useful data from crypto trends, dApps, or environmental sensors..Scavenger Bot:.Crawls DeFi protocols, NFT marketplaces, or GameFi ecosystems to discover and suggest hidden opportunities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0_0_3fb7f71afe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZILLA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZILLA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

