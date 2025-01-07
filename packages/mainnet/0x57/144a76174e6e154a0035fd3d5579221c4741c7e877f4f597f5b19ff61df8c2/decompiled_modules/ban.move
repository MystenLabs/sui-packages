module 0x57144a76174e6e154a0035fd3d5579221c4741c7e877f4f597f5b19ff61df8c2::ban {
    struct BAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAN>(arg0, 6, b"Ban", b"Comedian", x"546865206d6f7374207369676e69666963616e74206d656d65206f66207468652061727420686973746f7279206279204d6175726963696f2043617474656c616e2e204265696e672061756374696f6e20617420536f7468656279e2809973204e6f76656d626572203230746820f09f8d8c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmXdp7yUDHKR9UMhwRkeMe681aKRwAJxBxappQPjuYw9dd")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<BAN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<BAN>(10397900339178861767, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

