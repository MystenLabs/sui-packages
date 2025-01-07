module 0x5944f2d01a53373de1dc8cfd1b2dbf7057a3e74822728b6903aa1f3e8549cfd5::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TIPSY>(arg0, 16567913594556449380, b"Tipsy", b"$TIPSY", x"e2808b24544950535920697320612073656e736174696f6e2c20616e642074686f7567682054697073792069732061206269742064697a7a792066726f6d20616c6c20746865202273656177656564206a756963652c2220686973206865617274207377656c6c7320776974682070726964652e2048697320647265616d206265636f6d6573207265616c6974792c206f6e652063656c65627261746f72792073686f7420617420612074696d652e", b"https://images.hop.ag/ipfs/QmYtY2mzZC2RmjAdwAuu75WLDTK7JyJUeonszutJWKKzqx", 0x1::string::utf8(b"https://x.com/tipsyonsui"), 0x1::string::utf8(b"https://www.tipsyonsui.com/"), 0x1::string::utf8(b"https://t.me/tipsyonsuiportal"), arg1);
    }

    // decompiled from Move bytecode v6
}

