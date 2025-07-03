module 0x76626659ebcb7c12c5e34a44bcf714f5625cb420a20856b5c0b26e6f8b574a67::ryuk {
    struct RYUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYUK>(arg0, 6, b"Ryuk", b"Ryukk", b"RYUK is a cursed memecoin no roadmap, no promises, just chaos. Inspired by the Shinigami Ryuk. its a dark game of fate, apples, and pure degen energy. You picked it up  now he is watching", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif3lh7pjy6gwsuuszrsw4aq4tahhjmflcl3khoredjbpq46osfwde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RYUK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

