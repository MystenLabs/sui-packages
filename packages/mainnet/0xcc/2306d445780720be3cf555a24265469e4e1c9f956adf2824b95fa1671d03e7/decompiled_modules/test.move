module 0xcc2306d445780720be3cf555a24265469e4e1c9f956adf2824b95fa1671d03e7::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TEST>(arg0, 8713865436173946371, b"Test", b"Test", b"Test", b"https://images.hop.ag/ipfs/QmWHUntEF2Tb7HpWmzLr2uUT3RaxRaA1UAYPYnCYcJzXhA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

