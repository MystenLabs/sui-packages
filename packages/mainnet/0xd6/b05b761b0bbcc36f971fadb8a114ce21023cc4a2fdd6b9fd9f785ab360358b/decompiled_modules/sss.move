module 0xd6b05b761b0bbcc36f971fadb8a114ce21023cc4a2fdd6b9fd9f785ab360358b::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<SSS>(arg0, 949679679, b"SS", b"sss", b"ss", b"https://ipfs.io/ipfs/bafybeiacugg4gbdkztroj3yv56kib5ud7xjdonypg7lk7bsut5ijn6qdfy", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

