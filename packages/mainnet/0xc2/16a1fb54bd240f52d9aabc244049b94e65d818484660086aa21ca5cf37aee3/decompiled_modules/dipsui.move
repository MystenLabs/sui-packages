module 0xc216a1fb54bd240f52d9aabc244049b94e65d818484660086aa21ca5cf37aee3::dipsui {
    struct DIPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DIPSUI>(arg0, 9638410799537670906, b"Dipsui", b"DIPSUI", x"446970737920546f6b656e2069736ee2809974206865726520746f20706c6179206e6963653b2069742773206865726520746f206d616b6520776176657321", b"https://images.hop.ag/ipfs/QmUJ3jVpcusPL7ip3K3SGrButao64KQf8WbDEKt4jdty2X", 0x1::string::utf8(b"https://x.com/dipsyonsui"), 0x1::string::utf8(b"https://dipsui.fun/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

