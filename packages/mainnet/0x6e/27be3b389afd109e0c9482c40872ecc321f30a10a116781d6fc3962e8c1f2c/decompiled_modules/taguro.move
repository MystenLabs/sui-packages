module 0x6e27be3b389afd109e0c9482c40872ecc321f30a10a116781d6fc3962e8c1f2c::taguro {
    struct TAGURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAGURO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TAGURO>(arg0, 13089157852897292807, b"taguro", b"TAGURO", b"ghjkkbbbb", b"https://images.hop.ag/ipfs/QmYqaDPTeUXMpWk3LMv97732UDdNmQamArVTazJPgSu9uV", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

