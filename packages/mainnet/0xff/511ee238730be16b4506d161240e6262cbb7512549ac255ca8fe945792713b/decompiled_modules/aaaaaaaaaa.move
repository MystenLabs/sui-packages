module 0xff511ee238730be16b4506d161240e6262cbb7512549ac255ca8fe945792713b::aaaaaaaaaa {
    struct AAAAAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        0xc874b6eb08bcab05aea4b00dab8451b6f16b393023d39798366de4845e2917ec::connector_v3::new<AAAAAAAAAA>(arg0, 15632883, b"AA", b"aaaaaaaaaa", b"aaaaaaaaaaa", b"https://ipfs.io/ipfs/bafybeiewjapai7zuczxslwlbogsecxconbboyka6rv4wvbiwd3sa2op63u", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

