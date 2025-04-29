module 0x2ba1f9703950144e713f5852ff141e8bbb04a022391713867ba1145afca0e86f::tetete {
    struct TETETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETETE, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<TETETE>(arg0, 746267431, b"TETE", b"tetete", b"etetetette", b"https://ipfs.io/ipfs/bafkreief2yhdjb55o2hmol5bsdzjjvyy4oxd7saotppmbmsxe5ptnbrxau", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

