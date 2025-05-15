module 0x21b13c27aa4725475430f0a0a857b5370e2ebcd958ec50ecfcaff4ed8d6d3055::fffffff {
    struct FFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x1eb2a3d4d0f2ac3cc6848deb053ac8b15bd7844524bf11a225652ae4d694c882::connector_v3::new<FFFFFFF>(arg0, 71409956, b"FFFF", b"fffffff", b"ffffff", b"https://ipfs.io/ipfs/bafkreiaxftyjz6i5gccwwfdwmthcasrad62wukoylopjebqxiqu2wr3awu", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

