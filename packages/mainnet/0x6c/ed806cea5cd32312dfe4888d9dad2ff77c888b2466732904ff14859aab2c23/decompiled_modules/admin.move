module 0x42c1b5c270d2f583b7ba79c369e1e8213c050cbfa42dda4649519e2c196bdc93::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        billing_period_epochs: u64,
        max_storage_epochs: u64,
        points_per_gb: u64,
        sponsored_tx_enabled: bool,
        max_sponsored_tx: u64,
        grace_period_epochs: u64,
        max_viewers_per_store: u64,
        quilt_threshold_bytes: u64,
        user_accounts: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct ConfigUpdated has copy, drop {
        field: vector<u8>,
        updated_by: address,
        epoch: u64,
    }

    struct SystemPaused has copy, drop {
        paused_by: address,
        epoch: u64,
    }

    struct SystemUnpaused has copy, drop {
        unpaused_by: address,
        epoch: u64,
    }

    struct UserRegistered has copy, drop {
        user: address,
        account_id: 0x2::object::ID,
        epoch: u64,
    }

    struct UserDeregistered has copy, drop {
        user: address,
        account_id: 0x2::object::ID,
        epoch: u64,
    }

    struct UserAccountReassigned has copy, drop {
        old_owner: address,
        new_owner: address,
        account_id: 0x2::object::ID,
        epoch: u64,
    }

    struct MaxViewersPerStoreUpdated has copy, drop {
        old_max: u64,
        new_max: u64,
        updated_by: address,
        epoch: u64,
    }

    struct QuiltThresholdUpdated has copy, drop {
        old_threshold: u64,
        new_threshold: u64,
        updated_by: address,
        epoch: u64,
    }

    public(friend) fun assert_not_paused(arg0: &GlobalConfig) {
        assert!(!arg0.paused, 1);
    }

    public(friend) fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.version >= 1, 2);
    }

    public fun billing_period_epochs(arg0: &GlobalConfig) : u64 {
        arg0.billing_period_epochs
    }

    public(friend) fun deregister_user(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.user_accounts, arg1)) {
            let v0 = UserDeregistered{
                user       : arg1,
                account_id : 0x2::table::remove<address, 0x2::object::ID>(&mut arg0.user_accounts, arg1),
                epoch      : 0x2::tx_context::epoch(arg2),
            };
            0x2::event::emit<UserDeregistered>(v0);
        };
    }

    public fun get_user_account_id(arg0: &GlobalConfig, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.user_accounts, arg1)
    }

    public fun grace_period_epochs(arg0: &GlobalConfig) : u64 {
        arg0.grace_period_epochs
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                    : 0x2::object::new(arg0),
            version               : 1,
            paused                : false,
            billing_period_epochs : 2,
            max_storage_epochs    : 53,
            points_per_gb         : 1000,
            sponsored_tx_enabled  : true,
            max_sponsored_tx      : 2,
            grace_period_epochs   : 2,
            max_viewers_per_store : 10,
            quilt_threshold_bytes : 10485760,
            user_accounts         : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun is_user_registered(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.user_accounts, arg1)
    }

    public fun max_base_points_per_gb() : u64 {
        1000
    }

    public fun max_sponsored_tx(arg0: &GlobalConfig) : u64 {
        arg0.max_sponsored_tx
    }

    public fun max_storage_epochs(arg0: &GlobalConfig) : u64 {
        arg0.max_storage_epochs
    }

    public fun max_viewers_per_store(arg0: &GlobalConfig) : u64 {
        arg0.max_viewers_per_store
    }

    public fun migrate_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg1.version < arg2, 2);
        assert!(arg2 == 1, 2);
        arg1.version = arg2;
    }

    public fun pause(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(!arg1.paused, 3);
        arg1.paused = true;
        let v0 = SystemPaused{
            paused_by : 0x2::tx_context::sender(arg2),
            epoch     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SystemPaused>(v0);
    }

    public fun points_per_gb(arg0: &GlobalConfig) : u64 {
        arg0.points_per_gb
    }

    public fun quilt_threshold_bytes(arg0: &GlobalConfig) : u64 {
        arg0.quilt_threshold_bytes
    }

    public(friend) fun reassign_user_account(arg0: &mut GlobalConfig, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert_version(arg0);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.user_accounts, arg1), 12);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.user_accounts, arg2), 14);
        let v0 = 0x2::table::remove<address, 0x2::object::ID>(&mut arg0.user_accounts, arg1);
        assert!(v0 == arg3, 13);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.user_accounts, arg2, v0);
        let v1 = UserAccountReassigned{
            old_owner  : arg1,
            new_owner  : arg2,
            account_id : arg3,
            epoch      : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<UserAccountReassigned>(v1);
    }

    public(friend) fun register_user(arg0: &mut GlobalConfig, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert_version(arg0);
        assert!(arg1 != @0x0, 9);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.user_accounts, arg1), 8);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.user_accounts, arg1, arg2);
        let v0 = UserRegistered{
            user       : arg1,
            account_id : arg2,
            epoch      : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<UserRegistered>(v0);
    }

    public fun sponsored_tx_enabled(arg0: &GlobalConfig) : bool {
        arg0.sponsored_tx_enabled
    }

    public fun total_users(arg0: &GlobalConfig) : u64 {
        0x2::table::length<address, 0x2::object::ID>(&arg0.user_accounts)
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg1.paused, 4);
        arg1.paused = false;
        let v0 = SystemUnpaused{
            unpaused_by : 0x2::tx_context::sender(arg2),
            epoch       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SystemUnpaused>(v0);
    }

    public fun update_grace_period(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 > 0, 10);
        arg1.grace_period_epochs = arg2;
        let v0 = ConfigUpdated{
            field      : b"grace_period_epochs",
            updated_by : 0x2::tx_context::sender(arg3),
            epoch      : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun update_max_viewers_per_store(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 > 0, 15);
        arg1.max_viewers_per_store = arg2;
        let v0 = MaxViewersPerStoreUpdated{
            old_max    : arg1.max_viewers_per_store,
            new_max    : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            epoch      : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<MaxViewersPerStoreUpdated>(v0);
    }

    public fun update_points_config(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 > 0, 11);
        assert!(arg2 <= 1000, 17);
        arg1.points_per_gb = arg2;
        let v0 = ConfigUpdated{
            field      : b"points_per_gb",
            updated_by : 0x2::tx_context::sender(arg3),
            epoch      : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun update_quilt_threshold_bytes(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 > 0, 16);
        arg1.quilt_threshold_bytes = arg2;
        let v0 = QuiltThresholdUpdated{
            old_threshold : arg1.quilt_threshold_bytes,
            new_threshold : arg2,
            updated_by    : 0x2::tx_context::sender(arg3),
            epoch         : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<QuiltThresholdUpdated>(v0);
    }

    public fun update_sponsored_tx(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        arg1.sponsored_tx_enabled = arg2;
        arg1.max_sponsored_tx = arg3;
        let v0 = ConfigUpdated{
            field      : b"sponsored_tx",
            updated_by : 0x2::tx_context::sender(arg4),
            epoch      : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun update_storage_limits(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 > 0 && arg3 >= arg2, 7);
        arg1.billing_period_epochs = arg2;
        arg1.max_storage_epochs = arg3;
        let v0 = ConfigUpdated{
            field      : b"storage_limits",
            updated_by : 0x2::tx_context::sender(arg4),
            epoch      : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun version(arg0: &GlobalConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

