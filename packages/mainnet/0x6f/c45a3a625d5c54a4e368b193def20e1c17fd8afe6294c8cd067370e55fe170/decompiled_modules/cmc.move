module 0x6fc45a3a625d5c54a4e368b193def20e1c17fd8afe6294c8cd067370e55fe170::cmc {
    struct CMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CMC>(arg0, 5346072276312437707, b"Comediancoin", b"cmc", x"436f6d656469616e436f696e2028434d43292072656d696e647320796f752074686174206576656e2074686520e2809c726f7474656ee2809d20696e766573746d656e7473206d6967687420686f6c642070726963656c6573732076616c7565e280a6206f72206e6f742e", b"https://images.hop.ag/ipfs/QmXENoHZqfJML78vYQoamQQXoFHdcQVizw3pJPwAHBnkPD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://comediancoin.net/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

