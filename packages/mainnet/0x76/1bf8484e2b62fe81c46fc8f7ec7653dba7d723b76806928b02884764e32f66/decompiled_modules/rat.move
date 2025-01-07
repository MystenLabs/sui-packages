module 0x761bf8484e2b62fe81c46fc8f7ec7653dba7d723b76806928b02884764e32f66::rat {
    struct RAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<RAT>(arg0, 16647900275973831670, b"SUI RAT", b"RAT", b"No pain ,No gain ,Have Fun!", b"https://images.hop.ag/ipfs/QmX2PKMbAcS6GnJfV4uFFwMpBDZhLfi8U8H59NopJWyQSq", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

