module 0x1ba6e9197234b34641f2408dbf3c4ec781030c3428a17e9bbb41d17048423d11::szl {
    struct SZL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SZL>(arg0, 3939303403516424589, b"suizilla", b"szl", b"Suizilla is a meme-based cryptocurrency that aims to bring a fun and lighthearted approach to the world of digital coins. Here's a description of the coin:", b"https://images.hop.ag/ipfs/Qma48hGs3Bu5jXz4iFPvpUMdKqXn4UqKUzfynYaEBux4SK", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

