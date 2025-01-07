module 0x448e23db0a8b6e7af02b8d330e8eca21ed3492d049c69b053b0f91feaa933443::morph {
    struct MORPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORPH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MORPH>(arg0, 16404631187728476855, b"Morph from treasure planet!!", b"Morph", b"Morph is the trusted sidekick and pet of John Silver. Morph is known for being quite mischievous and has caused trouble in the past. He displays a liking to Jim Hawkins,", b"https://images.hop.ag/ipfs/QmU6VSRxLEaUpBf3s8zEkqnhWkx6W1gCXWTddjbuKZEx9x", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://disney.fandom.com/wiki/Morph"), 0x1::string::utf8(b"https://t.me/morph234"), arg1);
    }

    // decompiled from Move bytecode v6
}

