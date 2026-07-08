module 0x20e5e78eba373048904191f38ac0a82aeb5642420513e2684cda44895b5d54dd::vault_backstop {
    struct VaultBackstopRegistry has key {
        id: 0x2::object::UID,
        configs: 0x2::table::Table<vector<u8>, VaultBackstopConfig>,
    }

    struct VaultBackstopConfig has copy, drop, store {
        vault_account: address,
        capacity_cap_bps: u64,
        enabled: bool,
        pause_absorptions: bool,
    }

    struct VaultBackstopRegistered has copy, drop {
        symbol: vector<u8>,
        vault_account: address,
        capacity_cap_bps: u64,
    }

    struct VaultBackstopUpdated has copy, drop {
        symbol: vector<u8>,
        vault_account: address,
        capacity_cap_bps: u64,
    }

    struct VaultBackstopDisabled has copy, drop {
        symbol: vector<u8>,
    }

    struct VaultBackstopPaused has copy, drop {
        symbol: vector<u8>,
        paused: bool,
    }

    struct VaultDeficitCovered has copy, drop {
        symbol: vector<u8>,
        vault_account: address,
        deficit_covered: u64,
        residual_to_insurance: u64,
        timestamp_ms: u64,
    }

    struct VaultDeficitSkipped has copy, drop {
        symbol: vector<u8>,
        reason: u64,
        timestamp_ms: u64,
    }

    public fun admin_pause_absorptions(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut VaultBackstopRegistry, arg2: vector<u8>, arg3: bool) {
        assert!(0x2::table::contains<vector<u8>, VaultBackstopConfig>(&arg1.configs, arg2), 1);
        0x2::table::borrow_mut<vector<u8>, VaultBackstopConfig>(&mut arg1.configs, arg2).pause_absorptions = arg3;
        let v0 = VaultBackstopPaused{
            symbol : arg2,
            paused : arg3,
        };
        0x2::event::emit<VaultBackstopPaused>(v0);
    }

    public fun config_capacity_cap_bps(arg0: &VaultBackstopConfig) : u64 {
        arg0.capacity_cap_bps
    }

    public fun config_enabled(arg0: &VaultBackstopConfig) : bool {
        arg0.enabled
    }

    public fun config_pause_absorptions(arg0: &VaultBackstopConfig) : bool {
        arg0.pause_absorptions
    }

    public fun config_vault_account(arg0: &VaultBackstopConfig) : address {
        arg0.vault_account
    }

    public fun disable_backstop(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut VaultBackstopRegistry, arg2: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, VaultBackstopConfig>(&arg1.configs, arg2), 1);
        0x2::table::borrow_mut<vector<u8>, VaultBackstopConfig>(&mut arg1.configs, arg2).enabled = false;
        let v0 = VaultBackstopDisabled{symbol: arg2};
        0x2::event::emit<VaultBackstopDisabled>(v0);
    }

    public(friend) fun emit_deficit_covered(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = VaultDeficitCovered{
            symbol                : arg0,
            vault_account         : arg1,
            deficit_covered       : arg2,
            residual_to_insurance : arg3,
            timestamp_ms          : arg4,
        };
        0x2::event::emit<VaultDeficitCovered>(v0);
    }

    public(friend) fun emit_deficit_skipped(arg0: vector<u8>, arg1: u64, arg2: u64) {
        let v0 = VaultDeficitSkipped{
            symbol       : arg0,
            reason       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<VaultDeficitSkipped>(v0);
    }

    public fun get_config(arg0: &VaultBackstopRegistry, arg1: vector<u8>) : 0x1::option::Option<VaultBackstopConfig> {
        if (0x2::table::contains<vector<u8>, VaultBackstopConfig>(&arg0.configs, arg1)) {
            0x1::option::some<VaultBackstopConfig>(*0x2::table::borrow<vector<u8>, VaultBackstopConfig>(&arg0.configs, arg1))
        } else {
            0x1::option::none<VaultBackstopConfig>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultBackstopRegistry{
            id      : 0x2::object::new(arg0),
            configs : 0x2::table::new<vector<u8>, VaultBackstopConfig>(arg0),
        };
        0x2::transfer::share_object<VaultBackstopRegistry>(v0);
    }

    public fun register_backstop(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut VaultBackstopRegistry, arg2: vector<u8>, arg3: address, arg4: u64) {
        assert!(!0x2::table::contains<vector<u8>, VaultBackstopConfig>(&arg1.configs, arg2), 0);
        assert!(arg3 != @0x0, 2);
        assert!(arg4 > 0 && arg4 <= 10000, 3);
        let v0 = VaultBackstopConfig{
            vault_account     : arg3,
            capacity_cap_bps  : arg4,
            enabled           : true,
            pause_absorptions : false,
        };
        0x2::table::add<vector<u8>, VaultBackstopConfig>(&mut arg1.configs, arg2, v0);
        let v1 = VaultBackstopRegistered{
            symbol           : arg2,
            vault_account    : arg3,
            capacity_cap_bps : arg4,
        };
        0x2::event::emit<VaultBackstopRegistered>(v1);
    }

    public(friend) fun skip_disabled() : u64 {
        1
    }

    public(friend) fun skip_insufficient_margin() : u64 {
        6
    }

    public(friend) fun skip_no_config() : u64 {
        0
    }

    public(friend) fun skip_paused() : u64 {
        2
    }

    public(friend) fun skip_vault_is_trader() : u64 {
        4
    }

    public(friend) fun skip_zero_deficit() : u64 {
        3
    }

    public(friend) fun skip_zero_fill() : u64 {
        5
    }

    public fun update_backstop(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut VaultBackstopRegistry, arg2: vector<u8>, arg3: address, arg4: u64) {
        assert!(0x2::table::contains<vector<u8>, VaultBackstopConfig>(&arg1.configs, arg2), 1);
        assert!(arg3 != @0x0, 2);
        assert!(arg4 > 0 && arg4 <= 10000, 3);
        let v0 = 0x2::table::borrow_mut<vector<u8>, VaultBackstopConfig>(&mut arg1.configs, arg2);
        v0.vault_account = arg3;
        v0.capacity_cap_bps = arg4;
        let v1 = VaultBackstopUpdated{
            symbol           : arg2,
            vault_account    : arg3,
            capacity_cap_bps : arg4,
        };
        0x2::event::emit<VaultBackstopUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

