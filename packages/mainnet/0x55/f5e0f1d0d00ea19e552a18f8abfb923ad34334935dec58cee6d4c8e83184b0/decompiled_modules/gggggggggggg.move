module 0x55f5e0f1d0d00ea19e552a18f8abfb923ad34334935dec58cee6d4c8e83184b0::gggggggggggg {
    struct GGGGGGGGGGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGGGGGGGGGGG, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<GGGGGGGGGGGG>(arg0, 6236487, b"GGG", b"gggggggggggg", b"ggg", b"https://ipfs.io/ipfs/bafybeic57e2n66q6tx4ekemblbnu26zkbquzvpnp4af4llgikb6pqn7s5i", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

