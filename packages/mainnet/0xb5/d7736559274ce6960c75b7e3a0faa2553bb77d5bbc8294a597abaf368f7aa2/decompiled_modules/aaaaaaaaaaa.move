module 0xb5d7736559274ce6960c75b7e3a0faa2553bb77d5bbc8294a597abaf368f7aa2::aaaaaaaaaaa {
    struct AAAAAAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        0xc874b6eb08bcab05aea4b00dab8451b6f16b393023d39798366de4845e2917ec::connector_v3::new<AAAAAAAAAAA>(arg0, 887548509, b"AAAAAA", b"aaaaaaaaaaa", b"aaa", b"https://ipfs.io/ipfs/bafybeiavq7qhdesd6vrp77exoyg35k635qla6fke4jsakcihnrnpb5ghqy", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

