module 0x650f132c931617e78692bd27b8a2f34e5a042d735c3a31824b96b2ff0fe9a958::ghst {
    struct GHST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHST>(arg0, 6, b"GHST", b"SuiMascot", b"SUI Mascot is a fun and community-driven meme token inspired by the playful spirit of Phantom and the innovative power of the SUI blockchain. Represented by a cheerful little ghost, SUI Mascot aims to unite SUI enthusiasts and meme lovers in a lighthearted yet ambitious journey through the decentralized world. Whether you're here for the laughs or the long-term, SUI Mascot is your spooky guide to the future of Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pfp_6882d51105.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHST>>(v1);
    }

    // decompiled from Move bytecode v6
}

