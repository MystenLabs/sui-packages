module 0xa5c6a0e04ce4229b66d7f31093cc3addf9c2c4ec0d59a9bdac5b8c3df13b8ce6::bkkt {
    struct BKKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKKT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BKKT>(arg0, 4420590549895188494, b"Bkkt / sui", b"Bkkt ", x"446f6e616c64205472756d70e280997320736f6369616c206d6564696120636f6d70616e7920697320696e20616476616e6365642074616c6b7320746f206275792042616b6b742c20612063727970746f63757272656e63792074726164696e672076656e7565206f776e656420627920496e746572636f6e74696e656e74616c2045786368616e67652c2061732069742070757368657320746f20657870616e64206265796f6e64206f6e6c696e6520636f6e766572736174696f6e2e", b"https://images.hop.ag/ipfs/QmdWDdXWJipwbHZzW1aCx64QCkTyJPHDyzhj6P1tRmbA9Y", 0x1::string::utf8(b"https://x.com/bkktsol?t=pRLrCSJzMTrGljLVJco-aA&s=09"), 0x1::string::utf8(b"https://bkktsol.vip/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

