module 0xc9ba1dbd3869cc619eaa7e7caf74b1af9322fc42c50fa2860be9af0f1e8e4b62::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<COOK>(arg0, 5187833009282440413, b"COOK on Sui", b"COOK", b"Just let him $COOK", b"https://images.hop.ag/ipfs/QmWrHwB8bDPfpwP2DyFpdUSLFKx1Kywt4pvVEUE4L8nCL1", 0x1::string::utf8(b"https://x.com/ChefOfSui"), 0x1::string::utf8(b"https://ChefOfSui.com/"), 0x1::string::utf8(b"https://t.me/CookSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

