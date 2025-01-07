module 0x4fd3fd7091ec027e6576c3b18aceb8f8455ce4a1245cb8e7eeb8cac6f886bf6::chillguy {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CHILLGUY>(arg0, 7092327194391161675, b"Chill Guy", b"$ChillGuy", x"436869696c477579204d656d6520746f6b656e20666f722063656c656272617465206c697374696e6720746f20746f702065786368616e6765732e0a4c4647210a244368696c6c47757920697320796f7521", b"https://images.hop.ag/ipfs/QmebQ35qJP81fJoYdBNtrXXg7mqwBtxzjFkaQJLNNcFgAH", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+6fX4WKB1S5k1ZTFi"), arg1);
    }

    // decompiled from Move bytecode v6
}

