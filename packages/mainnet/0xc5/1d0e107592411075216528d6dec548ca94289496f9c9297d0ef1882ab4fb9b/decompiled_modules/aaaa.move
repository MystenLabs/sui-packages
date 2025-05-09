module 0xc51d0e107592411075216528d6dec548ca94289496f9c9297d0ef1882ab4fb9b::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        0xc874b6eb08bcab05aea4b00dab8451b6f16b393023d39798366de4845e2917ec::connector_v3::new<AAAA>(arg0, 732246727, b"AAAAAAA", b"aaaa", b"aaaaaaaaaaaaaaaa", b"https://ipfs.io/ipfs/bafybeidaft374laj7z4jv3fbbbkeo4t34y6efea6je7mvfjusypgsmp6o4", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

