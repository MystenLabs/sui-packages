module 0xa0ba0ca95b3bfcf15a2445ae49f21cb32d192f79028138fc8e8d0ee4f30d06f::asasa {
    struct ASASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASASA, arg1: &mut 0x2::tx_context::TxContext) {
        0x4e5dc9fb4496c4ed644f38223ed517568ac3a3dba234185076d5962145271e63::connector_v3::new<ASASA>(arg0, 68361268, b"ASASA", b"asasa", b"asasas", b"https://ipfs.io/ipfs/bafkreiagmse3cu427zb7koah7eujl6hpqztxa777p6l5o4gddgovbowetq", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

