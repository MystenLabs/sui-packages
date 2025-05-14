module 0x5140aaef0ea62404f69a52676924262abb852a2f59a5647e91aa94a13856af19::asas {
    struct ASAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASAS, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<ASAS>(arg0, 272409474, b"SASA", b"asas", b"as", b"https://ipfs.io/ipfs/bafkreicr7oo5ossiyfr53zgnqgpdlywba37geazv4k3nqxayuhkzqqbgla", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

