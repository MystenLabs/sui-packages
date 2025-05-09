module 0xe0e65b9a4b94f29f7b47e317ed4235da503d9d568bc8010503ea450d800ea472::aaaaaaaaaa {
    struct AAAAAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        0xc874b6eb08bcab05aea4b00dab8451b6f16b393023d39798366de4845e2917ec::connector_v3::new<AAAAAAAAAA>(arg0, 26026420, b"AAA", b"aaaaaaaaaa", b"aa", b"https://ipfs.io/ipfs/bafkreiagwynlgyutxzxlo4zds5ggs5lbgewccut2taq2plrmi3yxsebdfy", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

