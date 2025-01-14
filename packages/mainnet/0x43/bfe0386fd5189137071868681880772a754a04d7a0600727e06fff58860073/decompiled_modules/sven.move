module 0x43bfe0386fd5189137071868681880772a754a04d7a0600727e06fff58860073::sven {
    struct SVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SVEN>(arg0, 12661338788262428255, b"Sven", b"SVEN", x"54686973206973205376656e20f09f90b020746865207261626269742074686174206c6f7665732062616e616e617320f09f8d8c20616e64206368656572696f7320f09fa5a3", b"https://images.hop.ag/ipfs/QmRNqYWqbE92S4bCEAj2C3mVK69Z5PL5WRxk91uZohWwnz", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/SvenSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

