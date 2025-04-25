module 0x24ba36a1a7afda1eae3e54926a72155f1569269bdb73190a85e6c7a714b823f4::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<MEME>(arg0, 743189712, b"MEME", b"meme", b"mememem", b"https://ipfs.io/ipfs/bafkreiciq2wbntuat2ovxb4pfzfhsf6crcax2lr7wihx6d7lw7j45hax7e", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

