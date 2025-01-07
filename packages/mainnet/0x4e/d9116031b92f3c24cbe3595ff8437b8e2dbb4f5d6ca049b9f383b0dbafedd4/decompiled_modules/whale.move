module 0x4ed9116031b92f3c24cbe3595ff8437b8e2dbb4f5d6ca049b9f383b0dbafedd4::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WHALE>(arg0, 5803345640491202489, b"Whalebert", b"Whale", b"Whale for Whales", b"https://images.hop.ag/ipfs/QmdRmaRLkoiMhXVf2cFizoJ91JNHzfrnV1dZ5A4LaGox4x", 0x1::string::utf8(b"https://x.com/WhalebertSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

