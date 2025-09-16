module 0x82a33c8c9082b67736abc7a5c9be9f4aac8d5beb3d14c8498dd943ff0bfe0a28::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0xc907e599b1690d7b75b3d15acb57f48f762141ca86828abd435b98588a1f8414::connector_v3::new<HI>(arg0, 64529956, b"hi", b"HI", b"Hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/IPbg6p4Bha2FByleKIFUVUObA_WUq-q2VUMgxWKIlPI", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

