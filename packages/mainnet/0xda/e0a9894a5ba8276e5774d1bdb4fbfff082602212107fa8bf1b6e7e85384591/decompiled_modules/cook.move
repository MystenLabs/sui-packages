module 0xdae0a9894a5ba8276e5774d1bdb4fbfff082602212107fa8bf1b6e7e85384591::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<COOK>(arg0, 16469624221377025361, b"COOK", b"$COOK", b"Just let him $COOK", b"https://images.hop.ag/ipfs/Qmbr97yVnM8p8oxiLm1zQdn2vmF9cQtJnKaAToWet3iP5W", 0x1::string::utf8(b"https://x.com/ChefOfSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"http://t.me/CookSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

