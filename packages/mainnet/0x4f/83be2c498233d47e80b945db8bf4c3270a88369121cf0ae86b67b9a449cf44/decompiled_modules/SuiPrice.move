module 0x4f83be2c498233d47e80b945db8bf4c3270a88369121cf0ae86b67b9a449cf44::SuiPrice {
    struct ExampleHolder has store, key {
        id: 0x2::object::UID,
        feeds: 0x2::vec_map::VecMap<u32, ExampleEntry>,
    }

    struct ExampleEntry has copy, drop, store {
        value: u128,
        decimal: u16,
        timestamp: u128,
        round: u64,
    }

    public entry fun get_update_price(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: &mut ExampleHolder, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, arg2);
        update_price(arg1, arg2, v0, v1, v2, v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ExampleHolder{
            id    : 0x2::object::new(arg0),
            feeds : 0x2::vec_map::empty<u32, ExampleEntry>(),
        };
        0x2::transfer::share_object<ExampleHolder>(v0);
    }

    fun update_price(arg0: &mut ExampleHolder, arg1: u32, arg2: u128, arg3: u16, arg4: u128, arg5: u64) {
        let v0 = arg0.feeds;
        if (0x2::vec_map::contains<u32, ExampleEntry>(&v0, &arg1)) {
            let v1 = 0x2::vec_map::get_mut<u32, ExampleEntry>(&mut arg0.feeds, &arg1);
            v1.value = arg2;
            v1.decimal = arg3;
            v1.timestamp = arg4;
            v1.round = arg5;
        } else {
            let v2 = ExampleEntry{
                value     : arg2,
                decimal   : arg3,
                timestamp : arg4,
                round     : arg5,
            };
            0x2::vec_map::insert<u32, ExampleEntry>(&mut arg0.feeds, arg1, v2);
        };
    }

    // decompiled from Move bytecode v6
}

