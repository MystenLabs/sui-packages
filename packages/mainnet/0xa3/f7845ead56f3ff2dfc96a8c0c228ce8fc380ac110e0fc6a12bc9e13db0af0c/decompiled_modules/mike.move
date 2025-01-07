module 0xa3f7845ead56f3ff2dfc96a8c0c228ce8fc380ac110e0fc6a12bc9e13db0af0c::mike {
    struct MIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MIKE>(arg0, 8690904140984933129, b"Mike Wazowski", b"Mike", x"5468652063727970746f2074686174e28099732073636172696e6720757020626967206761696e732c206f6e6520726f617220617420612074696d65", b"https://images.hop.ag/ipfs/QmV1wkHRYumAWTsw85ns9S7G1kQ5fuWCjkiU8eutKqRXaz", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

