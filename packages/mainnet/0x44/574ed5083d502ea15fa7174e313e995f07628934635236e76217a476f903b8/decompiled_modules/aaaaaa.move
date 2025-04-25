module 0x44574ed5083d502ea15fa7174e313e995f07628934635236e76217a476f903b8::aaaaaa {
    struct AAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<AAAAAA>(arg0, 89908846, b"AAAAAAAAAAAA", b"aaaaaa", b"aaaaaaaaaaa", b"https://ipfs.io/ipfs/bafkreiagwynlgyutxzxlo4zds5ggs5lbgewccut2taq2plrmi3yxsebdfy", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

