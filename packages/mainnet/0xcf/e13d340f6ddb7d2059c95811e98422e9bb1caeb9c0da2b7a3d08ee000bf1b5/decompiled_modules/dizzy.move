module 0xcfe13d340f6ddb7d2059c95811e98422e9bb1caeb9c0da2b7a3d08ee000bf1b5::dizzy {
    struct DIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIZZY>(arg0, 6, b"DIZZY", b"DIZZY ON SUI", b"DIZZY is more than a token; he's a symbol of resilience and innovation on the Sui blockchain. Empowering DeFi and NFTs, DIZZY brings unmatched utility to a fast-growing ecosystem. Dive into a world of possibilities as DIZZY paves the way for an exciting decentralized future!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004750_6e3c3b3e55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

