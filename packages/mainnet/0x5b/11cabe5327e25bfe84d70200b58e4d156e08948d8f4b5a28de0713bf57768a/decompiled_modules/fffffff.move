module 0x5b11cabe5327e25bfe84d70200b58e4d156e08948d8f4b5a28de0713bf57768a::fffffff {
    struct FFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0xc874b6eb08bcab05aea4b00dab8451b6f16b393023d39798366de4845e2917ec::connector_v3::new<FFFFFFF>(arg0, 154310808, b"FFFFF", b"fffffff", b"ffffffffffffff", b"https://ipfs.io/ipfs/bafkreiagwynlgyutxzxlo4zds5ggs5lbgewccut2taq2plrmi3yxsebdfy", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

