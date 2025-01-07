module 0xe1320b4bf11f475d3a42691bde778512a80dbe53c744fbe4c834746a6be87628::suiren {
    struct SUIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIREN>(arg0, 9751060626409385396, b"Sui Siren", b"SUIREN", b"Beauty under water waiting to be rescued by Degens!", b"https://images.hop.ag/ipfs/QmXVvWMDi463nh1DidSiRVGK1re6nUzHhYCX8jcAmfiJG3", 0x1::string::utf8(b"https://x.com/GGreaper8779"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

