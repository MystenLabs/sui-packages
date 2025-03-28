module 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config {
    struct VaultConfig has store {
        min_debt_size: u64,
        reserve_pool_bps: u64,
        kill_bps: u64,
        max_kill_bps: u64,
        kill_treasury_bps: u64,
        treasury_addr: address,
        interest_model_addr: address,
        workers: 0x2::table::Table<address, address>,
        whitelisted_liquidators: 0x2::table::Table<address, bool>,
    }

    struct ConfigCapability has store, key {
        id: 0x2::object::UID,
        config_addr: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_accept_debt(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: bool) : bool {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_accept_debt(arg0, *0x2::table::borrow<address, address>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).workers, arg2), arg2, arg3)
    }

    public fun get_kill_factor(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: u64, arg4: bool) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_kill_factor(arg0, *0x2::table::borrow<address, address>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).workers, arg2), arg2, arg3, arg4)
    }

    public fun get_raw_kill_factor(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: u64) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_raw_kill_factor(arg0, *0x2::table::borrow<address, address>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).workers, arg2), arg2, arg3)
    }

    public fun get_work_factor(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: u64, arg4: bool) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config::get_work_factor(arg0, *0x2::table::borrow<address, address>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).workers, arg2), arg2, arg3, arg4)
    }

    public fun get_interest_model_addr(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : address {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).interest_model_addr
    }

    public fun get_interest_rate(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u64, arg3: u64) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::interest_model::get_interest_rate(arg0, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).interest_model_addr, arg2, arg3)
    }

    public fun get_interest_rate_scale() : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::interest_model::get_interest_rate_scale()
    }

    public fun get_kill_bps(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).kill_bps
    }

    public fun get_kill_bps_scale() : u64 {
        10000
    }

    public fun get_kill_factor_scale() : u64 {
        10000
    }

    public fun get_kill_treasury_bps(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).kill_treasury_bps
    }

    public fun get_kill_treasury_bps_scale() : u64 {
        10000
    }

    public fun get_max_kill_bps(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).max_kill_bps
    }

    public fun get_min_debt_size(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).min_debt_size
    }

    public fun get_reserve_pool_bps(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).reserve_pool_bps
    }

    public fun get_reserve_pool_bps_scale() : u64 {
        10000
    }

    public fun get_treasury_addr(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : address {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).treasury_addr
    }

    public fun get_work_factor_scale() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted_liquidator(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address) : bool {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        let v0 = &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).whitelisted_liquidators;
        if (!0x2::table::contains<address, bool>(v0, arg2)) {
            return false
        };
        *0x2::table::borrow<address, bool>(v0, arg2)
    }

    public fun is_worker(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address) : bool {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x2::table::contains<address, address>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<VaultConfig>(arg0, arg1).workers, arg2)
    }

    public entry fun register(arg0: &AdminCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2) = register_unchecked(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::add<VaultConfig>(arg1, v1, arg8);
        0x2::transfer::transfer<ConfigCapability>(v2, v0);
    }

    public fun register_for_uid(arg0: &AdminCap, arg1: &0x2::object::UID, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : ConfigCapability {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        let (v0, v1) = register_unchecked(0x2::object::uid_to_address(arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::add_to_uid<VaultConfig>(arg2, v0, arg1, arg9);
        v1
    }

    fun register_unchecked(arg0: address, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : (VaultConfig, ConfigCapability) {
        assert!(!0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<VaultConfig>(arg1, arg0), 1);
        assert!(arg4 + arg5 <= 500, 4);
        let v0 = VaultConfig{
            min_debt_size           : arg2,
            reserve_pool_bps        : arg3,
            kill_bps                : arg4,
            max_kill_bps            : 500,
            kill_treasury_bps       : arg5,
            treasury_addr           : arg6,
            interest_model_addr     : arg7,
            workers                 : 0x2::table::new<address, address>(arg8),
            whitelisted_liquidators : 0x2::table::new<address, bool>(arg8),
        };
        let v1 = ConfigCapability{
            id          : 0x2::object::new(arg8),
            config_addr : arg0,
        };
        (v0, v1)
    }

    public entry fun set_max_kill_bps(arg0: &AdminCap, arg1: &ConfigCapability, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: u64) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        assert!(arg3 < 1000, 5);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<VaultConfig>(arg2, arg1.config_addr).max_kill_bps = arg3;
    }

    public entry fun set_params(arg0: &AdminCap, arg1: &ConfigCapability, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        let v0 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<VaultConfig>(arg2, arg1.config_addr);
        assert!(arg5 + arg6 <= v0.max_kill_bps, 4);
        v0.min_debt_size = arg3;
        v0.reserve_pool_bps = arg4;
        v0.kill_bps = arg5;
        v0.kill_treasury_bps = arg6;
        v0.treasury_addr = arg7;
        v0.interest_model_addr = arg8;
    }

    public entry fun set_whitelisted_liquidator(arg0: &AdminCap, arg1: &ConfigCapability, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: address, arg4: bool) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        let v0 = &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<VaultConfig>(arg2, arg1.config_addr).whitelisted_liquidators;
        if (0x2::table::contains<address, bool>(v0, arg3)) {
            *0x2::table::borrow_mut<address, bool>(v0, arg3) = arg4;
        } else {
            0x2::table::add<address, bool>(v0, arg3, arg4);
        };
    }

    public entry fun set_worker_config(arg0: &AdminCap, arg1: &ConfigCapability, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: address, arg4: address) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        let v0 = &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<VaultConfig>(arg2, arg1.config_addr).workers;
        if (0x2::table::contains<address, address>(v0, arg3)) {
            *0x2::table::borrow_mut<address, address>(v0, arg3) = arg4;
        } else {
            0x2::table::add<address, address>(v0, arg3, arg4);
        };
    }

    // decompiled from Move bytecode v6
}

