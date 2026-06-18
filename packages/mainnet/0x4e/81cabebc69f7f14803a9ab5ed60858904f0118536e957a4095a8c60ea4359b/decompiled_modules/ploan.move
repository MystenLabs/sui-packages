module 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan {
    struct PLOAN has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RiskAdminCap has store, key {
        id: 0x2::object::UID,
        scope: u8,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        paused_global: bool,
        treasury: address,
        bad_debt_usd: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
        bad_debt_limit_usd: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
    }

    public(friend) fun add_bad_debt(arg0: &mut GlobalConfig, arg1: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) {
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(arg0.bad_debt_usd, arg1);
        assert!(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::le(v0, arg0.bad_debt_limit_usd), 4);
        arg0.bad_debt_usd = v0;
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_config_changed(0x2::object::id<GlobalConfig>(arg0), b"bad_debt_usd", arg0.version);
    }

    public fun assert_not_paused(arg0: &GlobalConfig) {
        assert!(!arg0.paused_global, 3);
    }

    public fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 1);
    }

    public fun bad_debt_limit_usd(arg0: &GlobalConfig) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        arg0.bad_debt_limit_usd
    }

    public fun bad_debt_usd(arg0: &GlobalConfig) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        arg0.bad_debt_usd
    }

    public fun eliminate_deficit(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) {
        arg1.bad_debt_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub_or_zero(arg1.bad_debt_usd, arg2);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_config_changed(0x2::object::id<GlobalConfig>(arg1), b"bad_debt_usd", arg1.version);
    }

    fun init(arg0: PLOAN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<PLOAN>(&arg0), 0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = RiskAdminCap{
            id    : 0x2::object::new(arg1),
            scope : 0,
        };
        0x2::transfer::transfer<RiskAdminCap>(v2, v0);
        let v3 = GlobalConfig{
            id                 : 0x2::object::new(arg1),
            version            : 1,
            paused_global      : false,
            treasury           : v0,
            bad_debt_usd       : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero(),
            bad_debt_limit_usd : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(1000000),
        };
        0x2::transfer::share_object<GlobalConfig>(v3);
        0x2::package::claim_and_keep<PLOAN>(arg0, arg1);
    }

    public fun is_paused(arg0: &GlobalConfig) : bool {
        arg0.paused_global
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_config_changed(0x2::object::id<GlobalConfig>(arg1), b"version", arg1.version);
    }

    public fun mint_risk_cap(arg0: &AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : RiskAdminCap {
        RiskAdminCap{
            id    : 0x2::object::new(arg2),
            scope : arg1,
        }
    }

    public(friend) fun reduce_bad_debt(arg0: &mut GlobalConfig, arg1: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) {
        arg0.bad_debt_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub_or_zero(arg0.bad_debt_usd, arg1);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_config_changed(0x2::object::id<GlobalConfig>(arg0), b"bad_debt_usd", arg0.version);
    }

    public fun risk_cap_scope(arg0: &RiskAdminCap) : u8 {
        arg0.scope
    }

    public fun set_bad_debt_limit(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) {
        arg1.bad_debt_limit_usd = arg2;
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_config_changed(0x2::object::id<GlobalConfig>(arg1), b"bad_debt_limit_usd", arg1.version);
    }

    public fun set_pause(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.paused_global = arg2;
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_config_changed(0x2::object::id<GlobalConfig>(arg1), b"paused_global", arg1.version);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.treasury = arg2;
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_config_changed(0x2::object::id<GlobalConfig>(arg1), b"treasury", arg1.version);
    }

    public fun treasury(arg0: &GlobalConfig) : address {
        arg0.treasury
    }

    public fun version(arg0: &GlobalConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

