module 0x527c46ea701b80f4c98df48fe55bad954bfe5d0d5666ae5aae78d4a3c55e4e1e::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SHIT>(arg0, 5497932452666535289, b"shit", b"Shit", b"Shit is shit, where is my rights?", b"https://images.hop.ag/ipfs/QmcE91X2QhJ44Q78wBkgGTfJ1ZNsW95Uzef3uxptKBwgHt", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

