module 0x38fbef61993cbb23e3b9b82921ca5fa4a1832cc4ef922849cdd188f8406bad5b::ssnail {
    struct SSNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SSNAIL>(arg0, 13661786399369204722, b"SuiSnail", b"SSnail", x"536c6f7720616e642073746561647920537569536e61696c2077696c6c2077696e7320746865206d656d65636f696e732072616365202120f09f908c20f09f8f81", b"https://images.hop.ag/ipfs/QmWHrKbqWwjM4AVtNXULwLMuqA2hEoWurZ2UANzuvEL6TA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

