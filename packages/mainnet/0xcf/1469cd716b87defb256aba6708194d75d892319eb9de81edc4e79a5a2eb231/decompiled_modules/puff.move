module 0xcf1469cd716b87defb256aba6708194d75d892319eb9de81edc4e79a5a2eb231::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PUFF>(arg0, 15948365674614176665, b"puff", b"PUFF", b"puff cat on sui", b"https://images.hop.ag/ipfs/QmRX1bLtrFLHfP9ZUh84bfpZeLxYG9sMCteuJ5thnb3wpx", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/puffsuiportal"), arg1);
    }

    // decompiled from Move bytecode v6
}

