module 0x24e040e6f0f269aade7207155d26cdb7da07a0f46289a64527e63267cb1c23ca::three34 {
    struct THREE34 has drop {
        dummy_field: bool,
    }

    fun init(arg0: THREE34, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THREE34>(arg0, 6, b"334", b"FWOG", b"hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmaSj7FAiStKkgRE1KZVmRYrN7wytKDWe3zZttUHAW6PPB")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<THREE34>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<THREE34>(4184952454326146313, v0, v1, 0x1::string::utf8(b"https://x.com/FlogTheFwog"), 0x1::string::utf8(b"https://fwog.com/"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

