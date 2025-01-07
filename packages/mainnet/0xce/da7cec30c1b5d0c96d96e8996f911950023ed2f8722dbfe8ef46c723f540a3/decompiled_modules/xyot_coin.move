module 0xceda7cec30c1b5d0c96d96e8996f911950023ed2f8722dbfe8ef46c723f540a3::xyot_coin {
    struct XYOT_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYOT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<XYOT_COIN>(arg0, 13323257663971086406, b"xyot", b"xyot coin ", b"mascot of all schoolchildren", b"https://images.hop.ag/ipfs/QmTf1fjfDDERbpT1ZouzaiMspFdW4JEvaCjQdqAQjgtDhG", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://mobi.sslkn.mobi/"), 0x1::string::utf8(b"https://t.me/toryyasss"), arg1);
    }

    // decompiled from Move bytecode v6
}

