module 0xa1e4171bef434da8e25e3a05444cd9cc4619cde7349fff14443e1dd6756b64e2::wsf {
    struct WSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WSF>(arg0, 3673359865461261816, b"Wall Street Forex", b"WSF", x"4e6578742067c3a96ec3a9726174696f6e20666f722074726164696e67", b"https://images.hop.ag/ipfs/QmQmX89nT7ov7bgR1YBFgBAFq8ccBZyGb8Xupr6TkmUkbE", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

