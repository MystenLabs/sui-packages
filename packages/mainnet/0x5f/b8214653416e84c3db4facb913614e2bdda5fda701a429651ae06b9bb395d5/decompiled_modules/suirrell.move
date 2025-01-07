module 0x5fb8214653416e84c3db4facb913614e2bdda5fda701a429651ae06b9bb395d5::suirrell {
    struct SUIRRELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRRELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRRELL>(arg0, 6, b"Suirrell", b"Peanut the Suirrell", b"Most famous Suirrell!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qmepmeh8sXCpdwc3aUWLEYtAKf6FvJsFLRkB2YtuV5NcMt")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUIRRELL>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUIRRELL>(8793959627197978569, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

