module 0xb1868adf3307018119dd4d2d4d5d3224dc55f913bc9794e6af80e5bbe668ba09::test_module {
    public fun a(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        let (_, _, _, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, 1);
    }

    // decompiled from Move bytecode v6
}

