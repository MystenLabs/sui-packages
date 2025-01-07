module 0x2863d84013ef867024199fc693fcd2f04e60ab507f748604d39f78292211436c::bb_3 {
    struct BB_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB_3, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BB_3>(arg0, 11577580631189893197, b"Baby three", b"BB3", b"BB3's trending nowwwwww", b"https://images.hop.ag/ipfs/QmRNChcPzjaJKcSLcyQHdK1nHKQPuf6rFPxES6NKXsgABD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

