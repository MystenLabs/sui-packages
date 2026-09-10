module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MigrationCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauserCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeClaimerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ConfigCap has store, key {
        id: 0x2::object::UID,
    }

    struct RolesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeSplitKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeSplit has copy, drop, store {
        creator_bps: u64,
        referrer_bps: u64,
        protocol_bps: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        curve_supply: u64,
        lp_supply: u64,
        virtual_sui: u64,
        virtual_tokens: u64,
        migration_fee_bps: u64,
        decimals: u8,
        paused: bool,
    }

    struct ConfigUpdated has copy, drop {
        fee_bps: u64,
        curve_supply: u64,
        lp_supply: u64,
        virtual_sui: u64,
        virtual_tokens: u64,
        migration_fee_bps: u64,
        paused: bool,
    }

    fun apply_curve_params(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg4 > arg1, 2);
        arg0.curve_supply = arg1;
        arg0.lp_supply = arg2;
        arg0.virtual_sui = arg3;
        arg0.virtual_tokens = arg4;
        emit_updated(arg0);
    }

    fun apply_fee_bps(arg0: &mut Config, arg1: u64) {
        assert!(arg1 <= 1000, 0);
        arg0.fee_bps = arg1;
        emit_updated(arg0);
    }

    fun apply_fee_split(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = if (arg1 <= 10000) {
            if (arg2 <= 10000) {
                arg3 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        assert!(arg1 + arg2 + arg3 == 10000, 5);
        let v1 = FeeSplit{
            creator_bps  : arg1,
            referrer_bps : arg2,
            protocol_bps : arg3,
        };
        let v2 = FeeSplitKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FeeSplitKey>(&arg0.id, v2)) {
            let v3 = FeeSplitKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<FeeSplitKey, FeeSplit>(&mut arg0.id, v3) = v1;
        } else {
            let v4 = FeeSplitKey{dummy_field: false};
            0x2::dynamic_field::add<FeeSplitKey, FeeSplit>(&mut arg0.id, v4, v1);
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::fee_split_changed(arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    fun apply_migration_fee_bps(arg0: &mut Config, arg1: u64) {
        assert!(arg1 <= 2000, 0);
        arg0.migration_fee_bps = arg1;
        emit_updated(arg0);
    }

    fun apply_paused(arg0: &mut Config, arg1: bool) {
        arg0.paused = arg1;
        emit_updated(arg0);
    }

    public fun assert_active(arg0: &Config) {
        assert!(!arg0.paused, 1);
    }

    public fun assert_config_cap(arg0: &Config, arg1: &ConfigCap) {
        assert!(is_live(arg0, 0x2::object::uid_to_inner(&arg1.id)), 3);
    }

    public fun assert_fee_claimer(arg0: &Config, arg1: &FeeClaimerCap) {
        assert!(is_live(arg0, 0x2::object::uid_to_inner(&arg1.id)), 3);
    }

    public fun assert_pauser(arg0: &Config, arg1: &PauserCap) {
        assert!(is_live(arg0, 0x2::object::uid_to_inner(&arg1.id)), 3);
    }

    fun burned(arg0: &mut Config, arg1: 0x2::object::UID, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::uid_to_inner(&arg1);
        0x2::object::delete(arg1);
        let v1 = roles_mut(arg0);
        if (0x2::vec_map::contains<0x2::object::ID, 0x1::ascii::String>(v1, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0x1::ascii::String>(v1, &v0);
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::role_revoked(0x1::ascii::string(arg2), v0, false, 0x2::clock::timestamp_ms(arg3));
    }

    public fun creator_bps() : u64 {
        5500
    }

    public fun curve_supply(arg0: &Config) : u64 {
        arg0.curve_supply
    }

    public fun decimals(arg0: &Config) : u8 {
        arg0.decimals
    }

    fun emit_updated(arg0: &Config) {
        let v0 = ConfigUpdated{
            fee_bps           : arg0.fee_bps,
            curve_supply      : arg0.curve_supply,
            lp_supply         : arg0.lp_supply,
            virtual_sui       : arg0.virtual_sui,
            virtual_tokens    : arg0.virtual_tokens,
            migration_fee_bps : arg0.migration_fee_bps,
            paused            : arg0.paused,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun fee_split(arg0: &Config) : (u64, u64, u64) {
        let v0 = FeeSplitKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FeeSplitKey>(&arg0.id, v0)) {
            let v4 = FeeSplitKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::borrow<FeeSplitKey, FeeSplit>(&arg0.id, v4);
            (v5.creator_bps, v5.referrer_bps, v5.protocol_bps)
        } else {
            (5500, 1000, 3500)
        }
    }

    fun grant(arg0: &mut Config, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: address, arg4: &0x2::clock::Clock) {
        let v0 = 0x1::ascii::string(arg2);
        0x2::vec_map::insert<0x2::object::ID, 0x1::ascii::String>(roles_mut(arg0), arg1, v0);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::role_granted(v0, arg1, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                : 0x2::object::new(arg0),
            fee_bps           : 100,
            curve_supply      : 800000000000000,
            lp_supply         : 200000000000000,
            virtual_sui       : 2277000000000,
            virtual_tokens    : 1030000000000000,
            migration_fee_bps : 0,
            decimals          : 6,
            paused            : false,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, v1);
        let v3 = MigrationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MigrationCap>(v3, v1);
    }

    fun is_live(arg0: &Config, arg1: 0x2::object::ID) : bool {
        let v0 = RolesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RolesKey>(&arg0.id, v0)) {
            let v2 = RolesKey{dummy_field: false};
            0x2::vec_map::contains<0x2::object::ID, 0x1::ascii::String>(0x2::dynamic_field::borrow<RolesKey, 0x2::vec_map::VecMap<0x2::object::ID, 0x1::ascii::String>>(&arg0.id, v2), &arg1)
        } else {
            false
        }
    }

    public fun is_live_role(arg0: &Config, arg1: 0x2::object::ID) : bool {
        is_live(arg0, arg1)
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun issue_migration_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : MigrationCap {
        MigrationCap{id: 0x2::object::new(arg1)}
    }

    public fun live_roles(arg0: &Config) : 0x2::vec_map::VecMap<0x2::object::ID, 0x1::ascii::String> {
        let v0 = RolesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RolesKey>(&arg0.id, v0)) {
            let v2 = RolesKey{dummy_field: false};
            *0x2::dynamic_field::borrow<RolesKey, 0x2::vec_map::VecMap<0x2::object::ID, 0x1::ascii::String>>(&arg0.id, v2)
        } else {
            0x2::vec_map::empty<0x2::object::ID, 0x1::ascii::String>()
        }
    }

    public fun lp_supply(arg0: &Config) : u64 {
        arg0.lp_supply
    }

    public fun migration_fee_bps(arg0: &Config) : u64 {
        arg0.migration_fee_bps
    }

    public fun mint_config_cap(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigCap{id: 0x2::object::new(arg4)};
        grant(arg1, 0x2::object::uid_to_inner(&v0.id), b"config", arg2, arg3);
        0x2::transfer::transfer<ConfigCap>(v0, arg2);
    }

    public fun mint_fee_claimer_cap(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeClaimerCap{id: 0x2::object::new(arg4)};
        grant(arg1, 0x2::object::uid_to_inner(&v0.id), b"fee_claimer", arg2, arg3);
        0x2::transfer::transfer<FeeClaimerCap>(v0, arg2);
    }

    public fun mint_migration_cap(arg0: &AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MigrationCap{id: 0x2::object::new(arg3)};
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::role_granted(0x1::ascii::string(b"migrator"), 0x2::object::uid_to_inner(&v0.id), arg1, 0x2::clock::timestamp_ms(arg2));
        0x2::transfer::transfer<MigrationCap>(v0, arg1);
    }

    public fun mint_pauser_cap(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PauserCap{id: 0x2::object::new(arg4)};
        grant(arg1, 0x2::object::uid_to_inner(&v0.id), b"pauser", arg2, arg3);
        0x2::transfer::transfer<PauserCap>(v0, arg2);
    }

    public fun protocol_bps() : u64 {
        3500
    }

    public fun referrer_bps() : u64 {
        1000
    }

    public fun revoke_config_cap(arg0: &mut Config, arg1: ConfigCap, arg2: &0x2::clock::Clock) {
        let ConfigCap { id: v0 } = arg1;
        burned(arg0, v0, b"config", arg2);
    }

    public fun revoke_fee_claimer_cap(arg0: &mut Config, arg1: FeeClaimerCap, arg2: &0x2::clock::Clock) {
        let FeeClaimerCap { id: v0 } = arg1;
        burned(arg0, v0, b"fee_claimer", arg2);
    }

    public fun revoke_migration_cap(arg0: MigrationCap, arg1: &0x2::clock::Clock) {
        let MigrationCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::role_revoked(0x1::ascii::string(b"migrator"), 0x2::object::uid_to_inner(&v0), false, 0x2::clock::timestamp_ms(arg1));
    }

    public fun revoke_pauser_cap(arg0: &mut Config, arg1: PauserCap, arg2: &0x2::clock::Clock) {
        let PauserCap { id: v0 } = arg1;
        burned(arg0, v0, b"pauser", arg2);
    }

    public fun revoke_role(arg0: &AdminCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert!(is_live(arg1, arg2), 4);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, 0x1::ascii::String>(roles_mut(arg1), &arg2);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::role_revoked(v1, arg2, true, 0x2::clock::timestamp_ms(arg3));
    }

    fun roles_mut(arg0: &mut Config) : &mut 0x2::vec_map::VecMap<0x2::object::ID, 0x1::ascii::String> {
        let v0 = RolesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RolesKey>(&arg0.id, v0)) {
            let v1 = RolesKey{dummy_field: false};
            0x2::dynamic_field::add<RolesKey, 0x2::vec_map::VecMap<0x2::object::ID, 0x1::ascii::String>>(&mut arg0.id, v1, 0x2::vec_map::empty<0x2::object::ID, 0x1::ascii::String>());
        };
        let v2 = RolesKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RolesKey, 0x2::vec_map::VecMap<0x2::object::ID, 0x1::ascii::String>>(&mut arg0.id, v2)
    }

    public fun set_curve_params(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        apply_curve_params(arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_curve_params_by_config_cap(arg0: &ConfigCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_config_cap(arg1, arg0);
        apply_curve_params(arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        apply_fee_bps(arg1, arg2);
    }

    public fun set_fee_bps_by_config_cap(arg0: &ConfigCap, arg1: &mut Config, arg2: u64) {
        assert_config_cap(arg1, arg0);
        apply_fee_bps(arg1, arg2);
    }

    public fun set_fee_split(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        apply_fee_split(arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_fee_split_by_config_cap(arg0: &ConfigCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_config_cap(arg1, arg0);
        apply_fee_split(arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_migration_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        apply_migration_fee_bps(arg1, arg2);
    }

    public fun set_migration_fee_bps_by_config_cap(arg0: &ConfigCap, arg1: &mut Config, arg2: u64) {
        assert_config_cap(arg1, arg0);
        apply_migration_fee_bps(arg1, arg2);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        apply_paused(arg1, arg2);
    }

    public fun set_paused_by_pauser(arg0: &PauserCap, arg1: &mut Config, arg2: bool) {
        assert_pauser(arg1, arg0);
        apply_paused(arg1, arg2);
    }

    public fun total_supply(arg0: &Config) : u64 {
        arg0.curve_supply + arg0.lp_supply
    }

    public fun virtual_sui(arg0: &Config) : u64 {
        arg0.virtual_sui
    }

    public fun virtual_tokens(arg0: &Config) : u64 {
        arg0.virtual_tokens
    }

    // decompiled from Move bytecode v7
}

