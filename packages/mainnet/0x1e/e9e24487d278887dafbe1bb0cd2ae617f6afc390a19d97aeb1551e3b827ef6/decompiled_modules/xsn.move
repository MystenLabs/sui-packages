module 0x1ee9e24487d278887dafbe1bb0cd2ae617f6afc390a19d97aeb1551e3b827ef6::xsn {
    struct XSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSN>(arg0, 6, b"XSN", b"XONO", b"I AM XONO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmXxcaytQghx8vJuhgJNPyCTc939NthS8zr8R4F1DFL7o4")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<XSN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<XSN>(133857874067475105, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

