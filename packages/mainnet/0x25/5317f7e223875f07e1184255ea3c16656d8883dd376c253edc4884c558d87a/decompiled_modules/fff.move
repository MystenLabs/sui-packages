module 0x255317f7e223875f07e1184255ea3c16656d8883dd376c253edc4884c558d87a::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x88a1a68c37327bddab2aa4117b938d52e64a0a04cf8809206bcd46217b6f3cd4::connector_v3::new<FFF>(arg0, 370152318, b"FFF", b"fff", b"ff", b"https://ipfs.io/ipfs/bafkreieivnfj3es2hogm3uciyuo6sae3w2pn3n5ykxsrtrlszdmtzv3svy", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

