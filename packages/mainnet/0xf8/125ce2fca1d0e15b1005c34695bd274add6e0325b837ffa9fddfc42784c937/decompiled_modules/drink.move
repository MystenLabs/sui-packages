module 0xf8125ce2fca1d0e15b1005c34695bd274add6e0325b837ffa9fddfc42784c937::drink {
    struct DRINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRINK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DRINK>(arg0, 2097636615469346044, b"DRINKIES", b"$DRINK", b"JUST TRY IT!", b"https://images.hop.ag/ipfs/QmYzrg7VyyGs7LED8s2kMn2yxLQBybwqDWuA95sU5kyC2s", 0x1::string::utf8(b"https://x.com/SuiDrinkies"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/saloonsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

