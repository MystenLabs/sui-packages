module 0x206153a5eb64ac6795107e5d88c8538a83692b358d61110e8f27a685da6156a1::project {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauserCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminTimelock has key {
        id: 0x2::object::UID,
        delay_epochs: u64,
        scheduled_epoch: u64,
        action: u8,
        value_u64: u64,
        value_addr: address,
    }

    struct PauserRegistry has key {
        id: 0x2::object::UID,
        current_pauser_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        protocol_treasury: address,
        protocol_fee_bps: u64,
        paused: bool,
        storage_price_per_epoch: u64,
        version: u64,
        migration_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Project has key {
        id: 0x2::object::UID,
        owner: address,
        treasury_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        metadata_cid: 0x1::option::Option<vector<u8>>,
        status: u8,
        blob_count: u64,
        created_at_epoch: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
    }

    struct Policy has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        renewal_window: u64,
        auto_renew: bool,
        paused: bool,
        keeper_reward: u64,
        max_epochs_per_call: u64,
    }

    struct BlobEntry has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        blob: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>,
        blob_object_id: 0x2::object::ID,
        walrus_blob_id: u256,
        expiry_epoch: u32,
        priority: u8,
        auto_renew: bool,
        status: u8,
        last_renewed_epoch: u64,
    }

    struct ProjectCreated has copy, drop {
        project_id: 0x2::object::ID,
        owner: address,
        treasury_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        created_at_epoch: u64,
    }

    struct ProjectUpdated has copy, drop {
        project_id: 0x2::object::ID,
        metadata_cid: 0x1::option::Option<vector<u8>>,
    }

    struct ProjectDeleted has copy, drop {
        project_id: 0x2::object::ID,
    }

    struct BlobAdded has copy, drop {
        project_id: 0x2::object::ID,
        blob_entry_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
        walrus_blob_id: u256,
        expiry_epoch: u32,
        priority: u8,
        auto_renew: bool,
    }

    struct BlobRemoved has copy, drop {
        project_id: 0x2::object::ID,
        blob_entry_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
        walrus_blob_id: u256,
    }

    struct BlobUpdated has copy, drop {
        project_id: 0x2::object::ID,
        blob_entry_id: 0x2::object::ID,
        priority: u8,
        auto_renew: bool,
    }

    struct BlobRenewed has copy, drop {
        project_id: 0x2::object::ID,
        blob_entry_id: 0x2::object::ID,
        walrus_blob_id: u256,
        new_end_epoch: u32,
        actual_cost: u64,
        protocol_fee_paid: u64,
        keeper_reward_paid: u64,
        executor: address,
    }

    struct Deposit has copy, drop {
        project_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        amount: u64,
        depositor: address,
    }

    struct Withdraw has copy, drop {
        project_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct PolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        renewal_window: u64,
        auto_renew: bool,
        paused: bool,
        keeper_reward: u64,
        max_epochs_per_call: u64,
    }

    struct RenewalSkipped has copy, drop {
        project_id: 0x2::object::ID,
        blob_entry_id: 0x2::object::ID,
        reason: u8,
    }

    struct Paused has copy, drop {
        dummy_field: bool,
    }

    struct Unpaused has copy, drop {
        dummy_field: bool,
    }

    struct PauserCapRevoked has copy, drop {
        revoked_by: address,
    }

    struct AdminActionScheduled has copy, drop {
        action: u8,
        value_u64: u64,
        value_addr: address,
        scheduled_epoch: u64,
        delay_epochs: u64,
        available_epoch: u64,
    }

    struct AdminActionExecuted has copy, drop {
        action: u8,
    }

    struct AdminActionCancelled has copy, drop {
        action: u8,
    }

    entry fun add_blob(arg0: &ProtocolConfig, arg1: &mut Project, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: u8, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 1);
        assert!(arg1.status == 1, 2);
        assert!(arg1.blob_count < 100000, 28);
        assert!(arg3 >= 1 && arg3 <= 100, 16);
        assert!(0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(&arg2)), 29);
        let v0 = 0x2::object::id<Project>(arg1);
        let v1 = 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg2);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg2);
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg2);
        let v4 = BlobEntry{
            id                 : 0x2::object::new(arg5),
            project_id         : v0,
            blob               : 0x1::option::some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg2),
            blob_object_id     : v1,
            walrus_blob_id     : v2,
            expiry_epoch       : v3,
            priority           : arg3,
            auto_renew         : arg4,
            status             : 1,
            last_renewed_epoch : 0,
        };
        0x2::transfer::share_object<BlobEntry>(v4);
        arg1.blob_count = arg1.blob_count + 1;
        let v5 = BlobAdded{
            project_id     : v0,
            blob_entry_id  : 0x2::object::id<BlobEntry>(&v4),
            blob_object_id : v1,
            walrus_blob_id : v2,
            expiry_epoch   : v3,
            priority       : arg3,
            auto_renew     : arg4,
        };
        0x2::event::emit<BlobAdded>(v5);
    }

    public fun admin_delay(arg0: &AdminTimelock) : u64 {
        arg0.delay_epochs
    }

    fun assert_not_paused(arg0: &ProtocolConfig) {
        assert!(!arg0.paused, 8);
    }

    public fun blob_entry_auto_renew(arg0: &BlobEntry) : bool {
        arg0.auto_renew
    }

    public fun blob_entry_expiry(arg0: &BlobEntry) : u32 {
        arg0.expiry_epoch
    }

    public fun blob_entry_has_blob(arg0: &BlobEntry) : bool {
        0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob)
    }

    public fun blob_entry_last_renewed(arg0: &BlobEntry) : u64 {
        arg0.last_renewed_epoch
    }

    public fun blob_entry_priority(arg0: &BlobEntry) : u8 {
        arg0.priority
    }

    public fun blob_entry_project_id(arg0: &BlobEntry) : 0x2::object::ID {
        arg0.project_id
    }

    public fun blob_entry_status(arg0: &BlobEntry) : u8 {
        arg0.status
    }

    public fun blob_entry_walrus_blob_id(arg0: &BlobEntry) : u256 {
        arg0.walrus_blob_id
    }

    entry fun cancel_admin_action(arg0: &AdminCap, arg1: &mut AdminTimelock) {
        assert!(arg1.action > 0, 21);
        arg1.scheduled_epoch = 0;
        arg1.action = 0;
        arg1.value_u64 = 0;
        arg1.value_addr = @0x0;
        let v0 = AdminActionCancelled{action: arg1.action};
        0x2::event::emit<AdminActionCancelled>(v0);
    }

    entry fun create_project(arg0: &ProtocolConfig, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0x1::option::Option<vector<u8>>, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        validate_policy_params(arg3, arg5, arg6, (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::max_epochs_ahead(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::future_accounting(arg1)) as u64));
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg2)) <= 256, 17);
        };
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::tx_context::epoch(arg7);
        let v2 = 0x2::object::new(arg7);
        0x2::object::delete(v2);
        let v3 = 0x2::object::new(arg7);
        0x2::object::delete(v3);
        let v4 = Project{
            id               : 0x2::object::new(arg7),
            owner            : v0,
            treasury_id      : 0x2::object::uid_to_inner(&v2),
            policy_id        : 0x2::object::uid_to_inner(&v3),
            metadata_cid     : arg2,
            status           : 1,
            blob_count       : 0,
            created_at_epoch : v1,
        };
        let v5 = 0x2::object::id<Project>(&v4);
        let v6 = Treasury{
            id         : 0x2::object::new(arg7),
            project_id : v5,
            balance    : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        let v7 = 0x2::object::id<Treasury>(&v6);
        let v8 = Policy{
            id                  : 0x2::object::new(arg7),
            project_id          : v5,
            renewal_window      : arg3,
            auto_renew          : arg4,
            paused              : false,
            keeper_reward       : arg5,
            max_epochs_per_call : arg6,
        };
        let v9 = 0x2::object::id<Policy>(&v8);
        v4.treasury_id = v7;
        v4.policy_id = v9;
        0x2::transfer::share_object<Project>(v4);
        0x2::transfer::share_object<Treasury>(v6);
        0x2::transfer::share_object<Policy>(v8);
        let v10 = ProjectCreated{
            project_id       : v5,
            owner            : v0,
            treasury_id      : v7,
            policy_id        : v9,
            created_at_epoch : v1,
        };
        0x2::event::emit<ProjectCreated>(v10);
    }

    public fun current_pauser_id(arg0: &PauserRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.current_pauser_id
    }

    entry fun delete_project(arg0: &ProtocolConfig, arg1: Project, arg2: Treasury, arg3: Policy, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 1);
        assert!(arg1.blob_count == 0, 18);
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2.balance) == 0, 19);
        assert!(arg2.project_id == 0x2::object::id<Project>(&arg1), 20);
        assert!(arg3.project_id == 0x2::object::id<Project>(&arg1), 20);
        let Project {
            id               : v0,
            owner            : _,
            treasury_id      : _,
            policy_id        : _,
            metadata_cid     : _,
            status           : _,
            blob_count       : _,
            created_at_epoch : _,
        } = arg1;
        0x2::object::delete(v0);
        let Treasury {
            id         : v8,
            project_id : _,
            balance    : v10,
        } = arg2;
        0x2::balance::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v10);
        0x2::object::delete(v8);
        let Policy {
            id                  : v11,
            project_id          : _,
            renewal_window      : _,
            auto_renew          : _,
            paused              : _,
            keeper_reward       : _,
            max_epochs_per_call : _,
        } = arg3;
        0x2::object::delete(v11);
        let v18 = ProjectDeleted{project_id: 0x2::object::id<Project>(&arg1)};
        0x2::event::emit<ProjectDeleted>(v18);
    }

    entry fun deposit(arg0: &ProtocolConfig, arg1: &Project, arg2: &mut Treasury, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert!(arg1.status == 1, 2);
        assert!(arg2.project_id == 0x2::object::id<Project>(arg1), 20);
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg3);
        assert!(v0 > 0, 10);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg2.balance, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3));
        let v1 = Deposit{
            project_id  : 0x2::object::id<Project>(arg1),
            treasury_id : 0x2::object::id<Treasury>(arg2),
            amount      : v0,
            depositor   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Deposit>(v1);
    }

    entry fun emergency_pause(arg0: &PauserCap, arg1: &PauserRegistry, arg2: &mut ProtocolConfig) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.current_pauser_id), 27);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg1.current_pauser_id) == 0x2::object::id<PauserCap>(arg0), 27);
        arg2.paused = true;
        let v0 = Paused{dummy_field: false};
        0x2::event::emit<Paused>(v0);
    }

    entry fun emergency_unpause(arg0: &PauserCap, arg1: &PauserRegistry, arg2: &mut ProtocolConfig) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.current_pauser_id), 27);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg1.current_pauser_id) == 0x2::object::id<PauserCap>(arg0), 27);
        arg2.paused = false;
        let v0 = Unpaused{dummy_field: false};
        0x2::event::emit<Unpaused>(v0);
    }

    public fun estimate_renewal_cost(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1
    }

    entry fun execute_admin_action(arg0: &mut AdminTimelock, arg1: &mut ProtocolConfig, arg2: &mut PauserRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.action > 0, 21);
        assert!(0x2::tx_context::epoch(arg3) >= arg0.scheduled_epoch + arg0.delay_epochs, 22);
        let v0 = arg0.action;
        if (v0 == 1) {
            arg1.protocol_treasury = arg0.value_addr;
        } else if (v0 == 2) {
            arg1.protocol_fee_bps = arg0.value_u64;
        } else if (v0 == 3) {
            arg1.storage_price_per_epoch = arg0.value_u64;
        } else if (v0 == 4) {
            let v1 = PauserCap{id: 0x2::object::new(arg3)};
            arg2.current_pauser_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<PauserCap>(&v1));
            0x2::transfer::transfer<PauserCap>(v1, arg0.value_addr);
        } else {
            assert!(v0 == 5, 23);
            arg0.delay_epochs = arg0.value_u64;
        };
        arg0.scheduled_epoch = 0;
        arg0.action = 0;
        arg0.value_u64 = 0;
        arg0.value_addr = @0x0;
        let v2 = AdminActionExecuted{action: v0};
        0x2::event::emit<AdminActionExecuted>(v2);
    }

    public fun get_version(arg0: &ProtocolConfig) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id                      : 0x2::object::new(arg0),
            protocol_treasury       : @0x0,
            protocol_fee_bps        : 0,
            paused                  : false,
            storage_price_per_epoch : 1000000,
            version                 : 1,
            migration_cap_id        : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<ProtocolConfig>(v0);
        let v1 = AdminTimelock{
            id              : 0x2::object::new(arg0),
            delay_epochs    : 0,
            scheduled_epoch : 0,
            action          : 0,
            value_u64       : 0,
            value_addr      : @0x0,
        };
        0x2::transfer::share_object<AdminTimelock>(v1);
        let v2 = PauserRegistry{
            id                : 0x2::object::new(arg0),
            current_pauser_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<PauserRegistry>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun is_due(arg0: &Project, arg1: &Policy, arg2: &BlobEntry, arg3: u32) : bool {
        if (arg0.status != 1) {
            return false
        };
        let v0 = if (arg1.paused) {
            true
        } else if (!arg1.auto_renew) {
            true
        } else {
            !arg2.auto_renew
        };
        if (v0) {
            return false
        };
        if (arg2.status != 1) {
            return false
        };
        if (0x1::option::is_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg2.blob)) {
            return false
        };
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg2.blob));
        if ((arg3 as u64) >= (v1 as u64)) {
            return false
        };
        (arg3 as u64) + arg1.renewal_window >= (v1 as u64)
    }

    public fun is_paused(arg0: &ProtocolConfig) : bool {
        arg0.paused
    }

    public entry fun migrate(arg0: &0x2::package::UpgradeCap, arg1: &mut ProtocolConfig) {
        if (0x1::option::is_some<0x2::object::ID>(&arg1.migration_cap_id)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg1.migration_cap_id) == 0x2::object::id<0x2::package::UpgradeCap>(arg0), 26);
        } else {
            let v0 = 0x2::package::upgrade_package(arg0);
            assert!(0x2::object::id_to_address(&v0) == @0x0, 26);
            arg1.migration_cap_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg0));
        };
        if (arg1.version < 1) {
            arg1.version = 1;
        };
    }

    public fun pending_admin_action(arg0: &AdminTimelock) : u8 {
        arg0.action
    }

    public fun pending_admin_scheduled_epoch(arg0: &AdminTimelock) : u64 {
        arg0.scheduled_epoch
    }

    public fun policy_auto_renew(arg0: &Policy) : bool {
        arg0.auto_renew
    }

    public fun policy_keeper_reward(arg0: &Policy) : u64 {
        arg0.keeper_reward
    }

    public fun policy_max_epochs_per_call(arg0: &Policy) : u64 {
        arg0.max_epochs_per_call
    }

    public fun policy_paused(arg0: &Policy) : bool {
        arg0.paused
    }

    public fun policy_project_id(arg0: &Policy) : 0x2::object::ID {
        arg0.project_id
    }

    public fun policy_renewal_window(arg0: &Policy) : u64 {
        arg0.renewal_window
    }

    public fun project_blob_count(arg0: &Project) : u64 {
        arg0.blob_count
    }

    public fun project_metadata_cid(arg0: &Project) : 0x1::option::Option<vector<u8>> {
        arg0.metadata_cid
    }

    public fun project_owner(arg0: &Project) : address {
        arg0.owner
    }

    public fun project_status(arg0: &Project) : u8 {
        arg0.status
    }

    public fun protocol_fee_bps(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_fee_bps
    }

    public fun protocol_treasury(arg0: &ProtocolConfig) : address {
        arg0.protocol_treasury
    }

    entry fun remove_blob(arg0: &ProtocolConfig, arg1: &mut Project, arg2: BlobEntry, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 1);
        assert!(arg2.project_id == 0x2::object::id<Project>(arg1), 20);
        assert!(arg2.status == 1 || arg2.status == 3, 4);
        let BlobEntry {
            id                 : v0,
            project_id         : _,
            blob               : v2,
            blob_object_id     : _,
            walrus_blob_id     : _,
            expiry_epoch       : _,
            priority           : _,
            auto_renew         : _,
            status             : _,
            last_renewed_epoch : _,
        } = arg2;
        let v10 = v2;
        0x1::option::destroy_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v10);
        arg1.blob_count = arg1.blob_count - 1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(0x1::option::extract<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v10), arg1.owner);
        let v11 = BlobRemoved{
            project_id     : 0x2::object::id<Project>(arg1),
            blob_entry_id  : 0x2::object::id<BlobEntry>(&arg2),
            blob_object_id : arg2.blob_object_id,
            walrus_blob_id : arg2.walrus_blob_id,
        };
        0x2::event::emit<BlobRemoved>(v11);
    }

    entry fun renew_blob(arg0: &ProtocolConfig, arg1: &Project, arg2: &Policy, arg3: &mut Treasury, arg4: &mut BlobEntry, arg5: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg6: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        let v0 = 0x2::object::id<Project>(arg1);
        assert!(arg4.status == 1, 4);
        assert!(0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg4.blob), 4);
        if (arg1.status != 1) {
            let v1 = RenewalSkipped{
                project_id    : v0,
                blob_entry_id : 0x2::object::id<BlobEntry>(arg4),
                reason        : 6,
            };
            0x2::event::emit<RenewalSkipped>(v1);
            return
        };
        assert!(arg4.project_id == v0, 20);
        assert!(arg3.project_id == v0, 20);
        assert!(arg2.project_id == v0, 20);
        let v2 = if (arg2.paused) {
            true
        } else if (!arg2.auto_renew) {
            true
        } else {
            !arg4.auto_renew
        };
        if (v2) {
            let v3 = RenewalSkipped{
                project_id    : v0,
                blob_entry_id : 0x2::object::id<BlobEntry>(arg4),
                reason        : 3,
            };
            0x2::event::emit<RenewalSkipped>(v3);
            return
        };
        let v4 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg5);
        let v5 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg4.blob));
        if ((v4 as u64) >= (v5 as u64)) {
            arg4.status = 3;
            let v6 = RenewalSkipped{
                project_id    : v0,
                blob_entry_id : 0x2::object::id<BlobEntry>(arg4),
                reason        : 5,
            };
            0x2::event::emit<RenewalSkipped>(v6);
            return
        };
        if ((v4 as u64) + arg2.renewal_window < (v5 as u64)) {
            let v7 = RenewalSkipped{
                project_id    : v0,
                blob_entry_id : 0x2::object::id<BlobEntry>(arg4),
                reason        : 1,
            };
            0x2::event::emit<RenewalSkipped>(v7);
            return
        };
        if (arg4.last_renewed_epoch > 0 && (v4 as u64) <= arg4.last_renewed_epoch) {
            let v8 = RenewalSkipped{
                project_id    : v0,
                blob_entry_id : 0x2::object::id<BlobEntry>(arg4),
                reason        : 4,
            };
            0x2::event::emit<RenewalSkipped>(v8);
            return
        };
        let v9 = arg0.protocol_fee_bps;
        let v10 = arg2.keeper_reward;
        let v11 = arg0.protocol_treasury;
        if (v9 > 0 && v11 == @0x0) {
            let v12 = RenewalSkipped{
                project_id    : v0,
                blob_entry_id : 0x2::object::id<BlobEntry>(arg4),
                reason        : 7,
            };
            0x2::event::emit<RenewalSkipped>(v12);
            return
        };
        let v13 = (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::max_epochs_ahead(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::future_accounting(arg5)) as u64);
        let v14 = (v5 as u64) - (v4 as u64);
        if (v14 >= v13) {
            let v15 = RenewalSkipped{
                project_id    : v0,
                blob_entry_id : 0x2::object::id<BlobEntry>(arg4),
                reason        : 8,
            };
            0x2::event::emit<RenewalSkipped>(v15);
            return
        };
        let v16 = v13 - v14;
        let v17 = arg2.max_epochs_per_call;
        let v18 = v17;
        if (v17 > 365) {
            v18 = 365;
        };
        if (v18 > v16) {
            v18 = v16;
        };
        let v19 = estimate_renewal_cost(v18, arg0.storage_price_per_epoch);
        let v20 = v19 * v9 / 10000;
        let v21 = v19 + v20 + v10;
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg3.balance) < v21) {
            let v22 = RenewalSkipped{
                project_id    : v0,
                blob_entry_id : 0x2::object::id<BlobEntry>(arg4),
                reason        : 2,
            };
            0x2::event::emit<RenewalSkipped>(v22);
            return
        };
        let v23 = 0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg3.balance, v21, arg6);
        if (v20 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v23, v20, arg6), v11);
        };
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v23, v10, arg6), 0x2::tx_context::sender(arg6));
        };
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg5, 0x1::option::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg4.blob), (v18 as u32), &mut v23);
        let v24 = 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v23);
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v24) > 0) {
            0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg3.balance, v24);
        } else {
            0x2::balance::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v24);
        };
        let v25 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg4.blob));
        arg4.expiry_epoch = v25;
        arg4.last_renewed_epoch = (v4 as u64);
        let v26 = BlobRenewed{
            project_id         : v0,
            blob_entry_id      : 0x2::object::id<BlobEntry>(arg4),
            walrus_blob_id     : arg4.walrus_blob_id,
            new_end_epoch      : v25,
            actual_cost        : 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v23) - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v23),
            protocol_fee_paid  : v20,
            keeper_reward_paid : v10,
            executor           : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<BlobRenewed>(v26);
    }

    entry fun revoke_pauser(arg0: &AdminCap, arg1: &mut PauserRegistry, arg2: &0x2::tx_context::TxContext) {
        arg1.current_pauser_id = 0x1::option::none<0x2::object::ID>();
        let v0 = PauserCapRevoked{revoked_by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<PauserCapRevoked>(v0);
    }

    entry fun schedule_admin_action(arg0: &AdminCap, arg1: &mut AdminTimelock, arg2: u8, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.action == 0, 24);
        assert!(arg2 > 0 && arg2 <= 5, 23);
        if (arg2 == 1) {
            assert!(arg4 != @0x0, 9);
        };
        if (arg2 == 2) {
            assert!(arg3 <= 10000, 11);
        };
        if (arg2 == 3) {
            assert!(arg3 <= 5000000000000, 13);
        };
        if (arg2 == 4) {
            assert!(arg4 != @0x0, 9);
        };
        if (arg2 == 5) {
            assert!(arg3 >= 1 && arg3 <= 1000, 25);
        };
        let v0 = 0x2::tx_context::epoch(arg5);
        arg1.scheduled_epoch = v0;
        arg1.action = arg2;
        arg1.value_u64 = arg3;
        arg1.value_addr = arg4;
        let v1 = AdminActionScheduled{
            action          : arg2,
            value_u64       : arg3,
            value_addr      : arg4,
            scheduled_epoch : v0,
            delay_epochs    : arg1.delay_epochs,
            available_epoch : v0 + arg1.delay_epochs,
        };
        0x2::event::emit<AdminActionScheduled>(v1);
    }

    public fun storage_price(arg0: &ProtocolConfig) : u64 {
        arg0.storage_price_per_epoch
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.balance)
    }

    public fun treasury_project_id(arg0: &Treasury) : 0x2::object::ID {
        arg0.project_id
    }

    entry fun update_blob(arg0: &ProtocolConfig, arg1: &Project, arg2: &mut BlobEntry, arg3: u8, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 1);
        assert!(arg2.project_id == 0x2::object::id<Project>(arg1), 20);
        assert!(arg2.status == 1, 4);
        assert!(arg3 >= 1 && arg3 <= 100, 16);
        arg2.priority = arg3;
        arg2.auto_renew = arg4;
        let v0 = BlobUpdated{
            project_id    : 0x2::object::id<Project>(arg1),
            blob_entry_id : 0x2::object::id<BlobEntry>(arg2),
            priority      : arg3,
            auto_renew    : arg4,
        };
        0x2::event::emit<BlobUpdated>(v0);
    }

    entry fun update_policy(arg0: &ProtocolConfig, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &Project, arg3: &mut Policy, arg4: u64, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert!(0x2::tx_context::sender(arg9) == arg2.owner, 1);
        assert!(arg3.project_id == 0x2::object::id<Project>(arg2), 20);
        validate_policy_params(arg4, arg7, arg8, (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::max_epochs_ahead(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::future_accounting(arg1)) as u64));
        arg3.renewal_window = arg4;
        arg3.auto_renew = arg5;
        arg3.paused = arg6;
        arg3.keeper_reward = arg7;
        arg3.max_epochs_per_call = arg8;
        let v0 = PolicyUpdated{
            policy_id           : 0x2::object::id<Policy>(arg3),
            project_id          : 0x2::object::id<Project>(arg2),
            renewal_window      : arg4,
            auto_renew          : arg5,
            paused              : arg6,
            keeper_reward       : arg7,
            max_epochs_per_call : arg8,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    entry fun update_project(arg0: &ProtocolConfig, arg1: &mut Project, arg2: 0x1::option::Option<vector<u8>>, arg3: &0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 1);
        assert!(arg1.status == 1, 2);
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg2)) <= 256, 17);
        };
        arg1.metadata_cid = arg2;
        let v0 = ProjectUpdated{
            project_id   : 0x2::object::id<Project>(arg1),
            metadata_cid : arg2,
        };
        0x2::event::emit<ProjectUpdated>(v0);
    }

    fun validate_policy_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 > 0, 14);
        assert!(arg0 <= 100000, 14);
        assert!(arg2 > 0, 15);
        assert!(arg2 <= 365, 15);
        assert!(arg2 > arg0, 15);
        assert!(arg0 < arg3, 30);
        assert!(arg1 <= 100000000000, 12);
    }

    entry fun withdraw(arg0: &ProtocolConfig, arg1: &Project, arg2: &mut Treasury, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 1);
        assert!(arg2.project_id == 0x2::object::id<Project>(arg1), 20);
        assert!(arg3 > 0, 10);
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2.balance) >= arg3, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg2.balance, arg3, arg4), arg1.owner);
        let v0 = Withdraw{
            project_id  : 0x2::object::id<Project>(arg1),
            treasury_id : 0x2::object::id<Treasury>(arg2),
            amount      : arg3,
            owner       : arg1.owner,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

