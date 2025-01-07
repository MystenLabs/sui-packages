module 0xfbba79d933b89ec030a1d31a4270751466951b0592af3a3e3ccfdba6d6a3ceaa::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MOJI>(arg0, 17467584059988385522, b"Emoji", b"Moji", x"54686520666972737420456d6f6a69206f6e20537569204e6574776f726b2c206261636b656420627920746865206269676765737420696e666c75656e63657273206f6e20746865204d61726b65742c2053686d6f6f2c2057756c662c2043727970746f2042616e74657220616e64206d6f72652e2e20474554204541524c59204e4f57210a28436f6d6d756e6974792d62617365642070726f6a65637429", b"https://images.hop.ag/ipfs/QmTTZVbdDfMYmiwMaMp5566a1X29WBBRdYd7u3AtpGubvv", 0x1::string::utf8(b"https://x.com/0xSigmak"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/Emojionsuinetwork"), arg1);
    }

    // decompiled from Move bytecode v6
}

