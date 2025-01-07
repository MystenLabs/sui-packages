module 0xc8380a4398e7fbba8a583768a03a8326ab89b1ede0c77064ad7faf5eab4ab15d::squide {
    struct SQUIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDE>(arg0, 6, b"Squide", b"Squide", b"Squide The Pearl OF SUI, The cryptocurrency market on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSdzf5XBe6TV93XX9RX19KJqiBii5VSiNozwVqbMwzzip")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SQUIDE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SQUIDE>(2206115996284920219, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

