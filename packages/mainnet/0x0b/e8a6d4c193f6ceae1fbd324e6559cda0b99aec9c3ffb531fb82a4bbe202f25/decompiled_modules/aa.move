module 0xbe8a6d4c193f6ceae1fbd324e6559cda0b99aec9c3ffb531fb82a4bbe202f25::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<AA>(arg0, 209775945, b"AAAAAA", b"aa", b"aaa", b"https://ipfs.io/ipfs/bafkreifumfvy65zmrtamvzrp4gywnu5lkg5626arayhjz634kykx6vhngm", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

