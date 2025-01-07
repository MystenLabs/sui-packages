module 0xc2ab2e66f464d2f72be5cbb2de6ea840cfaee5297e56b2a3bd202bbd1edad536::test_module {
    public fun a(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        let (_, _, _, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, 1);
    }

    // decompiled from Move bytecode v6
}

