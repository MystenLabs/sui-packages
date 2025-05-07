module 0xae94b8ac27b34e88e3b02f5ba361d62dec59fabeb18db6bfa34a2f8a5b19bb1a::aaaaaaa {
    struct AAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        0x4e5dc9fb4496c4ed644f38223ed517568ac3a3dba234185076d5962145271e63::connector_v3::new<AAAAAAA>(arg0, 143193622, b"AAAAA", b"aaaaaaa", b"AAAAAAA", b"https://ipfs.io/ipfs/bafybeibw4folz4ij4byndnpiiluz4m5ov35ilswqj4cd5gyz76p4pixxre", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

