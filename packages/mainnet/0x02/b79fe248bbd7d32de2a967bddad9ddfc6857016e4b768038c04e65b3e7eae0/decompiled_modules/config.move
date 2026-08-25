module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MigrationCap has store, key {
        id: 0x2::object::UID,
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

    public fun assert_active(arg0: &Config) {
        assert!(!arg0.paused, 1);
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

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun issue_migration_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : MigrationCap {
        MigrationCap{id: 0x2::object::new(arg1)}
    }

    public fun lp_supply(arg0: &Config) : u64 {
        arg0.lp_supply
    }

    public fun migration_fee_bps(arg0: &Config) : u64 {
        arg0.migration_fee_bps
    }

    public fun protocol_bps() : u64 {
        3500
    }

    public fun referrer_bps() : u64 {
        1000
    }

    public fun set_curve_params(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg5 > arg2, 2);
        arg1.curve_supply = arg2;
        arg1.lp_supply = arg3;
        arg1.virtual_sui = arg4;
        arg1.virtual_tokens = arg5;
        emit_updated(arg1);
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 1000, 0);
        arg1.fee_bps = arg2;
        emit_updated(arg1);
    }

    public fun set_migration_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 2000, 0);
        arg1.migration_fee_bps = arg2;
        emit_updated(arg1);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        emit_updated(arg1);
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

