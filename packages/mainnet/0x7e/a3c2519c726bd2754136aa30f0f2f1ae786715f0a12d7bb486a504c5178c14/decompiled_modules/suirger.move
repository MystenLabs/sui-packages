module 0x7ea3c2519c726bd2754136aa30f0f2f1ae786715f0a12d7bb486a504c5178c14::suirger {
    struct SUIRGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRGER, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIRGER>(arg0, 10810569845139870254, b"SUIRGER", b"SUIRGER", b"SUIRGER", b"https://images.hop.ag/ipfs/QmQpVaRAwsaM7cz4qHHcigVssrbmRF797EsG4bmEcRotpT", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

