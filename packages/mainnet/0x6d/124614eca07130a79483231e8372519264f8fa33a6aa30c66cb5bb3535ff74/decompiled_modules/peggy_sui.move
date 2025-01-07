module 0x6d124614eca07130a79483231e8372519264f8fa33a6aa30c66cb5bb3535ff74::peggy_sui {
    struct PEGGY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEGGY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PEGGY_SUI>(arg0, 17809493008963189488, b"Peggy", b"Peggy Sui", b"She Us Intelligence. The end!", b"https://images.hop.ag/ipfs/Qmc8wvtM9ZtW3vQM1MuHfLAT32tSQrRhwRrSQQHNNyw6vv", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

