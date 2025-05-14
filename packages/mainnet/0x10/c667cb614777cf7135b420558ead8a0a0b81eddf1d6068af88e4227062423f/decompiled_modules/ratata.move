module 0x10c667cb614777cf7135b420558ead8a0a0b81eddf1d6068af88e4227062423f::ratata {
    struct RATATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATATA, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<RATATA>(arg0, 499406266, b"RATATATATA", b"ratata", b"sssss", b"https://ipfs.io/ipfs/bafybeiglcg6vgquxsx6ddsxx6koul6f46fqhb5z2isqvherbkzisu72yne", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

