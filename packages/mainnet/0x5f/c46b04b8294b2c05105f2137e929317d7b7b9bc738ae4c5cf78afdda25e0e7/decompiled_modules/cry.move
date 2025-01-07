module 0x5fc46b04b8294b2c05105f2137e929317d7b7b9bc738ae4c5cf78afdda25e0e7::cry {
    struct CRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CRY>(arg0, 4200519470013417228, b"CRY", b"CRY", b"CRY", b"https://images.hop.ag/ipfs/QmRXzDqGnM9m96owyqAbTVkaYudWwg3HZhgafEkC8j1XAn", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

