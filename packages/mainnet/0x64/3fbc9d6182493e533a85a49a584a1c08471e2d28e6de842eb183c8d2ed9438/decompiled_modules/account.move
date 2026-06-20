module 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::account {
    struct AdminDelegatesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Profile has copy, drop, store {
        display_name: 0x1::string::String,
        handle: 0x1::string::String,
        bio: 0x1::string::String,
        avatar_blob: 0x1::option::Option<u256>,
    }

    struct Account has key {
        id: 0x2::object::UID,
        owner: address,
        memwal_account_id: 0x2::object::ID,
        profile: Profile,
        settings: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        agents: 0x2::vec_set::VecSet<0x2::object::ID>,
        kb_files: 0x2::vec_set::VecSet<0x2::object::ID>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<address, 0x2::object::ID>,
        handles: 0x2::table::Table<0x1::string::String, address>,
        total_accounts: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct AccountRegistered has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        handle: 0x1::string::String,
        memwal_account_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ProfileUpdated has copy, drop {
        account_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct HandleChanged has copy, drop {
        account_id: 0x2::object::ID,
        previous: 0x1::string::String,
        current: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct AvatarSet has copy, drop {
        account_id: 0x2::object::ID,
        blob_id: u256,
        timestamp_ms: u64,
    }

    struct SettingSet has copy, drop {
        account_id: 0x2::object::ID,
        key: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct SettingRemoved has copy, drop {
        account_id: 0x2::object::ID,
        key: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct MemwalLinked has copy, drop {
        account_id: 0x2::object::ID,
        memwal_account_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AgentLinked has copy, drop {
        account_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AgentUnlinked has copy, drop {
        account_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct KbFileLinked has copy, drop {
        account_id: 0x2::object::ID,
        kb_file_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct KbFileUnlinked has copy, drop {
        account_id: 0x2::object::ID,
        kb_file_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AdminGranted has copy, drop {
        account_id: 0x2::object::ID,
        delegate: address,
        timestamp_ms: u64,
    }

    struct AdminRevoked has copy, drop {
        account_id: 0x2::object::ID,
        delegate: address,
        timestamp_ms: u64,
    }

    public fun account_of(arg0: &Registry, arg1: address) : 0x2::object::ID {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, arg1), 3);
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.accounts, arg1)
    }

    public fun agents(arg0: &Account) : 0x2::vec_set::VecSet<0x2::object::ID> {
        arg0.agents
    }

    public fun avatar_blob(arg0: &Account) : 0x1::option::Option<u256> {
        arg0.profile.avatar_blob
    }

    public fun bio(arg0: &Account) : 0x1::string::String {
        arg0.profile.bio
    }

    public fun can_access(arg0: &Account, arg1: address) : bool {
        arg1 == arg0.owner || is_delegate(arg0, arg1)
    }

    public fun created_at_ms(arg0: &Account) : u64 {
        arg0.created_at_ms
    }

    public fun display_name(arg0: &Account) : 0x1::string::String {
        arg0.profile.display_name
    }

    fun ensure_delegates(arg0: &mut Account) {
        let v0 = AdminDelegatesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<AdminDelegatesKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0)) {
            let v1 = AdminDelegatesKey{dummy_field: false};
            0x2::dynamic_field::add<AdminDelegatesKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v1, 0x2::vec_set::empty<address>());
        };
    }

    public fun grant_admin(arg0: &mut Account, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 5);
        assert!(arg1 != arg0.owner, 6);
        let v0 = 0x2::object::id<Account>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        ensure_delegates(arg0);
        let v2 = AdminDelegatesKey{dummy_field: false};
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_insert<address>(0x2::dynamic_field::borrow_mut<AdminDelegatesKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v2), arg1)) {
            arg0.updated_at_ms = v1;
            let v3 = AdminGranted{
                account_id   : v0,
                delegate     : arg1,
                timestamp_ms : v1,
            };
            0x2::event::emit<AdminGranted>(v3);
        };
    }

    public fun handle(arg0: &Account) : 0x1::string::String {
        arg0.profile.handle
    }

    public fun handle_taken(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.handles, arg1)
    }

    public fun has_agent(arg0: &Account, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.agents, &arg1)
    }

    public fun has_kb_file(arg0: &Account, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.kb_files, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            accounts       : 0x2::table::new<address, 0x2::object::ID>(arg0),
            handles        : 0x2::table::new<0x1::string::String, address>(arg0),
            total_accounts : 0,
        };
        let v1 = RegistryCreated{registry_id: 0x2::object::id<Registry>(&v0)};
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_delegate(arg0: &Account, arg1: address) : bool {
        let v0 = AdminDelegatesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<AdminDelegatesKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0)) {
            return false
        };
        let v1 = AdminDelegatesKey{dummy_field: false};
        0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<AdminDelegatesKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v1), &arg1)
    }

    public fun is_registered(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, arg1)
    }

    public fun kb_files(arg0: &Account) : 0x2::vec_set::VecSet<0x2::object::ID> {
        arg0.kb_files
    }

    public(friend) fun link_agent(arg0: &mut Account, arg1: 0x2::object::ID, arg2: u64) {
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_insert<0x2::object::ID>(&mut arg0.agents, arg1)) {
            arg0.updated_at_ms = arg2;
            let v0 = AgentLinked{
                account_id   : 0x2::object::id<Account>(arg0),
                agent_id     : arg1,
                timestamp_ms : arg2,
            };
            0x2::event::emit<AgentLinked>(v0);
        };
    }

    public(friend) fun link_kb_file(arg0: &mut Account, arg1: 0x2::object::ID, arg2: u64) {
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_insert<0x2::object::ID>(&mut arg0.kb_files, arg1)) {
            arg0.updated_at_ms = arg2;
            let v0 = KbFileLinked{
                account_id   : 0x2::object::id<Account>(arg0),
                kb_file_id   : arg1,
                timestamp_ms : arg2,
            };
            0x2::event::emit<KbFileLinked>(v0);
        };
    }

    public fun link_memwal(arg0: &mut Account, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.memwal_account_id = arg1;
        arg0.updated_at_ms = v0;
        let v1 = MemwalLinked{
            account_id        : 0x2::object::id<Account>(arg0),
            memwal_account_id : arg1,
            timestamp_ms      : v0,
        };
        0x2::event::emit<MemwalLinked>(v1);
    }

    public fun memwal_account_id(arg0: &Account) : 0x2::object::ID {
        arg0.memwal_account_id
    }

    public fun owner(arg0: &Account) : address {
        arg0.owner
    }

    public fun owner_of_handle(arg0: &Registry, arg1: 0x1::string::String) : address {
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.handles, arg1), 9);
        *0x2::table::borrow<0x1::string::String, address>(&arg0.handles, arg1)
    }

    entry fun register(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.accounts, v0), 1);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.handles, arg3), 2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = Profile{
            display_name : arg2,
            handle       : arg3,
            bio          : arg4,
            avatar_blob  : 0x1::option::none<u256>(),
        };
        let v3 = Account{
            id                : 0x2::object::new(arg6),
            owner             : v0,
            memwal_account_id : arg1,
            profile           : v2,
            settings          : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            agents            : 0x2::vec_set::empty<0x2::object::ID>(),
            kb_files          : 0x2::vec_set::empty<0x2::object::ID>(),
            created_at_ms     : v1,
            updated_at_ms     : v1,
        };
        let v4 = 0x2::object::id<Account>(&v3);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.accounts, v0, v4);
        0x2::table::add<0x1::string::String, address>(&mut arg0.handles, arg3, v0);
        arg0.total_accounts = arg0.total_accounts + 1;
        let v5 = AccountRegistered{
            account_id        : v4,
            owner             : v0,
            handle            : arg3,
            memwal_account_id : arg1,
            timestamp_ms      : v1,
        };
        0x2::event::emit<AccountRegistered>(v5);
        0x2::transfer::transfer<Account>(v3, v0);
    }

    public fun remove_setting(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.settings, &arg1), 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.settings, &arg1);
        arg0.updated_at_ms = v0;
        let v3 = SettingRemoved{
            account_id   : 0x2::object::id<Account>(arg0),
            key          : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<SettingRemoved>(v3);
    }

    public fun revoke_admin(arg0: &mut Account, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 5);
        let v0 = 0x2::object::id<Account>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        ensure_delegates(arg0);
        let v2 = AdminDelegatesKey{dummy_field: false};
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_remove<address>(0x2::dynamic_field::borrow_mut<AdminDelegatesKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v2), arg1)) {
            arg0.updated_at_ms = v1;
            let v3 = AdminRevoked{
                account_id   : v0,
                delegate     : arg1,
                timestamp_ms : v1,
            };
            0x2::event::emit<AdminRevoked>(v3);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Account, arg2: &0x2::tx_context::TxContext) {
        assert!(can_access(arg1, 0x2::tx_context::sender(arg2)), 7);
        let v0 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::id_bytes(0x2::object::id<Account>(arg1));
        assert!(0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::bytes_start_with(&arg0, &v0), 8);
    }

    public fun set_avatar(arg0: &mut Account, arg1: u256, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.profile.avatar_blob = 0x1::option::some<u256>(arg1);
        arg0.updated_at_ms = v0;
        let v1 = AvatarSet{
            account_id   : 0x2::object::id<Account>(arg0),
            blob_id      : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<AvatarSet>(v1);
    }

    public fun set_handle(arg0: &mut Registry, arg1: &mut Account, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.handles, arg2), 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg1.profile.handle;
        0x2::table::remove<0x1::string::String, address>(&mut arg0.handles, v1);
        0x2::table::add<0x1::string::String, address>(&mut arg0.handles, arg2, arg1.owner);
        arg1.profile.handle = arg2;
        arg1.updated_at_ms = v0;
        let v2 = HandleChanged{
            account_id   : 0x2::object::id<Account>(arg1),
            previous     : v1,
            current      : arg2,
            timestamp_ms : v0,
        };
        0x2::event::emit<HandleChanged>(v2);
    }

    public fun set_setting(arg0: &mut Account, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::upsert<0x1::string::String, 0x1::string::String>(&mut arg0.settings, arg1, arg2);
        arg0.updated_at_ms = v0;
        let v1 = SettingSet{
            account_id   : 0x2::object::id<Account>(arg0),
            key          : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<SettingSet>(v1);
    }

    public fun setting(arg0: &Account, arg1: 0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        0x2::vec_map::try_get<0x1::string::String, 0x1::string::String>(&arg0.settings, &arg1)
    }

    public fun total_accounts(arg0: &Registry) : u64 {
        arg0.total_accounts
    }

    public(friend) fun unlink_agent(arg0: &mut Account, arg1: 0x2::object::ID, arg2: u64) {
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_remove<0x2::object::ID>(&mut arg0.agents, arg1)) {
            arg0.updated_at_ms = arg2;
            let v0 = AgentUnlinked{
                account_id   : 0x2::object::id<Account>(arg0),
                agent_id     : arg1,
                timestamp_ms : arg2,
            };
            0x2::event::emit<AgentUnlinked>(v0);
        };
    }

    public(friend) fun unlink_kb_file(arg0: &mut Account, arg1: 0x2::object::ID, arg2: u64) {
        if (0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::set_remove<0x2::object::ID>(&mut arg0.kb_files, arg1)) {
            arg0.updated_at_ms = arg2;
            let v0 = KbFileUnlinked{
                account_id   : 0x2::object::id<Account>(arg0),
                kb_file_id   : arg1,
                timestamp_ms : arg2,
            };
            0x2::event::emit<KbFileUnlinked>(v0);
        };
    }

    public fun update_profile(arg0: &mut Account, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.profile.display_name = arg1;
        arg0.profile.bio = arg2;
        arg0.updated_at_ms = v0;
        let v1 = ProfileUpdated{
            account_id   : 0x2::object::id<Account>(arg0),
            timestamp_ms : v0,
        };
        0x2::event::emit<ProfileUpdated>(v1);
    }

    public fun updated_at_ms(arg0: &Account) : u64 {
        arg0.updated_at_ms
    }

    // decompiled from Move bytecode v7
}

