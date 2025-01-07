module 0x448871247c9a63cd4eeb2d6571b2ed8df2377637eb960a05272732da032a2471::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TIPSY>(arg0, 6689636616042280102, b"Tipsy", b"TIPSY", b"Boozing My sorrows in the oceans deep , a narwhal adrift in sorrows keep!", b"https://images.hop.ag/ipfs/QmYtY2mzZC2RmjAdwAuu75WLDTK7JyJUeonszutJWKKzqx", 0x1::string::utf8(b"https://x.com/tipsyonsui"), 0x1::string::utf8(b"https://www.tipsyonsui.com/"), 0x1::string::utf8(b"https://t.me/tipsyonsuiportal"), arg1);
    }

    // decompiled from Move bytecode v6
}

