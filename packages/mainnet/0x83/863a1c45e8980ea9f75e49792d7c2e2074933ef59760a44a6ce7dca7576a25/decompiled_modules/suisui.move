module 0x83863a1c45e8980ea9f75e49792d7c2e2074933ef59760a44a6ce7dca7576a25::suisui {
    struct SUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<SUISUI>(arg0, 937873230, b"SUISUI", b"suisui", b"sui sui sui", b"https://ipfs.io/ipfs/bafkreidbqmdn66jz4u5y3hysa3g3zofwvzioswhbktjun4ovxxbndfsu6a", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

