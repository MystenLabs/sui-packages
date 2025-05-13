module 0xfca9cecaae589badd7fcdda4b7b3c666a270e8227e3bc81e9195cc43697e07::nnn {
    struct NNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNN, arg1: &mut 0x2::tx_context::TxContext) {
        0x88a1a68c37327bddab2aa4117b938d52e64a0a04cf8809206bcd46217b6f3cd4::connector_v3::new<NNN>(arg0, 979662331, b"NNN", b"nnn", b"nn", b"https://ipfs.io/ipfs/bafybeiewjapai7zuczxslwlbogsecxconbboyka6rv4wvbiwd3sa2op63u", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

