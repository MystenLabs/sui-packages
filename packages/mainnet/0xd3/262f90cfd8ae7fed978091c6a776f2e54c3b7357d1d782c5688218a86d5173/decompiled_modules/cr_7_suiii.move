module 0xd3262f90cfd8ae7fed978091c6a776f2e54c3b7357d1d782c5688218a86d5173::cr_7_suiii {
    struct CR_7_SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR_7_SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CR_7_SUIII>(arg0, 11893065652719397636, b"RONALDOSUIII", b"CR7SUIII", b"Cristiano Ronaldo", b"https://images.hop.ag/ipfs/QmWiHhNEvk6kLquM724HrnuY5sXQtUB6PLEk1WEVd9eYxF", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

