module 0x84536f1de5563fd473ecf65e226172b7b0f4aca368e0c0c36cad09435fe36b3d::testete {
    struct TESTETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTETE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TESTETE>(arg0, 4219099447151429237, b"TESTETE", b"TESTETE", b"TESTETE", b"https://images.hop.ag/ipfs/QmSi2b7NNys1kfAvK6LFCVpHVQuL2Vi4yimcGCnEefg2yi", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

