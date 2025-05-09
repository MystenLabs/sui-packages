module 0x941e5e0c44d8ee486ce5acc9ffa88c5c78b09d422ce59ed6b40c75aeff6fabf3::aaaaaaaaaaaaaa {
    struct AAAAAAAAAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        0xc874b6eb08bcab05aea4b00dab8451b6f16b393023d39798366de4845e2917ec::connector_v3::new<AAAAAAAAAAAAAA>(arg0, 826681243, b"AA", b"aaaaaaaaaaaaaa", b"aaa", b"https://ipfs.io/ipfs/bafybeiewjapai7zuczxslwlbogsecxconbboyka6rv4wvbiwd3sa2op63u", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

