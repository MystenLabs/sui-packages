module 0x85df7251d80a66b1ad124825f383253d9fa250f26866ed18e0b4af84be973d13::cny {
    struct CNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CNY>(arg0, 2974511423680437648, b"CHINA", b"CNY", b"SUI Dynasty was a great dynasty in Chinese history.  SUI coin will also be a currency representing Chinese sovereignty. SUI coins will make China great again.", b"https://images.hop.ag/ipfs/QmdMSHPXryp4jsT5YZo9ySCVp4yyLZb77gWjSnF37YNHw2", 0x1::string::utf8(b"https://www.twitter.com/PDChina"), 0x1::string::utf8(b"https://www.chinadaily.com.cn/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

