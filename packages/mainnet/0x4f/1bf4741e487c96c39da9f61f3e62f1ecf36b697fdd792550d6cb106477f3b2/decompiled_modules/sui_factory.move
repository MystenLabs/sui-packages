module 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_factory {
    struct SuiAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuiFactory has key {
        id: 0x2::object::UID,
        treasury: address,
        settings: 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GlobalSettings,
        default_bc_virtual_base: u64,
        default_bc_virtual_tokens: u64,
        default_initial_assets: u64,
        graduation_tiers: vector<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier>,
        exit_fee_tiers: vector<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier>,
        vaults: 0x2::table::Table<0x2::object::ID, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo>,
        vaults_by_leader: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_vaults: u64,
        verified_leaders: 0x2::table::Table<address, bool>,
        creation_fee: u64,
        paused: bool,
        version: u64,
    }

    struct FactoryCreated has copy, drop {
        factory_id: 0x2::object::ID,
        admin: address,
        treasury: address,
    }

    struct VaultRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        leader: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        performance_fee_bps: u64,
    }

    struct SettingsUpdated has copy, drop {
        factory_id: 0x2::object::ID,
        trading_fee_bps: u64,
        min_deposit_usdc: u64,
    }

    struct GraduationTierAdded has copy, drop {
        factory_id: 0x2::object::ID,
        threshold: u64,
        bc_virtual: u64,
    }

    struct LeaderVerified has copy, drop {
        leader: address,
        verified: bool,
    }

    struct SUI_FACTORY has drop {
        dummy_field: bool,
    }

    public fun id(arg0: &SuiFactory) : 0x2::object::ID {
        0x2::object::id<SuiFactory>(arg0)
    }

    public fun add_graduation_tier(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg4 <= arg5, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier>(&arg1.graduation_tiers)) {
            if (arg2 < 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_threshold(0x1::vector::borrow<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier>(&arg1.graduation_tiers, v0))) {
                break
            };
            v0 = v0 + 1;
        };
        0x1::vector::insert<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier>(&mut arg1.graduation_tiers, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_graduation_tier(arg2, arg3, arg4, arg5, arg6), v0);
        let v1 = GraduationTierAdded{
            factory_id : 0x2::object::id<SuiFactory>(arg1),
            threshold  : arg2,
            bc_virtual : arg3,
        };
        0x2::event::emit<GraduationTierAdded>(v1);
    }

    public fun clear_graduation_tiers(arg0: &SuiAdminCap, arg1: &mut SuiFactory) {
        arg1.graduation_tiers = 0x1::vector::empty<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier>();
    }

    public fun creation_fee(arg0: &SuiFactory) : u64 {
        arg0.creation_fee
    }

    public fun default_bc_params(arg0: &SuiFactory) : (u64, u64, u64) {
        (arg0.default_bc_virtual_base, arg0.default_bc_virtual_tokens, arg0.default_initial_assets)
    }

    fun default_exit_fee_tiers() : vector<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier> {
        let v0 = 0x1::vector::empty<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier>();
        0x1::vector::push_back<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier>(&mut v0, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_exit_fee_tier(0, 1500));
        0x1::vector::push_back<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier>(&mut v0, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_exit_fee_tier(7, 800));
        0x1::vector::push_back<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier>(&mut v0, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_exit_fee_tier(30, 300));
        0x1::vector::push_back<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier>(&mut v0, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_exit_fee_tier(90, 0));
        v0
    }

    public fun exit_fee_tiers(arg0: &SuiFactory) : &vector<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier> {
        &arg0.exit_fee_tiers
    }

    public fun get_exit_fee_bps(arg0: &SuiFactory, arg1: u64) : u64 {
        if (!0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::settings_exit_fee_enabled(&arg0.settings)) {
            return 0
        };
        0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_math::calculate_exit_fee_bps(arg1, &arg0.exit_fee_tiers)
    }

    public fun get_leader_vaults(arg0: &SuiFactory, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_by_leader, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.vaults_by_leader, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_tier_for_assets(arg0: &SuiFactory, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = &arg0.graduation_tiers;
        let v1 = 0x1::vector::length<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier>(v0);
        if (v1 == 0) {
            return (0, arg0.default_bc_virtual_base, 10000, 10000, 0)
        };
        let v2 = v1;
        while (v2 > 0) {
            v2 = v2 - 1;
            let v3 = 0x1::vector::borrow<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier>(v0, v2);
            if (arg1 >= 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_threshold(v3)) {
                return (0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_threshold(v3), 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_bc_virtual(v3), 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_nav_min_mul_bps(v3), 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_nav_max_mul_bps(v3), 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_squared_ratio_bps(v3))
            };
        };
        let v4 = 0x1::vector::borrow<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier>(v0, 0);
        (0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_threshold(v4), 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_bc_virtual(v4), 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_nav_min_mul_bps(v4), 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_nav_max_mul_bps(v4), 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::tier_squared_ratio_bps(v4))
    }

    public fun get_vault_info(arg0: &SuiFactory, arg1: 0x2::object::ID) : &0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo {
        assert!(0x2::table::contains<0x2::object::ID, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo>(&arg0.vaults, arg1), 6);
        0x2::table::borrow<0x2::object::ID, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo>(&arg0.vaults, arg1)
    }

    public fun graduation_tiers(arg0: &SuiFactory) : &vector<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier> {
        &arg0.graduation_tiers
    }

    public fun increment_version(arg0: &SuiAdminCap, arg1: &mut SuiFactory) {
        arg1.version = arg1.version + 1;
    }

    fun init(arg0: SUI_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = SuiAdminCap{id: 0x2::object::new(arg1)};
        let v2 = SuiFactory{
            id                        : 0x2::object::new(arg1),
            treasury                  : v0,
            settings                  : 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::default_global_settings(),
            default_bc_virtual_base   : 2000000000000,
            default_bc_virtual_tokens : 2000000000000,
            default_initial_assets    : 100000000000,
            graduation_tiers          : 0x1::vector::empty<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GraduationTier>(),
            exit_fee_tiers            : default_exit_fee_tiers(),
            vaults                    : 0x2::table::new<0x2::object::ID, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo>(arg1),
            vaults_by_leader          : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            total_vaults              : 0,
            verified_leaders          : 0x2::table::new<address, bool>(arg1),
            creation_fee              : 0,
            paused                    : false,
            version                   : 1,
        };
        let v3 = FactoryCreated{
            factory_id : 0x2::object::id<SuiFactory>(&v2),
            admin      : v0,
            treasury   : v0,
        };
        0x2::event::emit<FactoryCreated>(v3);
        0x2::transfer::transfer<SuiAdminCap>(v1, v0);
        0x2::transfer::share_object<SuiFactory>(v2);
    }

    public fun is_leader_verified(arg0: &SuiFactory, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.verified_leaders, arg1)
    }

    public fun is_paused(arg0: &SuiFactory) : bool {
        arg0.paused
    }

    public fun register_vault(arg0: &mut SuiFactory, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg5 <= 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::max_performance_fee_bps(), 3);
        assert!(!0x2::table::contains<0x2::object::ID, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo>(&arg0.vaults, arg1), 5);
        0x2::table::add<0x2::object::ID, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo>(&mut arg0.vaults, arg1, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_vault_info(arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6) / 1000, 0x2::table::contains<address, bool>(&arg0.verified_leaders, arg2)));
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vaults_by_leader, arg2)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.vaults_by_leader, arg2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.vaults_by_leader, arg2), arg1);
        arg0.total_vaults = arg0.total_vaults + 1;
        let v0 = VaultRegistered{
            vault_id            : arg1,
            leader              : arg2,
            name                : 0x1::string::utf8(arg3),
            symbol              : 0x1::string::utf8(arg4),
            performance_fee_bps : arg5,
        };
        0x2::event::emit<VaultRegistered>(v0);
    }

    public fun set_creation_fee(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: u64) {
        arg1.creation_fee = arg2;
    }

    public fun set_default_bc_params(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: u64, arg3: u64, arg4: u64) {
        arg1.default_bc_virtual_base = arg2;
        arg1.default_bc_virtual_tokens = arg3;
        arg1.default_initial_assets = arg4;
    }

    public fun set_exit_fee_tiers(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: vector<u64>, arg3: vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 7);
        let v1 = 0x1::vector::empty<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg3, v2);
            assert!(v3 <= 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::max_exit_fee_bps(), 3);
            0x1::vector::push_back<0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::ExitFeeTier>(&mut v1, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_exit_fee_tier(*0x1::vector::borrow<u64>(&arg2, v2), v3));
            v2 = v2 + 1;
        };
        arg1.exit_fee_tiers = v1;
    }

    public fun set_leader_verified(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: address, arg3: bool) {
        if (arg3) {
            if (!0x2::table::contains<address, bool>(&arg1.verified_leaders, arg2)) {
                0x2::table::add<address, bool>(&mut arg1.verified_leaders, arg2, true);
            };
        } else if (0x2::table::contains<address, bool>(&arg1.verified_leaders, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.verified_leaders, arg2);
        };
        let v0 = LeaderVerified{
            leader   : arg2,
            verified : arg3,
        };
        0x2::event::emit<LeaderVerified>(v0);
    }

    public fun set_max_buy_bps(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: u64) {
        assert!(arg2 == 0 || arg2 >= 10 && arg2 <= 1000, 7);
        arg1.settings = 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_global_settings_with_max_buy(&arg1.settings, arg2);
    }

    public fun set_min_deposit(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: u64) {
        arg1.settings = 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_global_settings_with_min_deposit(&arg1.settings, arg2);
    }

    public fun set_paused(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_rebalance_thresholds(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 < arg3, 7);
        assert!(arg4 >= arg2 && arg4 <= arg3, 7);
        arg1.settings = 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_global_settings_with_rebalance(&arg1.settings, arg2, arg3, arg4);
    }

    public fun set_trading_fee(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: u64) {
        assert!(arg2 <= 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::bps(), 3);
        arg1.settings = 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::new_global_settings_with_trading_fee(&arg1.settings, arg2);
    }

    public fun set_treasury(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun set_vault_verified(arg0: &SuiAdminCap, arg1: &mut SuiFactory, arg2: 0x2::object::ID, arg3: bool) {
        assert!(0x2::table::contains<0x2::object::ID, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo>(&arg1.vaults, arg2), 6);
        0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::set_vault_verified(0x2::table::borrow_mut<0x2::object::ID, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo>(&mut arg1.vaults, arg2), arg3);
    }

    public fun settings(arg0: &SuiFactory) : &0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::GlobalSettings {
        &arg0.settings
    }

    public fun total_vaults(arg0: &SuiFactory) : u64 {
        arg0.total_vaults
    }

    public fun treasury(arg0: &SuiFactory) : address {
        arg0.treasury
    }

    public fun vault_exists(arg0: &SuiFactory, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x4f1bf4741e487c96c39da9f61f3e62f1ecf36b697fdd792550d6cb106477f3b2::sui_types::VaultInfo>(&arg0.vaults, arg1)
    }

    public fun version(arg0: &SuiFactory) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

