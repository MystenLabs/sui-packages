module 0x2daad2173f11fc06ad10605ba503933e2a6e7f2b92ad4c8d9067ad9bd7ebae94::lmoo {
    struct LMOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMOO>(arg0, 6, b"LMOO", b"Let's Fucking Moo", b"Today is a great day for a new journey. How about you? Join me on this journey to conquer the world of cryptocurrencies today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibn7ossd2uuqylp7pwdhzpggzsvegu6k2gzeit4eo2enh6m26gnry")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LMOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

