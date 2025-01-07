module 0x70395ff52e1552bb636bbcc7e4b2d038ed3ae4619c9d2bc0dbfa3eea83876d3a::troj {
    struct TROJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROJ, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TROJ>(arg0, 10726791592276999937, b"Trojan", b"TROJ", b"Safe sex on Sui.", b"https://images.hop.ag/ipfs/QmYZ8AKLCeTCsVpDLpq6nwRZsnAnog9opH8TJAKDEhoHxn", 0x1::string::utf8(b"https://x.com/trojancondoms?s=21"), 0x1::string::utf8(b"https://www.trojancondoms.com"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

