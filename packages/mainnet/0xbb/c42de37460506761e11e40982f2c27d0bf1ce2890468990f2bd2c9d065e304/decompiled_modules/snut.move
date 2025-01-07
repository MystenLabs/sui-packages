module 0xbbc42de37460506761e11e40982f2c27d0bf1ce2890468990f2bd2c9d065e304::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SNUT>(arg0, 1998012861513594112, b"SUI PEANUT", b"SNUT", b"Fresh SUI peanuts have a pleasant aroma. If you smell SUI peanuts, you will flight to da moon.", b"https://images.hop.ag/ipfs/QmUaF5etaszQgr28f2uc3fkgta9GQWjgPYQnnC7YUr3zQd", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

