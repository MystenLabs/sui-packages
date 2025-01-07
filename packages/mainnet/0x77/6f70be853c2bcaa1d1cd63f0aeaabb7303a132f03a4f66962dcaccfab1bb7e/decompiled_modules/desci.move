module 0x776f70be853c2bcaa1d1cd63f0aeaabb7303a132f03a4f66962dcaccfab1bb7e::desci {
    struct DESCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESCI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DESCI>(arg0, 12109343737878171583, b"Sui Desci Agents", b"$DESCI", x"4c61756e6368204465536369206173736574732c2067726f772074686569722061756469656e63652077697468204149206167656e74732c20616e642067656e6572617465206c69717569646974792077697468206d656368616e69637320696e73706972656420627920687474703a2f2f70756d702e66756e20506f7765726564206279200a407375696e6574776f726b", b"https://images.hop.ag/ipfs/QmXuztk9BzaBrxw2dKyMTE7iE8Vz36wQtmhaBT71oDaQnG", 0x1::string::utf8(b"https://x.com/DeSci_Agents"), 0x1::string::utf8(b"https://desciagents.ai/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

