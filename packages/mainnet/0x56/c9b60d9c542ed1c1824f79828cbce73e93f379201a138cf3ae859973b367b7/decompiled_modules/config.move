module 0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        platform_fee_bps: u64,
        operator: address,
    }

    struct ConfigUpdated has copy, drop {
        treasury: address,
        platform_fee_bps: u64,
        operator: address,
    }

    public fun bps_denominator() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = PlatformConfig{
            id               : 0x2::object::new(arg0),
            treasury         : v0,
            platform_fee_bps : 1000,
            operator         : v0,
        };
        0x2::transfer::share_object<PlatformConfig>(v2);
    }

    public fun operator(arg0: &PlatformConfig) : address {
        arg0.operator
    }

    public fun platform_fee_bps(arg0: &PlatformConfig) : u64 {
        arg0.platform_fee_bps
    }

    public fun treasury(arg0: &PlatformConfig) : address {
        arg0.treasury
    }

    public fun update_config(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address, arg3: u64, arg4: address) {
        assert!(arg3 <= 2500, 1);
        arg1.treasury = arg2;
        arg1.platform_fee_bps = arg3;
        arg1.operator = arg4;
        let v0 = ConfigUpdated{
            treasury         : arg2,
            platform_fee_bps : arg3,
            operator         : arg4,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

