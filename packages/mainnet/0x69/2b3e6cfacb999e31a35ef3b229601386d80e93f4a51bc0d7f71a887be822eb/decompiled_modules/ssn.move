module 0x692b3e6cfacb999e31a35ef3b229601386d80e93f4a51bc0d7f71a887be822eb::ssn {
    struct SSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SSN>(arg0, 3795134731860331318, b"SUISON", b"SSN", b"SUISON is a visionary cryptocurrency designed to capture the dynamic and cyclical nature of the seasons, offering innovative features that align with growth, stability, and change. The coin embodies the philosophy that just as seasons change, so do opportunities in the financial and blockchain ecosystem.", b"https://images.hop.ag/ipfs/QmNtJyANp4JQ4utG1KX1FjRCzuFDCrT2JtDYMAc4DegBKD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

