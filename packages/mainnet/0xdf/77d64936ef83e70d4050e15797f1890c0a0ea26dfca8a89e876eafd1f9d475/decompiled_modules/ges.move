module 0xdf77d64936ef83e70d4050e15797f1890c0a0ea26dfca8a89e876eafd1f9d475::ges {
    struct GES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GES, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GES>(arg0, 3272954744760992186, b"GODES", b"GES", x"4d656d65636f696e2028e2809c4d454d45e2809d292069732061206469676974616c20746f6b656e20636f6d70617469626c652077697468", b"https://images.hop.ag/ipfs/QmPRuzvrun1mRxKvxcc94QcLnRuqkp2HCL2hiaQvAYqxfb", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

