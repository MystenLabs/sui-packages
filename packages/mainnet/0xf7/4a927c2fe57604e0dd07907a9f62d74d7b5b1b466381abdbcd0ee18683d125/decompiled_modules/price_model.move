module 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::price_model {
    struct PriceModel has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun delete_model(arg0: &AdminCap, arg1: &mut PriceModel, arg2: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg1.prices, arg2), 1);
        0x2::table::remove<0x1::string::String, u64>(&mut arg1.prices, arg2);
    }

    public fun get_price(arg0: &PriceModel, arg1: &0x1::string::String) : u64 {
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.prices, *arg1), 1);
        *0x2::table::borrow<0x1::string::String, u64>(&arg0.prices, *arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceModel{
            id     : 0x2::object::new(arg0),
            prices : 0x2::table::new<0x1::string::String, u64>(arg0),
        };
        0x2::transfer::share_object<PriceModel>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun update_price(arg0: &AdminCap, arg1: &mut PriceModel, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.prices, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.prices, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.prices, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

