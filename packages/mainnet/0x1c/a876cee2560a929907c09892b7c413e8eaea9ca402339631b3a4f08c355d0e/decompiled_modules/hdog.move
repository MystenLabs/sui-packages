module 0x1ca876cee2560a929907c09892b7c413e8eaea9ca402339631b3a4f08c355d0e::hdog {
    struct HDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDOG>(arg0, 6, b"HDOG", b"Hop Dog", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmT1PLJWZTfZQx8qA25EgA2oRqn4ANKDdK6pseWr1Z6RXt")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HDOG>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HDOG>(6184781941077755823, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

