module 0x97acff3b61c90199a2ab94ef6a73a43383280f04b31ac5fdeaf18d4cd1f55cbf::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BUBL>(arg0, 17424761011298834287, b"BUBLSUI", b"Bubl", b"Bubbling on Sui Network.", b"https://images.hop.ag/ipfs/QmXcxPvT88cvhBg69YpWzGais4L9SkD8tg1xuvvtPXvwLR", 0x1::string::utf8(b"https://x.com/bublsui"), 0x1::string::utf8(b"https://bublsui.com/"), 0x1::string::utf8(b"https://t.me/bublsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

