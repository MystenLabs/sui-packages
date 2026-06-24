module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::depeg_oracle {
    struct DepegOracle has key {
        id: 0x2::object::UID,
        price_1e8: u64,
        updated_at_ms: u64,
        source: vector<u8>,
    }

    struct DepegPriceUpdated has copy, drop {
        price_1e8: u64,
        updated_at_ms: u64,
        source: vector<u8>,
    }

    public fun admin_update_price(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut DepegOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.price_1e8 = arg2;
        arg1.updated_at_ms = v0;
        arg1.source = b"admin-shim";
        let v1 = DepegPriceUpdated{
            price_1e8     : arg2,
            updated_at_ms : v0,
            source        : arg1.source,
        };
        0x2::event::emit<DepegPriceUpdated>(v1);
    }

    public fun init_depeg_oracle(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DepegOracle{
            id            : 0x2::object::new(arg2),
            price_1e8     : 100000000,
            updated_at_ms : 0x2::clock::timestamp_ms(arg1),
            source        : b"init",
        };
        0x2::transfer::share_object<DepegOracle>(v0);
    }

    public fun max_staleness_ms() : u64 {
        30000
    }

    public fun price_scale() : u64 {
        100000000
    }

    public fun read_usdc_px(arg0: &DepegOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.updated_at_ms) {
            assert!(v0 - arg0.updated_at_ms <= 30000, 1);
        };
        arg0.price_1e8
    }

    public fun source(arg0: &DepegOracle) : vector<u8> {
        arg0.source
    }

    public fun try_read_usdc_px(arg0: &DepegOracle, arg1: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.updated_at_ms) {
            0x1::option::some<u64>(arg0.price_1e8)
        } else if (v0 - arg0.updated_at_ms <= 30000) {
            0x1::option::some<u64>(arg0.price_1e8)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun updated_at_ms(arg0: &DepegOracle) : u64 {
        arg0.updated_at_ms
    }

    // decompiled from Move bytecode v7
}

