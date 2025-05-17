module 0x6b4ff2406285098b00d345ffb2aaaa48cbae2091ef1846709a7bee0d17cf1e4::sssss {
    struct SSSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSSS, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<SSSSS>(arg0, 971547824, b"SSSSS", b"sssss", b"sssssssssssss", b"https://ipfs.io/ipfs/bafybeiemag6ejlkqwbcsyullprfomtiiw543gvh27sazw442fjo7iishbq", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

