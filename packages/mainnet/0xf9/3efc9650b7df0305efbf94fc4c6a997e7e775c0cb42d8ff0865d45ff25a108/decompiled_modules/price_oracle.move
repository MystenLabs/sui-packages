module 0xf93efc9650b7df0305efbf94fc4c6a997e7e775c0cb42d8ff0865d45ff25a108::price_oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        sui_price: u64,
        pre_price: u64,
        timestamp: u64,
    }

    public fun get_pre_amount(arg0: &PriceOracle, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.sui_price == 0) {
            return 0
        };
        arg1 * 1000 * 1000000 / arg0.pre_price
    }

    public fun get_price(arg0: &PriceOracle) : (u64, u64, u64) {
        (arg0.sui_price, arg0.pre_price, arg0.timestamp)
    }

    public fun get_sui_amount(arg0: &PriceOracle, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.sui_price == 0) {
            return 0
        };
        arg1 * 1000 * 1000000 / arg0.sui_price
    }

    public fun get_usdt_amount(arg0: &PriceOracle, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.pre_price == 0) {
            return 0
        };
        arg1 * arg0.pre_price / 1000000 / 1000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id        : 0x2::object::new(arg0),
            sui_price : 1660000,
            pre_price : 1660000,
            timestamp : 0,
        };
        0x2::transfer::share_object<PriceOracle>(v0);
    }

    public fun update_price(arg0: &mut PriceOracle, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(@0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca == 0x2::tx_context::sender(arg4), 201);
        arg0.sui_price = arg1;
        arg0.pre_price = arg2;
        arg0.timestamp = arg3;
    }

    // decompiled from Move bytecode v6
}

