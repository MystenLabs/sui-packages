module 0x12b5de304010a9e1cbe94798931497d7610999cf6ade3c546cfdeb05d1e03990::ted {
    struct TED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TED>(arg0, 6, b"TED", b"TEDDY", b"Introducing TED, the revolutionary meme coin on Solana! Spend a day with Ted and watch your perception of crypto transform. With its dynamic AMA sessions and interactive community, TED isn't just a meme coin; it's a movement. Engage with a team that genuinely values its community, where every voice matters. Say hello to a new era in cryptocurrency, where TED isn't just another coin it's a symbol of innovation and inclusivity. Join us on this journey, and let's redefine the future of finance together. Welcome to TED, where crypto meets the community in a whole new way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ted4567_96ff7c4cf1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TED>>(v1);
    }

    // decompiled from Move bytecode v6
}

