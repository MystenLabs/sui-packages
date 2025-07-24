module 0x52ea5415c5a879b595546d1e445abaffb4cf551547da073f067241644e417c12::litch {
    struct LITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITCH>(arg0, 6, b"LITCH", b"Litch Sui Drsgon", b"The blue dragon, which has DNA at its base, was born to bring peace to a chaotic and arbitrary dynasty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia3oh6lcusfvqvwcxw4ps6n7zncrpwa7dggkphqnhqh5crq2xq7ly")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LITCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

