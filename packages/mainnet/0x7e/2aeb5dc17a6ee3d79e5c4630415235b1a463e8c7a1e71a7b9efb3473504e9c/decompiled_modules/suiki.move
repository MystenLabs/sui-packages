module 0x7e2aeb5dc17a6ee3d79e5c4630415235b1a463e8c7a1e71a7b9efb3473504e9c::suiki {
    struct SUIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIKI>(arg0, 11062928868658654493, b"SUIKI", b"SUIKI", b"Water Onimusha (Suiki)", b"https://images.hop.ag/ipfs/QmUdcBJN8PsHVVyCN8vH2KnFcUxwBJFWKnwccrKYKhebby", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

