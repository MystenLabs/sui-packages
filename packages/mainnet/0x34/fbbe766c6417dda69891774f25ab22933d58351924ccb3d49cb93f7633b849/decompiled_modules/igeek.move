module 0x34fbbe766c6417dda69891774f25ab22933d58351924ccb3d49cb93f7633b849::igeek {
    struct IGEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGEEK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<IGEEK>(arg0, 8499633245223530658, b"Amdegeek", b"Igeek", x"49e280996d206e6f742070726f6372617374696e6174696e67e280a6206a75737420646f696e672061206d656e74616c207265626f6f74", b"https://images.hop.ag/ipfs/QmWD8yXUDJz9uW8MuCXyfdGLAoTksYBetTNq8v9NBnY7pK", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

