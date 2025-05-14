module 0xfe98df07b0a4ba45fc1978c86881d0fda4d22671efcf1be8075bdb00848c0e0c::sdfsdf {
    struct SDFSDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSDF, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<SDFSDF>(arg0, 371869459, b"SDFSDF", b"sdfsdf", b"ssfsdf", b"https://ipfs.io/ipfs/bafybeiemag6ejlkqwbcsyullprfomtiiw543gvh27sazw442fjo7iishbq", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

