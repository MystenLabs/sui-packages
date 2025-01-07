module 0xd5e4f92248fbd9689ea846adebbecde6b63807b3f28b178a81da11d0a723f55a::worker_config {
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

    public entry fun emergency_set_acceptDebt(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut<WorkerConfigStore>(arg0, arg1);
        assert!(v0.governor == 0x2::tx_context::sender(arg4), 8);
        0x2::table::borrow_mut<address, WorkerConfig>(&mut v0.workers, arg2).accept_debt = arg3;
    }

    public fun get_accept_debt(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: bool) : bool {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        assert!(arg3, 7);
        0x2::table::borrow<address, WorkerConfig>(&0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).accept_debt
    }

    public fun get_governor(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address) : address {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow<WorkerConfigStore>(arg0, arg1).governor
    }

    public fun get_kill_factor(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: u64, arg4: bool) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        assert!(arg4, 7);
        0x2::table::borrow<address, WorkerConfig>(&0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).kill_factor
    }

    public fun get_max_price_diff(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: address) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0x2::table::borrow<address, WorkerConfig>(&0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).max_price_diff
    }

    public fun get_max_price_diff_scale() : u64 {
        10000
    }

    public fun get_oracle(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address) : address {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow<WorkerConfigStore>(arg0, arg1).oracle
    }

    public fun get_raw_kill_factor(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: u64) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0x2::table::borrow<address, WorkerConfig>(&0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).kill_factor
    }

    public fun get_work_factor(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: address, arg3: u64, arg4: bool) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        assert!(arg4, 7);
        0x2::table::borrow<address, WorkerConfig>(&0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow<WorkerConfigStore>(arg0, arg1).workers, arg2).work_factor
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkerInfoStore{
            id           : 0x2::object::new(arg0),
            worker_infos : 0x2::table::new<address, WorkerInfo>(arg0),
        };
        0x2::transfer::transfer<WorkerInfoStore>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_worker_info_registered(arg0: &WorkerInfoStore, arg1: address) : bool {
        0x2::table::contains<address, WorkerInfo>(&arg0.worker_infos, arg1)
    }

    public entry fun register(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains<WorkerConfigStore>(arg0, v0), 1);
        let v1 = WorkerConfigStore{
            oracle   : arg1,
            workers  : 0x2::table::new<address, WorkerConfig>(arg2),
            governor : v0,
        };
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::add<WorkerConfigStore>(arg0, v1, arg2);
        let v2 = ConfigCapability{
            id     : 0x2::object::new(arg2),
            config : v0,
        };
        0x2::transfer::transfer<ConfigCapability>(v2, v0);
    }

    public fun register_worker_info<T0, T1, T2>(arg0: &mut WorkerInfoStore, arg1: address) {
        assert!(!is_worker_info_registered(arg0, arg1), 6);
        let v0 = WorkerInfo{
            base_coin_type    : 0x1::type_name::get<T0>(),
            farming_coin_type : 0x1::type_name::get<T1>(),
            lp_type           : 0x1::type_name::get<T2>(),
        };
        0x2::table::add<address, WorkerInfo>(&mut arg0.worker_infos, arg1, v0);
    }

    public entry fun set_config(arg0: &ConfigCapability, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: u64) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        let v0 = &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut<WorkerConfigStore>(arg1, arg0.config).workers;
        if (0x2::table::contains<address, WorkerConfig>(v0, arg2)) {
            let v1 = 0x2::table::borrow_mut<address, WorkerConfig>(v0, arg2);
            v1.accept_debt = arg3;
            v1.work_factor = arg4;
            v1.kill_factor = arg5;
            v1.max_price_diff = arg6;
        } else {
            let v2 = WorkerConfig{
                accept_debt    : arg3,
                work_factor    : arg4,
                kill_factor    : arg5,
                max_price_diff : arg6,
            };
            0x2::table::add<address, WorkerConfig>(v0, arg2, v2);
        };
    }

    public entry fun set_governor(arg0: &ConfigCapability, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: address) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut<WorkerConfigStore>(arg1, arg0.config).governor = arg2;
    }

    public entry fun set_oracle(arg0: &ConfigCapability, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: address) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut<WorkerConfigStore>(arg1, arg0.config).oracle = arg2;
    }

    // decompiled from Move bytecode v6
}

