module 0xa759452030d12bf815956a09a7739d004079a8bb1b469ca1e466183c5cee68a9::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TEST>(arg0, 12123009364411872447, b"TEST", b"TEST", b"TEST", b"https://images.hop.ag/ipfs/QmU75GDZU4492jjqGkLcCW8nJATKEDZRhrQUkmi1Jnx64P", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

