module 0xb7baac45a79e5c83cc9cf1ec1c059784cb5eb544f9252d202135bd3703c5985a::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TEST>(arg0, 3100484947499019261, b"testing", b"test", b"testing 123", b"https://images.hop.ag/ipfs/QmT5Hnwe2NPMjrdEAiL3auRwkdaRDJsspcUq8PpwhtRxm8", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

