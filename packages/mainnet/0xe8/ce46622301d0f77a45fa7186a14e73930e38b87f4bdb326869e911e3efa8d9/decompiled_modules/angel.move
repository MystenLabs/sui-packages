module 0xe8ce46622301d0f77a45fa7186a14e73930e38b87f4bdb326869e911e3efa8d9::angel {
    struct ANGEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGEL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ANGEL>(arg0, 14073251413119479486, b"Guardian Angel", b"ANGEL", x"4f6e6520666f7220616c6c20616e6420616c6c20666f72204f6e652e0a5468652073796d626f6c206f6620756e6974792c2070656163652c20616e642070726f737065726974792e0a4d79206d79737465727920776173206e65766572206d65616e7420746f20626520736f6c7665642c20697420776173206d65616e7420746f20626520657870657269656e6365642e", b"https://images.hop.ag/ipfs/QmYGncn45NxvCkzYmCs7HM7qPzTZpQBPgTAWqtgVbkSKjh", 0x1::string::utf8(b"https://x.com/BaseMemeAngel"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

