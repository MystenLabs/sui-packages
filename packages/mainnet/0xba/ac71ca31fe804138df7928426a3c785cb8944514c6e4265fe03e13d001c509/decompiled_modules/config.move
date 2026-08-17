module 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config {
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

    struct ProtocolMasterCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        clearance: u8,
        products: u32,
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

    struct PriceGuardConfig has copy, drop, store {
        max_age_ms_ceiling: u64,
        max_future_skew_ms_ceiling: u64,
        max_deviation_bps_ceiling: u64,
        max_slippage_bps_ceiling: u64,
    }

    struct LotusConfig has key {
        id: 0x2::object::UID,
        version: u64,
        status: u8,
        fee_config: FeeConfig,
        risk_config: RiskConfig,
        price_guard_config: PriceGuardConfig,
        allowed_dex: 0x2::vec_set::VecSet<u8>,
        allowed_venues: 0x2::vec_set::VecSet<u8>,
        halted_products: u32,
        allowed_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        guardian_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        direct_deposit_enabled: bool,
        setup_finalized: bool,
        extras: 0x2::table::Table<0x1::string::String, u64>,
    }

    public fun id(arg0: &LotusConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun all_products_mask() : u32 {
        255
    }

    public fun assert_active(arg0: &LotusConfig, arg1: u64) {
        assert!(arg1 == arg0.version, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::wrong_version());
        assert!(arg0.status == 0, status_error_code(arg0.status));
    }

    public fun assert_admin(arg0: &LotusConfig, arg1: &ProtocolAdminCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolAdminCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_revoked());
    }

    public fun assert_fee_cap(arg0: &LotusConfig, arg1: &ProtocolFeeCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolFeeCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_revoked());
    }

    public fun assert_governance_active(arg0: &LotusConfig, arg1: u64) {
        assert_product_active(arg0, arg1, 7);
    }

    public fun assert_guardian(arg0: &LotusConfig, arg1: &GuardianCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<GuardianCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_revoked());
    }

    public fun assert_master(arg0: &LotusConfig, arg1: &ProtocolMasterCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::master_cap_mismatch());
        let v0 = 0x2::object::id<ProtocolMasterCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_revoked());
    }

    public fun assert_not_paused(arg0: &LotusConfig, arg1: u64) {
        assert!(arg1 == arg0.version, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::wrong_version());
        assert!(arg0.status != 2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::protocol_paused());
    }

    public fun assert_pause_cap(arg0: &LotusConfig, arg1: &ProtocolPauseCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolPauseCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_revoked());
    }

    public fun assert_product_active(arg0: &LotusConfig, arg1: u64, arg2: u8) {
        assert_active(arg0, arg1);
        assert!(is_product_active(arg0, arg2), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::product_halted());
    }

    public fun assert_product_not_paused(arg0: &LotusConfig, arg1: u64, arg2: u8) {
        assert_not_paused(arg0, arg1);
        assert!(is_product_active(arg0, arg2), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::product_halted());
    }

    public fun assert_risk_cap(arg0: &LotusConfig, arg1: &ProtocolRiskCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolRiskCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_revoked());
    }

    public fun assert_upgrade_cap(arg0: &LotusConfig, arg1: &ProtocolUpgradeCap) {
        assert!(arg1.config_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_vault_mismatch());
        let v0 = 0x2::object::id<ProtocolUpgradeCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &v0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_revoked());
    }

    public fun assert_version(arg0: &LotusConfig, arg1: u64) {
        assert!(arg1 == arg0.version, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::wrong_version());
    }

    public fun bump_version(arg0: &mut LotusConfig, arg1: &ProtocolUpgradeCap, arg2: u64) {
        assert_upgrade_cap(arg0, arg1);
        assert!(arg2 > arg0.version, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::wrong_version());
        arg0.version = arg2;
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_version_updated(0x2::object::uid_to_inner(&arg0.id), arg0.version, arg2);
    }

    public fun cap_kind_guardian() : u8 {
        6
    }

    public fun cap_kind_master() : u8 {
        5
    }

    public fun clearance_halt() : u8 {
        1
    }

    public fun clearance_master() : u8 {
        4
    }

    public fun clearance_resume() : u8 {
        3
    }

    public fun clearance_scoped() : u8 {
        2
    }

    public fun dex_aftermath() : u8 {
        3
    }

    public fun dex_cetus() : u8 {
        2
    }

    public fun dex_deepbook() : u8 {
        1
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

    public fun disable_venue(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: u8) {
        assert_admin(arg0, arg1);
        if (0x2::vec_set::contains<u8>(&arg0.allowed_venues, &arg2)) {
            0x2::vec_set::remove<u8>(&mut arg0.allowed_venues, &arg2);
        };
    }

    fun do_revoke(arg0: &mut LotusConfig, arg1: 0x2::object::ID, arg2: u8) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::cap_not_in_allowlist());
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_caps, &arg1);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_protocol_cap_revoked(0x2::object::uid_to_inner(&arg0.id), arg1, arg2);
    }

    public fun enable_dex(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: u8) {
        assert_admin(arg0, arg1);
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::unknown_dex());
        if (!0x2::vec_set::contains<u8>(&arg0.allowed_dex, &arg2)) {
            0x2::vec_set::insert<u8>(&mut arg0.allowed_dex, arg2);
        };
    }

    public fun enable_venue(arg0: &mut LotusConfig, arg1: &ProtocolAdminCap, arg2: u8) {
        assert_admin(arg0, arg1);
        assert!(arg2 >= 1 && arg2 <= 32, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::venue_unknown());
        if (!0x2::vec_set::contains<u8>(&arg0.allowed_venues, &arg2)) {
            0x2::vec_set::insert<u8>(&mut arg0.allowed_venues, arg2);
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
        assert!(!arg0.setup_finalized, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::setup_already_finalized());
        arg0.setup_finalized = true;
    }

    public fun get_extra(arg0: &LotusConfig, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.extras, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.extras, arg1)
        } else {
            0
        }
    }

    public fun guard_max_age_ms_ceiling(arg0: &PriceGuardConfig) : u64 {
        arg0.max_age_ms_ceiling
    }

    public fun guard_max_deviation_bps_ceiling(arg0: &PriceGuardConfig) : u64 {
        arg0.max_deviation_bps_ceiling
    }

    public fun guard_max_future_skew_ms_ceiling(arg0: &PriceGuardConfig) : u64 {
        arg0.max_future_skew_ms_ceiling
    }

    public fun guard_max_slippage_bps_ceiling(arg0: &PriceGuardConfig) : u64 {
        arg0.max_slippage_bps_ceiling
    }

    public fun guardian_clearance(arg0: &GuardianCap) : u8 {
        arg0.clearance
    }

    public fun guardian_config_id(arg0: &GuardianCap) : 0x2::object::ID {
        arg0.config_id
    }

    public fun guardian_products(arg0: &GuardianCap) : u32 {
        arg0.products
    }

    public fun halted_products(arg0: &LotusConfig) : u32 {
        arg0.halted_products
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
        let v7 = ProtocolMasterCap{
            id        : 0x2::object::new(arg0),
            config_id : v1,
        };
        let v8 = GuardianCap{
            id        : 0x2::object::new(arg0),
            config_id : v1,
            clearance : 1,
            products  : 255,
        };
        let v9 = GuardianCap{
            id        : 0x2::object::new(arg0),
            config_id : v1,
            clearance : 2,
            products  : 1 << 2 | 1 << 3,
        };
        let v10 = GuardianCap{
            id        : 0x2::object::new(arg0),
            config_id : v1,
            clearance : 3,
            products  : 255,
        };
        let v11 = 0x2::vec_set::empty<0x2::object::ID>();
        0x2::vec_set::insert<0x2::object::ID>(&mut v11, 0x2::object::id<ProtocolAdminCap>(&v2));
        0x2::vec_set::insert<0x2::object::ID>(&mut v11, 0x2::object::id<ProtocolPauseCap>(&v3));
        0x2::vec_set::insert<0x2::object::ID>(&mut v11, 0x2::object::id<ProtocolFeeCap>(&v4));
        0x2::vec_set::insert<0x2::object::ID>(&mut v11, 0x2::object::id<ProtocolRiskCap>(&v5));
        0x2::vec_set::insert<0x2::object::ID>(&mut v11, 0x2::object::id<ProtocolUpgradeCap>(&v6));
        0x2::vec_set::insert<0x2::object::ID>(&mut v11, 0x2::object::id<ProtocolMasterCap>(&v7));
        0x2::vec_set::insert<0x2::object::ID>(&mut v11, 0x2::object::id<GuardianCap>(&v8));
        0x2::vec_set::insert<0x2::object::ID>(&mut v11, 0x2::object::id<GuardianCap>(&v9));
        0x2::vec_set::insert<0x2::object::ID>(&mut v11, 0x2::object::id<GuardianCap>(&v10));
        let v12 = 0x2::vec_set::empty<0x2::object::ID>();
        0x2::vec_set::insert<0x2::object::ID>(&mut v12, 0x2::object::id<GuardianCap>(&v8));
        0x2::vec_set::insert<0x2::object::ID>(&mut v12, 0x2::object::id<GuardianCap>(&v9));
        0x2::vec_set::insert<0x2::object::ID>(&mut v12, 0x2::object::id<GuardianCap>(&v10));
        let v13 = 0x2::vec_set::empty<u8>();
        0x2::vec_set::insert<u8>(&mut v13, 1);
        let v14 = 0x2::vec_set::empty<u8>();
        let v15 = 1;
        while (v15 <= 5) {
            0x2::vec_set::insert<u8>(&mut v14, v15);
            v15 = v15 + 1;
        };
        let v16 = FeeConfig{
            management_fee_bps_annual  : 200,
            performance_fee_bps        : 1000,
            share_resell_royalty_bps   : 50,
            buy_fee_bps_per_trade_cap  : 30,
            buy_fee_bps_per_period_cap : 100,
            buy_fee_period_ms          : 86400000,
            fee_recipient              : 0x2::tx_context::sender(arg0),
        };
        let v17 = RiskConfig{
            max_deposit_per_tx  : 0,
            max_withdraw_per_tx : 0,
            max_orders_per_tx   : 100,
            max_order_size      : 0,
            max_ptb_ops         : 256,
        };
        let v18 = PriceGuardConfig{
            max_age_ms_ceiling         : 60000,
            max_future_skew_ms_ceiling : 2000,
            max_deviation_bps_ceiling  : 1000,
            max_slippage_bps_ceiling   : 500,
        };
        let v19 = LotusConfig{
            id                     : v0,
            version                : 1,
            status                 : 0,
            fee_config             : v16,
            risk_config            : v17,
            price_guard_config     : v18,
            allowed_dex            : v13,
            allowed_venues         : v14,
            halted_products        : 0,
            allowed_caps           : v11,
            guardian_ids           : v12,
            direct_deposit_enabled : true,
            setup_finalized        : false,
            extras                 : 0x2::table::new<0x1::string::String, u64>(arg0),
        };
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_initialized(v1, 0x2::tx_context::sender(arg0), v19.version);
        0x2::transfer::share_object<LotusConfig>(v19);
        0x2::transfer::public_transfer<ProtocolAdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<ProtocolPauseCap>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<ProtocolFeeCap>(v4, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<ProtocolRiskCap>(v5, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<ProtocolUpgradeCap>(v6, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<ProtocolMasterCap>(v7, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<GuardianCap>(v8, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<GuardianCap>(v9, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<GuardianCap>(v10, 0x2::tx_context::sender(arg0));
    }

    public fun is_cap_allowed(arg0: &LotusConfig, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &arg1)
    }

    public fun is_dex_allowed(arg0: &LotusConfig, arg1: u8) : bool {
        0x2::vec_set::contains<u8>(&arg0.allowed_dex, &arg1)
    }

    public fun is_fully_halted(arg0: &LotusConfig) : bool {
        arg0.halted_products == 255
    }

    public fun is_guardian_id(arg0: &LotusConfig, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.guardian_ids, &arg1)
    }

    public fun is_product_active(arg0: &LotusConfig, arg1: u8) : bool {
        arg0.halted_products & product_mask(arg1) == 0
    }

    public fun is_venue_allowed(arg0: &LotusConfig, arg1: u8) : bool {
        0x2::vec_set::contains<u8>(&arg0.allowed_venues, &arg1)
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

    public(friend) fun new_guardian_cap(arg0: &LotusConfig, arg1: u8, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : GuardianCap {
        GuardianCap{
            id        : 0x2::object::new(arg3),
            config_id : 0x2::object::uid_to_inner(&arg0.id),
            clearance : arg1,
            products  : arg2,
        }
    }

    public fun price_guard_config(arg0: &LotusConfig) : &PriceGuardConfig {
        &arg0.price_guard_config
    }

    public fun product_count() : u8 {
        8
    }

    public fun product_deposit() : u8 {
        0
    }

    public fun product_fee() : u8 {
        6
    }

    public fun product_governance() : u8 {
        7
    }

    public fun product_mask(arg0: u8) : u32 {
        assert!(arg0 < 8, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::unknown_product());
        1 << arg0
    }

    public fun product_oracle() : u8 {
        3
    }

    public fun product_reward() : u8 {
        4
    }

    public fun product_share_transfer() : u8 {
        5
    }

    public fun product_trade() : u8 {
        2
    }

    public fun product_withdraw() : u8 {
        1
    }

    public(friend) fun register_guardian(arg0: &mut LotusConfig, arg1: 0x2::object::ID) {
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_caps, arg1);
        };
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.guardian_ids, &arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.guardian_ids, arg1);
        };
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
        assert!(arg2 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_fee_bps());
        assert!(arg3 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_fee_bps());
        assert!(arg4 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_period_ms());
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

    public(friend) fun set_halted_products(arg0: &mut LotusConfig, arg1: u32) {
        arg0.halted_products = arg1;
    }

    public fun set_management_fee_bps(arg0: &mut LotusConfig, arg1: &ProtocolFeeCap, arg2: u64) {
        assert_fee_cap(arg0, arg1);
        assert!(arg2 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_fee_bps());
        arg0.fee_config.management_fee_bps_annual = arg2;
    }

    public fun set_performance_fee_bps(arg0: &mut LotusConfig, arg1: &ProtocolFeeCap, arg2: u64) {
        assert_fee_cap(arg0, arg1);
        assert!(arg2 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_fee_bps());
        arg0.fee_config.performance_fee_bps = arg2;
    }

    public fun set_price_guard_config(arg0: &mut LotusConfig, arg1: &ProtocolRiskCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_risk_cap(arg0, arg1);
        assert!(arg2 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::price_bad_guard());
        assert!(arg4 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::price_bad_guard());
        assert!(arg5 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::price_bad_guard());
        let v0 = PriceGuardConfig{
            max_age_ms_ceiling         : arg2,
            max_future_skew_ms_ceiling : arg3,
            max_deviation_bps_ceiling  : arg4,
            max_slippage_bps_ceiling   : arg5,
        };
        arg0.price_guard_config = v0;
    }

    public fun set_resell_royalty_bps(arg0: &mut LotusConfig, arg1: &ProtocolFeeCap, arg2: u64) {
        assert_fee_cap(arg0, arg1);
        assert!(arg2 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_fee_bps());
        arg0.fee_config.share_resell_royalty_bps = arg2;
    }

    public fun set_risk_config(arg0: &mut LotusConfig, arg1: &ProtocolRiskCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_risk_cap(arg0, arg1);
        assert!(arg4 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_risk_param());
        assert!(arg6 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_risk_param());
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
        assert!(v0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::bad_risk_param());
        arg0.status = arg2;
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_status_changed(0x2::object::uid_to_inner(&arg0.id), arg0.status, arg2);
    }

    public fun setup_finalized(arg0: &LotusConfig) : bool {
        arg0.setup_finalized
    }

    public fun shipped_venue_count() : u8 {
        5
    }

    public fun status(arg0: &LotusConfig) : u8 {
        arg0.status
    }

    fun status_error_code(arg0: u8) : u64 {
        if (arg0 == 2) {
            0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::protocol_paused()
        } else if (arg0 == 1) {
            0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::protocol_frozen()
        } else {
            0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::protocol_paused()
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

    public(friend) fun unregister_guardian(arg0: &mut LotusConfig, arg1: 0x2::object::ID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.guardian_ids, &arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::not_a_guardian());
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.guardian_ids, &arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_caps, &arg1)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_caps, &arg1);
        };
    }

    public fun version(arg0: &LotusConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

