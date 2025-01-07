module 0x39dbfaa18163c6586493ce7f7f1bdc75190ef98f64a00a69046d0bbd45b1f916::peanut {
    struct PEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT>(arg0, 6, b"PEANUT", b"Peanut the Squirrel", b"Peanut (also known as P'Nut) was a pet Eastern grey squirrel that had a popular Instagram account devoted to it. In October 2024, it was seized from its owners home and later euthanized.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmNWi2Hk4sPioqDx1MrkSEHVk6hLFtKnkk9Fk38UgwyN8v")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PEANUT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PEANUT>(10430401917494367182, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

