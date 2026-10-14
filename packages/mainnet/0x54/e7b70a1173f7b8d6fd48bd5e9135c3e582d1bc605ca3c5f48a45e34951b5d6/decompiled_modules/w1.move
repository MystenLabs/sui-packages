module 0x54e7b70a1173f7b8d6fd48bd5e9135c3e582d1bc605ca3c5f48a45e34951b5d6::w1 {
    struct W1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: W1, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<W1>(arg0, 11332666662667661935, b"SYNTH", b"Synthetic W1", b"pkg_5c86 audit witness", b"https://example.invalid/w1.png", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v7
}

