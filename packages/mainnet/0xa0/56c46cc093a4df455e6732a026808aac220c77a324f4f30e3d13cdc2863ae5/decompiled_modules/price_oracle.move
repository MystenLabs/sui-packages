module 0xcb1eb9f050884fde155514433ae0ca8ea0af5be00850522441aa3d7a7b2f073::price_oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        price: u64,
        timestamp: u64,
    }

    public fun get_amount(arg0: &PriceOracle, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.price == 0) {
            return 0
        };
        arg1 * 1000 * 1000000 / arg0.price
    }

    public fun get_price(arg0: &PriceOracle) : (u64, u64) {
        (arg0.price, arg0.timestamp)
    }

    public fun init_new_resource(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id        : 0x2::object::new(arg0),
            price     : 3660000,
            timestamp : 0,
        };
        0x2::transfer::share_object<PriceOracle>(v0);
    }

    public fun update_price(arg0: &mut PriceOracle, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0xf771a5de8a0cda22f2fb8fe4ac2d7b22b3584c34ee7f0fe191dcff10975fdb26 == 0x2::tx_context::sender(arg3), 201);
        arg0.price = arg1;
        arg0.timestamp = arg2;
    }

    // decompiled from Move bytecode v6
}

