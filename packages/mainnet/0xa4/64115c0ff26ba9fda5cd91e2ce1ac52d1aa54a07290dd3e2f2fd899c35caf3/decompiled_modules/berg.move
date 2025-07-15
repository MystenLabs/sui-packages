module 0xa464115c0ff26ba9fda5cd91e2ce1ac52d1aa54a07290dd3e2f2fd899c35caf3::berg {
    struct BERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERG>(arg0, 6, b"BERG", b"Zoidberg", b"BERG is a degenerate-squid memecoin with more backstory than your ex's excuses. Born in a Sui ocean, Swimming  by the chaos, and raised on Sui meme culture, BERG is here to stretch your bags and your imagination.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicaepoalh3rxvsbpofyws75keijbq7pcxvps6t2ito3msr24kgj2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BERG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

