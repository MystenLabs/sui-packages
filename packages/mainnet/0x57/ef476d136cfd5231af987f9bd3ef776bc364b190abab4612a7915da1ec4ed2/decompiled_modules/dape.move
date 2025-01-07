module 0x57ef476d136cfd5231af987f9bd3ef776bc364b190abab4612a7915da1ec4ed2::dape {
    struct DAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DAPE>(arg0, 7007351750209732492, b"DuckTape", b"DAPE", x"44415045e28093204e6f206d617474657220686f7720626164206c6966652069732c20796f75206d7573742062652068617070792120f09fa686f09f92ab", b"https://images.hop.ag/ipfs/QmQ5j7iDZ3RRNvL77BsJtMyUtS3kDBDgsX9444YPWgg6Gc", 0x1::string::utf8(b"https://x.com/DuckTape_ONSOL"), 0x1::string::utf8(b"https://ducktapememe.vip/"), 0x1::string::utf8(b"https://t.me/DuckTape_Portal"), arg1);
    }

    // decompiled from Move bytecode v6
}

