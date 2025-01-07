module 0xbf048d29bd4ff1bb0e6e416461eefd080de8d4dd0dd0aab67f2138327b25246::loco {
    struct LOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<LOCO>(arg0, 4895565953487141008, b"LocoWifCoco", b"LOCO", x"244c4f434f203d204372617a7920696e205370616e6973680a0a5468652077686f6c6520776f726c64206973206c6f636f20616e642077652061726520676f696e6720746f206d656d65207466206f7574206f662069742e204c657473206f6e626f61726420746865206d617373657320746f20535549207468726f7567682074686520706f776572206f66206d656d657321", b"https://images.hop.ag/ipfs/QmXA3vG9XvZ17PzFJSeySQSjAvYvq8nTxuDzgj8Jx8jNvT", 0x1::string::utf8(b"https://x.com/locowifcoco"), 0x1::string::utf8(b"http://www.LocoWifCoco.com"), 0x1::string::utf8(b"https://t.me/+wHn4PnWoGp82ZTY5"), arg1);
    }

    // decompiled from Move bytecode v6
}

