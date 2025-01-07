module 0xf13e05b5ea989fa488be7febf28a9972ac79a238156b406c64df36637bb4e231::retired {
    struct RETIRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETIRED, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<RETIRED>(arg0, 1014293633529701646, b"Study Retired", b"RETIRED", b"We're all going to be retired this cycle, so let's study retirement now!", b"https://images.hop.ag/ipfs/QmaiLhXaSqbNGDZmgcuPCgDPrC2RfyiiAmfYkbSZHLedXf", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

