module 0x8113ffdb18c0fe9d81f5f72d478d25643c50397b4f7e4df73bf087b0fa273799::hopecat {
    struct HOPECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPECAT>(arg0, 6, b"Hopecat", b"HopeCat", b"First cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmZypMAezu4x4ipm3i19AjGBChe8qxbovtTM7GJ8yVAqw8")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPECAT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPECAT>(2226222738935263569, v0, v1, 0x1::string::utf8(b"https://x.com/HopCatSui"), 0x1::string::utf8(b"https://hopcat.fun/"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

