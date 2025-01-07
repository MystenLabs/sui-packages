module 0x2d888d39b86136396c68283b9b75c651bada7c5157d133f197a6eb3c397b26ce::mit {
    struct MIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MIT>(arg0, 6133322510997229078, b"EVIL KERMIT", b"MIT", b"TALKING TO THE DARK SELF...........Crypto .... internal conflicts $Temptations", b"https://images.hop.ag/ipfs/QmYjLEgi9wyKmY1KbnaMnmJvdBzG47yaBND5hPXCcdhNSg", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/evilkermit_meme"), arg1);
    }

    // decompiled from Move bytecode v6
}

