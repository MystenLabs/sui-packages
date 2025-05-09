module 0xb9ff7b9851d6342ff6f3e3bdaa18cde040c90929104f06bf4f38822333c7bdf5::aaaaaaaaaa {
    struct AAAAAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        0xc874b6eb08bcab05aea4b00dab8451b6f16b393023d39798366de4845e2917ec::connector_v3::new<AAAAAAAAAA>(arg0, 554971946, b"QA", b"aaaaaaaaaa", b"aaa", b"https://ipfs.io/ipfs/bafkreiagwynlgyutxzxlo4zds5ggs5lbgewccut2taq2plrmi3yxsebdfy", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

