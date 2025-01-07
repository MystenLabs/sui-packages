module 0xaf5af6e7ce4fe0d17201b6387458bcfca4b32510b3ad898e5354e5d42edaeef4::suisie {
    struct SUISIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISIE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<SUISIE>(arg0, 4385235537804786459, b"SuiSie Wiles", b"Suisie", b"SuiSie Wiles is Greate", b"https://images.hop.ag/ipfs/QmfHLQGwumVQH5iGbWtM8ed1wUHh8P1fmYakiXpkpFNaAo", 0x1::string::utf8(b"https://x.com/elonmusk/status/1854789727330955711"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

