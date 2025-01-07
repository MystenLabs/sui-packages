module 0x13328bf8f6378d0e44535921d871bdcdbe3ad03a0b21ec8b42c38178ca5b934::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUI>(arg0, 2043459098976009932, b"SUI", b"SUI", b"SUI", b"https://images.hop.ag/ipfs/QmdPsqEurFWTSFWPX7Nj5kTNjnreWeNJNbQf3pyjqYLBkj", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

