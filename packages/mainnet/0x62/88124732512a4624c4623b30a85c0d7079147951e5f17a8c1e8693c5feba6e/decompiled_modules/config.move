module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config {
    struct HopConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee_rate: u64,
        trading_enabled: bool,
        create_enabled: bool,
        liquidity_enabled: bool,
        collect_enabled: bool,
        flywheel_enabled: bool,
        min_version: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun enforce_collect_enabled(arg0: &HopConfig) {
        assert!(arg0.collect_enabled, 5);
    }

    public fun enforce_create_enabled(arg0: &HopConfig) {
        assert!(arg0.create_enabled, 3);
    }

    public fun enforce_flywheel_enabled(arg0: &HopConfig) {
        assert!(arg0.flywheel_enabled, 6);
    }

    public fun enforce_liquidity_enabled(arg0: &HopConfig) {
        assert!(arg0.liquidity_enabled, 4);
    }

    public fun enforce_min_version(arg0: &HopConfig) {
        assert!(0 >= arg0.min_version, 1);
    }

    public fun enforce_trading_enabled(arg0: &HopConfig) {
        assert!(arg0.trading_enabled, 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HopConfig{
            id                : 0x2::object::new(arg0),
            protocol_fee_rate : 300000,
            trading_enabled   : false,
            create_enabled    : false,
            liquidity_enabled : false,
            collect_enabled   : true,
            flywheel_enabled  : false,
            min_version       : 0,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<HopConfig>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun protocol_fee_rate(arg0: &HopConfig) : u64 {
        arg0.protocol_fee_rate
    }

    public fun set_collect_enabled(arg0: &AdminCap, arg1: &mut HopConfig, arg2: bool) {
        arg1.collect_enabled = arg2;
    }

    public fun set_create_enabled(arg0: &AdminCap, arg1: &mut HopConfig, arg2: bool) {
        arg1.create_enabled = arg2;
    }

    public fun set_flywheel_enabled(arg0: &AdminCap, arg1: &mut HopConfig, arg2: bool) {
        arg1.flywheel_enabled = arg2;
    }

    public fun set_liquidity_enabled(arg0: &AdminCap, arg1: &mut HopConfig, arg2: bool) {
        arg1.liquidity_enabled = arg2;
    }

    public fun set_min_version(arg0: &AdminCap, arg1: &mut HopConfig, arg2: u64) {
        arg1.min_version = arg2;
    }

    public fun set_protocol_fee_rate(arg0: &AdminCap, arg1: &mut HopConfig, arg2: u64) {
        assert!(arg2 <= 1000000, 0);
        arg1.protocol_fee_rate = arg2;
    }

    public fun set_trading_enabled(arg0: &AdminCap, arg1: &mut HopConfig, arg2: bool) {
        arg1.trading_enabled = arg2;
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

