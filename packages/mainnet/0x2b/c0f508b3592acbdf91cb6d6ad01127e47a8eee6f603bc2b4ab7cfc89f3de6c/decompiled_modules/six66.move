module 0x2bc0f508b3592acbdf91cb6d6ad01127e47a8eee6f603bc2b4ab7cfc89f3de6c::six66 {
    struct SIX66 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIX66, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIX66>(arg0, 6, b"666", b"666", b"666 Verses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmRqfrnb6s2ZEPVbXiVNrCeuoG3ZBjWZ6pvnNzhgFX4egV")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SIX66>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SIX66>(8787530859132640232, v0, v1, 0x1::string::utf8(b"https://x.com/LordVaghela"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

