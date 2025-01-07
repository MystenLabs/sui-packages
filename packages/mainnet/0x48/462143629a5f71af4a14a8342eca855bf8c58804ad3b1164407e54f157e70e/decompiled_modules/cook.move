module 0x48462143629a5f71af4a14a8342eca855bf8c58804ad3b1164407e54f157e70e::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<COOK>(arg0, 11796670644958418915, b"COOK", b"COOK", x"576527726520676f6e6e61207072696e742061206c6f74206f66206d6f6e657920776974682024434f4f4bf09f92b8", b"https://images.hop.ag/ipfs/Qmbr97yVnM8p8oxiLm1zQdn2vmF9cQtJnKaAToWet3iP5W", 0x1::string::utf8(b"https://x.com/ChefOfSui"), 0x1::string::utf8(b"https://cookonsui.xyz/"), 0x1::string::utf8(b"http://t.me/CookSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

