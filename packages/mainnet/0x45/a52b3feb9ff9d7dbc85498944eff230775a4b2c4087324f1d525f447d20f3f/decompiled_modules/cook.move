module 0x45a52b3feb9ff9d7dbc85498944eff230775a4b2c4087324f1d525f447d20f3f::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<COOK>(arg0, 18261405832459452641, b"COOK", b"COOK", x"f09fa791e2808df09f8db3", b"https://images.hop.ag/ipfs/Qmbr97yVnM8p8oxiLm1zQdn2vmF9cQtJnKaAToWet3iP5W", 0x1::string::utf8(b"https://x.com/ChefOfSui"), 0x1::string::utf8(b"https://cookonsui.xyz/"), 0x1::string::utf8(b"http://t.me/CookSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

