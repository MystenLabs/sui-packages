module 0x8bf8d033b027ecf708a862484e1956302fad6d867666a26a7c4c6da5a38df991::nnn {
    struct NNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNN, arg1: &mut 0x2::tx_context::TxContext) {
        0x88a1a68c37327bddab2aa4117b938d52e64a0a04cf8809206bcd46217b6f3cd4::connector_v3::new<NNN>(arg0, 196953588, b"NNN", b"nnn", b"nn", b"https://ipfs.io/ipfs/bafybeidaft374laj7z4jv3fbbbkeo4t34y6efea6je7mvfjusypgsmp6o4", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

