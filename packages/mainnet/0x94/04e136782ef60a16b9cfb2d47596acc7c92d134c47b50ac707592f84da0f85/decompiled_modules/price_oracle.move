module 0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::price_oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        sui_price: u64,
        pre_price: u64,
        timestamp: u64,
    }

    public fun get_pre_amount(arg0: &PriceOracle, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.pre_price == 0) {
            return 0
        };
        if (arg1 == 0 || arg0.pre_price == 0) {
            return 0
        };
        (((arg1 as u128) * 10000000 / (arg0.pre_price as u128)) as u64)
    }

    public fun get_sui_amount(arg0: &PriceOracle, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.sui_price == 0) {
            return 0
        };
        (((arg1 as u128) * 1000000000000 / (arg0.sui_price as u128)) as u64)
    }

    public fun get_usdt_from_pre(arg0: &PriceOracle, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.pre_price == 0) {
            return 0
        };
        (((arg1 as u128) * (arg0.pre_price as u128) / 10000000) as u64)
    }

    public fun get_usdt_from_sui(arg0: &PriceOracle, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.sui_price == 0) {
            return 0
        };
        (((arg1 as u128) * (arg0.sui_price as u128) / 1000000000000) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id        : 0x2::object::new(arg0),
            version   : 1,
            sui_price : 1411883242,
            pre_price : 282376,
            timestamp : 0,
        };
        0x2::transfer::share_object<PriceOracle>(v0);
    }

    public fun update_price(arg0: &mut PriceOracle, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 100);
        assert!(@0xb23566c96b68ca108257039e8dce14c5d40abec904a7f10271863664e4e23806 == 0x2::tx_context::sender(arg4), 201);
        arg0.sui_price = arg1;
        arg0.pre_price = arg2;
        arg0.timestamp = arg3;
    }

    // decompiled from Move bytecode v6
}

