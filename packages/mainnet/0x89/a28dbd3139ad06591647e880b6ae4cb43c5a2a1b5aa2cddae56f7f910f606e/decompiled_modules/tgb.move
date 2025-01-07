module 0x89a28dbd3139ad06591647e880b6ae4cb43c5a2a1b5aa2cddae56f7f910f606e::tgb {
    struct TGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TGB>(arg0, 380096865811198306, b"the great beast", b"TGB", b"Don't get too close, or i will tear you apart.", b"https://images.hop.ag/ipfs/QmSg3i6KEMRZebMzncVX1pL6SLqbcs2DcYVpH7H7xidewj", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

