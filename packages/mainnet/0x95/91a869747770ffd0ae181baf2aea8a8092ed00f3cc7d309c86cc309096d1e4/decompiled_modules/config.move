module 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config {
    struct ProtocolAdminCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct ProtocolPauseCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct ProtocolFeeCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct ProtocolRiskCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct ProtocolUpgradeCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct FeeConfig has copy, drop, store {
        management_fee_bps_annual: u64,
        performance_fee_bps: u64,
        share_resell_royalty_bps: u64,
        buy_fee_bps_per_trade_cap: u64,
        buy_fee_bps_per_period_cap: u64,
        buy_fee_period_ms: u64,
        fee_recipient: address,
    }

    struct RiskConfig has copy, drop, store {
        max_deposit_per_tx: u64,
        max_withdraw_per_tx: u64,
        max_orders_per_tx: u64,
        max_order_size: u64,
        max_ptb_ops: u64,
    }

    struct OracleConfig has copy, drop, store {
        min_sources: u8,
        max_source_age_ms: u64,
        max_spread_bps: u64,
        max_price_age_ms: u64,
        mark_max_age_ms: u64,
    }

    struct LotusConfig has key {
        id: 0x2::object::UID,
        version: u64,
        status: u8,
        fee_config: FeeConfig,
        risk_config: RiskConfig,
        oracle_config: OracleConfig,
        allowed_dex: 0x2::vec_set::VecSet<u8>,
        allowed_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        direct_deposit_enabled: bool,
        setup_finalized: bool,
        extras: 0x2::table::Table<0x1::string::String, u64>,
    }

    public fun id(arg0: &LotusConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun assert_active(arg0: &LotusConfig, arg1: u64) {
        assert!(arg1 == arg0.version, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::wrong_version());
        assert!(1 == arg0.version, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::wrong_version());
        assert!(arg0.status == 0, status_error_code(arg0.status));
    }

    public fun assert_admin(arg0: &LotusConfig, arg1: &ProtocolAdminCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolAdminCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_revoked());
    }

    public fun assert_fee_cap(arg0: &LotusConfig, arg1: &ProtocolFeeCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolFeeCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_revoked());
    }

    public fun assert_governance(arg0: &LotusConfig) {
        assert_governance_active(arg0, 1);
    }

    public fun assert_governance_active(arg0: &LotusConfig, arg1: u64) {
        assert_active(arg0, arg1);
    }

    public fun assert_not_paused(arg0: &LotusConfig, arg1: u64) {
        assert!(arg1 == arg0.version, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::wrong_version());
        assert!(1 == arg0.version, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::wrong_version());
        assert!(arg0.status != 2, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::protocol_paused());
    }

    public fun assert_pause_cap(arg0: &LotusConfig, arg1: &ProtocolPauseCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolPauseCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_revoked());
    }

    public fun assert_risk_cap(arg0: &LotusConfig, arg1: &ProtocolRiskCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolRiskCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_revoked());
    }

    public fun assert_upgrade_cap(arg0: &LotusConfig, arg1: &ProtocolUpgradeCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolUpgradeCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_revoked());
    }

    public fun assert_version(arg0: &LotusConfig, arg1: u64) {
        assert!(arg1 == arg0.version, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::wrong_version());
        assert!(1 == arg0.version, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::wrong_version());
    }

    public fun bump_version(arg0: &mut LotusConfig, arg1: &ProtocolUpgradeCap, arg2: u64) {
        assert_upgrade_cap(arg0, arg1);
        assert!(arg2 > arg0.version, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::wrong_version());
        arg0.version = arg2;
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::events::emit_version_updated(0x2::object::uid_to_inner(&arg0.id), arg0.version, arg2);
    }

    public fun code_version() : u64 {
        1
    }

    public fun dex_aftermath() : u8 {
        3
    }

    public fun dex_aftermath_perp() : u8 {
        6
    }

    public fun dex_bluefin() : u8 {
        4
    }

    public fun dex_cetus() : u8 {
        2
    }

    public fun dex_deepbook() : u8 {
        1
    }

    public fun dex_momentum() : u8 {
        5
    }

    public fun direct_deposit_enabled(arg0: &LotusConfig) : bool {
        arg0.direct_deposit_enabled
    }

    public fun disable_dex(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: u8) {
        assert_admin(arg0, arg1);
        if (0x2::vec_set::contains<u8>(&arg0.allowed_dex, &arg2)) {
            0x2::vec_set::remove<u8>(&mut arg0.allowed_dex, &arg2);
        };
    }

    fun do_revoke(arg0: &mut LotusConfig, arg1: 0x2::object::ID, arg2: u8) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &arg1), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::cap_not_in_allowlist());
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_caps, &arg1);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::events::emit_protocol_cap_revoked(0x2::object::uid_to_inner(&arg0.id), arg1, arg2);
    }

    public fun enable_dex(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: u8) {
        assert_admin(arg0, arg1);
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else if (arg2 == 3) {
            true
        } else if (arg2 == 4) {
            true
        } else if (arg2 == 5) {
            true
        } else {
            arg2 == 6
        };
        assert!(v0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::unknown_dex());
        if (!0x2::vec_set::contains<u8>(&arg0.allowed_dex, &arg2)) {
            0x2::vec_set::insert<u8>(&mut arg0.allowed_dex, arg2);
        };
    }

    public fun fee_buy_per_period_cap(arg0: &FeeConfig) : u64 {
        arg0.buy_fee_bps_per_period_cap
    }

    public fun fee_buy_per_trade_cap(arg0: &FeeConfig) : u64 {
        arg0.buy_fee_bps_per_trade_cap
    }

    public fun fee_buy_period_ms(arg0: &FeeConfig) : u64 {
        arg0.buy_fee_period_ms
    }

    public fun fee_config(arg0: &LotusConfig) : &FeeConfig {
        &arg0.fee_config
    }

    public fun fee_management_bps(arg0: &FeeConfig) : u64 {
        arg0.management_fee_bps_annual
    }

    public fun fee_performance_bps(arg0: &FeeConfig) : u64 {
        arg0.performance_fee_bps
    }

    public fun fee_recipient(arg0: &FeeConfig) : address {
        arg0.fee_recipient
    }

    public fun fee_resell_royalty_bps(arg0: &FeeConfig) : u64 {
        arg0.share_resell_royalty_bps
    }

    public fun finalize_setup(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap) {
        assert_admin(arg0, arg1);
        assert!(!arg0.setup_finalized, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::setup_already_finalized());
        arg0.setup_finalized = true;
    }

    public fun get_extra(arg0: &LotusConfig, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.extras, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.extras, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ProtocolAdminCap{
            id        : 0x2::object::new(arg0),
            config_id : v1,
        };
        let v3 = ProtocolPauseCap{
            id        : 0x2::object::new(arg0),
            config_id : v1,
        };
        let v4 = ProtocolFeeCap{
            id        : 0x2::object::new(arg0),
            config_id : v1,
        };
        let v5 = ProtocolRiskCap{
            id        : 0x2::object::new(arg0),
            config_id : v1,
        };
        let v6 = ProtocolUpgradeCap{
            id        : 0x2::object::new(arg0),
            config_id : v1,
        };
        let v7 = 0x2::vec_set::empty<0x2::object::ID>();
        0x2::vec_set::insert<0x2::object::ID>(&mut v7, 0x2::object::id<ProtocolAdminCap>(&v2));
        0x2::vec_set::insert<0x2::object::ID>(&mut v7, 0x2::object::id<ProtocolPauseCap>(&v3));
        0x2::vec_set::insert<0x2::object::ID>(&mut v7, 0x2::object::id<ProtocolFeeCap>(&v4));
        0x2::vec_set::insert<0x2::object::ID>(&mut v7, 0x2::object::id<ProtocolRiskCap>(&v5));
        0x2::vec_set::insert<0x2::object::ID>(&mut v7, 0x2::object::id<ProtocolUpgradeCap>(&v6));
        let v8 = 0x2::vec_set::empty<u8>();
        0x2::vec_set::insert<u8>(&mut v8, 1);
        let v9 = FeeConfig{
            management_fee_bps_annual  : 200,
            performance_fee_bps        : 1000,
            share_resell_royalty_bps   : 50,
            buy_fee_bps_per_trade_cap  : 30,
            buy_fee_bps_per_period_cap : 100,
            buy_fee_period_ms          : 86400000,
            fee_recipient              : 0x2::tx_context::sender(arg0),
        };
        let v10 = RiskConfig{
            max_deposit_per_tx  : 0,
            max_withdraw_per_tx : 0,
            max_orders_per_tx   : 100,
            max_order_size      : 0,
            max_ptb_ops         : 256,
        };
        let v11 = OracleConfig{
            min_sources       : 2,
            max_source_age_ms : 60000,
            max_spread_bps    : 100,
            max_price_age_ms  : 60000,
            mark_max_age_ms   : 300000,
        };
        let v12 = LotusConfig{
            id                     : v0,
            version                : 1,
            status                 : 0,
            fee_config             : v9,
            risk_config            : v10,
            oracle_config          : v11,
            allowed_dex            : v8,
            allowed_caps           : v7,
            direct_deposit_enabled : true,
            setup_finalized        : false,
            extras                 : 0x2::table::new<0x1::string::String, u64>(arg0),
        };
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::events::emit_initialized(v1, 0x2::tx_context::sender(arg0), v12.version);
        0x2::transfer::share_object<LotusConfig>(v12);
        0x2::transfer::public_transfer<ProtocolAdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<ProtocolPauseCap>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<ProtocolFeeCap>(v4, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<ProtocolRiskCap>(v5, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<ProtocolUpgradeCap>(v6, 0x2::tx_context::sender(arg0));
    }

    public fun is_cap_allowed(arg0: &LotusConfig, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &arg1)
    }

    public fun is_dex_allowed(arg0: &LotusConfig, arg1: u8) : bool {
        0x2::vec_set::contains<u8>(&arg0.allowed_dex, &arg1)
    }

    public fun mint_fee_cap(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: &mut 0x2::tx_context::TxContext) : ProtocolFeeCap {
        assert_admin(arg0, arg1);
        let v0 = ProtocolFeeCap{
            id        : 0x2::object::new(arg2),
            config_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_caps, 0x2::object::id<ProtocolFeeCap>(&v0));
        v0
    }

    public fun mint_pause_cap(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: &mut 0x2::tx_context::TxContext) : ProtocolPauseCap {
        assert_admin(arg0, arg1);
        let v0 = ProtocolPauseCap{
            id        : 0x2::object::new(arg2),
            config_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_caps, 0x2::object::id<ProtocolPauseCap>(&v0));
        v0
    }

    public fun mint_risk_cap(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: &mut 0x2::tx_context::TxContext) : ProtocolRiskCap {
        assert_admin(arg0, arg1);
        let v0 = ProtocolRiskCap{
            id        : 0x2::object::new(arg2),
            config_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_caps, 0x2::object::id<ProtocolRiskCap>(&v0));
        v0
    }

    public fun oracle_config(arg0: &LotusConfig) : &OracleConfig {
        &arg0.oracle_config
    }

    public fun oracle_mark_max_age_ms(arg0: &OracleConfig) : u64 {
        arg0.mark_max_age_ms
    }

    public fun oracle_max_price_age_ms(arg0: &OracleConfig) : u64 {
        arg0.max_price_age_ms
    }

    public fun oracle_max_source_age_ms(arg0: &OracleConfig) : u64 {
        arg0.max_source_age_ms
    }

    public fun oracle_max_spread_bps(arg0: &OracleConfig) : u64 {
        arg0.max_spread_bps
    }

    public fun oracle_min_sources(arg0: &OracleConfig) : u8 {
        arg0.min_sources
    }

    public fun revoke_admin_cap(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        do_revoke(arg0, arg2, 0);
    }

    public fun revoke_fee_cap(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        do_revoke(arg0, arg2, 2);
    }

    public fun revoke_pause_cap(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        do_revoke(arg0, arg2, 1);
    }

    public fun revoke_risk_cap(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        do_revoke(arg0, arg2, 3);
    }

    public fun revoke_upgrade_cap(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        do_revoke(arg0, arg2, 4);
    }

    public fun risk_config(arg0: &LotusConfig) : &RiskConfig {
        &arg0.risk_config
    }

    public fun risk_max_deposit_per_tx(arg0: &RiskConfig) : u64 {
        arg0.max_deposit_per_tx
    }

    public fun risk_max_order_size(arg0: &RiskConfig) : u64 {
        arg0.max_order_size
    }

    public fun risk_max_orders_per_tx(arg0: &RiskConfig) : u64 {
        arg0.max_orders_per_tx
    }

    public fun risk_max_ptb_ops(arg0: &RiskConfig) : u64 {
        arg0.max_ptb_ops
    }

    public fun risk_max_withdraw_per_tx(arg0: &RiskConfig) : u64 {
        arg0.max_withdraw_per_tx
    }

    public fun set_buy_fee_caps(arg0: &mut LotusConfig, arg1: &ProtocolFeeCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_fee_cap(arg0, arg1);
        assert!(arg2 <= 10000, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_fee_bps());
        assert!(arg3 <= 10000, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_fee_bps());
        assert!(arg4 > 0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_period_ms());
        arg0.fee_config.buy_fee_bps_per_trade_cap = arg2;
        arg0.fee_config.buy_fee_bps_per_period_cap = arg3;
        arg0.fee_config.buy_fee_period_ms = arg4;
    }

    public fun set_direct_deposit_enabled(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        arg0.direct_deposit_enabled = arg2;
    }

    public fun set_extra(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: 0x1::string::String, arg3: u64) {
        assert_admin(arg0, arg1);
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.extras, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.extras, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.extras, arg2, arg3);
        };
    }

    public fun set_fee_recipient(arg0: &mut LotusConfig, arg1: &ProtocolFeeCap, arg2: address) {
        assert_fee_cap(arg0, arg1);
        arg0.fee_config.fee_recipient = arg2;
    }

    public fun set_management_fee_bps(arg0: &mut LotusConfig, arg1: &ProtocolFeeCap, arg2: u64) {
        assert_fee_cap(arg0, arg1);
        assert!(arg2 <= 10000, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_fee_bps());
        arg0.fee_config.management_fee_bps_annual = arg2;
    }

    public fun set_oracle_config(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_admin(arg0, arg1);
        assert!(arg2 >= 1, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_oracle_param());
        assert!(arg3 > 0 && arg5 > 0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_oracle_param());
        assert!(arg4 <= 10000, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_oracle_param());
        assert!(arg6 > 0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_oracle_param());
        let v0 = OracleConfig{
            min_sources       : arg2,
            max_source_age_ms : arg3,
            max_spread_bps    : arg4,
            max_price_age_ms  : arg5,
            mark_max_age_ms   : arg6,
        };
        arg0.oracle_config = v0;
    }

    public fun set_performance_fee_bps(arg0: &mut LotusConfig, arg1: &ProtocolFeeCap, arg2: u64) {
        assert_fee_cap(arg0, arg1);
        assert!(arg2 <= 10000, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_fee_bps());
        arg0.fee_config.performance_fee_bps = arg2;
    }

    public fun set_resell_royalty_bps(arg0: &mut LotusConfig, arg1: &ProtocolFeeCap, arg2: u64) {
        assert_fee_cap(arg0, arg1);
        assert!(arg2 <= 10000, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_fee_bps());
        arg0.fee_config.share_resell_royalty_bps = arg2;
    }

    public fun set_risk_config(arg0: &mut LotusConfig, arg1: &ProtocolRiskCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_risk_cap(arg0, arg1);
        assert!(arg4 > 0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_risk_param());
        assert!(arg6 > 0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_risk_param());
        let v0 = RiskConfig{
            max_deposit_per_tx  : arg2,
            max_withdraw_per_tx : arg3,
            max_orders_per_tx   : arg4,
            max_order_size      : arg5,
            max_ptb_ops         : arg6,
        };
        arg0.risk_config = v0;
    }

    public fun set_status(arg0: &mut LotusConfig, arg1: &ProtocolPauseCap, arg2: u8) {
        assert_pause_cap(arg0, arg1);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::bad_risk_param());
        arg0.status = arg2;
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::events::emit_status_changed(0x2::object::uid_to_inner(&arg0.id), arg0.status, arg2);
    }

    public fun setup_finalized(arg0: &LotusConfig) : bool {
        arg0.setup_finalized
    }

    public fun status(arg0: &LotusConfig) : u8 {
        arg0.status
    }

    fun status_error_code(arg0: u8) : u64 {
        if (arg0 == 2) {
            0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::protocol_paused()
        } else if (arg0 == 1) {
            0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::protocol_frozen()
        } else {
            0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::protocol_paused()
        }
    }

    public fun status_frozen() : u8 {
        1
    }

    public fun status_normal() : u8 {
        0
    }

    public fun status_paused() : u8 {
        2
    }

    public fun version(arg0: &LotusConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

