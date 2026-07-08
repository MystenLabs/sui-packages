module 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LiquidatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct PendingChange has drop, store {
        change_type: u8,
        new_values: vector<u64>,
        execute_after: u64,
    }

    struct GlobalParams has key {
        id: 0x2::object::UID,
        fee_rate_bps: u64,
        initial_margin_ratio_bps: u64,
        maintenance_margin_ratio_bps: u64,
        max_leverage: u64,
        max_oi_cap: u64,
        liquidator_fee_bps: u16,
        insurance_fund_bps: u16,
        treasury_bps: u16,
        paused: bool,
        pending_change: 0x1::option::Option<PendingChange>,
        last_fee_rate_cancelled_at_ms: u64,
        last_margin_params_cancelled_at_ms: u64,
        last_max_leverage_cancelled_at_ms: u64,
        last_max_oi_cap_cancelled_at_ms: u64,
    }

    struct RiskParams has key {
        id: 0x2::object::UID,
        max_price_deviation_bps: u64,
        max_total_funding_rate_bps: u64,
        max_position_size_bps: u64,
    }

    struct ProtocolPaused has copy, drop {
        dummy: bool,
    }

    struct ProtocolUnpaused has copy, drop {
        dummy: bool,
    }

    struct FeeRateUpdated has copy, drop {
        old_fee_rate_bps: u64,
        new_fee_rate_bps: u64,
    }

    struct MarginParamsUpdated has copy, drop {
        old_initial_margin_bps: u64,
        new_initial_margin_bps: u64,
        old_maintenance_margin_bps: u64,
        new_maintenance_margin_bps: u64,
    }

    struct MaxLeverageUpdated has copy, drop {
        old_max_leverage: u64,
        new_max_leverage: u64,
    }

    struct MaxOiCapUpdated has copy, drop {
        old_max_oi_cap: u64,
        new_max_oi_cap: u64,
    }

    struct ChangeQueued has copy, drop {
        change_type: u8,
        execute_after: u64,
    }

    struct AdminTransferred has copy, drop {
        dummy: bool,
    }

    public fun assert_not_paused(arg0: &GlobalParams) {
        assert!(!arg0.paused, 0);
    }

    public fun cancel_pending_change(arg0: &AdminCap, arg1: &mut GlobalParams, arg2: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<PendingChange>(&arg1.pending_change), 9);
        let v0 = 0x1::option::extract<PendingChange>(&mut arg1.pending_change);
        record_cancel(arg1, v0.change_type, 0x2::clock::timestamp_ms(arg2));
    }

    public fun create_risk_params(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RiskParams>(new_default_risk_params(arg1));
    }

    fun enforce_cancel_cooldown(arg0: u64, arg1: u64) {
        assert!(arg0 == 0 || arg1 >= arg0 && arg1 - arg0 >= 86400000, 14);
    }

    public fun execute_pending_change(arg0: &AdminCap, arg1: &mut GlobalParams, arg2: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<PendingChange>(&arg1.pending_change), 9);
        let v0 = 0x1::option::extract<PendingChange>(&mut arg1.pending_change);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.execute_after, 8);
        if (v0.change_type == 0) {
            arg1.fee_rate_bps = *0x1::vector::borrow<u64>(&v0.new_values, 0);
            let v1 = FeeRateUpdated{
                old_fee_rate_bps : arg1.fee_rate_bps,
                new_fee_rate_bps : *0x1::vector::borrow<u64>(&v0.new_values, 0),
            };
            0x2::event::emit<FeeRateUpdated>(v1);
        } else if (v0.change_type == 1) {
            arg1.initial_margin_ratio_bps = *0x1::vector::borrow<u64>(&v0.new_values, 0);
            arg1.maintenance_margin_ratio_bps = *0x1::vector::borrow<u64>(&v0.new_values, 1);
            let v2 = MarginParamsUpdated{
                old_initial_margin_bps     : arg1.initial_margin_ratio_bps,
                new_initial_margin_bps     : *0x1::vector::borrow<u64>(&v0.new_values, 0),
                old_maintenance_margin_bps : arg1.maintenance_margin_ratio_bps,
                new_maintenance_margin_bps : *0x1::vector::borrow<u64>(&v0.new_values, 1),
            };
            0x2::event::emit<MarginParamsUpdated>(v2);
        } else if (v0.change_type == 2) {
            arg1.max_leverage = *0x1::vector::borrow<u64>(&v0.new_values, 0);
            let v3 = MaxLeverageUpdated{
                old_max_leverage : arg1.max_leverage,
                new_max_leverage : *0x1::vector::borrow<u64>(&v0.new_values, 0),
            };
            0x2::event::emit<MaxLeverageUpdated>(v3);
        } else if (v0.change_type == 3) {
            arg1.max_oi_cap = *0x1::vector::borrow<u64>(&v0.new_values, 0);
            let v4 = MaxOiCapUpdated{
                old_max_oi_cap : arg1.max_oi_cap,
                new_max_oi_cap : *0x1::vector::borrow<u64>(&v0.new_values, 0),
            };
            0x2::event::emit<MaxOiCapUpdated>(v4);
        };
    }

    public fun fee_rate_bps(arg0: &GlobalParams) : u64 {
        arg0.fee_rate_bps
    }

    public fun grant_liquidator_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<LiquidatorCap>(v0, arg1);
    }

    public fun has_pending_change(arg0: &GlobalParams) : bool {
        0x1::option::is_some<PendingChange>(&arg0.pending_change)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalParams{
            id                                 : 0x2::object::new(arg0),
            fee_rate_bps                       : 5,
            initial_margin_ratio_bps           : 1000,
            maintenance_margin_ratio_bps       : 500,
            max_leverage                       : 20,
            max_oi_cap                         : 1000000000000,
            liquidator_fee_bps                 : 200,
            insurance_fund_bps                 : 500,
            treasury_bps                       : 100,
            paused                             : false,
            pending_change                     : 0x1::option::none<PendingChange>(),
            last_fee_rate_cancelled_at_ms      : 0,
            last_margin_params_cancelled_at_ms : 0,
            last_max_leverage_cancelled_at_ms  : 0,
            last_max_oi_cap_cancelled_at_ms    : 0,
        };
        0x2::transfer::share_object<GlobalParams>(v1);
    }

    public fun initial_margin_ratio_bps(arg0: &GlobalParams) : u64 {
        arg0.initial_margin_ratio_bps
    }

    public fun insurance_fund_bps(arg0: &GlobalParams) : u16 {
        arg0.insurance_fund_bps
    }

    public fun is_paused(arg0: &GlobalParams) : bool {
        arg0.paused
    }

    public fun liquidator_fee_bps(arg0: &GlobalParams) : u16 {
        arg0.liquidator_fee_bps
    }

    public fun maintenance_margin_ratio_bps(arg0: &GlobalParams) : u64 {
        arg0.maintenance_margin_ratio_bps
    }

    public fun max_leverage(arg0: &GlobalParams) : u64 {
        arg0.max_leverage
    }

    public fun max_oi_cap(arg0: &GlobalParams) : u64 {
        arg0.max_oi_cap
    }

    public fun max_position_size_bps(arg0: &RiskParams) : u64 {
        arg0.max_position_size_bps
    }

    public fun max_price_deviation_bps(arg0: &RiskParams) : u64 {
        arg0.max_price_deviation_bps
    }

    public fun max_total_funding_rate_bps(arg0: &RiskParams) : u64 {
        arg0.max_total_funding_rate_bps
    }

    fun new_default_risk_params(arg0: &mut 0x2::tx_context::TxContext) : RiskParams {
        RiskParams{
            id                         : 0x2::object::new(arg0),
            max_price_deviation_bps    : 2000,
            max_total_funding_rate_bps : 876000,
            max_position_size_bps      : 2500,
        }
    }

    public fun pause(arg0: &AdminCap, arg1: &mut GlobalParams) {
        assert!(!arg1.paused, 0);
        arg1.paused = true;
        let v0 = ProtocolPaused{dummy: true};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun queue_fee_rate_update(arg0: &AdminCap, arg1: &mut GlobalParams, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 <= 100, 2);
        enforce_cancel_cooldown(arg1.last_fee_rate_cancelled_at_ms, 0x2::clock::timestamp_ms(arg3));
        let v0 = 0x2::clock::timestamp_ms(arg3) + 86400000;
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg2);
        let v2 = PendingChange{
            change_type   : 0,
            new_values    : v1,
            execute_after : v0,
        };
        0x1::option::fill<PendingChange>(&mut arg1.pending_change, v2);
        let v3 = ChangeQueued{
            change_type   : 0,
            execute_after : v0,
        };
        0x2::event::emit<ChangeQueued>(v3);
    }

    public fun queue_margin_params_update(arg0: &AdminCap, arg1: &mut GlobalParams, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 >= 100, 3);
        assert!(arg3 >= 50, 4);
        assert!(arg2 > arg3, 5);
        enforce_cancel_cooldown(arg1.last_margin_params_cancelled_at_ms, 0x2::clock::timestamp_ms(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg4) + 86400000;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, arg3);
        let v3 = PendingChange{
            change_type   : 1,
            new_values    : v1,
            execute_after : v0,
        };
        0x1::option::fill<PendingChange>(&mut arg1.pending_change, v3);
        let v4 = ChangeQueued{
            change_type   : 1,
            execute_after : v0,
        };
        0x2::event::emit<ChangeQueued>(v4);
    }

    public fun queue_max_leverage_update(arg0: &AdminCap, arg1: &mut GlobalParams, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 >= 1, 7);
        assert!(arg2 <= 20, 6);
        enforce_cancel_cooldown(arg1.last_max_leverage_cancelled_at_ms, 0x2::clock::timestamp_ms(arg3));
        let v0 = 0x2::clock::timestamp_ms(arg3) + 86400000;
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg2);
        let v2 = PendingChange{
            change_type   : 2,
            new_values    : v1,
            execute_after : v0,
        };
        0x1::option::fill<PendingChange>(&mut arg1.pending_change, v2);
        let v3 = ChangeQueued{
            change_type   : 2,
            execute_after : v0,
        };
        0x2::event::emit<ChangeQueued>(v3);
    }

    public fun queue_max_oi_cap_update(arg0: &AdminCap, arg1: &mut GlobalParams, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 > 0, 10);
        enforce_cancel_cooldown(arg1.last_max_oi_cap_cancelled_at_ms, 0x2::clock::timestamp_ms(arg3));
        let v0 = 0x2::clock::timestamp_ms(arg3) + 86400000;
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg2);
        let v2 = PendingChange{
            change_type   : 3,
            new_values    : v1,
            execute_after : v0,
        };
        0x1::option::fill<PendingChange>(&mut arg1.pending_change, v2);
        let v3 = ChangeQueued{
            change_type   : 3,
            execute_after : v0,
        };
        0x2::event::emit<ChangeQueued>(v3);
    }

    fun record_cancel(arg0: &mut GlobalParams, arg1: u8, arg2: u64) {
        if (arg1 == 0) {
            arg0.last_fee_rate_cancelled_at_ms = arg2;
        } else if (arg1 == 1) {
            arg0.last_margin_params_cancelled_at_ms = arg2;
        } else if (arg1 == 2) {
            arg0.last_max_leverage_cancelled_at_ms = arg2;
        } else {
            arg0.last_max_oi_cap_cancelled_at_ms = arg2;
        };
    }

    public fun revoke_liquidator_cap(arg0: LiquidatorCap) {
        let LiquidatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun set_fee_routing(arg0: &AdminCap, arg1: &mut GlobalParams, arg2: u16, arg3: u16, arg4: u16) {
        validate_fee_routing(arg2, arg3, arg4);
        arg1.liquidator_fee_bps = arg2;
        arg1.insurance_fund_bps = arg3;
        arg1.treasury_bps = arg4;
    }

    public fun set_risk_params(arg0: &AdminCap, arg1: &mut RiskParams, arg2: u64, arg3: u64, arg4: u64) {
        validate_risk_params(arg2, arg3, arg4);
        arg1.max_price_deviation_bps = arg2;
        arg1.max_total_funding_rate_bps = arg3;
        arg1.max_position_size_bps = arg4;
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = AdminTransferred{dummy: true};
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun treasury_bps(arg0: &GlobalParams) : u16 {
        arg0.treasury_bps
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut GlobalParams) {
        assert!(arg1.paused, 1);
        arg1.paused = false;
        let v0 = ProtocolUnpaused{dummy: true};
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    fun validate_fee_routing(arg0: u16, arg1: u16, arg2: u16) {
        assert!((arg0 as u64) + (arg1 as u64) + (arg2 as u64) <= 10000, 11);
    }

    fun validate_risk_params(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 13);
        assert!(arg0 <= 10000, 12);
        assert!(arg1 > 0, 13);
        assert!(arg2 > 0, 13);
        assert!(arg2 <= 10000, 12);
    }

    // decompiled from Move bytecode v7
}

