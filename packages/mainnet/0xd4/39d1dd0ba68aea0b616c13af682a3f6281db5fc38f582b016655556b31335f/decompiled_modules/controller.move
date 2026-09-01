module 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller {
    struct Controller has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee_bps: u64,
        affiliate_bps: u64,
        dev_address: address,
        max_loss_bps: u64,
        min_rebalance_interval_ms: u64,
        max_price_drift_bps: u64,
    }

    struct ControllerAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ControllerCreated has copy, drop {
        controller_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct FeesChanged has copy, drop {
        fee_bps: u64,
        affiliate_bps: u64,
        dev_address: address,
    }

    struct RiskParamsChanged has copy, drop {
        max_loss_bps: u64,
        min_rebalance_interval_ms: u64,
        max_price_drift_bps: u64,
    }

    struct PausedChanged has copy, drop {
        paused: bool,
    }

    struct Migrated has copy, drop {
        from_version: u64,
        to_version: u64,
    }

    public fun affiliate_bps(arg0: &Controller) : u64 {
        arg0.affiliate_bps
    }

    public fun assert_active(arg0: &Controller) {
        assert_version(arg0);
        assert!(!arg0.paused, 5);
    }

    fun assert_version(arg0: &Controller) {
        assert!(arg0.version == 1, 1);
    }

    public fun bps() : u64 {
        10000
    }

    public fun destroy_admin_cap(arg0: ControllerAdminCap, arg1: &ControllerAdminCap) {
        let ControllerAdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun dev_address(arg0: &Controller) : address {
        arg0.dev_address
    }

    public fun fee_bps(arg0: &Controller) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ControllerAdminCap{id: 0x2::object::new(arg0)};
        let v1 = Controller{
            id                        : 0x2::object::new(arg0),
            version                   : 1,
            paused                    : false,
            fee_bps                   : 1500,
            affiliate_bps             : 300,
            dev_address               : 0x2::tx_context::sender(arg0),
            max_loss_bps              : 50,
            min_rebalance_interval_ms : 300000,
            max_price_drift_bps       : 100,
        };
        let v2 = ControllerCreated{
            controller_id : 0x2::object::id<Controller>(&v1),
            admin_cap_id  : 0x2::object::id<ControllerAdminCap>(&v0),
        };
        0x2::event::emit<ControllerCreated>(v2);
        0x2::transfer::share_object<Controller>(v1);
        0x2::transfer::public_transfer<ControllerAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Controller) : bool {
        arg0.paused
    }

    public fun max_loss_bps(arg0: &Controller) : u64 {
        arg0.max_loss_bps
    }

    public fun max_price_drift_bps(arg0: &Controller) : u64 {
        arg0.max_price_drift_bps
    }

    public fun migrate(arg0: &mut Controller, arg1: &ControllerAdminCap) {
        assert!(arg0.version < 1, 2);
        arg0.version = 1;
        let v0 = Migrated{
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun min_rebalance_interval_ms(arg0: &Controller) : u64 {
        arg0.min_rebalance_interval_ms
    }

    public fun mint_admin_cap(arg0: &ControllerAdminCap, arg1: &mut 0x2::tx_context::TxContext) : ControllerAdminCap {
        ControllerAdminCap{id: 0x2::object::new(arg1)}
    }

    public fun set_fees(arg0: &mut Controller, arg1: &ControllerAdminCap, arg2: u64, arg3: u64, arg4: address) {
        assert_version(arg0);
        assert!(arg2 <= 2000, 3);
        assert!(arg3 <= arg2, 3);
        arg0.fee_bps = arg2;
        arg0.affiliate_bps = arg3;
        arg0.dev_address = arg4;
        let v0 = FeesChanged{
            fee_bps       : arg2,
            affiliate_bps : arg3,
            dev_address   : arg4,
        };
        0x2::event::emit<FeesChanged>(v0);
    }

    public fun set_paused(arg0: &mut Controller, arg1: &ControllerAdminCap, arg2: bool) {
        assert_version(arg0);
        arg0.paused = arg2;
        let v0 = PausedChanged{paused: arg2};
        0x2::event::emit<PausedChanged>(v0);
    }

    public fun set_risk_params(arg0: &mut Controller, arg1: &ControllerAdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg0);
        assert!(arg2 <= 500, 4);
        arg0.max_loss_bps = arg2;
        arg0.min_rebalance_interval_ms = arg3;
        arg0.max_price_drift_bps = arg4;
        let v0 = RiskParamsChanged{
            max_loss_bps              : arg2,
            min_rebalance_interval_ms : arg3,
            max_price_drift_bps       : arg4,
        };
        0x2::event::emit<RiskParamsChanged>(v0);
    }

    public fun version(arg0: &Controller) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

