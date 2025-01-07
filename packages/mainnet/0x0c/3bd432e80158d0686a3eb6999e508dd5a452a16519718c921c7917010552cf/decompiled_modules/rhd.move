module 0xc3bd432e80158d0686a3eb6999e508dd5a452a16519718c921c7917010552cf::rhd {
    struct RHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<RHD>(arg0, 2416526340179636164, b"Retarded Hop Dev", b"RHD", b"Retard Bonkman", b"https://images.hop.ag/ipfs/QmSEW774GbR2Ayq4SbmDW5f44Fbsco4qKSNUsUSDkBJTqa", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

