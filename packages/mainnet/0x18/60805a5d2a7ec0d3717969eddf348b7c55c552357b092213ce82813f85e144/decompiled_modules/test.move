module 0x1860805a5d2a7ec0d3717969eddf348b7c55c552357b092213ce82813f85e144::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TEST>(arg0, 10427056393050470797, b"test", b"test", b"test", b"https://images.hop.ag/ipfs/QmfUXErcnyC1tsXTMEmYzeXZR6RywxuZBBJw5dLwKdWVt5", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

