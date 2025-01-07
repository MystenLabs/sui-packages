module 0xa845b0bb9d07870ebc1d797882dc1a3a3037b2b1c1cc4202b542ff12f4a3bbdf::qwwwq {
    struct QWWWQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWWWQ, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<QWWWQ>(arg0, 12452051139740049552, b"qwerty token", b"qwwwq", b"notyhing", b"https://images.hop.ag/ipfs/Qmcr1rq6F7hBou4aRRw1PLvTdYmyQt98RY2JNjED84m2WP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

