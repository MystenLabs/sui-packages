module 0xc3b38818d4cd99caee44d915f213154678895c3766193cd0067e6f82b49a0974::price_supra {
    struct PriceHolder has store, key {
        id: 0x2::object::UID,
        feeds: 0x2::vec_map::VecMap<u32, PriceEntry>,
    }

    struct PriceEntry has copy, drop, store {
        value: u128,
        decimal: u16,
        timestamp: u128,
        round: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun get_update_price(arg0: &AdminCap, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &mut PriceHolder, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg1, arg3);
        update_price(arg2, arg3, v0, v1, v2, v3);
    }

    public entry fun get_update_prices(arg0: &AdminCap, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &mut PriceHolder, arg3: vector<u32>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_prices(arg1, arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::Price>(&v0)) {
            let (v2, v3, v4, v5, v6) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::extract_price(0x1::vector::borrow<0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::Price>(&v0, v1));
            update_price(arg2, v2, v3, v4, v5, v6);
            v1 = v1 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceHolder{
            id    : 0x2::object::new(arg0),
            feeds : 0x2::vec_map::empty<u32, PriceEntry>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PriceHolder>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    fun update_price(arg0: &mut PriceHolder, arg1: u32, arg2: u128, arg3: u16, arg4: u128, arg5: u64) {
        let v0 = arg0.feeds;
        if (0x2::vec_map::contains<u32, PriceEntry>(&v0, &arg1)) {
            let v1 = 0x2::vec_map::get_mut<u32, PriceEntry>(&mut arg0.feeds, &arg1);
            v1.value = arg2;
            v1.decimal = arg3;
            v1.timestamp = arg4;
            v1.round = arg5;
        } else {
            let v2 = PriceEntry{
                value     : arg2,
                decimal   : arg3,
                timestamp : arg4,
                round     : arg5,
            };
            0x2::vec_map::insert<u32, PriceEntry>(&mut arg0.feeds, arg1, v2);
        };
    }

    // decompiled from Move bytecode v6
}

