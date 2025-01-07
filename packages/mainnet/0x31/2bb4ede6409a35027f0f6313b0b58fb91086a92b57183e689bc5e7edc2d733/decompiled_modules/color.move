module 0x312bb4ede6409a35027f0f6313b0b58fb91086a92b57183e689bc5e7edc2d733::color {
    struct COLOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLOR>(arg0, 6, b"Color", b"Sui Color", x"436f6c6f72206f6e20737569efbc8c6769766520737569206d6f726520636f6c6f722c77656c636f6d20746f2073756920636f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmP5okeHmsKCLkWAbWA3C34BPcqUDRWvPYDyLXVTPuEFWL")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<COLOR>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<COLOR>(17844264840152284958, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

