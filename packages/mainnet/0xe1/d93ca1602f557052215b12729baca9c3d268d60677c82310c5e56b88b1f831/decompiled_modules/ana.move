module 0xe1d93ca1602f557052215b12729baca9c3d268d60677c82310c5e56b88b1f831::ana {
    struct ANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ANA>(arg0, 599933242504490374, b"Alaknanda", b"ANA", x"f09f8dbc204261627920f09f9297", b"https://images.hop.ag/ipfs/QmYcmYBDpxSVv25gzZMPmrGEiipFQ5NiDhrmPZKusddGXr", 0x1::string::utf8(b"https://x.com/ANA_Alaknanda"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/ANA_Alaknanda"), arg1);
    }

    // decompiled from Move bytecode v6
}

