module 0x886b85f86acc0dd3afaecdafda524eafc1df180682bcffac7196265fb2c8ed0::zen {
    struct ZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<ZEN>(arg0, 2479468527778662693, b"Zen", b"ZEN", b"Zen AF.", b"https://images.hop.ag/ipfs/QmPRq3mSDTzhi69yKLWFuG7oY1U3fdvXDjrAumBoiL5ku6", 0x1::string::utf8(b"https://x.com/zen_frogs"), 0x1::string::utf8(b"https://zenfrogs.com/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

