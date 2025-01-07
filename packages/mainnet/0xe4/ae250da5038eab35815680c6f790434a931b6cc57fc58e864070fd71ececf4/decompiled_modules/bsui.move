module 0xe4ae250da5038eab35815680c6f790434a931b6cc57fc58e864070fd71ececf4::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BSUI>(arg0, 11448953526728536002, b"SUIbanana", b"BSUI", b"Just a Meme Token. Messi is GOD", b"https://images.hop.ag/ipfs/QmTzjhVmDykkCg7b4fgirByTcYitnJymTH4pejiRTTY8s4", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

