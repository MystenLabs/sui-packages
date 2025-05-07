module 0x87c67d7014aca69b3f168cab31097f70fc895f7b3797391c5aa40acc30e60660::newa {
    struct NEWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWA, arg1: &mut 0x2::tx_context::TxContext) {
        0x23138291df7c61fb46bb4e9ff29d50f89d69fda5b38f539e3236d1d98de0a252::connector_v3::new<NEWA>(arg0, 455706684, b"NEWA", b"newa", b"new token", b"https://ipfs.io/ipfs/bafybeigschkt62entx7k4ylv2n55svrzrmegcaw7uush7od4gv3ge7jyn4", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

