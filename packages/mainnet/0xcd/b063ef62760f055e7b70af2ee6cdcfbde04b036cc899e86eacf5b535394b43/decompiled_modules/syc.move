module 0xcdb063ef62760f055e7b70af2ee6cdcfbde04b036cc899e86eacf5b535394b43::syc {
    struct SYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SYC>(arg0, 17047388236805448840, b"Sui Yacht Club", b"SYC", b"Welcome to Sui Yacht Club, the coolest token on the Sui network! Inspired by Bored Ape's iconic relaxed vibe, Sui Yacht Club is not just a token, but an invitation to a unique journey of luxury, fun, and exclusivity across the digital seas.", b"https://images.hop.ag/ipfs/QmbZVZX1LoLKqYJiKmbTLbPPT5qaoAsCMUR7kkRcamroE2", 0x1::string::utf8(b"https://x.com/SuiYachtClub"), 0x1::string::utf8(b"https://www.suiyachtclub.nl/"), 0x1::string::utf8(b"https://t.me/SuiYachtClub"), arg1);
    }

    // decompiled from Move bytecode v6
}

