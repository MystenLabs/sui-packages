module 0x4640c793cecc315c1e66d1adcc9825639f0274f4b609e02ac449273c0af85e7c::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 6, b"PAWS", b"PandaPaws", b"PandaPaws is more than a fun meme coin; it inspires its community, the \"Panda Guardians,\" to embrace environmental stewardship.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmeDe8Cy2kSsUa9zWuz3wt5pbpBrdysEWZBm2aGnHCmj2H")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PAWS>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PAWS>(15518910138546941673, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/PandaPaws_sui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

