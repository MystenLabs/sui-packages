module 0x202f690a82c9f26969ec212043a3c39eae9cb75b1a6a9f541f49d268f92d2e72::wag {
    struct WAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WAG>(arg0, 6219379932596065797, b"Why are you gay?", b"WAG", b"We are not going to leave here unless someone is gay", b"https://images.hop.ag/ipfs/QmUp6c8zm9huv3mfRuPgMM1DLEWXCSSdzbLTvC2YAH3KnL", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

