module 0x1de9e4917b510be97109af003f17fa9906c86a4d832132497aad28350389cce9::doo {
    struct DOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DOO>(arg0, 12290362633366617398, b"SUIBY DOO", b"DOO", b"Scooby Doo on SUI", b"https://images.hop.ag/ipfs/QmV5EA7BCTxmFAoGipfsgSwiS1hMBpJxiq8yXqyHAD6feN", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

