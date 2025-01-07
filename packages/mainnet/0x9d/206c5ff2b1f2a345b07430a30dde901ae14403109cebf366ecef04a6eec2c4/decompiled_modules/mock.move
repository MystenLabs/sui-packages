module 0x9d206c5ff2b1f2a345b07430a30dde901ae14403109cebf366ecef04a6eec2c4::mock {
    struct MOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK>(arg0, 6, b"MOCK", b"SpongeMock", b"retardio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmP5Ei3RVwqCNNfnzrJWBMKCoyc25115HBNMoxWXNDiVfQ")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<MOCK>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<MOCK>(16750272729155841792, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

