module 0x64da786ea4bbcedba51e63302e1a70a30534770c9891cc4b315a1680b91c377d::wbdog {
    struct WBDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WBDOG>(arg0, 16280020568775186496, b"World's Best Dog", b"WBDog", b"World's Best Dog", b"https://images.hop.ag/ipfs/QmVBAZFVpgbRz3czurpJcxmjVkVd3jYBgGcq2dZj5Td3jo", 0x1::string::utf8(b"https://x.com/SWorld94907"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

