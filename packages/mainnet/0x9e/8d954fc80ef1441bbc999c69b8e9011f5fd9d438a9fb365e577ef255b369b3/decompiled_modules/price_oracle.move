module 0xcb22c8a3069ac0dee2961233044244d8aef0f2cbe6b180f97ec7254a2c8ef376::price_oracle {
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
        assert!(@0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45 == 0x2::tx_context::sender(arg4), 201);
        arg0.sui_price = arg1;
        arg0.pre_price = arg2;
        arg0.timestamp = arg3;
    }

    // decompiled from Move bytecode v6
}

