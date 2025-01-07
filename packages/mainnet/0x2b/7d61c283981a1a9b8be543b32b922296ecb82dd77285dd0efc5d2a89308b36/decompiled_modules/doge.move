module 0x2b7d61c283981a1a9b8be543b32b922296ecb82dd77285dd0efc5d2a89308b36::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DOGE>(arg0, 7230064954225363696, b"DOGECOIN", b"DOGE", b"DOGECOIN ON SUI", b"https://images.hop.ag/ipfs/QmeciRDeHrqPEa52hKyqTG3V5xcMk7vGDizc6aQz3T5cHG", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

