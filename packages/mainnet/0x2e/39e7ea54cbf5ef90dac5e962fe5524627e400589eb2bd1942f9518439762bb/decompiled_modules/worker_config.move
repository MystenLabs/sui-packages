module 0x30e7109c6b3b813cd7af2c724183ffc6202958d1baf9744258870a4877d34370::worker_config {
    struct WorkerConfig has drop, store {
        accept_debt: bool,
        work_factor: u64,
        kill_factor: u64,
        max_price_diff: u64,
    }

    struct WorkerConfigStore has store {
        oracle: address,
        workers: 0x2::table::Table<address, WorkerConfig>,
        governor: address,
    }

    struct ConfigCapability has store, key {
        id: 0x2::object::UID,
        config: address,
    }

    struct WorkerInfo has store {
        base_coin_type: 0x1::type_name::TypeName,
        farming_coin_type: 0x1::type_name::TypeName,
        lp_type: 0x1::type_name::TypeName,
    }

    struct WorkerInfoStore has key {
        id: 0x2::object::UID,
        worker_infos: 0x2::table::Table<address, WorkerInfo>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun emergency_set_accept_debt(arg0: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        let v0 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<WorkerConfigStore>(arg0, arg1);
        assert!(v0.governor == 0x2::tx_context::sender(arg4), 8);
        0x2::table::borrow_mut<address, WorkerConfig>(&mut v0.workers, arg2).accept_debt = arg3;
    }

    public fun get_accept_debt(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: bool) : bool {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        assert!(arg3, 7);
        0x2::table::borrow<address, WorkerConfig>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).accept_debt
    }

    public fun get_governor(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : address {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<WorkerConfigStore>(arg0, arg1).governor
    }

    public fun get_kill_factor(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: u64, arg4: bool) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        assert!(arg4, 7);
        0x2::table::borrow<address, WorkerConfig>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).kill_factor
    }

    public fun get_max_price_diff(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x2::table::borrow<address, WorkerConfig>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).max_price_diff
    }

    public fun get_max_price_diff_scale() : u64 {
        10000
    }

    public fun get_oracle(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : address {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<WorkerConfigStore>(arg0, arg1).oracle
    }

    public fun get_raw_kill_factor(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: u64) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x2::table::borrow<address, WorkerConfig>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).kill_factor
    }

    public fun get_work_factor(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: u64, arg4: bool) : u64 {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        assert!(arg4, 7);
        0x2::table::borrow<address, WorkerConfig>(&0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).work_factor
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkerInfoStore{
            id           : 0x2::object::new(arg0),
            worker_infos : 0x2::table::new<address, WorkerInfo>(arg0),
        };
        0x2::transfer::transfer<WorkerInfoStore>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_worker_info_registered(arg0: &WorkerInfoStore, arg1: address) : bool {
        0x2::table::contains<address, WorkerInfo>(&arg0.worker_infos, arg1)
    }

    public entry fun register(arg0: &AdminCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<WorkerConfigStore>(arg1, v0), 1);
        let v1 = WorkerConfigStore{
            oracle   : arg2,
            workers  : 0x2::table::new<address, WorkerConfig>(arg3),
            governor : v0,
        };
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::add<WorkerConfigStore>(arg1, v1, arg3);
        let v2 = ConfigCapability{
            id     : 0x2::object::new(arg3),
            config : v0,
        };
        0x2::transfer::transfer<ConfigCapability>(v2, v0);
    }

    public fun register_worker_info<T0, T1, T2>(arg0: &AdminCap, arg1: &mut WorkerInfoStore, arg2: address) {
        assert!(!is_worker_info_registered(arg1, arg2), 6);
        let v0 = WorkerInfo{
            base_coin_type    : 0x1::type_name::get<T0>(),
            farming_coin_type : 0x1::type_name::get<T1>(),
            lp_type           : 0x1::type_name::get<T2>(),
        };
        0x2::table::add<address, WorkerInfo>(&mut arg1.worker_infos, arg2, v0);
    }

    public entry fun set_config(arg0: &AdminCap, arg1: &ConfigCapability, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: address, arg4: bool, arg5: u64, arg6: u64, arg7: u64) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        let v0 = &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<WorkerConfigStore>(arg2, arg1.config).workers;
        if (0x2::table::contains<address, WorkerConfig>(v0, arg3)) {
            let v1 = 0x2::table::borrow_mut<address, WorkerConfig>(v0, arg3);
            v1.accept_debt = arg4;
            v1.work_factor = arg5;
            v1.kill_factor = arg6;
            v1.max_price_diff = arg7;
        } else {
            let v2 = WorkerConfig{
                accept_debt    : arg4,
                work_factor    : arg5,
                kill_factor    : arg6,
                max_price_diff : arg7,
            };
            0x2::table::add<address, WorkerConfig>(v0, arg3, v2);
        };
    }

    public entry fun set_governor(arg0: &AdminCap, arg1: &ConfigCapability, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: address) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<WorkerConfigStore>(arg2, arg1.config).governor = arg3;
    }

    public entry fun set_oracle(arg0: &AdminCap, arg1: &ConfigCapability, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: address) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<WorkerConfigStore>(arg2, arg1.config).oracle = arg3;
    }

    // decompiled from Move bytecode v6
}

