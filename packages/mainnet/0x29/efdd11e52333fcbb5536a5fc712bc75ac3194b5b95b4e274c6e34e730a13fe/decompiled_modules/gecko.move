module 0x29efdd11e52333fcbb5536a5fc712bc75ac3194b5b95b4e274c6e34e730a13fe::gecko {
    struct GECKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKO>(arg0, 6, b"GECKO", b"GECKO on SUI", b"just a gecko with legit community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSff1TKR7VtLhDzUxCFS2xnLNCv8aiKeZoetM5a9dd8GR")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<GECKO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<GECKO>(7579444321599168643, v0, v1, 0x1::string::utf8(b"https://x.com/geckoonsui?s=21&t=_s98fr0YE-yC-j6rfGbR4g"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

