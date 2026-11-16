module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store {
    struct CapStore has key {
        id: 0x2::object::UID,
        version: u64,
        admin_timelock_id: 0x2::object::ID,
        auth_timelock_id: 0x2::object::ID,
    }

    struct CapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct UpgradeKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    public(friend) fun borrow<T0: store + key>(arg0: &CapStore) : &T0 {
        assert!(holds<T0>(arg0), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::cap_missing());
        let v0 = CapKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<CapKey<T0>, T0>(&arg0.id, v0)
    }

    public(friend) fun remove<T0: store + key>(arg0: &mut CapStore) : T0 {
        assert!(holds<T0>(arg0), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::cap_missing());
        let v0 = CapKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::remove<CapKey<T0>, T0>(&mut arg0.id, v0);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_cap_removed(0x1::type_name::with_original_ids<T0>(), 0x2::object::id<T0>(&v1));
        v1
    }

    public fun admin_timelock_id(arg0: &CapStore) : 0x2::object::ID {
        arg0.admin_timelock_id
    }

    public(friend) fun assert_admin_timelock(arg0: &CapStore, arg1: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock) {
        assert!(0x2::object::id<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock>(arg1) == arg0.admin_timelock_id, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::wrong_timelock());
    }

    public(friend) fun assert_auth_timelock(arg0: &CapStore, arg1: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock) {
        assert!(0x2::object::id<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock>(arg1) == arg0.auth_timelock_id, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::wrong_timelock());
    }

    public fun assert_version(arg0: &CapStore) {
        assert!(arg0.version == 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::constants::version(), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::wrong_version());
    }

    public fun auth_timelock_id(arg0: &CapStore) : 0x2::object::ID {
        arg0.auth_timelock_id
    }

    public(friend) fun borrow_upgrade_cap_mut(arg0: &mut CapStore, arg1: 0x2::object::ID) : &mut 0x2::package::UpgradeCap {
        assert!(holds_upgrade_cap(arg0, arg1), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::upgrade_cap_missing());
        let v0 = UpgradeKey{pos0: arg1};
        0x2::dynamic_object_field::borrow_mut<UpgradeKey, 0x2::package::UpgradeCap>(&mut arg0.id, v0)
    }

    public fun holds<T0: store + key>(arg0: &CapStore) : bool {
        let v0 = CapKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<CapKey<T0>, T0>(&arg0.id, v0)
    }

    public fun holds_upgrade_cap(arg0: &CapStore, arg1: 0x2::object::ID) : bool {
        let v0 = UpgradeKey{pos0: arg1};
        0x2::dynamic_object_field::exists_with_type<UpgradeKey, 0x2::package::UpgradeCap>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::new<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::AdminProposerRole, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::ExecutorRole, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::AdminCancellerRole, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::TimelockAdminRole>(0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::constants::admin_min_delay_ms(), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::constants::grace_period_ms(), arg0);
        let v1 = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::new<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::AuthProposerRole, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::ExecutorRole, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::AuthCancellerRole, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::TimelockAdminRole>(0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::constants::auth_min_delay_ms(), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::constants::grace_period_ms(), arg0);
        let v2 = CapStore{
            id                : 0x2::object::new(arg0),
            version           : 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::constants::version(),
            admin_timelock_id : 0x2::object::id<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock>(&v0),
            auth_timelock_id  : 0x2::object::id<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock>(&v1),
        };
        0x2::transfer::share_object<CapStore>(v2);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::share(v0);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::share(v1);
    }

    public(friend) fun migrate(arg0: &mut CapStore) {
        assert!(arg0.version < 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::constants::version(), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::already_migrated());
        arg0.version = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::constants::version();
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_cap_store_migrated(arg0.version, arg0.version);
    }

    public(friend) fun store_cap<T0: store + key>(arg0: &mut CapStore, arg1: T0) {
        assert_version(arg0);
        assert!(!holds<T0>(arg0), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::cap_slot_taken());
        let v0 = CapKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<CapKey<T0>, T0>(&mut arg0.id, v0, arg1);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_cap_stored(0x1::type_name::with_original_ids<T0>(), 0x2::object::id<T0>(&arg1));
    }

    public fun store_upgrade_cap(arg0: &mut CapStore, arg1: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg2: 0x2::package::UpgradeCap, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::assert_has_role<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::AdminProposerRole>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(&arg2);
        let v1 = UpgradeKey{pos0: v0};
        0x2::dynamic_object_field::add<UpgradeKey, 0x2::package::UpgradeCap>(&mut arg0.id, v1, arg2);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_upgrade_cap_stored(v0, 0x2::package::upgrade_package(&arg2));
    }

    public fun version(arg0: &CapStore) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

