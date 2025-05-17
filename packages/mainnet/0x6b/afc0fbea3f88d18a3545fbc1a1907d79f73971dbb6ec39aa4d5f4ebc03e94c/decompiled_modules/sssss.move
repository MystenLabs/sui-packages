module 0x6bafc0fbea3f88d18a3545fbc1a1907d79f73971dbb6ec39aa4d5f4ebc03e94c::sssss {
    struct SSSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSSS, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<SSSSS>(arg0, 841877415, b"SSSSS", b"sssss", b"sssssssssssss", b"https://ipfs.io/ipfs/bafybeiemag6ejlkqwbcsyullprfomtiiw543gvh27sazw442fjo7iishbq", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

