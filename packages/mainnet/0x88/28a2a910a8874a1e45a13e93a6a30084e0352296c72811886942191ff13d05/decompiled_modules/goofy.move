module 0x8828a2a910a8874a1e45a13e93a6a30084e0352296c72811886942191ff13d05::goofy {
    struct GOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOFY>(arg0, 6, b"GOOFY", b"Captain GOOFY", b"Captain Goofy ($GOOF) is a community-driven memecoin that brings humor, creativity, and inclusivity to the world of cryptocurrency. With its playful nautical theme, Captain Goofy invites adventurers and crypto enthusiasts to sail into the uncharted waters of Web3. Designed to engage a broad audience, $GOOF encourages active community participation through competitions, giveaways, and collaborations. Its not just a token; its a movement celebrating fun, unity, and the boundless potential of blockchain technology. Join Captain Goofys crew and set sail for a world where crypto meets creativity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_3_908b3e56b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

