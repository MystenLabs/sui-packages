module 0xa247493239a8adda5f18e33ae28e9be030d76e41446714ea633051e359e39a7e::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BTC>(arg0, 1866653514978707716, b"BITCOIN", b"BTC", b"COMUNITY", b"https://images.hop.ag/ipfs/QmSXimWm8RXshATNxykZPtLCDo69Kg4j7VqfFQwVcLuoJL", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

