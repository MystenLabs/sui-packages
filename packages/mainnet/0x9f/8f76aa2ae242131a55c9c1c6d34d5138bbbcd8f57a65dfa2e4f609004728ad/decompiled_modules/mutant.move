module 0x9f8f76aa2ae242131a55c9c1c6d34d5138bbbcd8f57a65dfa2e4f609004728ad::mutant {
    struct MUTANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTANT>(arg0, 6, b"MUTANT", b"Mutant blub", b"While Mutant Blub primarily serves as a meme coin, it could potentially be used for community-driven projects, merchandise, or even a future NFT collection based on the mutant fish theme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044147_c69e7a2185.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUTANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

