module 0x1dd1650bbdcc1c7d4f8ea20971a6f8781806946632267c2174f5e3689f7d3adf::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 6, b"Flip", b"Flippi", b"Flipping is a fun, community-driven token on the Sui network with a bold goal: to flip all the top meme coins while keeping things entertaining. Focused on fun and engagement, Flipping thrives on the excitement of the meme coin world and aims to surpass other popular tokens in a playful yet ambitious way. Backed by an enthusiastic community, it blends humor and competitive spirit, making it a unique contender in the ever-evolving meme token space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038102_b1e1556231.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

