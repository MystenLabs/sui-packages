module 0x5b96482adc42bfea2cb98a399f7521a6ee362b63dacc4501f5bb61562a1ea356::phah {
    struct PHAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHAH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PHAH>(arg0, 8931207219459554957, b"Phah", b"Phah", b"Phah", b"https://images.hop.ag/ipfs/QmSznAepkgAYfvheAsM4j9xAGBmYbGa963BB8R6vvxTJcj", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

