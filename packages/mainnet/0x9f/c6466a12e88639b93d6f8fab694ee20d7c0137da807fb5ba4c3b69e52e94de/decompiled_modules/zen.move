module 0x9fc6466a12e88639b93d6f8fab694ee20d7c0137da807fb5ba4c3b69e52e94de::zen {
    struct ZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<ZEN>(arg0, 18306117822688995129, b"Zen", b"ZEN", b"Zen AF.", b"https://images.hop.ag/ipfs/QmPRq3mSDTzhi69yKLWFuG7oY1U3fdvXDjrAumBoiL5ku6", 0x1::string::utf8(b"https://x.com/zen_frogs"), 0x1::string::utf8(b"https://zenfrogs.com/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

