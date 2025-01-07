module 0x5d545c85a465487099ecbffef72ebc9c61a2cc19b590e670e1408d7630810b29::chd {
    struct CHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CHD>(arg0, 8497982980053253381, b"CHAD", b"CHD", b"top sigma moment", b"https://images.hop.ag/ipfs/QmW7fGGy8RjwA49wr82TNfQHjvmt7tdzPVwMd3HEAX8zR1", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

