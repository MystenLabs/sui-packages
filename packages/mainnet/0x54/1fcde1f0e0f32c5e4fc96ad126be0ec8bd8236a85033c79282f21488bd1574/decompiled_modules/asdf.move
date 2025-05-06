module 0x541fcde1f0e0f32c5e4fc96ad126be0ec8bd8236a85033c79282f21488bd1574::asdf {
    struct ASDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDF, arg1: &mut 0x2::tx_context::TxContext) {
        0x23138291df7c61fb46bb4e9ff29d50f89d69fda5b38f539e3236d1d98de0a252::connector_v3::new<ASDF>(arg0, 115761300, b"ASDF", b"asdf", b"asdfasdf", b"https://ipfs.io/ipfs/bafkreia4f4ivjvrgtcxqbao3wk6vr72bn227wgoztd4rdbo575ymiea35a", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

