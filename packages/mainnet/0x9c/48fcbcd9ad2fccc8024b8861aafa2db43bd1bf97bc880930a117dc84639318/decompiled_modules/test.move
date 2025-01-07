module 0x9c48fcbcd9ad2fccc8024b8861aafa2db43bd1bf97bc880930a117dc84639318::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TEST>(arg0, 4559428229799902614, b"TEST", b"TEST", b"test", b"https://images.hop.ag/ipfs/QmU75GDZU4492jjqGkLcCW8nJATKEDZRhrQUkmi1Jnx64P", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

