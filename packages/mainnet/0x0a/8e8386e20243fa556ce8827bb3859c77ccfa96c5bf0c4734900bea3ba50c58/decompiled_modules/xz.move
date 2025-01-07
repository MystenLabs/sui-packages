module 0xa8e8386e20243fa556ce8827bb3859c77ccfa96c5bf0c4734900bea3ba50c58::xz {
    struct XZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: XZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<XZ>(arg0, 3766813181430407522, b"XZ", b"XZ", b"something", b"https://images.hop.ag/ipfs/QmR41YnnGSzZxZPyRTH9cmmQP5cGoNKcbUEBTh7QAFo1zZ", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

