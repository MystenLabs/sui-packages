module 0xd7acc8e91ea02582f3111dd6809f4f65e2ca2c1a0d13c966af3a673603ced42::orcie {
    struct ORCIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCIE>(arg0, 6, b"ORCIE", b"Orcie", b"Here to make a splash on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmZUt7qM1GH1aTggoNMykKhP4F8kffagsrfkkEACav83KL")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<ORCIE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<ORCIE>(12660965021115953731, v0, v1, 0x1::string::utf8(b"https://x.com/OrcieSUI"), 0x1::string::utf8(b"https://orcies.com/"), 0x1::string::utf8(b"https://t.me/OrcieSUI"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

