module 0x1e52a2cbdd6d2c86ac1b0bdfb5e7b89bd0d3a54106154738aada84b5f64fa50b::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<BUBL>(arg0, 5184223084609340334, b"BUBL SUI", b"BUBL", b"officially the first bubble on HopFun", b"https://images.hop.ag/ipfs/Qmbf752EhgUbtLCph7R9XuGYiWQZKdyCaA8Bo5afpwuNiY", 0x1::string::utf8(b"https://x.com/bublsui"), 0x1::string::utf8(b"https://bublsui.com/"), 0x1::string::utf8(b"https://t.me/bublsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

