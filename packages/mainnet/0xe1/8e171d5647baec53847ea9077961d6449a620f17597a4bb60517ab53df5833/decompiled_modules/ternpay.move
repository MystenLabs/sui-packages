module 0xe18e171d5647baec53847ea9077961d6449a620f17597a4bb60517ab53df5833::ternpay {
    struct TERNPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERNPAY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TERNPAY>(arg0, 6546961907159819696, b"TernPAY", b"TernPAY", b"Definite payment with profit at maturity", b"https://images.hop.ag/ipfs/Qmbs7ggTG2xLSVYJWRzVDNH9PGVw3t9muUVzf4beKFa5D5", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

