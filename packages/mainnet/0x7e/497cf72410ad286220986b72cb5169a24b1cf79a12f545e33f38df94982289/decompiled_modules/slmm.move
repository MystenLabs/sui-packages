module 0x7e497cf72410ad286220986b72cb5169a24b1cf79a12f545e33f38df94982289::slmm {
    struct SLMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLMM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SLMM>(arg0, 3140893156121467392, b"Suilamma", b"SLMM", b"The first memecoin on sui with high security", b"https://images.hop.ag/ipfs/QmP7MLT31bzvcBAFENYjnqWvrxwkz5zKNz9LsMMyHVx4oY", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

