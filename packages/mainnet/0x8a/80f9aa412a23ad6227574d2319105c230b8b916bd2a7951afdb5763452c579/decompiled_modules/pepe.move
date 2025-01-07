module 0x8a80f9aa412a23ad6227574d2319105c230b8b916bd2a7951afdb5763452c579::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PEPE>(arg0, 17984365641433013041, b"SUI Pepe", b"Pepe", x"486f70206f6e20746865205355492050657065207761766520e2809320526962626974696e672070726f66697473206177616974206f6e20746865206661737465737420626c6f636b636861696e2120f09f9a80f09f90b8", b"https://images.hop.ag/ipfs/QmZX5BYtDyYijNdvwdWnB1coKpGMX6hTnDPspFMqjkEdWf", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

