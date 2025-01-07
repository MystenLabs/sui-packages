module 0xcf806a1fb74a780f1cddf297e2aa72101a4e7cd6ce5cd1705cc63c927c3e4ecd::one00000000 {
    struct ONE00000000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE00000000, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ONE00000000>(arg0, 5590650755531020383, b"Mole", b"100000000", b"Mole is an Aptos & Sui based leveraged income protocol that provides savings, leveraged income farms and funds.", b"https://images.hop.ag/ipfs/QmYaGPDiV6LcQ5xvqdd8xnNKbpTuyfHEo988mYVPfndPxF", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

