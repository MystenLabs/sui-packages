module 0x4d02abcd24e5fd27123c60e30bea1ab9886de866eb1644c6353db674b786d035::butthole {
    struct BUTTHOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTHOLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BUTTHOLE>(arg0, 4798160209137356030, b"Butthole Coin", b"Butthole", b"Butthole coin made for fun.", b"https://images.hop.ag/ipfs/Qma5UzsLvfvXBmvPevZVDJ9UNBLTEgR1GL6379A3MxUmyC", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

