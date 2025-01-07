module 0x71a8c329b4894f76c86c3aed0689e345033549d640a330670c46a10e2a70ae46::verse {
    struct VERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERSE>(arg0, 6, b"VERSE", b"SUIVERSE", b"SUIVERSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmP5yt8khqwvXUK2DDPw6joXk5L1BrXJcjrfnGfvAWXNBd")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<VERSE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<VERSE>(811450303217497069, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

