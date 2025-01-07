module 0x874920d9f5c073b8fe88c246e4e45f3db7a737b1e099160adf0faeb511f56974::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TEST>(arg0, 18172574899959127107, b"test", b"test", b"test", b"https://images.hop.ag/ipfs/QmWHUntEF2Tb7HpWmzLr2uUT3RaxRaA1UAYPYnCYcJzXhA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

