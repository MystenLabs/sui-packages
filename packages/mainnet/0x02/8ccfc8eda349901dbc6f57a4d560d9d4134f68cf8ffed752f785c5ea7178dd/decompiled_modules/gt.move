module 0x28ccfc8eda349901dbc6f57a4d560d9d4134f68cf8ffed752f785c5ea7178dd::gt {
    struct GT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GT, arg1: &mut 0x2::tx_context::TxContext) {
        0x88a1a68c37327bddab2aa4117b938d52e64a0a04cf8809206bcd46217b6f3cd4::connector_v3::new<GT>(arg0, 72712479, b"GBG", b"gt", b"gg", b"https://ipfs.io/ipfs/bafybeibuipqdy2fd5oueo7b57c6linmj3m7iidbks5ge3kqh7fyrvlokf4", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

