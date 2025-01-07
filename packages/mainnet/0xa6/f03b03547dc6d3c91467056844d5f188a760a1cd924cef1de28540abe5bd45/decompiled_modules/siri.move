module 0xa6f03b03547dc6d3c91467056844d5f188a760a1cd924cef1de28540abe5bd45::siri {
    struct SIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIRI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SIRI>(arg0, 11717922221719038698, b"Siri", b"SIRI", b"Don't ask me, I'm just a cat", b"https://images.hop.ag/ipfs/QmWWKrZG8ax2ag9RKZY4Zt3W3ds8oZZGVqRa8aqxKyhVAR", 0x1::string::utf8(b"https://x.com/sirionsui"), 0x1::string::utf8(b"https://sirisui.xyz/"), 0x1::string::utf8(b"https://t.me/sirisuiportal/"), arg1);
    }

    // decompiled from Move bytecode v6
}

