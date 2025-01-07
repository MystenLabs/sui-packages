module 0xb19bf169e83c015b44246cc7990de425f11ea582548982bff7a4968414e64914::dick {
    struct DICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DICK>(arg0, 8329093879652041715, b"DICK", b"DICK", b"DICK", b"https://images.hop.ag/ipfs/QmR32Gdmk8PdLfskQKQv2W7PmUCCY8QoWS9eRDRRbivWWN", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

