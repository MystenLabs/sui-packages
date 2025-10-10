module 0x679e10cefe401da6e8469812f4dcd74b73a348d4090ca2089c7f17ff47ea0fad::price_oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        current_price: u64,
        last_update: u64,
        update_frequency: u64,
        price_deviation_limit: u64,
        is_stable: bool,
    }

    struct OracleAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
        timestamp: u64,
        is_stable: bool,
        updater: address,
    }

    struct StabilityChanged has copy, drop {
        price: u64,
        was_stable: bool,
        is_stable: bool,
        timestamp: u64,
    }

    public fun can_update(arg0: &PriceOracle, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.last_update + arg0.update_frequency
    }

    public fun get_deviation_bp(arg0: &PriceOracle) : u64 {
        let v0 = arg0.current_price;
        let v1 = if (v0 > 100) {
            v0 - 100
        } else {
            100 - v0
        };
        v1 * 10000 / 100
    }

    public fun get_last_update(arg0: &PriceOracle) : u64 {
        arg0.last_update
    }

    public fun get_oracle_stats(arg0: &PriceOracle) : (u64, u64, u64, bool) {
        (arg0.current_price, arg0.last_update, arg0.price_deviation_limit, arg0.is_stable)
    }

    public fun get_price(arg0: &PriceOracle) : u64 {
        arg0.current_price
    }

    public fun get_price_usd(arg0: &PriceOracle) : u64 {
        arg0.current_price
    }

    public fun get_target_price() : u64 {
        100
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id                    : 0x2::object::new(arg0),
            current_price         : 100,
            last_update           : 0,
            update_frequency      : 300000,
            price_deviation_limit : 500,
            is_stable             : true,
        };
        let v1 = OracleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OracleAdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PriceOracle>(v0);
    }

    public fun is_stable(arg0: &PriceOracle) : bool {
        arg0.is_stable
    }

    public entry fun update_deviation_limit(arg0: &OracleAdminCap, arg1: &mut PriceOracle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price_deviation_limit = arg2;
    }

    public entry fun update_frequency(arg0: &OracleAdminCap, arg1: &mut PriceOracle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.update_frequency = arg2;
    }

    public entry fun update_price(arg0: &OracleAdminCap, arg1: &mut PriceOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.last_update + arg1.update_frequency, 3);
        assert!(arg2 >= 50 && arg2 <= 150, 2);
        let v1 = arg1.is_stable;
        arg1.current_price = arg2;
        arg1.last_update = v0;
        let v2 = if (arg2 > 100) {
            arg2 - 100
        } else {
            100 - arg2
        };
        arg1.is_stable = v2 * 10000 / 100 <= arg1.price_deviation_limit;
        let v3 = PriceUpdated{
            old_price : arg1.current_price,
            new_price : arg2,
            timestamp : v0,
            is_stable : arg1.is_stable,
            updater   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PriceUpdated>(v3);
        if (v1 != arg1.is_stable) {
            let v4 = StabilityChanged{
                price      : arg2,
                was_stable : v1,
                is_stable  : arg1.is_stable,
                timestamp  : v0,
            };
            0x2::event::emit<StabilityChanged>(v4);
        };
    }

    // decompiled from Move bytecode v6
}

