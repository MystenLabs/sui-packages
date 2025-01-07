module 0xe9d32cda7e7f70ff0983101a4f0d7386d9d7e3a2d46210e8f273d3ebc4ed05f6::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<COOK>(arg0, 6995602511069752513, b"COOK", b"COOK", b"Cook is a spicy meme coin on the Sui blockchain, stirring up excitement with its community-driven vibes and playful energy. Designed to serve up fun in the crypto world, Cook aims to be the hottest new ingredient in your digital wallet", b"https://images.hop.ag/ipfs/Qmbr97yVnM8p8oxiLm1zQdn2vmF9cQtJnKaAToWet3iP5W", 0x1::string::utf8(b"https://x.com/ChefOfSui"), 0x1::string::utf8(b"https://cookonsui.com/"), 0x1::string::utf8(b"http://t.me/CookSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

