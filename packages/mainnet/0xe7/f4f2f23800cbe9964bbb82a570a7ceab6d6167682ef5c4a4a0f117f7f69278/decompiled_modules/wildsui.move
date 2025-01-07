module 0xe7f4f2f23800cbe9964bbb82a570a7ceab6d6167682ef5c4a4a0f117f7f69278::wildsui {
    struct WILDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WILDSUI>(arg0, 5866274269556411295, b"Wild Sui", b"WILDSUI", x"57696c642053756920f09f9085f09f8d83202d205468652057696c64657374204d656d6520546f6b656e206f6e207468652053756920426c6f636b636861696e2120f09f9a80f09fa4a3f09f92b020200af09f93a7202020696e666f4077696c647375692e636f6d202020f09f93a7", b"https://images.hop.ag/ipfs/QmXV57BxKkxMF4xhyA81kzzRZQcGeWhHTqzpq8yezRWHWn", 0x1::string::utf8(b"https://x.com/wildsui"), 0x1::string::utf8(b"http://wildsui.com"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

