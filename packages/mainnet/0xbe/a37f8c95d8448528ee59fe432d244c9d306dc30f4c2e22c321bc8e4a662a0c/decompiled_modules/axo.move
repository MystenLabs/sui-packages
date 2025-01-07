module 0xbea37f8c95d8448528ee59fe432d244c9d306dc30f4c2e22c321bc8e4a662a0c::axo {
    struct AXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<AXO>(arg0, 12004429593628160463, b"Axo", b"$Axo", b"Axo the Axolotl | Join our journey from the HopFun trenches to the $SUI oceans", b"https://images.hop.ag/ipfs/QmPNfrNhdzCL5xNcHxSJdMM1UtHrsWmEeSPqx3WnhWwmyA", 0x1::string::utf8(b"https://x.com/AxoOnSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/AxoSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

