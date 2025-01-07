module 0x938a07448c1052f94079096bdd2970e87001f4f0529aa91c7afa7fa0da268be2::mpox {
    struct MPOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPOX, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MPOX>(arg0, 3085116494330788386, b"MPOX", b"MPOX", b"Better safe than sorry, get your $MPOX on Sui Network.", b"https://images.hop.ag/ipfs/QmaHkZyTuYpS8UYYrwVczYRekzcP7BdRbjsz5rZN2iTBXv", 0x1::string::utf8(b"https://x.com/mpoxcoinsui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

