module 0x3b38314c53b9e54fd528eb1f91ca0a394362e6b1181a636c2410c4313c6ed5d3::duk {
    struct DUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DUK>(arg0, 16113162426078988197, b"Dukhop", b"DUK", b"Dukhop", b"https://images.hop.ag/ipfs/QmWSCX6PAKadbs1rU1CnUnx2VQmQGzBmWUSRbzqq971Q4t", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/dukhopsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

