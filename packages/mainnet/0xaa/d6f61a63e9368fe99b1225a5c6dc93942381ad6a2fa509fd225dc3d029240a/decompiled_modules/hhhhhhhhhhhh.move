module 0xaad6f61a63e9368fe99b1225a5c6dc93942381ad6a2fa509fd225dc3d029240a::hhhhhhhhhhhh {
    struct HHHHHHHHHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHHHHHHHHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<HHHHHHHHHHHH>(arg0, 92814663, b"HH", b"hhhhhhhhhhhh", b"hhhhhhhhhhh", b"https://ipfs.io/ipfs/bafkreifygts5svirknuboa5iqtmuaqtzid2zdjg6wm5sufokpovihfyj3m", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

