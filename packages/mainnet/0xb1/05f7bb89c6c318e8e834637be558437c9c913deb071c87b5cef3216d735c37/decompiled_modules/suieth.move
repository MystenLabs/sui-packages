module 0xb105f7bb89c6c318e8e834637be558437c9c913deb071c87b5cef3216d735c37::suieth {
    struct SUIETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIETH, arg1: &mut 0x2::tx_context::TxContext) {
        0x3f76de50456b55909e8d81b72e42d138a17a742e4e1e65ea34bb23d4292edd68::connector_v3::new<SUIETH>(arg0, 697664128, b"ETHS", b"suieth", b"Just a ETH on SUI ", b"https://ipfs.io/ipfs/bafkreid26dhrj4oqunpcirvrvwg3j7ccjrttlrgkfxwriehy2owwsrljcm", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

