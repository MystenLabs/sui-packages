module 0xd37db4583ab36bf23e08e317ed5ed547ce99a796d7b87936824b52fcdd02b73f::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ANDY>(arg0, 15601229210013886486, b"Andy", b"ANDY", b"Andy the Frog on SUI", b"https://images.hop.ag/ipfs/QmQahWgNF24W6U3CjNADEPkYn5bEXfRPLzpHXChRWfisKE", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

