module 0xf9d8d6a71394d426187c6ca2ca82479cf33af10e6f099dadbdebbc75d1956024::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<BUBL>(arg0, 18101457101160427242, b"BUBL", b"BUBL", x"427562626c696e67206f6e200a405375694e6574776f726b0a20746f206d616b65206672656e732e", b"https://images.hop.ag/ipfs/Qmbf752EhgUbtLCph7R9XuGYiWQZKdyCaA8Bo5afpwuNiY", 0x1::string::utf8(b"https://x.com/bublsui"), 0x1::string::utf8(b"https://bublsui.com/"), 0x1::string::utf8(b"https://t.me/bublsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

