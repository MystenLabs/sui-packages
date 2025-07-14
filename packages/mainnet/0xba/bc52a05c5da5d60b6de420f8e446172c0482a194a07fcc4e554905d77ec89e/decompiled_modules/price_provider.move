module 0xbabc52a05c5da5d60b6de420f8e446172c0482a194a07fcc4e554905d77ec89e::price_provider {
    struct PriceProvider has store, key {
        id: 0x2::object::UID,
        admins: 0x2::table::Table<address, bool>,
        prices: 0x2::table::Table<address, u64>,
    }

    public fun add_admin(arg0: &mut PriceProvider, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.admins, 0x2::tx_context::sender(arg2)), 0);
        0x2::table::add<address, bool>(&mut arg0.admins, arg1, true);
    }

    public fun get_price(arg0: &PriceProvider, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.prices, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.prices, arg1)
        } else {
            0
        }
    }

    public fun has_feed(arg0: &PriceProvider, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.prices, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v0, 0x2::tx_context::sender(arg0), true);
        let v1 = PriceProvider{
            id     : 0x2::object::new(arg0),
            admins : v0,
            prices : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<PriceProvider>(v1);
    }

    public fun update_price(arg0: &mut PriceProvider, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.admins, 0x2::tx_context::sender(arg3)), 0);
        assert!(arg2 > 0, 1);
        if (0x2::table::contains<address, u64>(&arg0.prices, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.prices, arg1);
        };
        0x2::table::add<address, u64>(&mut arg0.prices, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

