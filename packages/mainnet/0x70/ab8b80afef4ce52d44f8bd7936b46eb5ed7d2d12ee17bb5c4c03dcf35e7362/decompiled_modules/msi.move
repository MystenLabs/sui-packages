module 0x70ab8b80afef4ce52d44f8bd7936b46eb5ed7d2d12ee17bb5c4c03dcf35e7362::msi {
    struct MSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSI>(arg0, 6, b"msi", b"messui", b"messi is the king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmUSNPmaR2RsHzHyeMgv4XzCrunu5RH5akyQd8nQCFdmH4")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<MSI>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<MSI>(4866695733786359757, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

